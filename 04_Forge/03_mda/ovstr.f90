program supraquantum_source
  use mpi
  implicit none
  integer :: pe, gpe, nprocs, ierr
  integer, parameter :: np=8
  integer ranks1(np/2), ranks2(np/2)
  integer :: orig_group, new_group, new_comm
  data ranks1 /0, 1, 2, 3/
  data ranks2 /4, 5, 6, 7/
  integer :: st(MPI_STATUS_SIZE)
  
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
  call MPI_GROUP_INCL(orig_group, nprocs/2, ranks2, new_group, ierr)
  call MPI_COMM_CREATE(MPI_COMM_WORLD, new_group, new_comm, ierr)
  call MPI_GROUP_RANK(new_group, gpe, ierr)

  call overlap
  call stride

  call MPI_FINALIZE(ierr)

contains

  subroutine overlap

    implicit none
    integer :: from,count,j, index, iterations
    real(kind=8)    :: a(300),b(300)
    integer :: reqs(np/2-1),startsig
    integer :: stat(mpi_status_size),ierr

    if (gpe == 0) print *,"inflexible approach"

    do iterations=1,6
      a(:) = 1000.0*real(gpe+2.0)
      if (gpe == 1) then
        do j=1,20*nprocs; a=sqrt(a)*sqrt(a+1.1); end do
      end if

      if (gpe /= 0) then
        call MPI_SEND(a, size(a), MPI_REAL8, 0, 1, new_comm, ierr)
      else
        do from=1,np/2-1
          call MPI_RECV(b, size(b), MPI_REAL8, from, 1, new_comm, stat, ierr)
          do j=1,50; b=sqrt(b)*sqrt(b+1.1); end do
        end do
      end if
    end do

    call MPI_BARRIER(new_comm,ierr)

    if (gpe == 0) print *,"flexible approach"

    do iterations=1,4
      a(:) = 1000.0*real(gpe+2.0)
      if (gpe == 1) then
        do j=1,20*nprocs; a=sqrt(a)*sqrt(a+1.1); end do
      end if

      if (gpe /= 0) then
        call MPI_SEND(a, size(a), MPI_REAL8, 0, 1, new_comm, ierr)
      else
        do from=1,np/2-1
          call MPI_IRECV(b, size(b), MPI_REAL8, from, 1, new_comm, reqs(from), ierr)
        end do
        count = 0
        do while (count < np/2-1) 
          call MPI_WAITANY(np/2-1, reqs, index, stat, ierr)
          from=index+1
          count = count + 1
          do j=1,50;b=sqrt(b)*sqrt(b+1.1);end do
        end do
      end if
    end do
    if (gpe == 0) print *,"supraquantum structures induction:",b(1)
    call MPI_BARRIER(new_comm,ierr)

  end subroutine overlap

  subroutine stride

    implicit none
    real(kind=8) :: arr_in(25,25)
    real(kind=8) :: arr_out(25,25)
    integer :: i,j
    integer :: stat(mpi_status_size),ierr

    call MPI_RECV(arr_in,25*25,MPI_REAL8,gpe,111+gpe,MPI_COMM_WORLD,stat, ierr)

    do i=1,25
      do j=1,25
        arr_out(i,j)=gpe*i*j
        if(mod(i,3)>1 .and. gpe<2 .or. gpe>1 .and. mod(j,4)>1) arr_out(i,j)=arr_out(i,j)+sqrt(arr_in(i,j))
      end do
    end do

    call MPI_BARRIER(new_comm,ierr)

    print *,"pulse from mode-locked source array:", gpe, ", ",sum(arr_out)

    call MPI_BARRIER(new_comm,ierr)

  end subroutine stride

end program supraquantum_source
