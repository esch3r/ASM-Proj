/**
Square numbers 
by Johnathan Machler
**/

START:
      LDI r16,$0
      LDI r17,$0
LOOP:
     INC r17; adds 1 to register 17
     JPO SERIES; goes to subroutine odd if previous op had odd bit
     JMP LOOP; IF not odd go through loop again 
SERIES:
       ADC r16,r17 ; add and carry r16 with r17 store in r16
       OUT r16 ; ? display contents of register 
       DELAY  1 sec; need the exact code for this
       JMP  LOOP;  return to the beginning of the loop after 1 sec 
