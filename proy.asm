title miyuscula X
.model tiny
.code
org 100h

bandera db 1h ; 1h mayúscula y 0h minuscula

begin: jmp short main
     main proc near
          call teclado

          mov ah, 00h
          mov al, 11100011B
          mov dx, 00
          int 14h

          mov ax, 4c00h
          int 21h
     main endp

     teclado proc
          entrada:
               mov ah, 08
               int 21h

          cmp al, 20h
          je agregarPila

          cmp bandera, 1h
          jge mayusculas

          cmp bandera, 0h
          jz minusculas

          mayusculas:
               and al, 11011111B
               mov bandera, 0h
               jmp agregarPila

          minusculas:
               or al, 00100000B
               mov bandera,1h

          agregarPila:
               cbw
               push ax

          mostrar:
               mov ah, 02h
               pop dx
               int 21h

          mov dx, 00
          mov ah, 1
          int 14h

          comparaEnter:
               cmp al, 13
                    jne entrada
               ret
     teclado endp
end begin
