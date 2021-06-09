#!/bin/bash

module use  /lustre/projects/global/software/a64fx/modulefiles

module purge
module load gcc/10.2.0 
make gcc-old

module purge
module load gcc/11.1.0
make gcc

module purge
module load arm-modules/20
make arm

module purge
module load arm-modules/21
make arm

module purge
module load CPE-nosve/21.03
make cray

module purge
module load CPE/21.03
make cray

module purge
module load fujitsu/compiler/1.0.20
make fujitsu

./compare.py 0 out.*
