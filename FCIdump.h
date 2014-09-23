#ifndef FCIDUMP_H
#define FCIDUMP_H
#ifdef __cplusplus
#include <string>
#include <vector>
#include <fstream>

/*!
 * \brief Class that provides access to FCIdump files
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

/*!
 * \brief initialise access to an FCIDUMP
 * \param filename The file containing the FCIDUMP data
 */
#ifdef __cplusplus
extern "C"
#endif
void FCIdumpInitialise(char* filename);

#endif // FCIDUMP_H
