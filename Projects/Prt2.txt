

ldi r22,$08

Prt2:
pop r16
pop sreg,r16
pop r16


mov r17,r16
lsl r17

ldi r20,$31
ldi r21,$30

cpse r17,r20
rjmp nex
push r16 
rcall LCDchar

nex:
cpse r17,r21
rjmp next
push r16
rcall LCDchar

dec r22
brne prt2 
rjmp --
    

