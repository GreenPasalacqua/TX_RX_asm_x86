title emisor
.model tiny
.code
org 100h
begin: jmp short main
colu db 00 ; columna de la pantalla
rowa db 00 ;fila de la pantalla
temporal db ?

main proc near
     mov ah, 00h
     mov al, 11100011b
     mov dx, 00
     int 14h

     etiquetaEsperaInput:
          call esperaInput

          cmp temporal, 13
               jz finale

          mov dx, 0 ;enviar
          mov ah, 1
          mov al, temporal
          int 14h

     mostrarInput:
          call colocar
          call imprimir

          inc colu
          cmp colu, 80
               jnz etiquetaEsperaInput
          inc rowa
          mov colu, 0

     test ah, 80h ;Check for error
          jnz finale
     jmp etiquetaEsperaInput

     finale:
          mov ax,4c00h
          int 21h
main endp

colocar proc near
     mov ah, 02h ;petición para colocar el cursor
     mov bh, 00 ;pagina 0 (normal)
     mov al, temporal
     mov dh, rowa ;nuevo  renglon
     mov dl, colu ;nueva columna
     int 10h
     ret
colocar endp

imprimir proc near
     mov ah, 0ah ; función para desplegar
     mov bh, 00  ;página 0
     mov cx, 01 ;un caracter
     int 10h
     ret
imprimir endp

esperaInput proc near
     ;mov ah, 10h ;teclado
     ;int 16h
     mov ah, 08
     int 21h
     mov temporal, al
     ret
esperaInput endp
end begin
