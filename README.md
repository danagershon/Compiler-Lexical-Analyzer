# Compiler Lexical Analyzer

Theory of Compilation HW1: Building Lexical Analyzer with Flex

**Files in this project:**

• scanner.lex:
the lexical analyzer specifications in Flex format

• hw1.cpp:
driving program to run the lexical analyzer by calling yylex() and
handling recognized tokens and errors

• tokens.hpp:
header file included in scanner.lex and hw1.cpp, containing variables that
need to be accessed from both files and: enum for tokens names and errors,
string buffer and Flex global variables

• hw1.out:
the lexical analyzer executable

**There are also tests for checking the lexical analyzer:**

• tests/official_tests:
two tests from the course staff

• tests/students_tests:
58 tests written by other students

• tests/mytests:
35 tests I wrote based on examples from the HW instructions, Piazza and my ideas

**To create the lexical analyzer:**

Flex scanner.lex
g++ -std=c++11 lex.yy.c hw1.cpp -o hw1.out

**To run the tests:**

./mycheck
from the script directory

**to run individual test:**

./hw1.out < test.in > test.out


