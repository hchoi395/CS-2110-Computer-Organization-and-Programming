;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - fiveCharacterStrings
;;=============================================================
;; Name: Han Choi
;;=============================================================

;; 	Pseudocode (see PDF for explanation)
;;
;; 	int count = 0; (keep count of number of 5-letter words)
;; 	int chars = 0; (keep track of length of each word)
;; 	int i = 0; (indexer into each word)
;; 	String str = "I enjoy CS 2110 and assembly makes me smile! "; (sample string)
;;  while(str[i] != '\0') {
;;		if (str[i] != ' ')  {
;;			chars++;
;;		} else {
;;			if (chars == 5) {
;;				count++;   
;;			}
;;			chars = 0;
;;		}
;;		i++;
;;	}
;;	mem[ANSWER] = count;
;;
;; ***IMPORTANT***
;; - Assume that all strings provided will end with a space (' ').
;; - Special characters do not have to be treated differently. For instance, strings like "who's" and "Wait," are considered 5 character strings.

.orig x3000
	AND R0, R0, #0	;int count = 0
	AND R1, R1, #0	;int chars = 0
	AND R2, R2, #0	;int i = 0

	W1
	LD R3, STRING	;R3 = str
	ADD R3, R3, R2	;R3 = str[i]
	LDR R3, R3, #0

	LD R4, SPACE	;R4 = SPACE
	AND R5, R5, #0
	ADD R5, R3, R4	;R5 = str[i] + SPACE
	BRz ELSE1	;branch if str[i] == ' '
	ADD R1, R1, #1	;chars++
	BR STOPPER1	;branch to skip second case

	ELSE1 NOP	;branched to second case
	AND R6, R6, #0
	ADD R6, R1, #-5	;R6 = chars - 5
	BRnp ELSE2	;branch to ELSE2 if chars != 5
	ADD R0, R0, #1	;count++

	ELSE2 NOP	;second case if chars != 5
	AND R1, R1, #0	;chars = 0

	STOPPER1	;skipped second case

	ADD R2, R2, #1	;i++

	ADD R3, R3, #0
	BRnp W1	;continue loop when str[i] != 0 

	ST R0, ANSWER	;mem[ANSWER] = count

	HALT

;; DO NOT CHANGE THESE VALUES
SPACE 	.fill #-32
STRING	.fill x4000
ANSWER 	.blkw 1
.end

.orig x4000				;; DO NOT CHANGE THE .orig STATEMENT
	.stringz "I baked fours or fives or zeros goods huges colds rices cakes " ;; You can change this string for debugging!
.end