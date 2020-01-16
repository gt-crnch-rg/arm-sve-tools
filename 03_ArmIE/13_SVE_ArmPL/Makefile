CC=armclang
CXX=armclang++
CFLAGS=-g -Ofast -march=armv8-a+sve
CXXFLAGS=${CFLAGS} -std=c++11
LFLAGS=


all: mat_mult_blocked mat_mult_armpl mat_mult_armpl_sve

mat_mult_blocked: mat_mult_blocked.cpp
	$(CXX) $(CXXFLAGS) -o mat_mult_blocked $< $(LFLAGS)


mat_mult_armpl: mat_mult_armpl.cpp
	$(CXX) $(CXXFLAGS) -armpl -o mat_mult_armpl $< $(LFLAGS)


mat_mult_armpl_sve: mat_mult_armpl.cpp
	$(CXX) $(CXXFLAGS) -armpl=sve -o mat_mult_armpl_sve $< $(LFLAGS)

clean:
	rm -rf mat_mult_block mat_mult_armpl mat_mult_armpl_sve 
