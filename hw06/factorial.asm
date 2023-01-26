;;=============================================================
;;  CS 2110 - Fall 2022
;;  Homework 6 - Factorial
;;=============================================================
;;  Name: Han Choi
;;============================================================

;;  In this file, you must implement the 'MULTIPLY' and 'FACTORIAL' subroutines.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'MULTIPLY' or 'FACTORIAL' labels
;;      * Add the [a, b] or [n] params separated by a comma (,) 
;;        (e.g. 3, 5 for 'MULTIPLY' or 6 for 'FACTORIAL')
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. 3 * 5 = 15 or 6! = 720)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  MULTIPLY Pseudocode (see PDF for explanation and examples)   
;;  
;;  MULTIPLY(int a, int b) {
;;      int ret = 0;
;;      while (b > 0) {
;;          ret += a;
;;          b--;
;;      }
;;      return ret;
;;  }

MULTIPLY ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the MULTIPLY subroutine here!
    ;;first, lay out stack frame
    ADD R6, R6, -4  ;allocate space rv, ra, fp, lvl
    STR R7, R6, 2   ;save Ra
    STR R5, R6, 1   ;save old FP
    ADD R5, R6, 0   ;copy SP to FP
    ADD R6, R6, -5  ;make room for saved regs

    STR R0, R5, -1  ;save R0
    STR R1, R5, -2  ;save R1
    STR R2, R5, -3  ;save R2
    STR R3, R5, -4  ;save R3
    STR R4, R5, -5  ;save R4

    ;;now we do MULTIPLY(int a, int b)
    AND R0, R0, #0   ;int ret = 0
    STR R0, R5, 0    ;answer = ret

    W1
    LDR R0, R5, 5   ;R0 = b
    BRnz END_W1     ;while (b > 0)
    LDR R0, R5, 0   ;R0 = ret
    LDR R1, R5, 4   ;R1 = a
    ADD R0, R0, R1  ;ret = ret + a
    STR R0, R5, 0
    LDR R0, R5, 5   ;R0 = b
    ADD R0, R0, #-1 ;b--
    STR R0, R5, 5   ;store b

    BR W1
    END_W1 NOP

    LDR R0, R5, 0   ;R0 = answer
    STR R0, R5, 3   ;ret val = ret

    ;;stack teardown
    LDR R4, R5, -5  ;restore R4
    LDR R3, R5, -4  ;restore R3
    LDR R2, R5, -3  ;restore R2
    LDR R1, R5, -2  ;restore R1
    LDR R0, R5, -1  ;restore R0
    ADD R6, R5, 0   ;restore SP
    LDR R5, R6, 1   ;restore FP
    LDR R7, R6, 2   ;restore RA
    ADD R6, R6, 3   ;pop 3 words
    RET             ;MULTIPLY() is done

;;  FACTORIAL Pseudocode (see PDF for explanation and examples)
;;
;;  FACTORIAL(int n) {
;;      int ret = 1;
;;      for (int x = 2; x <= n; x++) {
;;          ret = MULTIPLY(ret, x);
;;      }
;;      return ret;
;;  }

FACTORIAL ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the FACTORIAL subroutine here!
    ;;first, lay out stack frame
    ADD R6, R6, -4  ;allocate space rv, ra, fp, lvl
    STR R7, R6, 2   ;save Ra
    STR R5, R6, 1   ;save old FP
    ADD R5, R6, 0   ;copy SP to FP
    ADD R6, R6, -5  ;make room for saved regs
    STR R0, R5, -1  ;save R0
    STR R1, R5, -2  ;save R1
    STR R2, R5, -3  ;save R2
    STR R3, R5, -4  ;save R3
    STR R4, R5, -5  ;save R4

    ;;now do the code
    AND R0, R0, #0  ;clear R0
    ADD R0, R0, #1  ;ret = 1
    STR R0, R5, 0   ;answer = ret

    AND R0, R0, #0  ;clear R0
    ADD R0, R0, #2  ;int x = 2
    FOR1
    LDR R1, R5, 4   ;R1 = int n
    NOT R1, R1      ;n *= -1
    ADD R1, R1, #1
    ADD R1, R1, R0  ;check if x <= n
    BRp END_FOR1
    LDR R2, R5, 0   ;R2 = answer
    ;; R2 (ret) = multiply(ret (R2), x (R0))
    ADD R6, R6, -1  ;push x
    STR R0, R6, 0   
    ADD R6, R6, -1  ;push ret
    STR R2, R6, 0
    JSR MULTIPLY    ;MULTIPLY(ret, x)
    LDR R2, R6, 0   ;ret = MULTIPLY(ret, x)
    STR R2, R5, 0   ;answer = ret
    ADD R6, R6, 3   ;pop MULTIPLY(ret, x), ret, x
    ADD R0, R0, #1  ;x++
    BR FOR1
    END_FOR1 NOP

    LDR R0, R5, 0   ;R0 = answer
    STR R0, R5, 3   ;ret val = ret
    ;;stack teardown
    LDR R4, R5, -5  ;restore R4
    LDR R3, R5, -4  ;restore R3
    LDR R2, R5, -3  ;restore R2
    LDR R1, R5, -2  ;restore R1
    LDR R0, R5, -1  ;restore R0
    ADD R6, R5, 0   ;restore SP
    LDR R5, R6, 1   ;restore FP
    LDR R7, R6, 2   ;restore RA
    ADD R6, R6, 3   ;pop 3 words
    RET             ;FACTORIAL is done

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end