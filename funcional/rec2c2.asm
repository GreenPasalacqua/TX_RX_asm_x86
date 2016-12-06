title receptor
.model tiny
.code
org 100h

begin: jmp short main

col db 00 ; columna de la pantalla
row db 00 ;fila de la pantalla

main proc near
     mov ah, 00h
     mov al, 11100011b
     mov dx, 00
     int 14h

     etiquetaEspera:
          call espera
          cmp ah, 00h
               jnz etiquetaEspera

          cmp al, 13
               jz final

     mostrar:
          call coloca
          call imprime

          inc col
          cmp col, 80
               jnz etiquetaEspera
          inc row
          mov col, 0

          jmp etiquetaEspera

     final:
          mov ax, 4c00h
          int 21h
main endp

coloca proc near
     mov ah, 02h ;petición para colocar el cursor
     mov bh, 00 ;pagina 0 (normal)
     mov dh, row ;nuevo  renglon
     mov dl, col ;nueva columna
     int 10h
     ret
coloca endp

imprime proc near
     mov ah, 0ah ; función para desplegar
     mov bh, 00  ;página 0
     mov cx, 01 ;un caracter
     int 10h
     ret
imprime endp

espera proc near
     mov dx, 0 ;recibir :D
     mov ah, 2
     int 14h
     ret
espera endp

end begin
