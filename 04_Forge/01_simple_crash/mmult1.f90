program mmult1
  use mpi

  implicit none
  integer           :: mr, nproc, ierr, i, sz, slice, st(MPI_STATUS_SIZE), remainder
  real(8), pointer  :: mat_a(:), mat_b(:), mat_c(:)
  character(32)     :: arg, filename

  call MPI_INIT(ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, mr, ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
  
  if(mr==0) then

    sz=1024

    filename="res2_f90.mat"

    remainder = mod(sz,nproc)
    if(remainder/=0) then
      print *, mr, ": Info: reducing SIZE (", sz, ") to", sz-remainder

      sz = sz-remainder
    end if

    print *, mr, ": Size of the matrices: ", sz, "x", sz
    
    do i=1,nproc-1
      call MPI_Send(sz, 1, MPI_INT, i, i, MPI_COMM_WORLD, ierr)
    end do
  else
    call MPI_Recv(sz, 1, MPI_INT, 0, mr, MPI_COMM_WORLD, st, ierr) ! set sz for slaves
  end if

  slice=sz*sz/nproc ! set slice size in number of elements

  if(mr==0) then
    allocate(mat_a(0:sz*sz-1))
    allocate(mat_b(0:sz*sz-1))
    allocate(mat_c(0:sz*sz-1))

    print *,mr,": Initializing matrices..."

    call minit(sz, mat_a)
    call minit(sz, mat_b)
    call minit(sz, mat_c)
    
    print *,mr,": Sending matrices..."

    do i=1,nproc-1
      call MPI_Send(mat_a(slice*i), slice, MPI_DOUBLE, i, 100+i, MPI_COMM_WORLD, ierr)
      call MPI_Send(mat_b, sz*sz, MPI_DOUBLE, i, 200+i, MPI_COMM_WORLD, ierr)
      call MPI_Send(mat_c(slice*i), slice, MPI_DOUBLE, i, 300+i, MPI_COMM_WORLD, ierr)
    end do
  else
    allocate(mat_a(0:slice-1))
    allocate(mat_b(0:sz*sz-1))
    allocate(mat_c(0:slice-1))

    print *,mr,": Receiving matrices..."
    
    call MPI_Recv(mat_a, slice, MPI_DOUBLE, 0, 100+mr, MPI_COMM_WORLD, st, ierr)
    call MPI_Recv(mat_b, sz*sz, MPI_DOUBLE, 0, 200+mr, MPI_COMM_WORLD, st, ierr)
    call MPI_Recv(mat_c, slice, MPI_DOUBLE, 0, 300+mr, MPI_COMM_WORLD, st, ierr)
  end if
  
  print *,mr,": Processing..."

  call mmult(sz, nproc, mat_a, mat_b, mat_c)

  if(mr==0) then
    print *,mr,": Receiving result matrix..."

    do i=1,nproc-1
      call MPI_Recv(mat_c(slice*i), slice, MPI_DOUBLE, i, 500+i, MPI_COMM_WORLD, st, ierr)
    end do
  else
    print *,mr,": Sending result matrix..."
    
    call MPI_Send(mat_c, slice, MPI_DOUBLE, 0, 500+mr, MPI_COMM_WORLD, ierr)
  end if

  if(mr==0) then
    print *,mr,": Writing results..."
    call mwrite(sz, mat_c, filename)
    print *,mr,": Done."
  endif

  deallocate(mat_a)
  deallocate(mat_b)
  deallocate(mat_c)

  call MPI_Finalize(ierr)

contains

  subroutine minit(sz, A)
    integer, intent(in)   :: sz
    real(8), intent(out)  :: A(0:sz*sz-1)
    real(8)               :: num
    integer               :: i,j

    call random_seed()

    do i=0,sz-1
      do j=0,sz-1
        call random_number(num)
        A(i*sz+j)= num * 1000
      end do
    enddo
  end subroutine minit

  subroutine mwrite(sz, A, fn)
    integer, intent(in)       :: sz
    real(8), intent(in)      :: A(0:sz*sz-1)
    character(32), intent(in) :: fn
    integer                   :: i,j

    open(unit=12, file=fn, status="replace")

    do i=0,sz-1
      do j=0,sz-1
        write(12, "(E10.3)", advance="no") A(i*sz+j)
      end do
      write(12, "(A)", advance="yes") " "
    end do
    close(12)
  end subroutine mwrite

  subroutine mmult(sz, nslices, A, B, C)
    integer, intent(in)     :: sz, nslices
    real(8), intent(in)     :: A(0:sz*sz-1), B(0:sz*sz-1)
    real(8), intent(inout)  :: C(0:sz*sz-1)
    integer                 :: i,j,k
    real(8)                 :: res

    do i=0,sz/nslices-1
      do j=0,sz-1
        res=0.0
        do k=0,sz*sz
         res=A(i*sz+k)*B(k*sz+j)+res
        end do
        C(i*sz+j)=res+C(i*sz+j)
      end do
    end do
  end subroutine mmult

end program mmult1


