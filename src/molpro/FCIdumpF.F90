!> @brief Fortran module that accesses an FCIDUMP file. A binding to the FCIdump C++ class, but not object-oriented.
MODULE FCIdumpF
 USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
 CHARACTER(kind=C_Char,len=1024), PRIVATE :: c_filename
 INTERFACE
  SUBROUTINE FCIdumpInitialiseC(filename) BIND(C,name="FCIdumpInitialise")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: filename
  END SUBROUTINE FCIdumpInitialiseC
  SUBROUTINE FCIdumpParameterS(key, values) BIND(C,name="FCIdumpParameterS")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   CHARACTER(kind=C_CHAR), DIMENSION(*) :: values
  END SUBROUTINE FCIdumpParameterS
  SUBROUTINE FCIdumpParameterI(key, values, n) BIND(C,name="FCIdumpParameterI")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   INTEGER(kind=C_INT), DIMENSION(*) :: values
   INTEGER(kind=C_INT), VALUE :: n
  END SUBROUTINE FCIdumpParameterI
  SUBROUTINE FCIdumpParameterF(key, values, n) BIND(C,name="FCIdumpParameterF")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT, C_DOUBLE
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   REAL(kind=C_DOUBLE), DIMENSION(*) :: values
   INTEGER(kind=C_INT), VALUE :: n
  END SUBROUTINE FCIdumpParameterF
  SUBROUTINE FCIdumpAddParameterS(key, valu) BIND(C,name="FCIdumpAddParameterS")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: valu
  END SUBROUTINE FCIdumpAddParameterS
  SUBROUTINE FCIdumpAddParameterI(key, values, n) BIND(C,name="FCIdumpAddParameterI")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   INTEGER(kind=C_INT), DIMENSION(*), INTENT(IN) :: values
   INTEGER(kind=C_INT), VALUE :: n
  END SUBROUTINE FCIdumpAddParameterI
  SUBROUTINE FCIdumpAddParameterF(key, values, n) BIND(C,name="FCIdumpAddParameterF")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT, C_DOUBLE
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   REAL(kind=C_DOUBLE), DIMENSION(*), INTENT(IN) :: values
   INTEGER(kind=C_INT), VALUE :: n
  END SUBROUTINE FCIdumpAddParameterF
  SUBROUTINE FCIdumpRewindC() BIND(C,name="FCIdumpRewind")
  END SUBROUTINE FCIdumpRewindC
  FUNCTION FCIdumpFNextIntegralC(i,j,k,l,valu) BIND(C,name="FCIdumpNextIntegral")
   USE iso_c_binding, ONLY: C_INT, C_DOUBLE
   INTEGER(kind=C_INT) :: FCIdumpFNextIntegralC
   INTEGER(kind=C_INT) :: i,j,k,l
   REAL(kind=C_DOUBLE) :: valu
  END FUNCTION FCIdumpFNextIntegralC
  FUNCTION FCIdumpWrite(filename, typc) BIND(C,name="FCIdumpWrite")
   USE iso_c_binding, ONLY: C_CHAR, C_NULL_CHAR, C_INT
   INTEGER(kind=C_INT) :: FCIdumpWrite
   CHARACTER(kind=C_CHAR), DIMENSION(*), INTENT(IN) :: filename
   INTEGER(kind=C_INT), VALUE :: typc
  END FUNCTION FCIdumpWrite
  SUBROUTINE FCIdumpWriteIntegralC(i, j, k, l, valu) BIND(C,name="FCIdumpWriteIntegral")
   USE iso_c_binding, ONLY:  C_INT, C_DOUBLE
   INTEGER(kind=C_INT), VALUE :: i, j, k, l;
   REAL(kind=C_DOUBLE), VALUE :: valu
  END SUBROUTINE FCIdumpWriteIntegralC
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
!> \param valu  The result as a character. Note that character arrays are not supported
 SUBROUTINE FCIdumpFParameterS(key,valu)
  CHARACTER(*), INTENT(in) :: key
  CHARACTER(*), INTENT(inout) :: valu
  CHARACTER(kind=C_Char,len=1024) :: c_key
  CHARACTER(kind=C_CHAR, LEN=LEN(valu)) :: c_values
  INTEGER :: i
  c_key=TRIM(key)//C_NULL_CHAR
  c_values = TRIM(valu)//C_NULL_CHAR
  CALL FCIDumpParameterS(c_key,c_values);
  DO i=1,LEN(valu)
   IF (c_values(i:i) .EQ. C_NULL_CHAR) EXIT
   valu(i:i) = c_values(i:i)
  END DO
 END SUBROUTINE FCIdumpFParameterS

!> \brief F90 binding of FCIdump:  Obtain an integer namelist parameter from the FCIDUMP data.
!> \param key The name of the parameter
!> \param values  The result as a vector of integers.
 SUBROUTINE FCIdumpFParameterI(key,values)
  CHARACTER(*), INTENT(in) :: key
  INTEGER, INTENT(inout), DIMENSION(:) :: values
  CHARACTER(kind=C_Char,len=1024) :: c_key
  INTEGER(kind=C_INT), DIMENSION(LBOUND(values,1):UBOUND(values,1)) :: c_values
  c_key=TRIM(key)//C_NULL_CHAR
  c_values = INT(values,kind=C_INT)
  CALL FCIDumpParameterI(c_key,c_values,INT(UBOUND(values,1)-LBOUND(values,1)+1,kind=C_INT));
  values = c_values
 END SUBROUTINE FCIdumpFParameterI

!> \brief F90 binding of FCIdump:  Obtain a floating-point namelist parameter from the FCIDUMP data.
!> \param key The name of the parameter
!> \param values  The result as a vector of doubles.
 SUBROUTINE FCIdumpFParameterF(key,values)
  CHARACTER(*), INTENT(in) :: key
  DOUBLE PRECISION, INTENT(inout), DIMENSION(:) :: values
  CHARACTER(kind=C_Char,len=1024) :: c_key
  c_key=TRIM(key)//C_NULL_CHAR
  CALL FCIDumpParameterF(c_key,values,INT(UBOUND(values,1)-LBOUND(values,1)+1,kind=C_INT));
 END SUBROUTINE FCIdumpFParameterF

!> \brief F90 binding of FCIdump: Position the file so that the next call to nextIntegral will deliver the first integral
 SUBROUTINE FCIdumpFRewind()
  CALL FCIdumpRewindC()
 END SUBROUTINE FCIdumpFRewind

!> \brief F90 binding of FCIdump: Read the next integral from the file
!> \param i orbital label (zero indicates not 1-electron or 2-electron)
!> \param j orbital label
!> \param k orbital label(zero indicates not 2-electron)
!> \param l orbital label
!> \param valu numerical value of the integral
!> \return indicator of the type of entry (core, 1-electron, 2-electron integrals; end of record; end of file)
 FUNCTION FCIdumpFNextIntegral(i,j,k,l,valu)
  INTEGER :: FCIdumpFNextIntegral
  INTEGER, INTENT(inout) :: i,j,k,l
  INTEGER(kind=C_INT) :: ic,jc,kc,lc
  DOUBLE PRECISION, INTENT(inout) :: valu
  FCIdumpFNextIntegral = FCIdumpFNextIntegralC(ic,jc,kc,lc,valu)
  i=ic; j=jc; k=kc; l=lc
 END FUNCTION FCIdumpFNextIntegral

!> \brief F90 binding of FCIdump:  Set a string namelist parameter in the FCIDUMP data.
!> \param key The name of the parameter
!> \param valu  The value to be set as a single character string
 SUBROUTINE FCIdumpFAddParameterS(key,valu)
  CHARACTER(*), INTENT(in) :: key
  CHARACTER(*), INTENT(in) :: valu
  CHARACTER(kind=C_Char,len=1024) :: c_key
  CHARACTER(kind=C_CHAR, LEN=LEN(valu)+1) :: c_value
  c_key=TRIM(key)//C_NULL_CHAR
  c_value = TRIM(valu)//C_NULL_CHAR
  CALL FCIDumpAddParameterS(c_key,c_value);
 END SUBROUTINE FCIdumpFAddParameterS

!> \brief F90 binding of FCIdump:  Set an integer namelist parameter in the FCIDUMP data.
!> \param key The name of the parameter
!> \param values  The values to be set as a vector of integers.
 SUBROUTINE FCIdumpFAddParameterI(key,values)
  CHARACTER(*), INTENT(in) :: key
  INTEGER, INTENT(in), DIMENSION(:) :: values
  CHARACTER(kind=C_Char,len=1024) :: c_key
  INTEGER(kind=C_INT), DIMENSION(LBOUND(values,1):UBOUND(values,1)) :: c_values
  c_key=TRIM(key)//C_NULL_CHAR
  c_values = INT(values,kind=C_INT)
  CALL FCIDumpAddParameterI(c_key,c_values,INT(UBOUND(values,1)-LBOUND(values,1)+1,kind=C_INT));
 END SUBROUTINE FCIdumpFAddParameterI

!> \brief F90 binding of FCIdump:  Set a floating-point namelist parameter in the FCIDUMP data.
!> \param key The name of the parameter
!> \param values  The values to be set as a vector of doubles.
 SUBROUTINE FCIdumpFAddParameterF(key,values)
  CHARACTER(*), INTENT(in) :: key
  DOUBLE PRECISION, INTENT(in), DIMENSION(:) :: values
  CHARACTER(kind=C_Char,len=1024) :: c_key
  c_key=TRIM(key)//C_NULL_CHAR
  CALL FCIDumpAddParameterF(c_key,values,INT(UBOUND(values,1)-LBOUND(values,1)+1,kind=C_INT));
 END SUBROUTINE FCIdumpFAddParameterF

!> \brief F90 binding of FCIdump: write the data to an external file
!> \param filename The relative or absolute path name of the file
!> \param typf The desired format of the file
!> \return .TRUE. if OK, .FALSE. if not
 FUNCTION FCIdumpFWrite(filename,typf)
  LOGICAL :: FCIdumpFWrite
  CHARACTER(*), INTENT(in) :: filename
  INTEGER, INTENT(in), OPTIONAL :: typf
  INTEGER(kind=C_INT) :: typ
  CHARACTER(kind=C_CHAR, len=1024) :: c_filename
  c_filename=TRIM(filename)//C_NULL_CHAR
  FCIDumpFWrite = .FALSE.
  typ = INT(0,kind=C_INT)
  IF (PRESENT(typf)) typ=INT(typf,kind=C_INT)
  IF ( FCIDumpWrite(c_filename, typ) .EQ.INT(1,kind=C_INT)) FCIDumpFWrite = .TRUE.
  RETURN
 END FUNCTION FCIdumpFWrite

 SUBROUTINE FCIdumpFWriteIntegral(i, j, k, l, valu)
  INTEGER, INTENT(in) :: i,j,k,l
  DOUBLE PRECISION, INTENT(in) :: valu
  INTEGER(KIND=C_INT) :: ic, jc, kc, lc
  ic = INT(i,kind=C_INT)
  jc = INT(j,kind=C_INT)
  kc = INT(k,kind=C_INT)
  lc = INT(l,kind=C_INT)
  CALL FCIdumpWriteIntegralC(ic,jc,kc,lc,valu)
 END SUBROUTINE FCIdumpFWriteIntegral
END MODULE FCIdumpF
