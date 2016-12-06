title emisor
.model tiny
.code
org 100h

begin: jmp short main

col db 00 ;columna de la pantalla
row db 00 ;fila de la pantalla
temporal db ?

bandera db 1h ;1h mayúscula y 0h minuscula

main proc near
     mov ah, 00h
     mov al, 11100011b
     mov dx, 00
     int 14h

     etiquetaEsperaInput:
          call esperaInput

          cmp temporal, 20h
               je enviarCaracter

          cmp bandera, 1h
               je mayusculas

          cmp bandera, 0h
               je minusculas

          mayusculas:
               and temporal, 11011111B
               mov bandera, 0h
               jmp enviarCaracter

          minusculas:
               or temporal, 00100000B
               mov bandera,1h

          enviarCaracter:
               mov dx, 0 ;enviar
               mov ah, 1
               mov al, temporal
               int 14h

          cmp temporal, 13
               jz finale

          cmp temporal, 9
               jz etiquetaEspera

     mostrarInput:
          call colocarInput
          call imprimir

          inc col
          cmp col, 80
               jnz etiquetaEsperaInput
          inc row
          mov col, 0

     test ah, 80h ;Check for error
          jnz finale
     jmp etiquetaEsperaInput

     etiquetaEspera:
          call espera
          cmp ah, 00h
               jnz etiquetaEspera

          cmp al, 13
               jz finale

          cmp al, 9
               jz etiquetaEsperaInput

     mostrar:
          call coloca
          call imprimir

          inc col
          cmp col, 80
               jnz etiquetaEspera
          inc row
          mov col, 0
          jmp etiquetaEspera

     finale:
          mov ax,4c00h
          int 21h
main endp

colocarInput proc near
     mov ah, 02h ;petición para colocar el cursor
     mov bh, 00 ;pagina 0 (normal)
     mov al, temporal
     mov dh, row ;nuevo  renglon
     mov dl, col ;nueva columna
     int 10h
     ret
colocarInput endp

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

coloca proc near
     mov ah, 02h ;petición para colocar el cursor
     mov bh, 00 ;pagina 0 (normal)
     mov dh, row ;nuevo  renglon
     mov dl, col ;nueva columna
     int 10h
     ret
coloca endp

espera proc near
     mov dx, 0 ;recibir :D
     mov ah, 2
     int 14h
     ret
espera endp
end begin
