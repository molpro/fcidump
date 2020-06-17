LibraryManager_Append(${PROJECT_NAME}
        SOURCES FCIdump.cpp
        PUBLIC_HEADER FCIdump.h
        )
if (FORTRAN)
    LibraryManager_Append(${PROJECT_NAME}
            SOURCES FCIdumpF.F90
            )
endif ()


target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_EXTENSIONS OFF)
