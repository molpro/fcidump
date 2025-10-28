include(FetchContent)
set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG "v1.17.0"
)
FetchContent_MakeAvailable(googletest)

include(GoogleTest)
foreach (t testFCIdump)
    add_executable(${t} ${t}.cpp)
    target_link_libraries(${t} PUBLIC gmock_main molpro::${PROJECT_NAME})
    if (NOT CMAKE_CROSSCOMPILING)
        gtest_discover_tests(${t})
        add_test(${t} ${t})
    endif ()
endforeach ()
