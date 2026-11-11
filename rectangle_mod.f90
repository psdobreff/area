!> Rectangle shape.
module rectangle_mod
   use shape_base_mod, only: dp, shape_t, fmt
   implicit none
   private

   public :: rectangle_t

   type, extends(shape_t) :: rectangle_t
      real(dp) :: width  = 0.0_dp
      real(dp) :: height = 0.0_dp
   contains
      procedure :: area     => rectangle_area
      procedure :: describe => rectangle_describe
   end type rectangle_t

contains

   pure function rectangle_area(this) result(a)
      class(rectangle_t), intent(in) :: this
      real(dp) :: a
      a = this%width * this%height
   end function rectangle_area

   function rectangle_describe(this) result(s)
      class(rectangle_t), intent(in) :: this
      character(len=:), allocatable :: s
      s = 'Rectangle (width = ' // fmt(this%width) // &
          ', height = ' // fmt(this%height) // ')'
   end function rectangle_describe

end module rectangle_mod
