cmake_minimum_required(VERSION 3.15)
project(FCIdump C CXX)

include(FetchContent)
FetchContent_Declare(
        LibraryManager
        GIT_REPOSITORY https://gitlab+deploy-token-178345:RQZa2rmdwnV7Hdwg8XEq@gitlab.com/molpro/LibraryManager.git
        GIT_TAG master
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
        DOC_URL "https://molpro.gitlab.io/library-template/${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
        )
