/*
 * lab_5.asm
 *
 *  Created: 2/23/2018 4:22:13 PM
 *   Author: EE Student
 */ 


 

ldi r16,High (RAMEND) ; initialize stack 
out SPH,r16
ldi r16,Low(RAMEND)
out SPL,r16
ser r16
out DDRA,r16
out DDRC,r16
out DDRD,r16
out PORTB,r16
rcall LCDini 
rcall LCDini 


Rand: inc r16
Loop: sbis PINB,7 
      rjmp Rand 
	  push r16 
	  rcall LCDcom 
     .db
	rcall prt2 
	rcall prt16
	rcall Swp
	rcall LCDcom
	.db  $C0,0 
	rcall Prt2 
	rcall Prt16
	pop r17 
	rjmp Loop 

Prt2:           ; Prints the binary representation
       ret 
Prt16:          ; Prints the hex representation
       ret 
Swp: 
     push r16
     in SREG,r16
     push r16

     ldi r17, $AA
     ldi r19, $55 

	 and r17,r16 
	 and r19,r16

	 lsl r19
	 lsr r17
	 
	 or r17,r19

	 pop r16
	 in  r16,SREG
	 pop r16

     ret 

 .include "C:\Users\Public\Documents\LCDstuff.asm"
