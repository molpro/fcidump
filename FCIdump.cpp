#include "FCIdump.h"
#include <iostream>
#include <fstream>
#include <istream>
#include <sstream>
#define xout std::cout

FCIdump::FCIdump(std::string filename)
{
  _fileName = filename;
  std::ifstream s;
  s.open(_fileName.c_str());
  if ( (s.rdstate() & std::ifstream::failbit ) != 0 ) {
    std::cerr << "Error opening " << _fileName <<std::endl;
    throw "FCIDUMP::parameter file missing";
  }
  // cache the namelist data
  std::string ss;
  s >> ss ; namelistData=","; // forget the first word of namelist
  while (s >> ss && ss != "&END" && ss != "/")
    namelistData.append(ss);
  namelistData.append(",DUMMY_KEY=,"); // dummy entry at end to simplify parsing
//  xout <<"namelistData=" <<namelistData <<std::endl;
}

std::string FCIdump::fileName()
{
  return _fileName;
}



std::vector<int> FCIdump::parameter(std::string key, std::vector<int> def) { // dirty sucking in from FCIDUMP namelist
  std::vector<int> answer;
  std::vector<std::string> strings = parameter(key,std::vector<std::string>(1," "));
//  xout <<"parameter "<<key<<std::endl;
//  xout << "parameter "<<key<<"="; for (std::vector<std::string>::iterator s=strings.begin(); s < strings.end(); s++) xout <<*s ; xout <<std::endl;
  if (strings == std::vector<std::string>(1," ")) return def;
  for (std::vector<std::string>::const_iterator s1=strings.begin(); s1!= strings.end(); s1++) {
    int i;
    std::istringstream b(*s1);
    b >>i;
//    xout <<"s1="<<*s1<<"; i="<<i<<std::endl;
    answer.push_back(i);
  }
//  xout << "parameter "<<key<<"="; for (std::vector<int>::iterator s=answer.begin(); s < answer.end(); s++) xout <<*s ; xout <<std::endl;
  return answer;
}


std::vector<double> FCIdump::parameter(std::string key, std::vector<double> def) { // dirty sucking in from FCIDUMP namelist
  std::vector<double> answer;
  std::vector<std::string> strings = parameter(key,std::vector<std::string>(1," "));
//  xout <<"parameter "<<key<<std::endl;
//  xout << "parameter "<<key<<"="; for (std::vector<std::string>::iterator s=strings.begin(); s < strings.end(); s++) xout <<*s ; xout <<std::endl;
  if (strings == std::vector<std::string>(1," ")) return def;
  for (std::vector<std::string>::const_iterator s1=strings.begin(); s1!= strings.end(); s1++) {
    double i;
    std::istringstream b(*s1);
    b >>i;
//    xout <<"s1="<<*s1<<"; i="<<i<<std::endl;
    answer.push_back(i);
  }
//  xout << "parameter "<<key<<"="; for (std::vector<double>::iterator s=answer.begin(); s < answer.end(); s++) xout <<*s ; xout <<std::endl;
  return answer;
}

std::vector<std::string> FCIdump::parameter(std::string key, std::vector<std::string> def) { // dirty sucking in from FCIDUMP namelist
  std::vector<std::string> answer;
//  xout <<"search for "<<","<<key<<"="<<std::endl;
  size_t pos = namelistData.find(","+key+"=");
  if (pos == std::string::npos) return def;
  pos=namelistData.find("=",pos)+1;
  size_t pose=namelistData.find("=",pos);
  pose=namelistData.find_last_of(",",pose)+1;
//  xout << "string parameter key="<<key<<"; values='"<<namelistData.substr(pos,pose-pos)<<"'"<<std::endl;
//  xout << "pos="<<pos<<"; pose="<<pose<<std::endl;
  for (size_t posNext=pos; posNext < pose; pos=posNext) {
    posNext=namelistData.find(",",pos)+1;
    answer.push_back(namelistData.substr(pos,posNext-pos-1));
  }
//  xout <<"answer";
//  for (std::vector<std::string>::const_iterator s=answer.begin(); s != answer.end(); s++)
//    xout <<":"<<*s;
//  xout <<std::endl;
  return answer;
}

void FCIdump::addParameter(const std::string& key, const std::vector<std::string>& values)
{
//  xout << "FCIdump::addParameter namelistData originally "<<namelistData<<std::endl;
//  for (std::string::const_reverse_iterator s=values.rbegin();
//       s != values.rend(); s++)
  namelistData.erase(0,1);
  for (int i=values.size()-1; i>-1; i--)
    namelistData.insert(0,values[i]+",");
  namelistData.insert(0,","+key+"=");
//  xout << "FCIdump::addParameter namelistData set to "<<namelistData<<std::endl;
}

void FCIdump::rewind()
{
  stream.open(_fileName.c_str());
  std::string ss;
  while (stream >> ss && ss != "&END" && ss != "/") ;
  uhf = parameter("IUHF").at(0) != 0;
  states.clear();
  states.push_back(I2aa);
  if (uhf) states.push_back(I2ab);
  if (uhf) states.push_back(I2bb);
  states.push_back(I1a);
  if (uhf) states.push_back(I1b);
  states.push_back(I0);
  currentState = states.begin();
}

FCIdump::integralType FCIdump::nextIntegral(int &i, int &j, int &k, int &l, double &value)
{
  integralType result = *currentState;
  if (stream >> value) {
    stream >> i; stream >> j; stream >> k; stream >> l;
  }
  else {
    stream.close();
    return endOfFile;
  }
  // following is tricky stuff reflecting historical structure of UHF and RHF FCIdump files
  if (i == 0) {
//    std::cout << "zero read uhf="<<uhf<<", *currentState="<<*currentState<<std::endl;
    if (uhf && *currentState != I0) {
      result = endOfRecord;
      currentState++;
//      std::cout << "end of Record signalled; *currentState="<<*currentState<<std::endl;
    }
    else {
//      std::cout << "real scalar signalled"<<std::endl;
      result = I0;
    }
  }
  else if (k == 0 && (*currentState != FCIdump::I1a && *currentState != FCIdump::I1b)) {
//    std::cout << "special state switch to "<<*(currentState+1)<<std::endl;
    result=FCIdump::endOfRecord; ++currentState;
  }
  return result;
}

FCIdump* dump;

void FCIdumpInitialise(char* filename)
{
  printf("Initialise FCIDUMP from file %s\n",filename);
  dump = new FCIdump(std::string(filename));
}

void FCIdumpParameter(char* key, int* values)
{
  std::vector<int> vals = dump->parameter(std::string(key));
  for (size_t i=0; i<vals.size(); i++)
    values[i]=vals[i];
}

void FCIdumpRewind()
{
  dump->rewind();
}

int FCIdumpNextIntegral(int* i, int* j, int* k, int* l, double* value)
{
  int ii, jj, kk, ll;
  double vv;
  FCIdump::integralType type = dump->nextIntegral(ii, jj, kk, ll, vv);
  *i = ii; *j = jj; *k = kk; *l = ll; *value = vv;
  return (int) type;
}

void FCIdumpAddParameter(char *key, int values[])
{
  std::string keys(key);
  std::vector<int> valuess;
  for (size_t i=0; values[i]; i++)
    valuess.push_back(values[i]);
  dump->addParameter(keys,valuess);
}
