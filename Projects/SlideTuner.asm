/*
 * SlideTuner.asm
 *
 *  Created: 4/9/2018 1:04:26 PM
 *   Author: Johnathan Machler
 */ 

 /**
 Initilization of Data direction registers 
 and I/O 
 Timer 1 
 **/


 ldi r16,0b00001000; Initialize Match_A with Timer1 fix2
 out TCCR1A,r16

 ldi  r16,0b000000110 ; Toggles Speaker to Output
 out DDRA,r16

 ldi r16,0b00000101; sets it to divide 8MHz clock by 1024
 out TCCR1B,r16; Initialize Match_B with Timer 1

 ldi r16,0b11100110
 out ADCSRA,r16

 clr r16
 out ADMUX,r16 ; External Reference


 Loop: 

   /** Equation of Line Y:=36x+9090**/

   in r17,ADCL ; Take in input from the analog to digital converter 
   subi r17,16; subtract $10

   brcs  Loop; If carry is set theres no touch 

   ldi r16,36

   mul r18,r16
   mov r17,r0
   mov r18,r1  
  
  
    ldi r20,High(9090)
	ldi r21,Low(9090) ;Y:=36x+9090

	add r20,r17; compose output with 440Hz fix 1
	adc r21,r18


	out ICR1H,r21; Hz
	out ICR1L,r20

	ser r16
	out PORTD,r16; output sound 

  jmp loop 

