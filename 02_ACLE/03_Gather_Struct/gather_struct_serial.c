#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

const uint32_t SIZE = 1024;

typedef struct {
    int32_t x;
    int32_t y;
} Particle_t;

void move(Particle_t p[SIZE], int32_t x, int32_t y)
{
    for (int i=0; i<SIZE; i++) {
        p[i].x += x;
        p[i].y += y;
    }
}

int main()
{
    Particle_t particles[SIZE] = {{1,2},{2,3},{-1,1},{2,0},{-2,1}}; //initializes first 5 numbers

    for (int i=0; i<1; i++) {
	move(particles, 1, -1);
    }

    for (int i=0; i<5; i++) {
        printf("[%i] = (%i,%i)\n", i, particles[i].x, particles[i].y);
    }

    return 0;
}
