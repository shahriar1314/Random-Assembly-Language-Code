.MODEL SMALL
.STACK 100H 


.DATA 

MSG1 DB 'Enter the Decimal value: $'
MSG2 DB 0AH, 0DH, 'The Hexadecimal equivalent digit is: $'

NUM1 DB ? 
NUM2 DB ? 




.CODE 


MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV NUM1, AL 
    
    
    MOV AH, 1
    INT 21H
    MOV NUM2, AL
    
    MOV BL, NUM2
    ADD BL, 11H
    
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    
    MOV AH, 2
    MOV DL, BL 
    INT 21H
    
    MOV AH, 4CH 
    INT 21H
    
    MAIN ENDP 
END MAIN 

    