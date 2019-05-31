CC=armclang
CXX=armclang++
CFLAGS=-g -Ofast -mcpu=native
CXXFLAGS=${CFLAGS} -std=c++11
LFLAGS=

VERSION_NUM=1
SRC_NAME=mat_mult_${VERSION_NUM}.cpp
EXEC_NAME=mat_mult_${VERSION_NUM}

all: mat_mult 

mat_mult: $(SRC_NAME)
	$(CXX) $(CXXFLAGS) -o ${EXEC_NAME} $< $(LFLAGS)

clean:
	rm -rf $(EXEC_NAME)
