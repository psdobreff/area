!> Shape factory and single import point for the shape hierarchy.
!>
!> Re-exports the base type and every concrete shape (each defined in its
!> own file), and provides `create_shape`, which builds the right concrete
!> type from a name and a list of dimensions.
module shapes_mod
   use shape_base_mod,     only: dp, shape_t
   use rectangle_mod,      only: rectangle_t
   use circle_mod,         only: circle_t
   use right_triangle_mod, only: right_triangle_t
   implicit none
   private

   public :: dp, shape_t, rectangle_t, circle_t, right_triangle_t, create_shape

contains

   !--------------------------------------------------------------------------
   ! Factory: build a shape from its name and dimensions.
   ! On failure `shp` is left unallocated and `errmsg` explains why.
   !--------------------------------------------------------------------------
   subroutine create_shape(name, dims, shp, errmsg)
      character(len=*),              intent(in)  :: name
      real(dp),                      intent(in)  :: dims(:)
      class(shape_t), allocatable,   intent(out) :: shp
      character(len=:), allocatable, intent(out) :: errmsg

      errmsg = ''

      if (any(dims <= 0.0_dp)) then
         errmsg = 'all dimensions must be positive'
         return
      end if

      select case (to_lower(trim(adjustl(name))))
      case ('rectangle')
         if (.not. need(2)) return
         shp = rectangle_t(width=dims(1), height=dims(2))
      case ('circle')
         if (.not. need(1)) return
         shp = circle_t(radius=dims(1))
      case ('right_triangle', 'righttriangle', 'triangle')
         if (.not. need(2)) return
         shp = right_triangle_t(base=dims(1), height=dims(2))
      case default
         errmsg = 'unknown shape "' // trim(name) // &
                  '" (valid: rectangle, circle, right_triangle)'
      end select

   contains

      logical function need(n)
         integer, intent(in) :: n
         character(len=16) :: want, got
         need = size(dims) == n
         if (.not. need) then
            write (want, '(i0)') n
            write (got,  '(i0)') size(dims)
            errmsg = trim(name) // ' needs ' // trim(want) // &
                     ' dimension(s), got ' // trim(got)
         end if
      end function need

   end subroutine create_shape

   pure function to_lower(str) result(out)
      character(len=*), intent(in) :: str
      character(len=len(str)) :: out
      integer :: i, c
      out = str
      do i = 1, len(str)
         c = iachar(str(i:i))
         if (c >= iachar('A') .and. c <= iachar('Z')) out(i:i) = achar(c + 32)
      end do
   end function to_lower

end module shapes_mod
