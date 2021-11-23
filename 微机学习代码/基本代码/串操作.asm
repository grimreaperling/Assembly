.386
DATA SEGMENT USE16
     RECEIVER DB 100 DUP(?)
     RESULT DW 0
     CONTENT DB 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100
     NUM  DB 5 DUP(?)
         DB '$'
    COUNT DW ?
DATA ENDS

CODE SEGMENT USE16
 ASSUME CS:CODE,DS:DATA
Transfer: 
    mov ax,DATA
    mov ds,ax
    mov es,ax
    lea ax,RECEIVER
    mov di,ax
    lea ax,CONTENT
    mov si,ax
    mov cx,100
    CLD
    REP MOVSB
    JMP CHECK
CHECK:
    lea SI,CONTENT
    lea di,RECEIVER
    mov cx,100
    CLD
    REPE CMPSB
    JZ SUM
    JMP Transfer
SUM:
    lea BX,RECEIVER
    mov cx,100
L1:
    mov al,[BX]
    mov ah,0H
    add RESULT,ax
    add bx,1
    loop L1
ADJUSTMENT:
    mov ax,RESULT
    mov COUNT,ax
BEG:    
    MOV AX,DATA
    MOV DS,AX
    CALL DECPC
    MOV AH,9H
    LEA DX,NUM
    INT 21H
    MOV AH,4CH
    INT 21H
;子程序：将COUNT中的数据转化为十进制数后转为ASCII码存在NUM中
DECPC PROC
		MOV CX,5
        MOV AX,COUNT
	    LEA BX,NUM+4				
DBEG:   MOV DX,0
        MOV SI,10
		DIV SI
		ADD DX,30H
		MOV [BX],DL
		DEC BX
		MOV DX,0
		LOOP DBEG
    	LEA BX,NUM
DAGA:	CMP BYTE PTR [BX],'0'
		JNZ DEXIT
		MOV BYTE PTR [BX],0
		INC BX
		JMP DAGA
DEXIT:   RET
DECPC ENDP
CODE ENDS
     END Transfer
   


