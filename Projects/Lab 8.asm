/*
 * Lab_8.asm
 *
 *  Created: 4/2/2018 1:45:15 PM
 *   Author: EE Student
 */ 


 Interrupt:
              jmp RESET ; Interrupt vector table
			  .org $00E
			  jmp MatchA; Compare match 
			  .org $010
			  jmp MatchB
			  .org $012
			  jmp T1Over

			  ;Overflow 
RESET:
          ldi r16,High(RAMEND) ; stack initialization
		  out SPH,r16
		  ldi r16,Low(RAMEND)
		  out SPL,r16

		  ser r16
		  out DDRC,r16
		  out DDRA,r16
		  out DDRD,r16
		  
		  sei ; set 1 in SREG

		  ;TIFR  (set ICF1,tov1,OCF1A,OCF1B)
		  ldi r16,$03; Divide by 64
		  out TCCR1B
		 
	      clr r16
		  out TIFR,r16

		  ;TIMSK (est TICIE1,TOIE1,OCIE1A,OCIE1B)
		  ldi r16,$1C
		  out TIMSK,r16

		  ;TCCR1A
		  ldi r16,0b00010000 ; Toggle on match 
		  out TCCR1A,r16
		  clr r25

		 Main: ldi r16,$80 
		 GoRght: sbiw r24,1 ; Light Sequence 
		         brne GoRght 
				 ror r16
				 out PORTC,r16
				 brcc GoRght 
				 rol r16
		 GoLeft: sbiw r24,1 
		         brne GoLeft

		t1Over: push r16
		        in r16,SREG
				push r16
				in r16,PINA 
				lsl r16
				sbci r16,-1 
				out PORTA,r16
				pop r16
				out SREG,r16
				pop r16
				reti 

	 MatchA: push r16 ; Tempo routine
	         in r16,SREG 
			 push r16 
			 push r17
			 push r18
			 push r19

			 ldi ZH,High((Song*2)-1); Start 1 byte before the beginning of the table
			 ldi ZL,Low((Song*2)-1) 

			 add ZL,r24
			 clr r24
			 adc ZH,r24

			 in r16,OCR1AL
			 in r17,OCR1AH
			 
			 out OCR1AH,r16
			 out OCR1AL,r17

			 ldi r19,High(4000) ; Interrupt wherein 4000 is the number of timer ticks
			 ldi r18,Low(4000) ; Establish the next interrupt in 1/6 second

			 lpm r24,Z
		     subi r24,-1; add 1 to r24


	
			pop r19 
			pop r18 
			pop r17 
			pop r16 
			out SREG,r16
			pop r16

	        reti

	 MatchB:
	         push r16   ; Pitch Routine
	         in r16,SREG 
			 push r16 
			 push r17
			 push r18
			 push r19

	            
		    lpm r24,Z; Get value from table and put into r25

			subi r24,0 
			breq exit

            rjmp around; once zero stop outputting 

	 exit:  add r24,OCR1B
	        clr TCCR1A 
			clr TIMSK
	       around:

			pop r19 
			pop r18 
			pop r17 
			pop r16 
			out SREG,r16
			pop r16
	        reti 

  Song: .db 95,100,95,100,95,127,106,119,142,142,142,239,190,142,127,127,127,190,150,127,119,119,119,190
        .db 95,100,95,100,95,127,106,119,142,142,142,239,190,142,127,127,127,190,119,127,142,142,142,0