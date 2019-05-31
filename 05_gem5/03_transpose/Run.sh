#!/bin/bash

make clean all

gem5-o3 -c ./03_transpose.axf -o "128 128 128"
