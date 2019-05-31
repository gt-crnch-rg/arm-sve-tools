#!/bin/bash
make clean all
 
ddt --offline --output=final.html --mem-debug -np 8 ./*_c.exe
