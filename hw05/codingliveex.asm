;;  Pseudocode
;;  if (n<=1) return 1;
;;  else return n + sum(n-1)

sum
ADD R6, R6, -4  ;make space for RA, RV, old FP, and one local var
STR R7, R6, 2   ;save return address
STR R5, R6, 1   ;saves old frame pointer
ADD R5, R6, 0   ;point frame pointer at the first local variable
ADD R6, R6, -5  ;allocate space to save all five registers R0-R4
    ;save registers
STR R0, R6, 0
STR R1, R6, 1
STR R2, R6, 2
STR R3, R6, 3
STR R4, R6, 4

    ;buildup is done, time to do actual code
    LDR, R0, R5, 4  ; the argument in the stack is
    ;offset from FP by 4 (grabbing n)
    ADD R1, R0, -1  ;need to decide if n-1 is positive
                    ;hint we might want to use R0 later, so don't overwrite
    BRp ELSE
    AND R0, R0, 0
    ADD, R0, R0, 1
                    ;if block, we need to get a 1 into R0 to return
                    ;note, this isn't necessary, I'm just using R0 as my final return for convenience

    BR TEARDOWN                ;make sure we don't fall through to else block

ELSE
    ADD, R2, R0, -1     ;decrement our param and put in on the stack
                        ;again, don't overwrite, we want n (R0) later
    ADD R6, R6, -1      ;create space on stack for param
                        ;remember, buildup takes care of RV
    STR R2, R6, 0       ;don't forget to save params on stack
    JRS sum     ;jump to subroutine
    LDR R2, R6, 0            ;grab return value (don't care about R2 prev value anymore)
    ADD R6, R6, 2            ;and pop RV and param off stack

    ADD R0, R0, R2            ;add RV to n

TEARDOWN
    ;save the value in R0 on the stack as our return value
    STR R0, R5, 3

    ;restore registers
    LDR R0, R6, 0
    LDR R1, R6, 1
    LDR R2, R6, 2
    LDR R3, R6, 3
    LDR R4, R6, 4

    ;restore return address, frame pointer, and move R6 to RV
    ;adding 6 points the stack pointer at the old FP
    ;ADD R6, R6, 6
    ADD R6, R5, 1   ;this should work, and not be reliant on multiple local variables
    LDR R5, R6, 0
    LDR R7, R6, 1
    ADD R6, R6, 2

RET

STACK .fill xF000

.end