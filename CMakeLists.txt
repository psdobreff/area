cmake_minimum_required(VERSION 3.16)
include(${CMAKE_CURRENT_LIST_DIR}/cmake/brew-gcc16.cmake)
project(area LANGUAGES NONE)

# Build whichever languages have a working compiler. Each subdirectory can
# also be configured on its own, e.g. `cmake -S cpp -B build-cpp`.
include(CheckLanguage)

set(run_targets)
foreach(lang IN ITEMS CXX Fortran)
  check_language(${lang})
  if(CMAKE_${lang}_COMPILER)
    string(TOLOWER ${lang} dir)
    if(dir STREQUAL "cxx")
      set(dir cpp)
    endif()
    add_subdirectory(${dir})
    list(APPEND run_targets run_${dir})
  else()
    message(STATUS "No ${lang} compiler found; skipping that version")
  endif()
endforeach()

if(NOT run_targets)
  message(FATAL_ERROR "Neither a C++ nor a Fortran compiler was found")
endif()

add_custom_target(run DEPENDS ${run_targets})
