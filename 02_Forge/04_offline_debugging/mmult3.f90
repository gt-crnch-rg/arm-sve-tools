program mmult3
  use mpi

#define DEFAULT_FN "res3_f90.mat"
#ifdef DEBUG
#define DEFAULT_SIZE 1024
#else
#define DEFAULT_SIZE 3072
#endif

  implicit none
  integer           :: iargs, myrank, nproc, ierr, i, size, slice, st(MPI_STATUS_SIZE)
  real(8), pointer  :: mat_a(:), mat_b(:), mat_c(:)
  character(32)     :: arg, filename

  call MPI_INIT(ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
  
  if(myrank==0) then

    iargs = COMMAND_ARGUMENT_COUNT()

    if(iargs>2) then
      print *,"Usage: ./mmult3_f90.exe SIZE FILENAME"
      print *,"    SIZE: size of the matrix to compute (default is ", DEFAULT_SIZE, ")"
      print *,"    FILENAME: output matrix file name (default is ", DEFAULT_FN, ")"

      call exit(1)
    end if

    if(iargs>0) then
      call GET_COMMAND_ARGUMENT(1, arg)
      read(arg, '(i10)') size ! set size for master
    else
      size=DEFAULT_SIZE
    end if

    if(iargs==2) then
      call GET_COMMAND_ARGUMENT(2, filename) ! set filename
    else
      filename=DEFAULT_FN
    end if

    if(mod(size,nproc)/=0) then
      print *,"Error: SIZE (", size, ") must be a multiple of number of processes (", nproc,")"

      call exit(1)
    end if

    print *, myrank, ": Size of the matrices: ", size, "x", size
    
    do i=1,nproc-1
      call MPI_Send(size, 1, MPI_INT, i, i, MPI_COMM_WORLD, ierr)
    end do
  else
    call MPI_Recv(size, 1, MPI_INT, 0, myrank, MPI_COMM_WORLD, st, ierr) ! set size for slaves
  end if

  slice=size*size/nproc ! set slice size in number of elements

  if(myrank==0) then
    allocate(mat_a(0:size*size-1))
    allocate(mat_b(0:size*size-1))
    allocate(mat_c(0:size*size-1))

    print *,myrank,": Initializing matrices..."

    call minit(size, mat_a)
    call minit(size, mat_b)
    mat_b => mtrans(size, mat_b)
    call minit(size, mat_c)
    
    print *,myrank,": Sending matrices..."

    do i=1,nproc-1
      call MPI_Send(mat_a(slice*i), slice, MPI_DOUBLE, i, 100+i, MPI_COMM_WORLD, ierr)
      call MPI_Send(mat_b, size*size, MPI_DOUBLE, i, 200+i, MPI_COMM_WORLD, ierr)
      call MPI_Send(mat_c(slice*i), slice, MPI_DOUBLE, i, 300+i, MPI_COMM_WORLD, ierr)
    end do
  else
    allocate(mat_a(0:slice-1))
    allocate(mat_b(0:size*size-1))
    allocate(mat_c(0:slice-1))

    print *,myrank,": Receiving matrices..."
    
    call MPI_Recv(mat_a, slice, MPI_DOUBLE, 0, 100+myrank, MPI_COMM_WORLD, st, ierr)
    call MPI_Recv(mat_b, size*size, MPI_DOUBLE, 0, 200+myrank, MPI_COMM_WORLD, st, ierr)
    call MPI_Recv(mat_c, slice, MPI_DOUBLE, 0, 300+myrank, MPI_COMM_WORLD, st, ierr)
  end if
  
  print *,myrank,": Processing..."

  call mmult(size, nproc, mat_a, mat_b, mat_c)

  if(myrank==0) then
    print *,myrank,": Receiving result matrix..."

    do i=1,nproc-1
      call MPI_Recv(mat_c(slice*i), slice, MPI_DOUBLE, i, 500+i, MPI_COMM_WORLD, st, ierr)
    end do
  else
    print *,myrank,": Sending result matrix..."
    
    call MPI_Send(mat_c, slice, MPI_DOUBLE, 0, 500+myrank, MPI_COMM_WORLD, ierr)
  end if

  if(myrank==0) then
    print *,myrank,": Writing results..."
    call mwrite(size, mat_c, filename)
    print *,myrank,": Done."
  endif

  deallocate(mat_a)
  deallocate(mat_b)
  deallocate(mat_c)

  call MPI_Finalize(ierr)

contains

  subroutine minit(size, A)
    integer, intent(in)   :: size
    real(8), intent(out)  :: A(0:size*size-1)
    real(8)               :: num
    integer               :: i,j

    call random_seed()

    do i=0,size-1
      do j=0,size-1
#ifdef DEBUG
        A(i*size+j)=i*(j+1)
#else
        call random_number(num)
        A(i*size+j)= num * 1000
#endif
      end do
    enddo
  end subroutine minit

  subroutine mwrite(size, A, fn)
    integer, intent(in)       :: size
    real(8), intent(in)      :: A(0:size*size-1)
    character(32), intent(in) :: fn
    integer                   :: i,j

    open(unit=12, file=fn, status="replace")

    do i=0,size-1
      do j=0,size-1
        write(12, "(E10.3)", advance="no"), A(i*size+j)
      end do
      write(12, "(A)", advance="yes") " "
    end do
    close(12)
  end subroutine mwrite

  subroutine mmult(size, nslices, A, transB, C)
    integer, intent(in)     :: size, nslices
    real(8), intent(in)     :: A(0:size*size-1), transB(0:size*size-1)
    real(8), intent(inout)  :: C(0:size*size-1)
    integer                 :: i,j,k
    real(8)                 :: res

    do i=0,size/nslices-1
      do j=0,size-1
        res=0.0
        do k=0,size-1
         res=A(i*size+k)*transB(j*size+k)+res
        end do
        C(i*size+j)=res+C(i*size+j)
      end do
    end do
  end subroutine mmult

  function mtrans(size, A)
    integer, intent(in) :: size
    real(8), intent(in) :: A(0:size*size-1)
    real(8), pointer    :: mtrans(:)
    integer             :: i,j

    allocate(mtrans(0:size*size-1))

    do i=0,size-1
      do j=0,size-1
        mtrans(i*size+j)=A(j*size+i)
      end do
    end do

    return
  end function mtrans

end program mmult3

