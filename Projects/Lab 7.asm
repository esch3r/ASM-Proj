/*
 * Lab_7.asm
 *
 *  Created: 3/21/2018 1:02:41 PM
 *   Author: EE Student
 */ 


 Interrupt:

            jmp RESET; Interrupt Vector table 
			.org $006
			jmp Ext2
            .org $014
  		    jmp Match
			.org $016
			jmp Ovrflo
RESET:
           ldi r16,High(RAMEND); Stack Pointer initialization 
		   out SPH,r16
		   ldi r16,Low (RAMEND) 
		   out SPL,r16 

		   ser r16
		   out PORTB,r16
		   out DDRC,r16
		   out DDRA, r16

		   ldi r16,1
		   out PORTA,r16
                                                                                                  

		 ldi r16,$02	
		 out TCCR0,r16;

		 ldi r16,0b00100000
		 out  GICR,r16

		 ldi r16,$01; See I/O Registry Summary 
		 out PORTA,r16
		 out TIMSK,r16; Sets bit 1 and bit 0 OCIE0 TOIE
		 sei; initializes the interrupt flag 
		 
		 ldi r23,3
		 ldi r22,2
		 ldi r21,1
		 ldi r20,0


			Idle: rjmp Idle 
 
	  Match:
	 
					 push r24
					 in r24, SREG 
					 push r24
					 push r18
					 push YH
					 push YL

					 ldd r18,Y+3

					
	                 subi r18,-100;
					 out OCR0, r18

					 inc r20
					 cpi r20,10
				     breq  inc21
					 rjmp exit
			inc21: 
			         clr r20
					 inc r21
					 cpi r21,10
				     breq  inc22
					 rjmp exit
			inc22:  
			         clr r21
	                 inc r22
					 cpi r22,10
					 breq  inc23
					 rjmp exit
			 inc23:  
			        clr r22
					inc r23 
					cpi r23,10
					breq exit
			 exit: 



			         std Y+3,r18

					 pop YL
					 pop YH
					 pop r18
					 pop r24
					 out SREG,r24
					 pop r24

				
			         reti

		     Ovrflo:
			
			         push r24
					 in r24,SREG
					 push r24
					 push r17
					 push ZH
					 push ZL
				
				 
					in r24,PORTA ; Digits
					sbrc r24,4
					ldi r24,1
				    out PORTA,r24
                       
                 
					 sbrc r24,0
					 mov r25,r20
					 sbrc r24,1
					 mov r25,r21
					 sbrc r24,2
					 mov r25,r22
					 sbrc r24,3
					 mov r25,r23
		         

					 ldi ZH,High(Numbers*2) 
					 ldi ZL,Low(Numbers*2)

					 add ZL,r25
					 clr r25
					 adc ZH,r25

					 lpm r25,Z
		             out PORTC,r25

					 pop ZL 
					 pop ZH 
					 pop r25
					 pop r24 
					 out SREG,r24
					 pop r24 

				
			        reti 


		Ext2: push r24 
		      in r24, SREG 
			  push r24 
			  push r15
			  in r24,TCNT0
			  subi r24, -50 
			  out OCR0, r24

			  clr r23 
			  clr r22 
			  clr r21
			  clr r20

			  ldi r24,$02
			  out TIFR,r24
			  ldi r24, $03
			  out TIMSK,r24
			  clr r25
			  clr r17
			  clr r24 
			  out GICR,r24
			  sei 

   Del1:    sbiw r24,1
	        brne Del1

	Wait:  sbis PINB,2
	        rjmp Wait
			ldi r24,$01
			out TIMSK,r24
			clr r24

	Del2:  sbiw r24,1
	       brne Del2 
		   ldi r24,$20 
		   out GIFR,r24
		   out GIFR,r24 
		   pop r25 
		   pop r24 
		   out SREG,r24 
		   pop r24
		   reti 
	
	Numbers: .db $3f,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$67 
