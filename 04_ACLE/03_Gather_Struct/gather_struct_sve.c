#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <arm_sve.h>

const uint32_t SIZE = 1024;

typedef struct {
    int32_t x;
    int32_t y;
} Particle_t;

void move(Particle_t p[SIZE], int32_t x, int32_t y)
{
    uint32_t vl = svcntw();

    svbool_t p32_all = svptrue_b32();

    for (int i=0; i<SIZE; i+=vl) {
        svint32x2_t vp = svld2(p32_all, (int32_t*)&p[i]);

        vp.v0 = svadd_m(p32_all, vp.v0, x);
        vp.v1 = svadd_m(p32_all, vp.v1, y);

        svst2(p32_all, (int32_t*)&p[i], vp);
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
