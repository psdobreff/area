# Default to Homebrew's GCC 16 compilers (g++-16 / gfortran-16).
# Include this before project(). An explicit -DCMAKE_<LANG>_COMPILER=...
# still takes precedence.
set(_brew_hints $ENV{HOMEBREW_PREFIX}/bin /home/linuxbrew/.linuxbrew/bin
    /opt/homebrew/bin /usr/local/bin)

foreach(_pair IN ITEMS "CXX;g++-16" "Fortran;gfortran-16")
  list(GET _pair 0 _lang)
  list(GET _pair 1 _name)
  if(NOT CMAKE_${_lang}_COMPILER)
    find_program(_brew_${_lang} NAMES ${_name} HINTS ${_brew_hints})
    if(_brew_${_lang})
      set(CMAKE_${_lang}_COMPILER ${_brew_${_lang}} CACHE FILEPATH
          "${_lang} compiler" FORCE)
    endif()
  endif()
endforeach()
