.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 0AH, 0DH, 'ENTER A HEX DIGIT: $'
MSG2 DB 0AH, 0DH, 'IN DECIMAL IT IS: $'
MSG3 DB 0AH, 0DH, 'TRY AGAIN?Y/y: $'
MSG4 DB 0AH, 0DH, 'ILLEGAL CHARACTER - ENTER 0..9 OR A..F: $'


.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    
    TAKE_INPUT:
    
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    INVALID_INVADER:
    
    MOV AH, 1
    INT 21H
    MOV BL, AL 
    
    
    CHECK_LEGALITY: 
    
    MOV AL, BL
    CMP AL, 30H
    JL INVALID_RESULT
    
    MOV AL, BL
    CMP AL, 46H
    JG INVALID_RESULT
    
    MOV AL, BL
    CMP AL, 39H
    JLE SHOW_OUTPUT_TEXT
    
    MOV AL, BL
    CMP AL, 41H
    JGE SHOW_OUTPUT_TEXT
    
    JMP INVALID_RESULT
    
    
    
    INVALID_RESULT:
    
    MOV AH, 9
    LEA DX, MSG4
    INT 21H
    
    JMP INVALID_INVADER
    
 
    
    
    SHOW_OUTPUT_TEXT: 
    MOV AH, 9
    LEA DX,MSG2
    INT 21H
    
    JMP HEX_DEC
    
    
    SHOW_RESULT:
    MOV AH, 2
    MOV DL, BH
    INT 21H
    
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV CL, AL
    
    CMP CL, 'Y'
    JE TAKE_INPUT
    
    CMP CL, 'y'
    JE TAKE_INPUT
    
    
    JMP EXIT 
    
    
    HEX_DEC:
    
    MOV BH, BL
    
    MOV AL, BL
    CMP AL, 39H
    JLE SHOW_RESULT 
    
    MOV AH, 2
    MOV DL, '1'
    INT 21H
    
    MOV DL, BL
    SUB DL, 11H
    MOV BH, DL
    
    JMP SHOW_RESULT    
  
    
    EXIT:
    
    
    MOV AH, 4CH 
    INT 21H
    
    MAIN ENDP 
END MAIN