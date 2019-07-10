cmake_minimum_required(VERSION 3.11)

project(FCIdump VERSION 1.0 LANGUAGES C CXX)
set(CMAKE_CXX_STANDARD 14)
if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    option(FORTRAN "Whether to build fortran binding" ON)
endif ()
if (FORTRAN)
    enable_language(Fortran)
endif ()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(libconfig)


########## Compiler Flags ##########

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-Wall" _Wall)
if (_Wall)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall")
endif ()

if (CMAKE_Fortran_COMPILER_ID)
    message("Configuring Fortran support for ${CMAKE_CURRENT_SOURCE_DIR}")
    include(CheckFortranCompilerFlag)
    foreach (f "-fdefault-integer-8" "-i8")
        CHECK_Fortran_COMPILER_FLAG(${f} _fortran_flags)
        if (_fortran_flags)
            set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${f}")
        endif ()
        unset(_fortran_flags CACHE)
    endforeach ()
    CHECK_Fortran_COMPILER_FLAG("-Wall" _Wallf)
    if (_Wallf)
        set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -Wall")
    endif ()
endif ()


add_subdirectory(dependencies)


########## Targets ##########

add_subdirectory(lib)
enable_testing()
add_subdirectory(test)
add_subdirectory(example)


########## Documentation ##########

find_package(Doxygen)
if (DOXYGEN_FOUND)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
    SET(doxyfile_in ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
    SET(doxyfile ${PROJECT_BINARY_DIR}/Doxyfile)
    SET(doxy_html_index_file ${CMAKE_CURRENT_BINARY_DIR}/html/index.html)
    SET(doxy_input ${SRCS})
    CONFIGURE_FILE(${doxyfile_in} ${doxyfile} @ONLY)
    file(GLOB headers lib/*.h lib/*.F90)
    ADD_CUSTOM_COMMAND(OUTPUT ${doxy_html_index_file}
            COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
            MAIN_DEPENDENCY ${doxyfile} ${doxyfile_in}
            DEPENDS ${headers}
            COMMENT "Generating API documentation with Doxygen" VERBATIM)
    ADD_CUSTOM_TARGET(FCIdump-doc ALL DEPENDS ${doxy_html_index_file})
endif (DOXYGEN_FOUND)
