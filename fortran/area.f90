!> Compute the area of shapes described in an input file.
!>
!> Usage:  ./area [input_file]        (default: shape.in)
!>
!> Input file format — one shape per line, followed by its dimensions:
!>     rectangle       <width> <height>
!>     square          <side>
!>     circle          <radius>
!>     right_triangle  <base> <height>
!> Blank lines and lines beginning with '#' or '!' are ignored.
program area
   use shapes_mod, only: shape_t, create_shape
   implicit none

   integer, parameter :: max_line = 512, max_dims = 8

   character(len=:), allocatable :: filename, errmsg
   character(len=max_line) :: line, name
   class(shape_t), allocatable :: shp
   real :: dims(max_dims)
   integer :: unit, ios, line_no, ndims, nerr, nok, arglen

   ! ---- Determine input file name ------------------------------------------
   if (command_argument_count() >= 1) then
      call get_command_argument(1, length=arglen)
      allocate (character(len=arglen) :: filename)
      call get_command_argument(1, filename)
   else
      filename = 'shape.in'
   end if

   open (newunit=unit, file=filename, status='old', action='read', iostat=ios)
   if (ios /= 0) then
      write (*, '(a)') 'Error: cannot open input file "' // filename // '"'
      stop 1, quiet=.true.
   end if

   ! ---- Process each line --------------------------------------------------
   line_no = 0
   nok = 0
   nerr = 0
   do
      read (unit, '(a)', iostat=ios) line
      if (ios /= 0) exit
      line_no = line_no + 1

      line = adjustl(line)
      if (len_trim(line) == 0) cycle
      if (line(1:1) == '#' .or. line(1:1) == '!') cycle

      call parse_line(line, name, dims, ndims, ios)
      if (ios /= 0) then
         call report('could not parse dimensions')
         cycle
      end if

      call create_shape(name, dims(1:ndims), shp, errmsg)
      if (.not. allocated(shp)) then
         call report(errmsg)
         cycle
      end if

      ! Polymorphic dispatch: the correct area/describe is chosen at run time.
      write (*, '(a, t56, a, f0.6)') shp%describe(), 'Area = ', shp%area()
      nok = nok + 1
   end do
   close (unit)

   if (nok + nerr == 0) then
      write (*, '(a)') 'Error: no shapes found in "' // filename // '"'
      stop 1, quiet=.true.
   end if
   if (nerr > 0) stop 2, quiet=.true.

contains

   !> Split a line into a shape name followed by up to max_dims real numbers.
   subroutine parse_line(line, name, dims, ndims, ios)
      character(len=*), intent(in)  :: line
      character(len=*), intent(out) :: name
      real,             intent(out) :: dims(:)
      integer,          intent(out) :: ndims, ios
      character(len=len(line)) :: rest
      integer :: k

      ! Shape name is the first whitespace-delimited token.
      k = scan(line, ' ' // achar(9))
      if (k == 0) k = len(line) + 1
      name = line(:k-1)
      rest = adjustl(line(k:))

      ! Count tokens in the remainder, then read that many reals.
      ndims = count_tokens(rest)
      ios = 0
      if (ndims > size(dims)) then
         ios = 1
      else if (ndims > 0) then
         read (rest, *, iostat=ios) dims(1:ndims)
      end if
   end subroutine parse_line

   integer function count_tokens(str) result(n)
      character(len=*), intent(in) :: str
      integer :: i
      logical :: in_tok, is_sep
      n = 0
      in_tok = .false.
      do i = 1, len_trim(str)
         is_sep = str(i:i) == ' ' .or. str(i:i) == ',' .or. str(i:i) == achar(9)
         if (.not. is_sep .and. .not. in_tok) n = n + 1
         in_tok = .not. is_sep
      end do
   end function count_tokens

   subroutine report(msg)
      character(len=*), intent(in) :: msg
      write (*, '(a, i0, a)') 'Line ', line_no, ': ' // msg // &
                              '  ->  "' // trim(line) // '"'
      nerr = nerr + 1
   end subroutine report

end program area
