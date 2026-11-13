!> Circle shape.
module circle_mod
   use shape_base_mod, only: shape_t, fmt
   implicit none
   private

   public :: circle_t

   real, parameter :: pi = acos(-1.0)

   type, extends(shape_t) :: circle_t
      real :: radius = 0.0
   contains
      procedure :: area     => circle_area
      procedure :: describe => circle_describe
   end type circle_t

contains

   pure function circle_area(this) result(a)
      class(circle_t), intent(in) :: this
      real :: a
      a = pi * this%radius**2
   end function circle_area

   function circle_describe(this) result(s)
      class(circle_t), intent(in) :: this
      character(len=:), allocatable :: s
      s = 'Circle (radius = ' // fmt(this%radius) // ')'
   end function circle_describe

end module circle_mod
