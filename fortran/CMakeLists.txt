cmake_minimum_required(VERSION 3.16)
project(area_fortran LANGUAGES Fortran)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
  endif()
  set(standalone TRUE)
endif()

set(SHAPE_INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../shape.in CACHE FILEPATH
    "Input file used by the run targets")

# CMake scans Fortran sources for module dependencies, so no manual
# ordering is needed.
add_executable(area_fortran
  shape_base_mod.f90
  rectangle_mod.f90
  square_mod.f90
  circle_mod.f90
  right_triangle_mod.f90
  shapes_mod.f90
  area.f90
)
set_target_properties(area_fortran PROPERTIES
  OUTPUT_NAME area
  Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod
)
target_compile_options(area_fortran PRIVATE -std=f2018 -Wall -Wextra)

add_custom_target(run_fortran
  COMMAND area_fortran ${SHAPE_INPUT}
  DEPENDS area_fortran
  USES_TERMINAL
)
if(standalone)
  add_custom_target(run DEPENDS run_fortran)
endif()
