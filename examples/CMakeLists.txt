get_filename_component(COMPILER_NAME ${CMAKE_CXX_COMPILER} NAME)
if (${COMPILER_NAME} STREQUAL "mpic++" OR ${COMPILER_NAME} STREQUAL "mpicxx")
    add_definitions(-DFCIDUMP_MPI)
endif ()

configure_file(rhf.fcidump ${CMAKE_CURRENT_BINARY_DIR}/rhf.fcidump COPYONLY)
configure_file(uhf.fcidump ${CMAKE_CURRENT_BINARY_DIR}/uhf.fcidump COPYONLY)

add_executable(example-cpp example-cpp.cpp)
target_link_libraries(example-cpp PUBLIC fcidump)

configure_file(example-cpp.cpp ${CMAKE_CURRENT_BINARY_DIR}/example-c.c COPYONLY)
add_executable(example-c ${CMAKE_CURRENT_BINARY_DIR}/example-c.c)

target_link_libraries(example-c PUBLIC fcidump)

if (FORTRAN)
    add_executable(example-fortran example-fortran.F90)
    target_link_libraries(example-fortran PUBLIC fcidump)
endif ()
