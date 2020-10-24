program teleportation
  use mpi
  implicit none
  integer :: pe, gpe, nprocs, ierr
  integer, parameter :: np=8
  integer ranks1(np/2), ranks2(np/2)
  integer :: orig_group, new_group, new_comm
  data ranks1 /0, 1, 2, 3/
  data ranks2 /4, 5, 6, 7/

  common /shared/ gpe,new_comm

  call MPI_INIT(ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, pe, ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)

  if (nprocs .ne. np) then
    print *, 'Must specify NPROCS=', np, '. Terminating.'
    call MPI_FINALIZE(ierr)
    stop
  endif

  call MPI_COMM_GROUP(MPI_COMM_WORLD, orig_group, ierr)
  call MPI_GROUP_INCL(orig_group, nprocs/2, ranks1, new_group, ierr)
  call MPI_COMM_CREATE(MPI_COMM_WORLD, new_group, new_comm, ierr)
  call MPI_GROUP_RANK(new_group, gpe, ierr)

  call imbalance
  call power

  call MPI_FINALIZE(ierr)

contains

  subroutine imbalance

    integer :: i,j
    real(kind=8)    :: a(25,25),b(25,25)

    a=11.1*gpe
    do j=1,gpe
      do i=1,25
        call random_seed
        call random_number(a(i,i))    ! random number between 0 and 1
        a(i,i)=a(i,i)*(150+j*gpe-size(a)/4)
      end do
    end do
    call MPI_ALLREDUCE(a,b,size(a),MPI_REAL8,MPI_SUM,new_comm,ierr)

    if (gpe == 0) print *,"nonlinear transuranic crystal",b(1,1)

    call MPI_BARRIER(new_comm,ierr)

    call MPI_SEND(a,25*25,MPI_REAL8,4+gpe,111+gpe,MPI_COMM_WORLD,ierr)


  end subroutine imbalance

  subroutine power

    implicit none
    integer :: i,iterations
    real(kind=8) :: two,three,four
    real(kind=8) :: a(800),b(800)

    two=2.0
    three=3.0
    four=4.0

    do i=1,200
      a(i)=1.1*i
    end do

    do i=1,200
      b(i)=a(i)*two+sqrt(a(i)*two*three*four)+b(i)
    end do

    if (pe == 0) print *,"wavelength",b(66)

    call MPI_BARRIER(new_comm,ierr)

  end subroutine power

end program teleportation
