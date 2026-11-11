!> Square shape.
module square_mod
   use shape_base_mod, only: dp, shape_t, fmt
   implicit none
   private

   public :: square_t

   type, extends(shape_t) :: square_t
      real(dp) :: side = 0.0_dp
   contains
      procedure :: area     => square_area
      procedure :: describe => square_describe
   end type square_t

contains

   pure function square_area(this) result(a)
      class(square_t), intent(in) :: this
      real(dp) :: a
      a = this%side**2
   end function square_area

   function square_describe(this) result(s)
      class(square_t), intent(in) :: this
      character(len=:), allocatable :: s
      s = 'Square (side = ' // fmt(this%side) // ')'
   end function square_describe

end module square_mod
