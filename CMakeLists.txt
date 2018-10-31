cmake_minimum_required(VERSION 3.11)

project(FCIdump C CXX Fortran)
set(CMAKE_CXX_STANDARD 14)

include(FetchContent)
add_subdirectory(dependencies)


########## Targets ##########

add_subdirectory(lib)
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
    ADD_CUSTOM_COMMAND(OUTPUT ${doxy_html_index_file}
            COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
            MAIN_DEPENDENCY ${doxyfile} ${doxyfile_in}
            DEPENDS ${SRCS}
            COMMENT "Generating API documentation with Doxygen" VERBATIM)
    ADD_CUSTOM_TARGET(FCIdump-doc ALL DEPENDS ${doxy_html_index_file})
endif (DOXYGEN_FOUND)
