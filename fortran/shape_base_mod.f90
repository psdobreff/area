!> Abstract base type for the shape hierarchy.
!>
!> `shape_t` declares the interface every shape must implement; concrete
!> types (one per file) extend it and provide their own `area` and
!> `describe` procedures.
module shape_base_mod
   use, intrinsic :: iso_fortran_env, only: dp => real64
   implicit none
   private

   public :: dp, shape_t, fmt

   type, abstract :: shape_t
   contains
      procedure(area_iface),     deferred :: area
      procedure(describe_iface), deferred :: describe
   end type shape_t

   abstract interface
      pure function area_iface(this) result(a)
         import :: shape_t, dp
         class(shape_t), intent(in) :: this
         real(dp) :: a
      end function area_iface

      function describe_iface(this) result(s)
         import :: shape_t
         class(shape_t), intent(in) :: this
         character(len=:), allocatable :: s
      end function describe_iface
   end interface

contains

   !> Format a real compactly for use in shape descriptions.
   function fmt(x) result(s)
      real(dp), intent(in) :: x
      character(len=:), allocatable :: s
      character(len=32) :: buf
      write (buf, '(g0.6)') x
      s = trim(adjustl(buf))
   end function fmt

end module shape_base_mod
