
assume cs:cdsg,ds:datasg
datasg segment
    gread db 24,0,24 dup(?)
    gno db 6 dup(?,'$')
    string1 db 'The score between 90 and 100 ：','$'
    string2 db 'The score between 80 and 89 ：','$'
    string3 db 'The score between 70 and 79 ：','$'
    string4 db 'The score between 60 and 69 ：','$'
    string5 db 'The score between 0 and 59 ：','$'
    string6 db 'Max is','$'
    string7 db 'Min is','$'
    string8 db 'The middle score is','$'
    string9 db 'Rank ordering:','$'
    string10 db 'input gread:','$'
datasg ends
cdsg segment
start:
       mov ax,datasg
       mov ds,ax
          ;input
          lea dx,gread
          mov ah,0ah
          int 21h
         ; lea si,gread
          ;mov cl,[si+1]
          ;xor ch,ch
          ;add dx,cx
          ;mov byte ptr[si+2],'$'
           ;分组
           lea di,gno
           lea si,gread
           mov cx,11
    again: mov ax,[si]
           cmp ax,90
           jc next1
           inc byte ptr[di]
           jmp goon
    next1: cmp ax,80
           jc next2
           inc byte ptr[di+1]
           jmp goon
    next2: cmp ax,70
           jc next3
           inc byte ptr[di+2]
           jmp goon
    next3: cmp ax,60
           jc next4
           inc byte ptr[di+3]
           jmp goon
    next4: inc byte ptr[di+4]
           jmp goon
    goon:  inc si
           inc si
           loop again
           lea di,gno
           mov cx,5
    turn:  mov dx,[di]
           add dx,30h;转为字符输出
           mov [di],dx
           inc di
           loop turn

           ;字符输出分段结果
           lea dx,string1;90-100
           mov ax,09h
           int 21h              ;;;;;;;;;;;;调试到这一步程序不动了
           
           lea di,gno
           mov dx,[di]
           mov ax,2
           int 21h
           
           mov dx,0Ah
           mov ax,2
           int 21h

           lea dx,string2;80-89
           mov ax,09h
           int 21h
           
           lea di,gno
           mov dx,[di+1]
           mov ax,2
           int 21h
           
           mov dx,0Ah
           mov ax,2
           int 21h
           
           lea dx,string3;70-79
           mov ax,09h
           int 21h
           
           lea di,gno
           mov dx,[di+2]
           mov ax,2
           int 21h
           
           mov dx,0Ah
           mov ax,2
           int 21h
           
           lea dx,string4;60-69
           mov ax,09h
           int 21h
           
           lea di,gno
           mov dx,[di+3]
           mov ax,2
           int 21h
           
           mov dx,0Ah
           mov ax,2
           int 21h 
           
           lea dx,string5;不及格
           mov ax,09h
           int 21h
           
           lea di,gno
           mov dx,[di+4]
           mov ax,2
           int 21h
           
           mov dx,0Ah
           mov ax,2
           int 21h
        
    ;排序
       ;外循环
       mov bl,11
       ;内循环

 sort2:lea si,gread
       mov cx,10
 sort1:mov ax,[si]
       mov dx,[si+2]
       cmp ax,dx
       jg branch4
       jmp branch5
branch4:xchg ax,dx      ;交换成绩
        mov [si],ax
        mov [si+2],dx
        jmp branch5
branch5:add si,2
        loop sort1

        dec bl
        jnz sort2
        jmp go1

     go1:  mov dx,0Ah
           mov ax,2
           int 21h
      
      lea dx,string6  ;max
      mov ax,09h
      int 21h
      
      lea si,gread
      mov dx,[si]
      mov ax,2
      int 21h

       mov dx,0Ah
           mov ax,2
           int 21h
      
      lea dx,string7  ;min
      mov ax,09h
      int 21h
      
      lea si,gread
      mov dx,[si+20]
      mov ax,2
      int 21h

      mov dx,0Ah
           mov ax,2
           int 21h
     
      lea dx,string7  ;middle
      mov ax,09h
      int 21h
      
      lea si,gread
      mov dx,[si+10]
      mov ax,2
      int 21h

       mov dx,0Ah
           mov ax,2
           int 21h
      
      lea dx,string9   ;ordering
      mov ax,09h
      int 21h

      lea dx,gread
      mov ax,09h
      int 21h

mov ah,4ch
int 21h
cdsg ends
end start