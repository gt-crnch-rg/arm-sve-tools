#!/usr/bin/env python3
#
# BSD 3-Clause License
# 
# Copyright (c) 2021, esiegmann
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import sys

files = sys.argv[1:]

data = []
names = []
rownames = []
for file in files:
    rownames = []
    r = []
    f = open(file)
    for line in f:
        fields = line.split()
        rownames.append(fields[0])
        r.append(float(fields[1]))
    names.append(file)
    data.append(r)

for index,compiler in enumerate(names):
    print("Compiler %2d --> %s" % (index,compiler[4:].replace(':','/')))
print()
print("Seconds per element")
print("-------------------")
print("  Test   ",end="")
for compilerindex in range(len(names)):
    print("Compiler %d  "%compilerindex,end="")
print()
print("------   ",end="")
for compilerindex in range(len(names)):
    print("----------  ", end="")
print()
for rowindex,rowname in enumerate(rownames):
    print("%6s   " % rowname,end="")
    for compilerindex in range(len(names)):
        print("%10.1e  " % data[compilerindex][rowindex],end="")
    print("")

