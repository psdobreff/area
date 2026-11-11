!> Circle shape.
module circle_mod
   use shape_base_mod, only: dp, shape_t, fmt
   implicit none
   private

   public :: circle_t

   real(dp), parameter :: pi = acos(-1.0_dp)

   type, extends(shape_t) :: circle_t
      real(dp) :: radius = 0.0_dp
   contains
      procedure :: area     => circle_area
      procedure :: describe => circle_describe
   end type circle_t

contains

   pure function circle_area(this) result(a)
      class(circle_t), intent(in) :: this
      real(dp) :: a
      a = pi * this%radius**2
   end function circle_area

   function circle_describe(this) result(s)
      class(circle_t), intent(in) :: this
      character(len=:), allocatable :: s
      s = 'Circle (radius = ' // fmt(this%radius) // ')'
   end function circle_describe

end module circle_mod
