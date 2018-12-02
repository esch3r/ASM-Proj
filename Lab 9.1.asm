

  /**
 Initilization of Data direction registers 
 and I/O 
 Timer 1 
 **/


 ldi r16,0b01010000; Initialize Match_A with Timer1 fix2
 out TCCR1A,r16

 ldi  r16,0b00001100 
 out DDRA,r16

 ser r16 ;Toggles Speaker to Output
 out DDRD,r16

 ldi r16,0b00000100
 out PORTA,r16

 ldi r16,0b00011001; sets it to divide 8MHz clock by 1
 out TCCR1B,r16; Initialize Match_B with Timer 1

 ldi r16,0b11100110
 out ADCSRA,r16

 ldi r16, 0b00100000
 out ADMUX,r16 ; External Reference


 Loop: 
    
   clr r16 
   out DDRD,r16; turn speaker off 
   in r17,ADCH ; Take in input from the analog to digital converter 
   subi r17,16; subtract $10
   brcs  Loop; If carry is set theres no touch 
 

   ldi r16,36; multiple 36*X
   mul r17,r16
   mov r17,r0 ; Low Byte
   mov r18,r1 ;High Byte 
  
  
    ldi r20,High(9090)
	ldi r21,Low(9090) 

	sub r21,r17
	sbc r20,r18


	/** Equation of Line Y:=9090-36X**/
	out ICR1H,r20; 440Hz
	out ICR1L,r21; Mode 12

    
    ser r16
	out DDRD,r16

  jmp loop 

