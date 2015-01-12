cmake_minimum_required(VERSION 2.6)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

project(FCIdump)
enable_language(Fortran)

file (GLOB SRCS FCIdump.cpp FCIdump.h FCIdumpF.F90)
add_library (FCIdump ${SRCS})
target_include_directories (FCIdump PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


get_filename_component(COMPILER_NAME  ${CMAKE_CXX_COMPILER} NAME)
if (${COMPILER_NAME} STREQUAL "mpic++" OR ${COMPILER_NAME} STREQUAL "mpicxx")
add_definitions(-DFCIDUMP_MPI)
endif (${COMPILER_NAME} STREQUAL "mpic++" OR ${COMPILER_NAME} STREQUAL "mpicxx")

add_custom_command(
OUTPUT testc.c
COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/testcpp.cpp testc.c
DEPENDS testcpp.cpp
)
add_executable(testcpp testcpp.cpp)
target_link_libraries (testcpp LINK_PUBLIC FCIdump)
add_executable(testc testc.c)
target_link_libraries (testc LINK_PUBLIC FCIdump)
add_executable(testf testf.F90)
target_link_libraries (testf LINK_PUBLIC FCIdump)

configure_file(rhf.fcidump rhf.fcidump COPYONLY)
configure_file(uhf.fcidump uhf.fcidump COPYONLY)

find_package(Doxygen)
if(DOXYGEN_FOUND)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
SET(doxyfile_in ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
SET(doxyfile ${PROJECT_BINARY_DIR}/Doxyfile)
SET(doxy_html_index_file ${CMAKE_CURRENT_BINARY_DIR}/html/index.html)
SET(doxy_input ${SRCS})
CONFIGURE_FILE( ${doxyfile_in} ${doxyfile} @ONLY )
ADD_CUSTOM_COMMAND(OUTPUT ${doxy_html_index_file}
                   COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
                   MAIN_DEPENDENCY ${doxyfile} ${doxyfile_in}
                   DEPENDS ${SRCS}
                   COMMENT "Generating API documentation with Doxygen" VERBATIM)
ADD_CUSTOM_TARGET( doc ALL DEPENDS ${doxy_html_index_file} )
endif(DOXYGEN_FOUND)
