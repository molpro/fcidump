if (CMAKE_Fortran_COMPILER_ID)
    set(FCIDUMP_FORTRAN_SRCS "FCIdumpF.F90")
endif ()
add_library(FCIdump FCIdump.cpp FCIdump.h ${FCIDUMP_FORTRAN_SRCS})
set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER "FCIdump.h")

configure_library(${PROJECT_NAME})
