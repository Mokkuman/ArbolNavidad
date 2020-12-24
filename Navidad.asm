;Creado por Mockumann

PonMsj macro msj
    mov ah, 09h
    lea dx, msj
    int 21h
endm

Pila segment para stack 'stack'

Pila ends

Datos segment para data 'data'
    
    tit     db "FELIZ NAVIDAD EN 8086",10,13,"$"
    
    spa     db 32 ;Espacio
    ast     db 42 ;asterisco 
    palo    db 179; | imprimir esto
    salto   db 10,13,"$"    
    c       dw 1  ;Contador de mi ciclo  
    n       dw 8  

Datos ends

Codigo segment para 'code'
    inicio proc far ;Definiendo un procedimiento
        assume ss: Pila,ds: Datos, cs: Codigo ;Definir los segments

        mov ax, Datos
        mov ds,ax
        
        PonMsj tit 
        call salto_proc
        
        mov cx,n 
        
     @c1:
        push cx ;ya no asignaria de nuevo cx = 8, sino que ya toma el dec
                ;por propiedad de cx
     
     @c2:;Imprime los espacios   
        mov ah, 02h
        mov dl, spa
        int 21h
        loop @c2 
        mov cx,c ;Le asigno la cantidad al ciclo xD  
        
     @c3:  
        ;IMPRIMIENDO ASTERISCO
        mov ah, 02h 
        mov dl, ast
        int 21h
        loop @c3
        
        call salto_proc  ;Salto   
        INC c
        INC c    
        
        pop  cx          ;Termina ciclo interno
         
        
        loop @c1  
        
        ;Antes que salga al SO, debemos de imprimir el tronco del arbol :)
        mov ax,n
        mov bx,1
        SUB ax,bx 
        
        mov n,ax
        
        mov cx,n
    @cT:
       push cx    
       mov cx,n
    @cTSpace:
       ;Imprime los espacios   
        mov ah, 02h
        mov dl, spa
        int 21h
        loop @cTSpace 
        mov cx, 3 ;Le asigno la cantidad al ciclo xD     
    @cTronco: 
        
        ;Imprimiendo |
        mov ah, 02h
        mov dl, palo
        int 21h
        loop @cTronco
        call salto_proc  ;Salto 
        pop  cx          ;Termina ciclo interno
         
        
        loop @cT     
        ; Salir al Sistema Operativo:
        mov ah, 4ch 
        int 21h
    inicio endp 
    
    salto_proc proc
        mov ah, 09h
        lea dx, salto
        int 21h
        ret
    salto_proc endp 
    
Codigo ends
    end inicio