cmake_minimum_required(VERSION 3.16)
include(${CMAKE_CURRENT_LIST_DIR}/../cmake/brew-gcc16.cmake)
project(area_cpp LANGUAGES CXX)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
  endif()
  set(standalone TRUE)
endif()

set(SHAPE_INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../shape.in CACHE FILEPATH
    "Input file used by the run targets")

add_executable(area_cpp
  shape.cpp
  rectangle.cpp
  square.cpp
  circle.cpp
  right_triangle.cpp
  shapes.cpp
  area.cpp
)
set_target_properties(area_cpp PROPERTIES OUTPUT_NAME area CXX_EXTENSIONS OFF)
target_compile_features(area_cpp PRIVATE cxx_std_17)
target_compile_options(area_cpp PRIVATE -Wall -Wextra)

add_custom_target(run_cpp
  COMMAND area_cpp ${SHAPE_INPUT}
  DEPENDS area_cpp
  USES_TERMINAL
)
if(standalone)
  add_custom_target(run DEPENDS run_cpp)
endif()
