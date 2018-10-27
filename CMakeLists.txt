cmake_minimum_required(VERSION 3.11)

project(FCIdump C CXX Fortran)


########## Compiler Flags ##########

get_filename_component(COMPILER_NAME ${CMAKE_CXX_COMPILER} NAME)
if (${COMPILER_NAME} STREQUAL "mpic++" OR ${COMPILER_NAME} STREQUAL "mpicxx")
    add_definitions(-DFCIDUMP_MPI)
endif ()


########## Targets ##########

add_subdirectory(lib)
add_subdirectory(test)


########## Documentation ##########

find_package(Doxygen)
if (DOXYGEN_FOUND)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
    SET(doxyfile_in ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
    SET(doxyfile ${PROJECT_BINARY_DIR}/Doxyfile)
    SET(doxy_html_index_file ${CMAKE_CURRENT_BINARY_DIR}/html/index.html)
    SET(doxy_input ${SRCS})
    CONFIGURE_FILE(${doxyfile_in} ${doxyfile} @ONLY)
    ADD_CUSTOM_COMMAND(OUTPUT ${doxy_html_index_file}
            COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
            MAIN_DEPENDENCY ${doxyfile} ${doxyfile_in}
            DEPENDS ${SRCS}
            COMMENT "Generating API documentation with Doxygen" VERBATIM)
    ADD_CUSTOM_TARGET(FCIdump-doc ALL DEPENDS ${doxy_html_index_file})
endif (DOXYGEN_FOUND)
