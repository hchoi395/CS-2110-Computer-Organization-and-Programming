/**
 * CS 2110 Summer 2022 HW1
 * Part 2 - Coding with bases
 *
 * @author Han Choi
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt (where you may use multiplication only)
 * - You may declare exactly one String variable each in intToOctalString and
 *   and binaryStringToHexString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        int conversion = 0;
        int power = 0;
        for (int i = binary.length() - 1; i >= 0; i--) {
            if (binary.charAt(i) == 49) {
                conversion += (1 << power);
            }
            power++;
        }
        return conversion;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("46"); // => 46
     *
     * You may use multiplication in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int conversion = 0;
        int multiply = 1;
        for (int i = decimal.length() - 1; i >= 0; i--) {
            int temp = decimal.charAt(i) - 48;
            conversion += multiply * temp;
            multiply *= 10;
        }
        return conversion;
    }
    /**
     * Convert a string containing ASCII characters (in hex) to an int.
     * The input string will only contain numbers and uppercase letters A-F.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid hexadecimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: hexStringToInt("A6"); // => 166
     */
    public static int hexStringToInt(String hex)
    {
        int conversion = 0;
        int power = 0;
        for (int i = hex.length() - 1; i >= 0; i--) {
            if (hex.charAt(i) < 58) {
                int temp = hex.charAt(i) - 48;
                conversion += (temp << power);
            } else {
                int temp = hex.charAt(i) - 55;
                conversion += (temp << power);
            }
            power += 4;
        }
        return conversion;
    }
    /**
     * Convert a int into a String containing ASCII characters (in octal).
     *
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     *
     * Example: intToOctalString(166); // => "246"
     *
     * You may declare one String variable in this method.
     */
    public static String intToOctalString(int octal)
    {
        String conversion = "";
        while (octal > 0) {
            int temp = octal & 0b111;
            conversion = ((char)(temp + 48)) + conversion;
            octal = octal >> 3;
        }
        return conversion;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * binary into a String containing ASCII characters that represent that same
     * value in hex.
     *
     * The output string should only contain numbers and capital letters.
     * You do not need to handle negative numbers.
     * All binary strings passed in will contain exactly 32 characters.
     * The hex string returned should contain exactly 8 characters.
     *
     * Example: binaryStringToHexString("00001111001100101010011001011100"); // => "0F32A65C"
     *
     * You may declare one String variable in this method.
     */
    public static String binaryStringToHexString(String binary)
    {
        int conversion = 0;
        int power = 0;
        for (int i = binary.length() - 1; i >= 0; i--) {
            if (binary.charAt(i) == 49) {
                conversion += (1 << power);
            }
            power++;
        }
        String string = "";
        for (int i = 7; i >= 0; i--) {
            int temp = conversion & 0b1111;
            if (temp > 9) {
                string = ((char)(temp + 55)) + string;
            } else {
                string = ((char)(temp + 48)) + string;
            }
            conversion = conversion >> 4;
        }
        return string;
    }
}
