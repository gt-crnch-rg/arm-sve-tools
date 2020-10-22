CC=armclang
CXX=armclang++
CFLAGS=-g -Ofast -fopenmp -mcpu=native -armpl
CXXFLAGS=${CFLAGS} -std=c++11
LFLAGS=

VERSION_NUM=6
SRC_NAME=mat_mult_${VERSION_NUM}.cpp
EXEC_NAME=mat_mult_${VERSION_NUM}

all: mat_mult 

mat_mult: $(SRC_NAME)
	$(CXX) $(CXXFLAGS) -o $(EXEC_NAME) $< $(LFLAGS)

clean:
	rm -rf $(EXEC_NAME) 
