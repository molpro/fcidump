MODULE FCIdump
 USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR
 CHARACTER(kind=C_Char,len=1024), PRIVATE :: c_filename
 INTERFACE
  SUBROUTINE FCIdumpInitialiseC(filename) BIND(C,name="FCIdumpInitialise")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR
   CHARACTER(kind=C_CHAR), DIMENSION(*) :: filename
  END SUBROUTINE FCIdumpInitialiseC
 END INTERFACE
CONTAINS
 SUBROUTINE FCIdumpInitialise(filename)
  CHARACTER(*), INTENT(in) :: filename
  c_filename=TRIM(filename)//C_NULL_CHAR
  CALL FCIDumpInitialiseC(c_filename)
 END SUBROUTINE FCIdumpInitialise
END MODULE FCIdump
