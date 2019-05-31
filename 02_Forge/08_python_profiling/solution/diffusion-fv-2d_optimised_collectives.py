#!/usr/bin/env python
from __future__ import print_function
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import argparse
import sys
from mpi4py import MPI


def main(args):
    parser = argparse.ArgumentParser(description='2D diffusion implemented using a finite volume discretisation.')
    parser.add_argument("--visualise", help="visualise the diffusion", type=int, default=0)
    parser.add_argument("--quiet", help="suppress output", action="store_true", default=False)
    parser.add_argument("--initial", help="initial conditions", choices=["cylinder", "cube"], default="cylinder")
    options = parser.parse_args(args)

    if options.visualise > 0:
        plt.ion()
        fig = plt.figure()
        ax = fig.add_subplot(111, projection='3d')

    comm = MPI.COMM_WORLD
    size = comm.Get_size()
    rank = comm.Get_rank()


    dx = 0.01
    dy = 0.01
    datax = np.arange(0, 1, dx)
    datay = np.arange(0, 1, dy)
    nx = datax.size
    ny = datay.size
    datax, datay = np.meshgrid(datax, datay)
    hat_height = 2
    u = np.ones((ny, nx))

    if options.initial == "cylinder":
        cylinder_init(u, nx, ny, hat_height)
    else:
        cube_init(u, nx, ny, hat_height)

    un = u.copy()
    nu = 0.3
    sigma = 0.2
    dt = sigma*dx*dy
    draw = options.visualise


    xlow = int((nx/size)*rank)
    xhigh = int((nx/size)*(rank+1))-1
    if rank == 0:
       xlow = 1
    if rank == size-1:
       xhigh = nx -2

    xxhigh = xhigh+1

    msize = ((xhigh - xlow)+1)*ny
    sizes = comm.gather(msize) or []
    displacements = [int(sum(sizes[:i])) for i in range(len(sizes))]


    print(rank, size, xlow, xhigh, nx, ny)


    glo_min = np.min(u)
    glo_max = np.max(u)
    glo_sum = np.sum(u)


    
    while glo_max - glo_min > 0.01:
        u[xlow:xxhigh,1:-1] = un[xlow:xxhigh,1:-1] - nu * (dt *
            ((un[xlow:xxhigh,1:-1] - un[xlow+1:xxhigh+1,1:-1]) * (dx/dy)
            - (un[xlow-1:xxhigh-1,1:-1] - un[xlow:xxhigh,1:-1]) * (dx/dy)
            + (un[xlow:xxhigh,1:-1] - un[xlow:xxhigh,2:]) * (dy/dx)
            - (un[xlow:xxhigh,0:-2] - un[xlow:xxhigh,1:-1]) * (dy/dx)) / (dy*dx))
        solid_boundary(u)
        # Halo exchange
        halo(u, xlow, xhigh, nx, ny, comm, rank, size)
        
        loc_sum = np.sum(u[xlow:xxhigh,1:-1])
        loc_min = np.min(u[xlow:xxhigh,1:-1])
        loc_max = np.max(u[xlow:xxhigh,1:-1])

        send_buf = np.array([loc_sum, loc_min, loc_max])
        recv_buf = np.zeros([size,3])

        comm.Allgather([send_buf, 3, MPI.DOUBLE], [recv_buf, MPI.DOUBLE])
        #print(rank, loc_min, "send", send_buf, " min ", recv_buf[:,1])
        glo_min = np.min(recv_buf[:,1])
        glo_max = np.max(recv_buf[:,2])
        glo_sum = np.sum(recv_buf[:,0])

        #glo_min = comm.allreduce(loc_min, op=MPI.MIN)
        #glo_max = comm.allreduce(loc_max, op=MPI.MAX)
        #glo_sum = comm.allreduce(loc_sum,  op=MPI.SUM)
       

        if not options.quiet and rank == 0:
            print("sum(u): ", glo_sum, glo_max - glo_min)

        if options.visualise > 0:
            draw = draw-1
            if draw == 0:
                # Collective
                #data = np.ones(((xxhigh-xlow)+1,ny))
                data = u[xlow:xxhigh].copy()
                u1 = np.ones((nx,ny))
                comm.Gatherv([data, msize, MPI.DOUBLE], [u1, (sizes, displacements), MPI.DOUBLE], root=0)
                if rank == 0:
                   ax.plot_surface(datay[1:-1,1:-1], datax[1:-1,1:-1], u1[0:-2,1:-1], cmap=cm.viridis)
                   ax.set_zlim(bottom=1, top=hat_height)
                   plt.draw()
                   plt.pause(0.1)
                   ax.cla()
                draw = options.visualise
        tmp = un
        un = u
        u = tmp

    if not options.quiet and rank == 0:
        print("Delta uniform reached: max, min", glo_max, glo_min)

def cylinder_init(u, nx, ny, h):
    for x in range(1, nx):
        for y in range(2, ny):
            u[x,y] = h if (0.5*nx-x)**2 + (0.5*ny-y)**2 - ((0.25*nx)**2) < 0 else 1

def cube_init(u, nx, ny, h):
    u[int(0.2*ny):int(0.8*ny),int(0.2*nx):int(0.8*nx)] = h

def solid_boundary(u):
    u[0,:] = u[1,:]
    u[-1,:] = u[-2,:]
    u[:,0] = u[:,1]
    u[:,-1] = u[:,-2]

def halo(u, xlow, xhigh, nx, ny, comm, rank, size):

   # Inefficient pairwise halo exchange
    data = np.ones(ny)
    if rank % 2 == 0:
       # Send right recv right
       if rank < size - 1:
          # Dont send off end
          data = u[xhigh].copy()
          comm.Send([data,ny+1, MPI.DOUBLE], dest=rank+1)
          comm.Recv([data,ny+1, MPI.DOUBLE], source=rank+1)
          u[xhigh+1] = data.copy()
    else:
       # Rec left send left
       if rank > 0:
          # Dont recv off end
          comm.Recv([data,ny+1, MPI.DOUBLE], source=rank -1)
          u[xlow-1] = data.copy()
          data = u[xlow].copy()
          comm.Send([data,ny+1, MPI.DOUBLE], dest=rank-1)

    if rank % 2 == 0:
       # Send left recv left
       if rank > 0:
          # Dont send off end
          data = u[xlow].copy()
          comm.Send([data,ny+1, MPI.DOUBLE], dest=rank-1)
          comm.Recv([data,ny+1, MPI.DOUBLE], source=rank-1)
          u[xlow-1] = data.copy()
    else:
       # Rec right send right
       if rank < size - 1:
          # Dont recv off end
          comm.Recv([data,ny+1, MPI.DOUBLE], source=rank+1)
          u[xhigh+1] = data.copy()
          data = u[xhigh].copy()
          comm.Send([data,ny+1, MPI.DOUBLE], dest=rank+1)

    return


if __name__ == "__main__":
    main(sys.argv[1:])
