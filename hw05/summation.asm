;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - summation
;;=============================================================
;; Name: Han Choi
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;
;;  int x = 6; (sample integer)
;;  int sum = 0;
;;  while (x > 0) {
;;      sum += x;
;;      x--;
;;  }
;;  mem[ANSWER] = sum;

.orig x3000
    AND R1, R1, #0      ;clears R1
    LD R1, x       ;loads value of x to R1 register

    AND R2, R2, #0      ;clears R2 which represents sum

    W1 ADD R1, R1, #0       ;while R1 (x) > 0
    BRnz ENDW1      ;branch to ENDW1 if x <= 0
    ADD R2, R2, R1      ;R2 (sum) equals R2 + R1 (x)
    ADD R1, R1, -1      ;R1 (x) equals R1 + -1
    BR W1       ;branch back to W1 label

    ENDW1       ;branched to when R1 <= 0

    ADD R2, R2, #0      ;if R2 (sum) > 0
    BRnz ELSE1
    ST R2, ANSWER       ;store R2 into memory at ANSWER
    BR STOPPER

    ELSE1 NOP       ;if R2 <= 0
    AND R2, R2, #0     ;set R2 to 0
    ST R2, ANSWER       ;store 0 into ANSWER
    STOPPER
    HALT        ;halt

    x      .fill 6      ;; You can change this value for debugging!
    ANSWER .blkw 1
.end