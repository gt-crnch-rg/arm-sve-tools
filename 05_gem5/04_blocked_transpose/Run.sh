#!/bin/bash

make clean all

gem5-o3 -c ./04_blocked_transpose.axf -o "128 128 128"
