FetchContent_Declare(
        googletest_dep
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/dependencies/googletest"
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG "release-1.8.1"
        GIT_SHALLOW TRUE
)
