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
  char* files[]={"rhf.fcidump","uhf.fcidump"};
  for (int i=0; i<2; i++) {
  if (parallel_rank == 0) {
#ifdef __cplusplus
    std::cout << "Process file "<<files[i]<<std::endl;
    FCIdump dump(files[i]);
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
#else
    FCIdumpInitialise("rhf.fcidump");
#endif
  }
  }

#ifdef FCIDUMP_MPI
  MPI_Finalize();
#endif
  return 0;
}
