#!/bin/bash

make clean all

/opt/gem5/bin/gem5-o3 -c ./04_blocked_transpose.axf -o "128 128 128"
