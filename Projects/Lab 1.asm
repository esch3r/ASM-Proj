/*
 * Lab 1.asm
 *
 *  Created: 1/14/2018 11:16:51 AM
 *   Author: Johnathan Machler
 */ 



Begin:  ldi r16,High(RAMEND)
        out SPH,r16
        ldi r16,Low(RAMEND)
        out SPL,r16 
        ldi r16,0b11111111
        out DDRA,r16
        out DDRC,r16
        out DDRD,r16
        rcall LCDini
        rcall LCDini
        rcall LCDstr
        .db "EE2325:Welcome!",$80,0
        
Back:

      ldi r16,0b000010000
      out PORTA,r16
      ldi r16,0b01011110
      out PORTC,r16
      
Delay1:
       dec r17 
       brne Delay1
       ldi r16,0b000000100
       out PORTA,r16
       ldi r16,0b11010000 
       out PORTC,r16 
       
Delay2: dec r17 
        brne Delay2 
        ldi r16,0b00000010
        out PORTA,r16 
        ldi r16,0b10111001
        out PORTC,r16

Delay3:  
       dec r17
       brne Delay3
       rjmp Back
       
       .include "C:\Users\student\documents\LCDstuff.asm"
