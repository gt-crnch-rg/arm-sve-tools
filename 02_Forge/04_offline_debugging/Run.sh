#!/bin/bash
make clean all
 
ddt --offline --output=initial.txt --mem-debug -np 8 ./*_c.exe
