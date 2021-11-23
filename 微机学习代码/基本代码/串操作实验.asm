DATAS SEGMENT 
    ;此处输入数据段代码   
    ;D1 DB 100 DUP(?) 
    I DB ? 
DATAS ENDS 


STACKS SEGMENT 
    ;此处输入堆栈段代码 
STACKS ENDS 


CODES SEGMENT 
    ASSUME CS:CODES,DS:DATAS,SS:STACKS 
START: 
    MOV AX,DATAS 
    MOV DS,AX 
    MOV CX,100 
    MOV AX,0 
A1: ADD AX,CX 
    LOOP A1 
    PUSH AX 
    MOV CX,10 
    MOV BX,10000 
A2: XOR DX,DX 
    MOV AX,BX 
    DIV CX 
    CMP AX,0 
    JL S 
    JE S 
    MOV BX,AX 
    XOR DX,DX 
    POP AX 
    DIV BX 
    PUSH DX 
    ADD AL,30H 
    MOV DL,AL 
    MOV AH,2 
    INT 21H 
    JMP A2 
S:     
    MOV AH,4CH 
    INT 21H 
CODES ENDS 
    END START 
