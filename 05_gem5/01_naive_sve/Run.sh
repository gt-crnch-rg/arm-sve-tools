#!/bin/bash

make clean all

gem5-o3 -c ./01_naive.axf -o "64 64 64"
