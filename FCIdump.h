#ifndef FCIDUMP_H
#define FCIDUMP_H
#ifdef __cplusplus
#include <string>
#include <vector>
#include <fstream>
/**
 @mainpage FCIdump access through C++, C and Fortran

 @section Introduction
 This is a C++ class, together with non-object-oriented C and Fortran 90 bindings, that implement access
 to an FCIDUMP file as produced by the Full CI code (Computer Physics Communications
Volume 54, Issue 1, April 1989, Pages 75–83,
<a href="http://dx.doi.org/10.1016/0010-4655(89)90033-7">
doi:10.1016/0010-4655(89)90033-7</a>;
<a href="http://bitbucket.org:pjknowles/fci">
http://bitbucket.org/pjknowles/fci</a>),
as well as <a href="http://www.molpro.net/">Molpro</a> via its fci;dump facility

@author Peter Knowles

 */

/*!
 * \brief C++ class that provides access to FCIdump files
 */
class FCIdump
{
public:
  /*!
     * \brief Construct FCIdump object
     * \param filename The file containing the FCIDUMP data
     */
  FCIdump(std::string filename="FCIDUMP");

  /*!
     * \brief parameter Obtain an integer namelist parameter from the FCIDUMP data.
     * \param key The name of the parameter
     * \param def Default value if the parameter is not found.
     * \return  The result as a vector of integers.
     */
  std::vector<int> parameter(std::string key, std::vector<int> def=std::vector<int>(1,0));

  /*!
     * \brief parameter Obtain a real namelist parameter from the FCIDUMP data.
     * \param key The name of the parameter
     * \param def Default value if the parameter is not found.
     * \return  The result as a vector of integers.
     */
  std::vector<double> parameter(std::string key, std::vector<double> def);

  /*!
     * \brief parameter Obtain a string namelist parameter from the FCIDUMP data.
     * \param key The name of the parameter
     * \param def Default value if the parameter is not found.
     * \return  The result as a vector of integers.
     */
  std::vector<std::string> parameter(std::string key, std::vector<std::string> def);
  /*!
   * \brief addParameter add a parameter
   * \param key key
   * \param values values
   */
  void addParameter(const std::string& key, const std::vector<std::string>& values);

   /*!
     * \brief fileName The file containing the FCIDUMP data
     */
  std::string fileName();

  /*!
   * \brief indicator of the type of integral record (core, 1-electron, 2-electron integrals; end of record; end of file)
    */
  typedef enum { I0, I1a, I1b, I2aa, I2ab, I2bb, endOfFile, endOfRecord } integralType;

  /*!
   * \brief Position the file so that the next call to nextIntegral will deliver the first integral
   */
  void rewind();

  /*!
   * \brief Read the next integral from the file
   * \param i orbital label (zero indicates not 1-electron or 2-electron)
   * \param j orbital label
   * \param k orbital label(zero indicates not 2-electron)
   * \param l orbital label
   * \param value numerical value of the integral
   * \return indicator of the type of entry (core, 1-electron, 2-electron integrals; end of record; end of file)
   */
  integralType nextIntegral(int& i, int& j, int& k, int& l, double& value);

private:
  std::string namelistData;
  std::string _fileName;
  std::ifstream stream;
  bool uhf;
  std::vector<integralType> states;
  std::vector<integralType>::const_iterator currentState;
};
#endif

#ifdef __cplusplus
extern "C" {
#endif
/*!
 * \brief C binding of FCIdump: initialise access to an FCIDUMP
 * \param filename The file containing the FCIDUMP data
 */
void FCIdumpInitialise(char* filename);
/*!
 * \brief C binding of FCIdump:  Obtain a string namelist parameter from the FCIDUMP data.
 * \param key The name of the parameter
 * \param values  The result as a vector of integers.
 */
void FCIdumpParameter(char* key, int* values);
/*!
 * \brief C binding of FCIdump: Position the file so that the next call to nextIntegral will deliver the first integral
 */
void FCIdumpRewind();
  /*!
 * \brief C binding of FCIdump: Read the next integral from the file
   * \param i orbital label (zero indicates not 1-electron or 2-electron)
   * \param j orbital label
   * \param k orbital label(zero indicates not 2-electron)
   * \param l orbital label
   * \param value numerical value of the integral
   * \return indicator of the type of entry (core, 1-electron, 2-electron integrals; end of record; end of file)
   */
int FCIdumpNextIntegral(int* i, int* j, int* k, int* l, double* value);
/*!
 * \brief addParameter C binding of FCIdump: add a parameter
 * \param key key
 * \param values values
 */
void FCIdumpAddParameter(char* key, int values[]);
#ifdef __cplusplus
}
#endif

#endif // FCIDUMP_H
