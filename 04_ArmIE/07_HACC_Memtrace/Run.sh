#!/bin/bash
make clean all
rm -rf *.log

armie -e libmemtrace_sve_512.so -i libmemtrace_simple.so -- ./HACCKernels 50

ls *.log

echo "Native instructions: memtrace"
python ./postprocess.py `ls memtrace*`

echo ""
echo ""
echo "Emulated instructions: memtrace"
python ./postprocess.py `ls sve*`

python ./merge.py --memtrace -o out.log `ls *.log`
