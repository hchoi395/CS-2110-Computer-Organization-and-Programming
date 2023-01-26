;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - buildMinArray
;;=============================================================
;; Name: Han Choi
;;=============================================================

;; 	Pseudocode (see PDF for explanation)
;;
;;	int A[] = {-4, 2, 6}; (sample array)
;;	int B[] = {4, 7, -2}; (sample array)
;;	int C[3]; (sample array)
;;	int length = 3; (sample length of above arrays)
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] < B[i]) {
;;			C[i] = A[i];
;;		}
;;		else {
;;			C[i] = B[i];
;;		}
;;		i++;
;;	}

.orig x3000


	AND R3, R3, #0   ;int i = 0 
	LD R4, LENGTH   ;load int length = 3

    W1
    LD R0, A      ;R0 = A[]
    ADD R0, R0, R3   ;R0 = A[i]
    LDR R0, R0, #0   

    LD R1, B   ;LR1 = B[]
    ADD R1, R1, R3   ;R1 = B[i]
    LDR R1, R1, #0   

    NOT R7, R1      ;not value of R6 and add 1 for negative
    ADD R7, R7, #1

    ADD R7, R0, R7  ;A[i] + B[i]
    BRzp ELSE1  ;branch to ELSE1 if A[i] >= B[i]
    LD R2, C    ;R2 = C[]
    ADD R2, R2, R3  ;R2 = C[i]
    STR R0, R2, #0  ;C[i] = A[i]
    BR STOPPER  ;branch to STOPPER to skip other case

    ELSE1 NOP   ;branch to ELSE1 if A[i] < B[i]
    LD R2, C    ;R2 = C[]
    ADD R2, R2, R3  ;R2 = C[i]
    STR R1, R2, #0  ;C[i] = B[i]

    STOPPER ;used to branch past 2nd case if 1st case reached
    ADD R3, R3, #1  ;i++
    ADD R4, R4, #-1 ;length-- until i >= length
    BRp W1  ;branch back up to W1 if R4 > 0

	HALT

A 		.fill x3200		;; DO NOT CHANGE
B 		.fill x3300		;; DO NOT CHANGE
C 		.fill x3400		;; DO NOT CHANGE
LENGTH 	.fill 3			;; You can change this value if you increase the size of the arrays below
.end

.orig x3200				;; Array A : You can change these values for debugging! DO NOT CHANGE THE .orig STATEMENT
	.fill -4
	.fill 2
	.fill 6
.end

.orig x3300				;; Array B : You can change these values for debugging! DO NOT CHANGE THE .orig STATEMENT
	.fill 4
	.fill 7
	.fill -2
.end

.orig x3400				;; DO NOT CHANGE THE .orig STATEMENT
	.blkw 3				;; Array C: Make sure to increase block size if you add more values to Arrays A and B!
.end