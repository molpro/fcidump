#ifdef MOLPRO
#include "molpro_config.h"
#else
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#endif
#include "FCIdump.h"
#include <iostream>
#include <fstream>
#include <istream>
#include <sstream>
#include <stdexcept>
#define xout std::cout

FCIdump::FCIdump(std::string filename, bool old)
    : _fileName(std::move(filename)), namelistData(",")  {
  if (_fileName.empty()) return;
  std::ifstream s;
  s.open(_fileName.c_str());
  if ((s.rdstate() & std::ifstream::failbit) != 0) {
    if (old) {
      std::cerr << "Error opening " << _fileName << std::endl;
      throw std::runtime_error("FCIDUMP::parameter file missing");
    }
  } else {
    // cache the namelist data
    std::string ss;
    s >> ss;
    namelistData = ","; // forget the first word of namelist
    while (s >> ss && ss != "&END" && ss != "/")
      namelistData.append(ss);
  }
  namelistData.append(",DUMMY_KEY=,"); // dummy entry at end to simplify parsing
//  xout <<"namelistData=" <<namelistData <<std::endl;
}

FCIdump::FCIdump(std::vector<char> bytestream) {
  throw std::logic_error("Unimplemented function");
}

FCIdump::~FCIdump() {
  if (outputStream.is_open()) outputStream.close();
}

std::string FCIdump::fileName() const {
  return _fileName;
}

std::vector<int> FCIdump::parameter(const std::string& key,
                                    const std::vector<int>& def) const { // dirty sucking in from FCIDUMP namelist
  std::vector<int> answer;
  std::vector<std::string> strings = parameter(key, std::vector<std::string>(1, " "));
  if (strings == std::vector<std::string>(1, " ")) return def;
  for (std::vector<std::string>::const_iterator s1 = strings.begin(); s1 != strings.end(); s1++) {
    int i;
    std::istringstream b(*s1);
    b >> i;
    answer.push_back(i);
  }
  return answer;
}

std::vector<double> FCIdump::parameter(const std::string& key,
                                       const std::vector<double>& def) const { // dirty sucking in from FCIDUMP namelist
  std::vector<double> answer;
  std::vector<std::string> strings = parameter(key, std::vector<std::string>(1, " "));
  if (strings == std::vector<std::string>(1, " ")) return def;
  for (std::vector<std::string>::const_iterator s1 = strings.begin(); s1 != strings.end(); s1++) {
    double i;
    std::istringstream b(*s1);
    b >> i;
    answer.push_back(i);
  }
  return answer;
}

std::vector<std::string> FCIdump::parameter(const std::string& key,
                                            const std::vector<std::string>& def) const { // dirty sucking in from FCIDUMP namelist
  std::vector<std::string> answer;
  size_t pos = namelistData.find("," + key + "=");
  if (pos == std::string::npos) return def;
  pos = namelistData.find('=', pos) + 1;
  size_t pose = namelistData.find('=', pos);
  pose = namelistData.find_last_of(',', pose) + 1;
  for (size_t posNext = pos; posNext < pose; pos = posNext) {
    posNext = namelistData.find(',', pos) + 1;
    answer.push_back(namelistData.substr(pos, posNext - pos - 1));
  }
  return answer;
}

void FCIdump::addParameter(const std::string& key, const std::vector<std::string>& values) {
//  xout << "FCIdump::addParameter namelistData originally "<<namelistData<<std::endl;
  namelistData.erase(0, 1);
  for (auto s = values.rbegin(); s != values.rend(); s++)
    namelistData.insert(0, (*s) + ",");
  namelistData.insert(0, "," + key + "=");
//  xout << "FCIdump::addParameter namelistData set to "<<namelistData<<std::endl;
}
void FCIdump::addParameter(const std::string& key, const std::vector<int>& values) {
  std::vector<std::string> valuess;
  for (const auto& v: values) {
    std::ostringstream ss;
    ss << v;
    valuess.push_back(ss.str());
  }
  addParameter(key, valuess);
}
void FCIdump::addParameter(const std::string& key, const std::vector<double>& values) {
  std::vector<std::string> valuess;
  for (const auto& v : values) {
    std::ostringstream ss;
    ss << v;
    valuess.push_back(ss.str());
  }
  addParameter(key, valuess);
}
void FCIdump::addParameter(const std::string& key, const std::string& value) {
  addParameter(key, std::vector<std::string>(1, value));
}
void FCIdump::addParameter(const std::string& key, const int& value) {
  addParameter(key, std::vector<int>(1, value));
}
void FCIdump::addParameter(const std::string& key, const double& value) {
  addParameter(key, std::vector<double>(1, value));
}

void FCIdump::rewind() const {
  stream.open(_fileName.c_str());
  std::string ss;
  while (stream >> ss && ss != "&END" && ss != "/");
  uhf = parameter("IUHF").at(0) != 0;
  orbital_numbers.clear();
  orbital_numbers.resize(8);
  orbital_symmetries.clear();
  orbital_offsets.clear();
  size_t count = 0;
  for (const auto& s : parameter("ORBSYM")) {
    orbital_offsets.push_back(orbital_numbers[s - 1].size());
    orbital_numbers[s - 1].push_back(++count);
    orbital_symmetries.push_back(s - 1);
  }
  orbital_block_dimensions.clear();
  orbital_block_dimensions.resize(8, 0);
  orbital_block_offsets.resize(8, 0);
  count = 0;
  for (auto i = 0; i < 8; i++) {
    orbital_block_offsets[i] = count;
    orbital_block_dimensions[i] = orbital_numbers[i].size();
    count += orbital_block_dimensions[i];
  }
  states.clear();
  states.push_back(I2aa);
  if (uhf) states.push_back(I2bb);
  if (uhf) states.push_back(I2ab);
  states.push_back(I1a);
  if (uhf) states.push_back(I1b);
  states.push_back(I0);
  currentState = states.begin();
}

#include <iomanip>
bool FCIdump::write(std::string filename, fileType type, bool integrals) {
  outputStream.open((filename=="" ? this->_fileName : filename).c_str());
  if ((outputStream.rdstate() & std::ifstream::failbit) != 0) {
    xout << "FCIdump::write failed to open " << filename << std::endl;
    outputStream.close();
    return false;
  }
  outputStream << "&FCI" << std::endl;
  size_t pos = 0;
  while ((pos = namelistData.find('=', pos)) != std::string::npos) {
    std::string key = namelistData.substr(0, pos);
    size_t pose = namelistData.find('=', pos + 1);
    pose = namelistData.find_last_of(',', pose) + 1;
    while (namelistData.substr(pose - 2, 1) == ",") pose--;
    pos = namelistData.find_last_of(',', pos) + 1;
    if (namelistData.substr(pos, pose - pos).find("DUMMY_KEY") == std::string::npos)
      outputStream << " " << namelistData.substr(pos, pose - pos) << std::endl;
    pos = pose;
  }
  outputStream << "/" << std::endl;
  outputStream << std::scientific << std::setprecision(15);
  rewind();
  if (integrals) {
    int i, j, k, l;
    double value;
    while (nextIntegral(i, j, k, l, value) != endOfFile)
      writeIntegral(i, j, k, l, value);
  }
  return true;
}

#include <stdint.h>
std::vector<char> FCIdump::bytestream(bool integrals) const {
  std::vector<char> result;
  for (std::string::const_iterator s = namelistData.begin(); s != namelistData.end(); s++)
    result.push_back(*s);
  if (integrals) {
    rewind();
    int i, j, k, l;
    union {
      struct {
        int16_t labels[4];
        double value;
      } s = {{0, 0, 0, 0}};
      char buf[16];
    } u;
    while (nextIntegral(i, j, k, l, u.s.value) != endOfFile) {
      u.s.labels[0] = i;
      u.s.labels[1] = j;
      u.s.labels[2] = k;
      u.s.labels[3] = l;
    }
    for (i = 0; i < 16; i++) result.push_back(u.buf[i]);
  }
  return result;
}

void FCIdump::writeIntegral(int i, int j, int k, int l, double value) const {
  outputStream << value << " " << i << " " << j << " " << k << " " << l << std::endl;
}

FCIdump::integralType FCIdump::nextIntegral(int& i, int& j, int& k, int& l, double& value) const {
  integralType result = *currentState;
  if (stream >> value) {
    stream >> i;
    stream >> j;
    stream >> k;
    stream >> l;
  } else {
    stream.close();
    return endOfFile;
  }
  // following is tricky stuff reflecting historical structure of UHF and RHF FCIdump files
  if (i == 0) {
//    xout << "zero read uhf="<<uhf<<", *currentState="<<*currentState<<std::endl;
    if (uhf && *currentState != I0) {
      result = endOfRecord;
      currentState++;
//      xout << "end of Record signalled; *currentState="<<*currentState<<std::endl;
    } else {
//      xout << "real scalar signalled"<<std::endl;
      result = I0;
    }
  } else if (k == 0 && (*currentState != FCIdump::I1a && *currentState != FCIdump::I1b)) {
//    xout << "special state switch to "<<*(currentState+1)<<std::endl;
    result = (*currentState == FCIdump::I2aa) ? FCIdump::I1a : FCIdump::endOfRecord;
    ++currentState;
  }
//  xout << "FCIdump::nextIntegral i,j,k,l,value "<<i<<","<<j<<","<<k<<","<<l<<","<<value<<", result="<<result<<std::endl;
  return result;
}

FCIdump::integralType FCIdump::nextIntegral(unsigned int& symi,
                                            size_t& i,
                                            unsigned int& symj,
                                            size_t& j,
                                            unsigned int& symk,
                                            size_t& k,
                                            unsigned int& syml,
                                            size_t& l,
                                            double& value) const {
  int ii, jj, kk, ll;
  auto result = nextIntegral(ii, jj, kk, ll, value);
  if (result == FCIdump::endOfFile) return result;
//  std::cout << "nextIntegral "<<ii<<jj<<kk<<ll<<" "<<value<<std::endl;
  if (ii > 0) {
    symi = orbital_symmetries[ii - 1];
    i = orbital_offsets[ii - 1];
    symj = orbital_symmetries[jj - 1];
    j = orbital_offsets[jj - 1];
    if (kk > 0) {
      symk = orbital_symmetries[kk - 1];
      k = orbital_offsets[kk - 1];
      syml = orbital_symmetries[ll - 1];
      l = orbital_offsets[ll - 1];
    } else {
      symk = 8;
      syml = 8;
      k = l = 0;
    }
  } else {
    symi = 8;
    symj = 8;
    i = j = 0;
  }
//  std::cout << "symi="<<symi<<std::endl;
//  std::cout << "symk="<<symk<<std::endl;
//  std::cout << "result="<<result<<std::endl;
  return result;
}

FCIdump* dump;

void FCIdumpInitialise(char* filename) {
//  printf("Initialise FCIDUMP from file %s\n",filename);
  dump = new FCIdump(std::string(filename));
}

#include <cstring>
void FCIdumpParameterS(char* key, char* value) {
  std::vector<std::string> vals(1);
  vals[0] = value;
  vals = dump->parameter(std::string(key), vals);
  if (!vals.empty()) value = strdup(vals[0].c_str());
}

void FCIdumpParameterI(char* key, int* values, int n) {
  std::vector<int> vals(n);
  for (size_t i = 0; i < (size_t) n; i++) vals[i] = values[i];
  vals = dump->parameter(std::string(key), vals);
  for (size_t i = 0; i < vals.size() && i < (size_t) n; i++)
    values[i] = vals[i];
}

void FCIdumpParameterF(char* key, double* values, int n) {
  std::vector<double> vals(n);
  for (size_t i = 0; i < (size_t) n; i++) vals[i] = values[i];
  vals = dump->parameter(std::string(key), vals);
  for (size_t i = 0; i < vals.size() && i < (size_t) n; i++)
    values[i] = vals[i];
}

void FCIdumpRewind() {
  dump->rewind();
}

int FCIdumpNextIntegral(int* i, int* j, int* k, int* l, double* value) {
  int ii, jj, kk, ll;
  double vv;
  FCIdump::integralType type = dump->nextIntegral(ii, jj, kk, ll, vv);
  *i = ii;
  *j = jj;
  *k = kk;
  *l = ll;
  *value = vv;
  return (int) type;
}

void FCIdumpAddParameterS(char* key, char* value) {
  std::string keys(key);
  std::vector<std::string> valuess(1, value);
  dump->addParameter(keys, valuess);
}

void FCIdumpAddParameterI(char* key, int values[], int n) {
  std::string keys(key);
  std::vector<int> valuess;
  for (size_t i = 0; i < (size_t) n; i++)
    valuess.push_back(values[i]);
  dump->addParameter(keys, valuess);
}

void FCIdumpAddParameterF(char* key, double values[], int n) {
  std::string keys(key);
  std::vector<double> valuess;
  for (size_t i = 0; i < (size_t) n; i++)
    valuess.push_back(values[i]);
  dump->addParameter(keys, valuess);
}

int FCIdumpWrite(char* filename, int type) {
  return dump->write(std::string(filename), (FCIdump::fileType) type) ? 1 : 0;
}

void FCIdumpWriteIntegral(int i, int j, int k, int l, double value) {
  dump->writeIntegral(i, j, k, l, value);
}
