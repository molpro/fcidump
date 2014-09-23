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
add_custom_target(doc ALL
${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
COMMENT "Generating API documentation with Doxygen" VERBATIM
)
endif(DOXYGEN_FOUND)
