unset(DEPENDENCIES)
if (CMAKE_Fortran_COMPILER_ID)
    set(FCIDUMP_FORTRAN_SRCS "FCIdumpF.F90")
endif ()
add_library(FCIdump FCIdump.cpp FCIdump.h ${FCIDUMP_FORTRAN_SRCS})

configure_library(${PROJECT_NAME} "${DEPENDENCIES}")
