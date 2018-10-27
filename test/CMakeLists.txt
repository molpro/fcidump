enable_testing()

configure_file(rhf.fcidump ${CMAKE_CURRENT_BINARY_DIR}/rhf.fcidump COPYONLY)
configure_file(uhf.fcidump ${CMAKE_CURRENT_BINARY_DIR}/uhf.fcidump COPYONLY)
configure_file(testcpp.cpp ${CMAKE_CURRENT_BINARY_DIR}/testc.c COPYONLY)

add_executable(testcpp testcpp.cpp)
add_executable(testc ${CMAKE_CURRENT_BINARY_DIR}/testc.c)
add_executable(testf testf.F90)

target_link_libraries(testcpp PUBLIC FCIdump)
target_link_libraries(testc PUBLIC FCIdump)
target_link_libraries(testf PUBLIC FCIdump)

add_test(NAME testcpp COMMAND testcpp)
add_test(NAME testc COMMAND testc)
add_test(NAME testf COMMAND testf)
