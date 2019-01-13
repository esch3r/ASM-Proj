 







Prt16: 

Twice:
 /** get digit  r16= Param xxxxxxxx **/
pop count
pop r16
in sreg, r16
pop r16


ori r16, $30
cpi r16, $39
brlt lessthan
/** If greater than $39 **/
ldi r20, $07
add r16, r20


/** if less than or greater than $39 **/
lessthan:

      push r16
      rcall LCDchar
      push r16 
      dec count
      push count
breq Twice
