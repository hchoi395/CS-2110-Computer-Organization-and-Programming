;;=============================================================
;;  CS 2110 - Fall 2022
;;  Homework 6 - Selection Sort
;;=============================================================
;;  Name: Han Choi
;;============================================================

;;  In this file, you must implement the 'SELECTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'SELECTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * SELECTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  SELECTION_SORT Pseudocode (see PDF for explanation and examples)
;; 
;;  SELECTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;          return;
;;      }
;;      int largest = 0;
;;      for (int i = 1; i < length; i++) {
;;          if (arr[i] > arr[largest]) {
;;              largest = i;
;;          }
;;      }
;;      int temp = arr[length - 1];
;;      arr[length - 1] = arr[largest];
;;      arr[largest] = temp;
;;
;;      SELECTION_SORT(arr, length - 1);
;;      return;
;;  }

SELECTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the SELECTION_SORT subroutine here!
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

    ;;implement SELECTION_SORT(int[] arr (addr), int length)

    LDR R0, R5, 5   ;R0 = length
    ADD R0, R0, #-1 ;if (length <= 1)
    BRp END_IF1
    BR TEARDOWN
    END_IF1 NOP

    AND R0, R0, #0  ;int largest = 0
    AND R1, R1, #0  ;clear R1
    ADD R1, R1, #1  ;int i = 1;
    FOR1
    LDR R2, R5, 5   ;R2 = length
    NOT R2, R2      ;length *= -1
    ADD R2, R2, #1  
    ADD R2, R2, R1  ;R2 = -length + i
    BRzp END_FOR1
    LDR R2, R5, 4   ;R2 = arr[]
    ADD R3, R2, R1  ;R3 = arr[i]
    LDR R3, R3, 0   ;R3 = value of arr[i]
    ADD R4, R2, R0  ;R4 = arr[largest]
    LDR R4, R4, 0   ;R4 = value of arr[largest]
    NOT R4, R4      ;arr[largest] *= -1
    ADD R4, R4, #1
    ADD R4, R4, R3  ;R3 = -arr[largest] + arr[i]
    BRnz END_IF2
    AND R0, R0, #0  ;clear R0
    ADD R0, R0, R1  ;largest = i
    END_IF2 NOP
    ADD R1, R1, #1  ;i++
    BR FOR1
    END_FOR1 NOP

    LDR R1, R5, 4   ;R1 = arr
    LDR R2, R5, 5   ;R2 = length
    ADD R2, R2, #-1 ;R2 = length - 1
    ADD R2, R1, R2  ;R2 = arr[length - 1]
    LDR R3, R2, 0   ;R3 = value of arr[length - 1]
    STR R3, R5, 0   ;temp = value of arr[length - 1]
    ADD R3, R1, R0  ;R3 = arr[largest]
    LDR R4, R3, 0   ;R4 = value of arr[largest]  
    STR R4, R2, 0   ;arr[length - 1] = value of arr[largest]
    LDR R1, R5, 0   ;R1 = temp    
    STR R1, R3, 0   ;arr[largest] = temp

    LDR R0, R5, 5   ;R0 = length
    ADD R0, R0, #-1 ;R0 = length - 1
    ADD R6, R6, -1  ;push stack
    STR R0, R6, 0   ;add length - 1
    LDR R1, R5, 4   ;R1 = arr
    ADD R6, R6, -1  ;push stack
    STR R1, R6, 0   ;add arr
    JSR SELECTION_SORT  ;selection sort
    ADD R6, R6, 3   ;pop 3

    TEARDOWN
    LDR R4, R5, -5  ;restore R4
    LDR R3, R5, -4  ;restore R3
    LDR R2, R5, -3  ;restore R2
    LDR R1, R5, -2  ;restore R1
    LDR R0, R5, -1  ;restore R0
    ADD R6, R5, 0   ;restore SP
    LDR R5, R6, 1   ;restore FP
    LDR R7, R6, 2   ;restore RA
    ADD R6, R6, 3   ;pop 3 words
    RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end