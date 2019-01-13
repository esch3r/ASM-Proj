/*
 * practice.asm
 *
 *  Created: 1/14/2018 11:16:51 AM
 *   Author: Johnathan Machler
 */ 


 ; Purpose
 
 ; Period .125 usec per clock cycle 
 ; Account for the clock cycles per second of each instruction to find the execution time
 ;clock rate on the Atmega is approximately 8Mhz
 ; Excectution time = Time * Cycle 
 ; N should be 81 base 10 or $51 hex
 ; 125 decimal = $7D hex  inner loop 
 ; 256 decimal =$100 hex  outer loop 
 
 Start: clr r17         ; inner loop counter starting from 0      1
        ldi r18,$7D     ; outer loop counter starting from the top 1
        DDRD 0b00010000 ; DDRD initialization set speaker to be an output 1
        ldi r16,$51    ; Load immediate put $3f into r16




 Outer:              ; outer loop      2
 Inner: rjmp Waste   ; waste time      2
        inc r17      ; data for PORTD  1
	out PORTD,r17; speaker data    1
	brne Inner   ; 256 times loop  2 if jump , 1 if no jump 
	dec r18      ; count loops     1 
	brne Outer   ;  125 times      2 if jump , 1 if no jump 

 Idle:  rjmp Idle   ; Idle until reset  

          
Waste: dec r16    ; decriment r16 
       brne Waste ; jump back to label waste is most recent result is not equal to zero

               
