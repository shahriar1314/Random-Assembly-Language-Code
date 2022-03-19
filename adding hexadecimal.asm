.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 'TYPE A HEX NUMBER, 0 - FFEF: $'
MSG2 DB 0AH, 0DH, 'TYPE A HEX NUMBER, 0 - FFEF: $'
MSG3 DB 0AH, 0DH, 'THE SUM IS $'
MSG4 DB 0AH, 0DH, 'ILLEGAL CHARACTER, TRY AGAIN!', 0AH, 0DH, '$'

NO1 DW 0H
NO2 DW 0H

.CODE


MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX
    
    
    TAKE_INPUT: 
    
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    ;TAKING INPUT 1ST NO 
    MOV CX, 4              
    MOV BX, 0H ; CLEARING BX
    
    
    INPUT1:
    
    MOV AH, 1
    INT 21H
    
    CMP AL, 0DH
    JE TAKE_2ND_INPUT
    
    CMP AL, 39H
    JA FOR_CHAR1
    
    CMP AL, 30H
    JB TRY_AGAIN
    
    
    
    INPUT1_SUB:
    
    SUB AL, 30H
    
    MOV AH, 0H
             
    ;PUSHING THE DIGIT IN BX             
    ROL BX, 4    
    ADD BX, AX 
    
    LOOP INPUT1
    
    MOV NO1, BX
    JMP TAKE_2ND_INPUT
    
    
    FOR_CHAR1: 
    
    CMP AL, 41H
    JB TRY_AGAIN
    CMP AL, 46H
    JA TRY_AGAIN
    
    
    SUB AL, 7H
    JMP INPUT1_SUB
    
    
    TRY_AGAIN:
    
    MOV AH, 9
    LEA DX, MSG4
    INT 21H
    
    JMP TAKE_INPUT
    
    
    ;TAKING INPUT 2ND NO
    TAKE_2ND_INPUT:
    
    
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    
    
    MOV CX, 4              
    MOV BX, 0H ; CLEARING BX
    
    
    INPUT2:
    
    MOV AH, 1
    INT 21H
    
    CMP AL, 0DH
    JE EXECUTE
    
    CMP AL, 39H
    JA FOR_CHAR2
    
    CMP AL, 30H
    JB TRY_AGAIN
    
    
    
    INPUT2_SUB:
    
    SUB AL, 30H
    
    MOV AH, 0H
             
    ;PUSHING THE DIGIT IN BX             
    ROL BX, 4    
    ADD BX, AX 
    
    LOOP INPUT2
    
    MOV NO2, BX
    JMP EXECUTE
    
    
    FOR_CHAR2: 
    
    CMP AL, 41H
    JB TRY_AGAIN
    CMP AL, 46H
    JA TRY_AGAIN
    
    
    SUB AL, 7H
    JMP INPUT2_SUB
    
    
    
    
    
   
    
    ;ADDING THE 2 NO
    EXECUTE:
    
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    
    MOV BX, NO1
    ADD BX, NO2
    
    JC OVERFLOW
    
    RESULT:
    
    MOV CX, 4H
    
    LOOP_RESULT:
    
    ROL BX, 4
    MOV DX, BX
    AND DX, 0FH
    
    CMP DX, 9H
    JA FOR_CHAR  ; TO SHOW A-F
    
    SUB_RESULT:
    
    ADD DX, 30H
    
    MOV AH, 2
    INT 21H
      
    LOOP LOOP_RESULT
    
    JMP EXIT
    
    
    FOR_CHAR:
    ADD DX,7H
    JMP SUB_RESULT
    
    
    OVERFLOW:
    MOV AH, 2
    MOV DL, 31H
    INT 21H
    JMP RESULT
    
    
    EXIT:
    
    MOV AH, 4CH 
    INT 21H
    
    MAIN ENDP 
END MAIN 