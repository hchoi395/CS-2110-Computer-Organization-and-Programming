;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - binaryStringToInt
;;=============================================================
;; Name: Han Choi
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;
;;  String binaryString = "00010101"; (sample binary string)
;;  int length = 8; (sample length of the above binary string)
;;  int base = 1;
;;  int value = 0;
;;  int i = length - 1;
;;  while (i >= 0) {
;;      int x = binaryString[i] - 48;
;;      if (x == 1) {
;;          if (i == 0) {
;;              value -= base;
;;          } else {
;;              value += base;
;;          }
;;      }     
;;      base += base;
;;      i--;
;;  }
;;  mem[mem[RESULTIDX]] = value;

.orig x3000
    LD R0, LENGTH   ;int length = 0
    AND R1, R1, #0  ;clear R1
    ADD R1, R1, #1  ;int base = 1
    AND R2, R2, #0  ;clear R2 and int value = 0
    AND R3, R3, #0  ;clear R3
    ADD R3, R0, #-1 ;int i = length - 1

    W1  ;while loop start
    LD R4, BINARYSTRING ;int x = binaryString[]
    ADD R4, R4, R3  ;int x = binaryString[i]
    LDR R4, R4, #0

    LD R5, ASCII    ;R5 = ASCII
    ADD R4, R4, R5  ;int x = binaryString[i] - 48 (ASCII)

    BRz ELSE1   ;branch to ELSE1 if x == 0

    ADD R3, R3, #0  ;we need BRnp to reference R3
    BRnp ELSE2  ;branch to ELSE2 if i != 0
    NOT R1, R1  ;base turns negative
    ADD R1, R1, #1  ;make sure to +1
    ADD R2, R2, R1  ;value -= base
    BR STOPPER  ;branch to STOPPER to skip second case

    ELSE2 NOP   ;branch to if i != 0
    ADD R2, R2, R1  ;value += base

    STOPPER ;branch to to skip i != 0 case
    ELSE1 NOP   ;branch to if x == 0 instead of x == 1

    ADD R1, R1, R1  ;base += base
    ADD R3, R3, #-1 ;i--

    BRzp W1 ;branch to while loop W1 if i >= 0
    STI R2, RESULTIDX   ;mem[mem[RESULTIDX]] = value

    HALT
    
;; DO NOT CHANGE THESE VALUES
ASCII           .fill -48
BINARYSTRING    .fill x5000
LENGTH          .fill 8
RESULTIDX       .fill x4000
.end

.orig x5000                    ;;  DO NOT CHANGE THE .orig STATEMENT
    .stringz "00010101"        ;; You can change this string for debugging!
.end
