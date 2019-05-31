#!/bin/bash

make clean all

gem5-o3 -c ./02_basic_vec.axf -o "128 128 128"
