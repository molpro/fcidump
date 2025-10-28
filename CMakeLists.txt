cmake_minimum_required(VERSION 3.5...4.0)
project(fcidump C CXX)

include(FetchContent)
FetchContent_Declare(
        LibraryManager
        GIT_REPOSITORY https://github.com/molpro/library-manager.git
        GIT_TAG 0.13.3
)
FetchContent_MakeAvailable(LibraryManager)

LibraryManager_Project(FORTRAN_OPTION)

add_subdirectory(dependencies)

add_subdirectory(src)

if (${CMAKE_PROJECT_NAME} STREQUAL ${PROJECT_NAME})
    add_subdirectory(examples)
    enable_testing()
    add_subdirectory(test)
endif ()

include(DependencyManagerDocs)
DependencyManagerDocs_Add(${PROJECT_NAME}
        FILES README.md LICENCE.md
        DOC_URL "https://molpro.github.io/fcidump"
        )
