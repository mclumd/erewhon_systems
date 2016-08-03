#ifndef UMBC_TEXT_UTILS_H
#define UMBC_TEXT_UTILS_H

/** \file text_utils.h
 * \brief contains textFunctions class for manipulating strings.
 *
 * String tokenizer and various static text processing functions in the 
 * textFunctions class.
 */

#include <string>
using namespace std;

namespace umbc {

  /** provides static functions for text processing. */
  class textFunctions {
  public:
    textFunctions() {};
    //! dumps all the tokens as parsed by the tokenMachine class.
    static void dumpTokens(string k);
    //! reads a text file and returns its contents as a string.
    static string file2string(string fn,string commend_prefix,
			      bool convert_eol_to_ws);
    static string file2string(string fn,bool convert_eol_to_ws=true);
    /** reads from a a string until whitespace is encountered.
     * \param k the input string
     * \param start the index into k at which to start
     * \param end the index into k at which to stop
     * \param nextStart the index of the first encountered whitespace character 
     * \return the non whitespace text before the first whitespace character
     */
    static string readUntilWS(string k,int start,int end,int *nextStart);
    //! tests if the first non-WS characters in SRC match PREFIX
    static bool prefixMatchNoWS(string src,string prefix);
    //! tests if the first non-WS character in SRC is in CHARBAG
    static bool firstNonWSinBag(string src,string charbag);
    //! tests if a character is considered whitespace.
    static bool isWS(char c);
    //! tests if a character is considered an escape-code ('\').
    static bool isEscape(char c);
    //! returns a string value for an number
    static string num2string(int k);
    static string num2string(double k);
    //! returns the numerical (integer) value of a string.
    static int numval(string q);
    //! returns the numerical (integer) value of a string.
    static long longval(string q);
    //! returns the unsigned numerical (integer) value of a string.
    static unsigned int unumval(string q);
    //! returns the boolean value of a string.
    //  @returns true iff q == "true" || "TRUE"
    static bool boolval(string q);
    //! computes a hash key for a string.
    static int hashKey(string q);
    //! returns either the value of a numerical string or its hash value if it is not numerical.
    static int valueOrHash(string q);

    static string str2lower(string source);
    static string str2upper(string source);

    //! removes quotation marks from a string
    static string dequote(string s);
    //! returns the double-precision numberical value of a string
    static double dubval(string q);
    //! substitutes one character for another in a string
    static string substChar(const string source, char c_was, char c_is);
    
    static string getFunctor(const string source);
    static string getParameters(const string source);

    // //! detokenizes a TokArr for PNL output
    // static void dumpTokArrStr(string tas);
    
    static string chopLastChar(string k) { return k.substr(0,k.length()-1); };

    static string adjustProtectLevelEnhanced(char c,string protect,
					     string open,string close,
					     bool* error);
    static string readUntilWSEnhanced(string k,int start,int end,
				      int *nextStart);

    static string trimBraces(string src);
    static string trimBrackets(string src);
    static string trimAngleBrackets(string src);
    static string trimParens(string src);
    static string trimWS(const string& src);
    
    static string DEFAULT_OPEN_PROTECTORS;
    static string DEFAULT_CLOSE_PROTECTORS;

  private:
    static void adjustProtectLevel(char c,int *protect);
    
  };
};

#endif
