
get_dependency(googletest)

add_executable(testFCIdump testFCIdump.cpp)
target_link_libraries(testFCIdump PUBLIC FCIdump gmock_main)

add_test(NAME testFCIdump COMMAND testFCIdump)
