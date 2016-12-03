title miyuscula X
.model tiny
.code
org 100h

begin: jmp short main
     main proc near
          mov ah, 00h
          mov al, 11100011B
          mov dx, 00
          int 14h

          receptor:
               estadoPuertos:
                    mov ah, 03h
                    mov dx, 00h
                    int 14h
                    cmp ah, 00h
                    jne estadoPuertos

               mov dx, 0
               mov ah, 2
               int 14h

               mov dl, al
               mov ah, 02h
               int 21h

               jmp receptor

               mov ax, 4c00h
               int 21h
     main endp
end begin
