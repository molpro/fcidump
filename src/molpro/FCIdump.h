#ifndef FCIDUMP_H
#define FCIDUMP_H
#ifdef __cplusplus
#include <cstddef>
#include <string>
#include <vector>
#include <fstream>
/**
 @if MOLPRO
 @page FCIdump FCIdump access through C++, C and Fortran
 @else
 @mainpage FCIdump access through C++, C and Fortran
 @endif

 @section Introduction
 This is a C++ class, together with non-object-oriented C and Fortran 90 bindings, that implement access
 to an FCIDUMP file as produced by the Full CI code (Computer Physics Communications
Volume 54, Issue 1, April 1989, Pages 75-83,
<a href="http://dx.doi.org/10.1016/0010-4655(89)90033-7">
doi:10.1016/0010-4655(89)90033-7</a>;
<a href="http://bitbucket.org:pjknowles/fci">
http://bitbucket.org/pjknowles/fci</a>),
as well as <a href="http://www.molpro.net/">Molpro</a> via its fci;dump facility

@author Peter Knowles

 */
namespace molpro {

/*!
 * \brief C++ class that provides access to FCIdump files
 */
class FCIdump {
 public:
  /*!
     * \brief Construct FCIdump object
     * \param filename The file containing the FCIDUMP data
     * \param old The file must pre-exist
     */
  explicit FCIdump(std::string filename = "", bool old = false);

  ~FCIdump();

  /*!
     * \brief Construct FCIdump object from bytestream
     * \param bytestream The serialised representation
     */
  FCIdump(std::vector<char> bytestream);

  /*!
     * \brief Obtain an integer namelist parameter from the FCIDUMP data.
     * \param key The name of the parameter
     * \param def Default value if the parameter is not found.
     * \return  The result as a vector of integers.
     */
  std::vector<int> parameter(const std::string& key, const std::vector<int>& def = std::vector<int>(1, 0)) const;

  /*!
     * \brief Obtain a real namelist parameter from the FCIDUMP data.
     * \param key The name of the parameter
     * \param def Default value if the parameter is not found.
     * \return  The result as a vector of integers.
     */
  std::vector<double> parameter(const std::string& key, const std::vector<double>& def) const;

  /*!
     * \brief Obtain a string namelist parameter from the FCIDUMP data.
     * \param key The name of the parameter
     * \param def Default value if the parameter is not found.
     * \return  The result as a vector of integers.
     */
  std::vector<std::string> parameter(const std::string& key, const std::vector<std::string>& def) const;
  /*!
   * \brief Add a parameter with array values
   * \param key key
   * \param values values
   */
  void addParameter(const std::string& key, const std::vector<std::string>& values);

  /*!
   * \brief Add a parameter with array values
   * \param key key
   * \param values values
   */
  void addParameter(const std::string& key, const std::vector<int>& values);

  /*!
   * \brief Add a parameter with array values
   * \param key key
   * \param values values
   */
  void addParameter(const std::string& key, const std::vector<double>& values);

  /*!
   * \brief Add a parameter with a scalar value
   * \param key key
   * \param value value
   */
  void addParameter(const std::string& key, const std::string& value);

  /*!
   * \brief Add a parameter with a scalar value
   * \param key key
   * \param value value
   */
  void addParameter(const std::string& key, const int& value);

  /*!
   * \brief Add a parameter with a scalar value
   * \param key key
   * \param value value
   */
  void addParameter(const std::string& key, const double& value);

  /*!
    * \brief The file containing the FCIDUMP data
    */
  std::string fileName() const;

  /*!
   * \brief The possible external file formats
    */
  typedef enum {
    FileFormatted ///< formatted ASCII file
  } fileType;

  /*!
   * \brief Serialise the object to a stream of bytes
   * \param integrals If true, write out the integrals as well as the headers
   * \return the serialised representation of the object
   */
  std::vector<char> bytestream(bool integrals = true) const;

  /*!
   * \brief Write the object to an external file
   * \param filename The relative or absolute path name of the file
   * \param type The desired format of the file
   * \param integrals If true, write out the integrals; otherwise leave the file open and positioned ready to write integrals later
   * \return true if OK, false if not
   */
  bool write(std::string filename = "", fileType type = FileFormatted, bool integrals = true);

  /*!
   * \brief writeIntegral Write an integral to the output stream. write() must already have been called.
   * \param i Orbital index
   * \param j Orbital index
   * \param k Orbital index
   * \param l Orbital index
   * \param value The integral
   */
  void writeIntegral(int i, int j, int k, int l, double value) const;
  /*!
   * @brief
   * @param symi Symmetry of bra-1 orbital
   * @param i Offset of bra-1 orbital in its symmetry
   * @param symj Symmetry of ket-1 orbital
   * @param j Offset of ket-1 orbital in its symmetry
   * @param symk Symmetry of bra-2 orbital
   * @param k Offset of bra-2 orbital in its symmetry
   * @param syml Symmetry of ket-2 orbital
   * @param l Offset of ket-2 orbital in its symmetry
   * @param value The integral
   */
  void writeIntegral(int symi, int i, int symj, int j, int symk, int k, int syml, int l, double value) const {
    writeIntegral(orbital_number(symi, i),
                  orbital_number(symj, j),
                  orbital_number(symk, k),
                  orbital_number(syml, l),
                  std::move(value));
  }

  /*!
   * \brief Indicator of the type of integral record (core, 1-electron, 2-electron integrals; end of record; end of file)
    */
  typedef enum {
    I0, ///< scalar part of energy, ie nuclear repulsion plus any included core
    I1a, ///< 1-electron integrals, alpha spin
    I1b, ///< 1-electron integrals, beta spin
    I2aa, ///< 2-electron integrals, alpha-alpha spin
    I2ab, ///< 2-electron integrals, alpha-beta spin
    I2bb, ///< 2-electron integrals, beta-beta spin
    endOfFile, ///< End of file
    endOfRecord ///< Separator between different spin cases
  } integralType;

  /*!
   * \brief Position the file so that the next call to nextIntegral will deliver the first integral
   */
  void rewind() const;

  /*!
   * \brief Read the next integral from the file
   * \param i orbital label (zero indicates not 1-electron or 2-electron)
   * \param j orbital label
   * \param k orbital label(zero indicates not 2-electron)
   * \param l orbital label
   * \param value numerical value of the integral
   * \return indicator of the type of entry (core, 1-electron, 2-electron integrals; end of record; end of file)
   */
  integralType nextIntegral(int& i, int& j, int& k, int& l, double& value) const;
  /*!
   * @brief Read the next integral from the file
   * @param symi Symmetry of bra-1 orbital (8 indicates not 1-electron or 2-electron)
   * @param i Offset of bra-1 orbital in its symmetry
   * @param symj Symmetry of ket-1 orbital
   * @param j Offset of ket-1 orbital in its symmetry
   * @param symk Symmetry of bra-2 orbital (8 indicates not 2-electron)
   * @param k Offset of bra-2 orbital in its symmetry
   * @param syml Symmetry of ket-2 orbital
   * @param l Offset of ket-2 orbital in its symmetry
   * @param value numerical value of the integral
   * @return
   */
  integralType nextIntegral(unsigned int& symi,
                            size_t& i,
                            unsigned int& symj,
                            size_t& j,
                            unsigned int& symk,
                            size_t& k,
                            unsigned int& syml,
                            size_t& l,
                            double& value) const;
  std::string data() const { return namelistData; }

  /*!
   * @brief Get the symmetry of an orbital
   * @param orbital The index of the orbital, counting from 1
   * @return The symmetry, in the range 0-7
   */
  off_t orbital_symmetry(int orbital) const { return orbital_symmetries[orbital - 1]; }
  /*!
   * @brief Get the number of previous orbitals of the same symmetry
   * @param orbital The index of the orbital, counting from 1
   * @return The offset
   */
  off_t orbital_offset(int orbital) const { return orbital_offsets[orbital - 1]; }
  /*!
   * @brief Get the orbital number for a given symmetry and offset
   * @param symmetry The symmetry of the orbital, in the range 0-7
   * @param offset The offset of the orbital in its symmetry
   * @return The index of the orbital, counting from 1
   */
  int orbital_number(off_t symmetry, off_t offset) const { return orbital_numbers[symmetry][offset]; }

 private:
  std::string _fileName;
  std::string namelistData;
  mutable std::ifstream stream;
  mutable std::ofstream outputStream;
  mutable bool uhf;
  mutable std::vector<integralType> states;
  mutable std::vector<integralType>::const_iterator currentState;
  mutable std::vector<off_t> orbital_block_dimensions;
  mutable std::vector<off_t> orbital_block_offsets;
  mutable std::vector<std::vector<int> > orbital_numbers;
  mutable std::vector<off_t> orbital_symmetries;
  mutable std::vector<off_t> orbital_offsets;
};
}
#endif

// C binding
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
 * \param value  The result as a char* (arrays not supported). If not present in the FCIDUMP, value is not overwritten, i.e. value serves as a default
 */
void FCIdumpParameterS(char* key, char* value);
/*!
 * \brief C binding of FCIdump:  Obtain an integer namelist parameter from the FCIDUMP data.
 * \param key The name of the parameter
 * \param values  The result as a vector of integers. Any elements not present in the FCIDUMP are not overwritten, i.e. values serves as a list of defaults
 * \param n The length of values
 */
void FCIdumpParameterI(char* key, int* values, int n);
/*!
 * \brief C binding of FCIdump:  Obtain a floating-point namelist parameter from the FCIDUMP data.
 * \param key The name of the parameter
 * \param values  The result as a vector of doubles. Any elements not present in the FCIDUMP are not overwritten, i.e. values serves as a list of defaults
 * \param n The length of values
 */
void FCIdumpParameterF(char* key, double* values, int n);
/*!
 * \brief C binding of FCIdump: Position the file so that the next call to FCIdumpNextIntegral will deliver the first integral
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
 * \brief C binding of FCIdump: add a parameter
 * \param key key
 * \param value value. Note that through this interface only a single string, not an array, can be given
 */
void FCIdumpAddParameterS(char* key, char* value);
/*!
 * \brief C binding of FCIdump: add a parameter
 * \param key key
 * \param values values
 * \param n length of values
 */
void FCIdumpAddParameterI(char* key, int values[], int n);
/*!
 * \brief C binding of FCIdump: add a parameter
 * \param key key
 * \param values values
 * \param n length of values
 */
void FCIdumpAddParameterF(char* key, double values[], int n);
/*!
 * \brief C binding of FCIdump: write the data to an external file
 * \param filename The relative or absolute path name of the file
 * \param type The desired format of the file
 * \return 1 if OK, 0 if not
 */
int FCIdumpWrite(char* filename, int type);
/*!
 * \brief C binding of FCIdump: write an integral to the output stream. FCIdumpWrite() must already have been called.
 * \param i Orbital index
 * \param j Orbital index
 * \param k Orbital index
 * \param l Orbital index
 * \param value The integral
 */
void FCIdumpWriteIntegral(int i, int j, int k, int l, double value);
#ifdef __cplusplus
}
#endif

#endif // FCIDUMP_H
