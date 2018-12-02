	  
		

ldi r16,High (RAMEND) ; initialize stack pointer0 
out SPH,r16
ldi r16,Low(RAMEND)
out SPL,r16
ser r16
out DDRA,r16
out DDRC,r16
out PORTB,r16


Rand: inc r16
Loop: sbis PINB,7
      rjmp Rand
	  andi r16,$0f


	  rcall To7
	  out PORTC,r16
	  ldi  r17 ,$02
	  out PORTA,r17
      
	  ldi r18,$FA
	  rcall Delay  
	  
	   clr r17
	   out PORTA,r17
	   
	   ldi  r17,$03
	   mul  r16,r17

	   push r16
	   rcall To7

	   pop r18

	   out PORTC,r18
	   ldi r17,0b00000001
	   out PORTA,r17

	   rcall Delay 
	   rjmp Loop 


To7:     ; Procedure here
         Push r16 
		 in r16, SREG 
		 push r16
		 push r0 
		 push r1 
		 push YH 
		 push YL 

		 in YH,SPH
		 in YL,SPL
          
		  
		 ldi ZH,High(VIIseg*2)
		 ldi ZL,Low (VIIseg*2)
		
		  add ZL,r16; add the index 
		  clr r16
		  adc ZH,r16; add with carry because its a word 


		 lpm r16,Z
		 std Y+8,r16 ; goto r16 in the stack and put into

		  pop YL 
		  pop YH 0
		  pop r1 
		  pop r0 
		  pop r16 
		  out SREG,r16
		  pop r16
		  pop r18

          ret 

Delay: 
	        dec r18
			brne Delay
			ret 

VIIseg: .db $3f,$06,$5b,$4F,$66,$6D,$7D,$07,$7F,$67,$77,$7C,$39,$5E,$79,$71

