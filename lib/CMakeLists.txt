add_library(FCIdump FCIdump.cpp FCIdump.h FCIdumpF.F90)
### For including header files
target_include_directories(FCIdump INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
### For linking Fortran static library
target_include_directories(FCIdump INTERFACE ${PROJECT_BINARY_DIR}/lib)
