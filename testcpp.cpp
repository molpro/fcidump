#include "FCIdump.h"

#ifdef __cplusplus
#include <iostream>
#include <string>
#include <vector>
#else
#include <stdio.h>
#endif

#ifdef FCIDUMP_MPI
#include "mpi.h"
#endif

int main(int argc, char *argv[])
//int main()
{
  int parallel_size=1, parallel_rank=0;
#ifdef FCIDUMP_MPI
  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&parallel_size);
  MPI_Comm_rank(MPI_COMM_WORLD,&parallel_rank);
  //  if (parallel_rank > 0) freopen("/dev/null", "w", stdout);
#endif

  int oneelectron[] = {2,1};
  int twoelectron[] = {4,3,2,1};
#ifdef __cplusplus
  std::vector<std::string> files(1,"rhf.fcidump"); files.push_back("uhf.fcidump");
#else
  char* files[]={"rhf.fcidump","uhf.fcidump"};
#endif
  int ifile;
  for (ifile=0; ifile<2; ifile++) {
    if (parallel_rank == 0) {
#ifdef __cplusplus
      std::cout << std::endl<<"Process file "<<files[ifile]<<std::endl;
      FCIdump dump(files[ifile]);
      std::vector<int> NELEC=dump.parameter("NELEC");
      std::cout << "NELEC="<<NELEC[0]<<std::endl;
      std::vector<int> MS2=dump.parameter("MS2");
      std::cout << "MS2="<<MS2[0]<<std::endl;
      std::vector<int> NORB=dump.parameter("NORB");
      std::cout << "NORB="<<NORB[0]<<std::endl;
      std::vector<int> IUHF=dump.parameter("IUHF");
      std::cout << "IUHF="<<IUHF[0]<<std::endl;
      std::vector<int> ORBSYM=dump.parameter("ORBSYM");
      std::cout << "ORBSYM="; for (std::vector<int>::const_iterator s=ORBSYM.begin(); s<ORBSYM.end(); s++) std::cout <<*s<<","; std::cout<<std::endl;
      int i,j,k,l;
      double value;
      FCIdump::integralType type;
      dump.rewind();
      while ((type = dump.nextIntegral(i,j,k,l,value)) != FCIdump::endOfFile) {
        if (i==twoelectron[0] && j==twoelectron[1] && k==twoelectron[2] && l==twoelectron[3] )
          std::cout << "found "<<
                       ((type != FCIdump::I2bb) ? "alpha" : "beta" ) <<"-" <<
                       ((type == FCIdump::I2aa) ? "alpha" : "beta" ) <<
                       " integral ("<<i<<j<<"|"<<k<<l<<")="<<value <<std::endl;
        else if (i==oneelectron[0] && j==oneelectron[1] && k==0 && l==0 )
          std::cout << "found "<<
                       ((type != FCIdump::I1b) ? "alpha" : "beta" ) <<
                       " integral <"<<i<<"|h|"<<j<<">="<<value <<std::endl;
        else if (type == FCIdump::I0)
          std::cout << "found "<<
                       "scalar integral "<<value <<std::endl;
      }
      std::vector<std::string> testc(1,"99"); testc.push_back("98");
      dump.addParameter("TESTC",testc);
      std::vector<std::string> resultc = dump.parameter("TESTC",std::vector<std::string>(1,""));
      if (resultc != testc) throw std::runtime_error("trouble with string addParameter");
      std::vector<int> test(1,99);test.push_back(44);
      dump.addParameter("TEST",test);
      std::vector<int> result = dump.parameter("TEST");
      if (result != test) throw std::runtime_error("trouble with int addParameter");
      if (dump.write("new.fcidump"))
        std::cout << "written to new file"<<std::endl;
      else
        std::cout << "failure to write to new file"<<std::endl;
#else
      printf("\nProcess file %s\n",files[ifile]);
      FCIdumpInitialise(files[ifile]);
      int buffer[1];
      FCIdumpParameterI("NELEC",buffer,1); printf("NELEC=%d\n",buffer[0]);
      FCIdumpParameterI("MS2",buffer,1); printf("MS2=%d\n",buffer[0]);
      FCIdumpParameterI("NORB",buffer,1); printf("NORB=%d\n",buffer[0]);
      int norb=buffer[0];
      FCIdumpParameterI("IUHF",buffer,1); printf("IUHF=%d\n",buffer[0]);
      int orbsym[norb];
      FCIdumpParameterI("ORBSYM",orbsym,norb); printf("ORBSYM=");
      int i,j,k,l;
      for (i=0; i<norb; i++) printf("%d,",orbsym[i]);
      printf("\n");
      double value;
      FCIdumpRewind();
      int type;
      while ( (type = FCIdumpNextIntegral(&i,&j,&k,&l,&value)) != 6 ) {
        if (i==twoelectron[0] && j==twoelectron[1] && k==twoelectron[2] && l==twoelectron[3] )
          printf("found %s %s integral (%d%d|%d%d)=%f\n",
                 ((type != 5) ? "alpha" : "beta" ) ,
                 ((type == 3) ? "alpha" : "beta" ),
                 i,j,k,l,value);
        else if (i==oneelectron[0] && j==oneelectron[1] && k==0 && l==0 )
          printf("found %s integral <%d|h|%d>=%f\n",
                 ((type != 2) ? "alpha" : "beta" ),
                 i,j,value);
        else if (type == 0)
          printf("found scalar integral %f\n",
                 value);
      }
      FCIdumpAddParameterS("TESTC","99");
      int test[]={99,44};
      FCIdumpAddParameterI("TEST",test,2);
      if (FCIdumpWrite("new.fcidump",0) == 1)
        printf("written to new file\n");
      else
        printf("failure to write to new file\n");
#endif
    }
  }

#ifdef FCIDUMP_MPI
  MPI_Finalize();
#endif
  return 0;
}
