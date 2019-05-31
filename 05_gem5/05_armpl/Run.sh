#!/bin/bash

make clean all

gem5-o3 -c ./05_armpl.axf -o "128 128 128"
