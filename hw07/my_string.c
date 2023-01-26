/**
 * @file my_string.c
 * @author Han Choi
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2022-10-27
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include <stddef.h>
#include "my_string.h"

/**
 * @brief Calculate the length of a string. See PDF for more detailed instructions
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  
  size_t size = 0;
  int i = 0;
  while (*(s + i) != '\0') {
    i = i + 1;
    size = size + 1;
  }
  return size;
}

/**
 * @brief Compare two strings. See PDF for more detailed instructions
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */

  size_t i = 0;
  while (i < n) {
    if (*(s1 + i) == '\0' && *(s2 + i) == '\0') {
      return 0;
    }
    if (*(s1 + i) - *(s2 + i) > 0) {
      return 1;
    }
    if (*(s1 + i) - *(s2 + i) < 0) {
      return -1;
    }
    i = i + 1;
  }
  return 0;
}

/**
 * @brief Copy a string. See PDF for more detailed instructions
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  size_t i = 0;
  while (i < n) {
    if (*(src + i) == '\0') {
      *(dest + i) = '\0';
    } else {
      *(dest + i) = *(src + i);
    }
    i++;
  }
  return dest;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  size_t i = 0;
  size_t j = 0;
  while (*(dest + j) != '\0') {
    j++;
  }
  while (i < n) {
    if (*(src + i) == '\0') {
      break;
    } else {
      *(dest + i + j) = *(src + i);
    }
    i++;
  }
  return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  unsigned char* p = str;
  size_t i = 0;
  while (i < n) {
    *(p) = (unsigned char)c;
    p++;
    i++;
  }
  return str;
}

