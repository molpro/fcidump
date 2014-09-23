!> @brief Fortran module that accesses an FCIDUMP file. A binding to the FCIdump C++ class, but not object-oriented.
MODULE FCIdumpF
 USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
 CHARACTER(kind=C_Char,len=1024), PRIVATE :: c_filename
 INTERFACE
  SUBROUTINE FCIdumpInitialiseC(filename) BIND(C,name="FCIdumpInitialise")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR
   CHARACTER(kind=C_CHAR), DIMENSION(*) :: filename
  END SUBROUTINE FCIdumpInitialiseC
  SUBROUTINE FCIdumpParameterC(key, values) BIND(C,name="FCIdumpParameter")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
   CHARACTER(kind=C_CHAR), DIMENSION(*) :: key
   INTEGER(kind=C_INT), DIMENSION(*) :: values
  END SUBROUTINE FCIdumpParameterC
  SUBROUTINE FCIdumpRewindC() BIND(C,name="FCIdumpRewind")
  END SUBROUTINE FCIdumpRewindC
  FUNCTION FCIdumpFNextIntegralC(i,j,k,l,valu) BIND(C,name="FCIdumpNextIntegral")
   USE iso_c_binding, ONLY: C_INT
   integer(kind=C_INT) :: FCIdumpFNextIntegralC
   INTEGER(kind=C_INT) :: i,j,k,l
   DOUBLE PRECISION :: valu
  END FUNCTION FCIdumpFNextIntegralC
 END INTERFACE
CONTAINS

!> \brief F90 binding of FCIdump: initialise access to an FCIDUMP
!> \param filename The file containing the FCIDUMP data
 SUBROUTINE FCIdumpFInitialise(filename)
  CHARACTER(*), INTENT(in) :: filename
  c_filename=TRIM(filename)//C_NULL_CHAR
  CALL FCIDumpInitialiseC(c_filename)
 END SUBROUTINE FCIdumpFInitialise

 !> \brief F90 binding of FCIdump:  Obtain a string namelist parameter from the FCIDUMP data.
 !> \param key The name of the parameter
 !> \param values  The result as a vector of integers.
 SUBROUTINE FCIdumpFParameter(key,values)
  CHARACTER(*), INTENT(in) :: key
  INTEGER, INTENT(inout), dimension(:) :: values
  CHARACTER(kind=C_Char,len=1024) :: c_key
  INTEGER(kind=C_INT), DIMENSION(LBOUND(values,1):UBOUND(values,1)) :: c_values
  c_key=TRIM(key)//C_NULL_CHAR
  CALL FCIDumpParameterC(c_key,c_values);
  values = c_values
 END SUBROUTINE FCIdumpFParameter

!> \brief F90 binding of FCIdump: Position the file so that the next call to nextIntegral will deliver the first integral
 SUBROUTINE FCIdumpFRewind()
  CALL FCIdumpRewindC()
 END SUBROUTINE FCIdumpFRewind

!> \brief F90 binding of FCIdump: Read the next integral from the file
!> \param i orbital label (zero indicates not 1-electron or 2-electron)
!> \param j orbital label
!> \param k orbital label(zero indicates not 2-electron)
!> \param l orbital label
!> \param value numerical value of the integral
!> \return indicator of the type of entry (core, 1-electron, 2-electron integrals; end of record; end of file)
 FUNCTION FCIdumpFNextIntegral(i,j,k,l,value)
  INTEGER :: FCIdumpFNextIntegral
  INTEGER, INTENT(inout) :: i,j,k,l
  INTEGER(kind=C_INT) :: ic,jc,kc,lc
  DOUBLE PRECISION, INTENT(inout) :: value
  FCIdumpFNextIntegral = FCIdumpFNextIntegralC(ic,jc,kc,lc,value)
  i=ic; j=jc; k=kc; l=lc
 END FUNCTION FCIdumpFNextIntegral
END MODULE FCIdumpF
