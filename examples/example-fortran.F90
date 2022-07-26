PROGRAM testF
 USE FCIdumpF
 IMPLICIT NONE
 CHARACTER(80), DIMENSION(2) :: files=(/'rhf.fcidump','uhf.fcidump'/)
 INTEGER, DIMENSION(5) :: values
 INTEGER :: ifile, NELEC, IUHF, NORB, MS2
 DOUBLE PRECISION :: valu
 INTEGER :: i,j,k,l,typ
 DO ifile=LBOUND(files,1),UBOUND(files,1)
  PRINT *
  PRINT *, 'Process file ',TRIM(files(ifile))
  CALL FCIdumpFInitialise(files(ifile))
  CALL FCIdumpFParameterI('NELEC',values); NELEC=values(1); PRINT*,'NELEC=',NELEC
  CALL FCIdumpFParameterI('MS2',values); MS2=values(1); PRINT*,'MS2=',MS2
  CALL FCIdumpFParameterI('NORB',values); NORB=values(1); PRINT*,'NORB=',NORB
  CALL FCIdumpFParameterI('IUHF',values); IUHF=values(1); PRINT*,'IUHF=',IUHF
  CALL FCIdumpFRewind
  DO WHILE(.TRUE.)
   typ = FCIdumpFNextIntegral(i,j,k,l,valu)
   IF (typ.EQ.6) EXIT
   IF (i.EQ.4 .AND. j.EQ.3 .AND. k.EQ.2 .AND. l.EQ.1) THEN
    PRINT *, '2-electron integral ',i,j,k,l,valu,typ
   ELSE IF (i.EQ.2 .AND. j.EQ.1 .AND. k.EQ.0) THEN
    PRINT *, '1-electron integral ',i,j,valu,typ
   ELSE IF (typ.EQ.0) THEN
    PRINT *, 'scalar integral ',valu
   END IF
  END DO
  call FCIdumpFAddParameterS('TESTC','99')
  call FCIdumpFAddParameterI('TEST',(/99,44/))
  if ( FCIdumpFWrite('new.fcidump') ) then
   print*,'written to new file'
   else
     print*,'failure to write to new file'
     end if
 END DO
END PROGRAM testF
