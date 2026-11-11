!> Right triangle shape (defined by its two legs).
module right_triangle_mod
   use shape_base_mod, only: dp, shape_t, fmt
   implicit none
   private

   public :: right_triangle_t

   type, extends(shape_t) :: right_triangle_t
      real(dp) :: base   = 0.0_dp   ! one leg
      real(dp) :: height = 0.0_dp   ! the other leg
   contains
      procedure :: area     => right_triangle_area
      procedure :: describe => right_triangle_describe
   end type right_triangle_t

contains

   pure function right_triangle_area(this) result(a)
      class(right_triangle_t), intent(in) :: this
      real(dp) :: a
      a = 0.5_dp * this%base * this%height
   end function right_triangle_area

   function right_triangle_describe(this) result(s)
      class(right_triangle_t), intent(in) :: this
      character(len=:), allocatable :: s
      s = 'Right triangle (base = ' // fmt(this%base) // &
          ', height = ' // fmt(this%height) // ')'
   end function right_triangle_describe

end module right_triangle_mod
