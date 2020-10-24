program cpi
  use mpi

  integer :: done, n, myid, numprocs, i, namelen, err
  real*8, parameter :: PI25DT=3.141592653589793238462643
  real*8 mypi, pi, h, sum, x, starttime, endtime
  character(MPI_MAX_PROCESSOR_NAME) :: processor_name

  call MPI_Init(err)
  call MPI_Comm_size(MPI_COMM_WORLD, numprocs, err)
  call MPI_Comm_rank(MPI_COMM_WORLD, myid, err)
  call MPI_Get_processor_name(processor_name, namelen, err)

  done = 0 

  print *,"Process ", myid, " on ", processor_name

  n = 0
  do while(done.eq.0)
    if (myid.eq.0) then
      if (n.eq.0) then
        n=100
      else
        n=0
      endif
      startwtime=MPI_Wtime()
    endif
    call MPI_Bcast(n, 1, MPI_INT, 0, MPI_COMM_WORLD, err)

    if (n.eq.0) then
      done=1
    else
      h=1.0/n
      sum=0.0
      do i=myid+1,n,numprocs
        x=h*(i-0.5)
        sum=sum+f(x)
        call MPI_Barrier(MPI_COMM_WORLD, err)
      end do
      mypi=h*sum
      call MPI_Reduce(mypi, pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD, err)
      if(myid.eq.0) then
       print *,"pi is approximately ", pi, ", Error is ", abs(pi-PI25DT)
       endwtime = MPI_Wtime()
		   print *,"wall clock time = ", endwtime-startwtime
      end if
    end if
  end do

  call MPI_Finalize(err)
  
  stop

contains
  real*8 function f(a)
    real*8, intent(in)  :: a

    f = 4.0 / (1.0+a*a)
  end function f

end program cpi

