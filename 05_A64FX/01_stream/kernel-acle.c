/*-----------------------------------------------------------------------*/
/* Program: STREAM                                                       */
/* Revision: $Id: stream.c,v 5.10 2013/01/17 16:01:06 mccalpin Exp mccalpin $ */
/* Original code developed by John D. McCalpin                           */
/* Programmers: John D. McCalpin                                         */
/*              Joe R. Zagar                                             */
/*                                                                       */
/* This program measures memory transfer rates in MB/s for simple        */
/* computational kernels coded in C.                                     */
/*-----------------------------------------------------------------------*/
/* Copyright 1991-2013: John D. McCalpin                                 */
/*-----------------------------------------------------------------------*/
/* License:                                                              */
/*  1. You are free to use this program and/or to redistribute           */
/*     this program.                                                     */
/*  2. You are free to modify this program for your own use,             */
/*     including commercial use, subject to the publication              */
/*     restrictions in item 3.                                           */
/*  3. You are free to publish results obtained from running this        */
/*     program, or from works that you derive from this program,         */
/*     with the following limitations:                                   */
/*     3a. In order to be referred to as "STREAM benchmark results",     */
/*         published results must be in conformance to the STREAM        */
/*         Run Rules, (briefly reviewed below) published at              */
/*         http://www.cs.virginia.edu/stream/ref.html                    */
/*         and incorporated herein by reference.                         */
/*         As the copyright holder, John McCalpin retains the            */
/*         right to determine conformity with the Run Rules.             */
/*     3b. Results based on modified source code or on runs not in       */
/*         accordance with the STREAM Run Rules must be clearly          */
/*         labelled whenever they are published.  Examples of            */
/*         proper labelling include:                                     */
/*           "tuned STREAM benchmark results"                            */
/*           "based on a variant of the STREAM benchmark code"           */
/*         Other comparable, clear, and reasonable labelling is          */
/*         acceptable.                                                   */
/*     3c. Submission of results to the STREAM benchmark web site        */
/*         is encouraged, but not required.                              */
/*  4. Use of this program or creation of derived works based on this    */
/*     program constitutes acceptance of these licensing restrictions.   */
/*  5. Absolutely no warranty is expressed or implied.                   */
/*-----------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <omp.h>
#include <arm_sve.h>

#include "stream.h"


/* 256-byte cache lines */
static const int ELEM_PER_CACHE_LINE = 256 / sizeof(stream_t);


void stream_allocate(stream_t ** a, stream_t ** b, stream_t ** c)
{
  size_t const size = sizeof(STREAM_TYPE) * (STREAM_ARRAY_SIZE + OFFSET);
  printf("size=%zd\n", size);
  if (NULL == (*a = (STREAM_TYPE*)malloc(size))) {
    fprintf(stderr, "Failed to allocated %zd bytes for a\n", size);
    exit(1);
  }
  if (NULL == (*b = (STREAM_TYPE*)malloc(size))) {
    fprintf(stderr, "Failed to allocated %zd bytes for b\n", size);
    exit(1);
  }
  if (NULL == (*c = (STREAM_TYPE*)malloc(size))) {
    fprintf(stderr, "Failed to allocated %zd bytes for c\n", size);
    exit(1);
  }
}


void stream_copy(stream_t * c, stream_t * a)
{

  #pragma omp parallel for
  for (size_t j=0; j<STREAM_ARRAY_SIZE; ++j) {
    c[j] = a[j];
  }
}

void stream_scale(stream_t scalar, stream_t * b, stream_t * c)
{
  #pragma omp parallel for
  for (size_t j=0; j<STREAM_ARRAY_SIZE; ++j) {
    b[j] = scalar*c[j];
  }
}

void stream_add(stream_t * c, stream_t * a, stream_t * b)
{
  #pragma omp parallel for
  for (size_t j=0; j<STREAM_ARRAY_SIZE; ++j) {
    c[j] = a[j] + b[j];
  }
}

void stream_triad(stream_t scalar, stream_t * a, stream_t * b, stream_t * c)
{
  #pragma omp parallel
  {
    size_t const vlen = svcntd();
    size_t const stride = 4 * vlen;

    #pragma omp master
    {
      if (STREAM_ARRAY_SIZE % stride) {
        fprintf(stderr, "Error: STREAM_ARRAY_SIZE=%zd is not a multiple of stride=%zd\n",
            STREAM_ARRAY_SIZE, stride);
        exit(1);
      }
    }

    svbool_t ptrue = svptrue_b64();
    svfloat64_t const vscalar = svdup_f64(scalar);

    #pragma omp for schedule(static)
    for (size_t j=0; j<STREAM_ARRAY_SIZE; j+=stride) {
      size_t const j0 = j;
      size_t const j1 = j + vlen;
      size_t const j2 = j + 2*vlen;
      size_t const j3 = j + 3*vlen;

      svfloat64_t vb0 = svld1(ptrue, b+j0);
      svfloat64_t vb1 = svld1(ptrue, b+j1);
      svfloat64_t vb2 = svld1(ptrue, b+j2);
      svfloat64_t vb3 = svld1(ptrue, b+j3);

      svfloat64_t vc0 = svld1(ptrue, c+j0);
      svfloat64_t vc1 = svld1(ptrue, c+j1);
      svfloat64_t vc2 = svld1(ptrue, c+j2);
      svfloat64_t vc3 = svld1(ptrue, c+j3);

      svst1(ptrue, a+j0, svmla_f64_x(ptrue, vb0, vscalar, vc0));
      svst1(ptrue, a+j1, svmla_f64_x(ptrue, vb1, vscalar, vc1));
      svst1(ptrue, a+j2, svmla_f64_x(ptrue, vb2, vscalar, vc2));
      svst1(ptrue, a+j3, svmla_f64_x(ptrue, vb3, vscalar, vc3));
    }

  } // parallel
} 

