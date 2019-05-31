#!/bin/bash

make clean all

/opt/gem5/bin/gem5-o3 -c ./05_armpl.axf -o "128 128 128"
