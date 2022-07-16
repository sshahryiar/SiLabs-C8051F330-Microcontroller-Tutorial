
_EXTI_0_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;rot_enc.c,58 :: 		ics ICS_AUTO
;rot_enc.c,60 :: 		present_clock_state = ROT_ENC_CLK;
	MOV C, P0_1_bit+0
	CLR A
	RLC A
	MOV _present_clock_state+0, A
;rot_enc.c,61 :: 		data_state = ROT_ENC_DATA;
	MOV C, P0_0_bit+0
	CLR A
	RLC A
	MOV _data_state+0, A
;rot_enc.c,63 :: 		if(present_clock_state != past_clock_state)
	MOV A, _present_clock_state+0
	XRL A, _past_clock_state+0
	JZ L_EXTI_0_ISR0
;rot_enc.c,65 :: 		if(data_state != present_clock_state)
	MOV A, _data_state+0
	XRL A, _present_clock_state+0
	JZ L_EXTI_0_ISR1
;rot_enc.c,67 :: 		value -= step_size;
	CLR C
	MOV A, _value+0
	SUBB A, _step_size+0
	MOV _value+0, A
	MOV A, _value+1
	SUBB A, _step_size+1
	MOV _value+1, A
;rot_enc.c,68 :: 		}
	SJMP L_EXTI_0_ISR2
L_EXTI_0_ISR1:
;rot_enc.c,71 :: 		value += step_size;
	MOV A, _value+0
	ADD A, _step_size+0
	MOV _value+0, A
	MOV A, _value+1
	ADDC A, _step_size+1
	MOV _value+1, A
;rot_enc.c,72 :: 		}
L_EXTI_0_ISR2:
;rot_enc.c,74 :: 		past_clock_state = present_clock_state;
	MOV _past_clock_state+0, _present_clock_state+0
;rot_enc.c,75 :: 		}
L_EXTI_0_ISR0:
;rot_enc.c,77 :: 		if(value > 9999)
	SETB C
	MOV A, _value+0
	SUBB A, #15
	MOV A, #39
	XRL A, #128
	MOV R0, A
	MOV A, _value+1
	XRL A, #128
	SUBB A, R0
	JC L_EXTI_0_ISR3
;rot_enc.c,79 :: 		value = 0;
	MOV _value+0, #0
	MOV _value+1, #0
;rot_enc.c,80 :: 		}
L_EXTI_0_ISR3:
;rot_enc.c,82 :: 		if(value < 0)
	CLR C
	MOV A, _value+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _value+1
	XRL A, #128
	SUBB A, R0
	JNC L_EXTI_0_ISR4
;rot_enc.c,84 :: 		value = 9999;
	MOV _value+0, #15
	MOV _value+1, #39
;rot_enc.c,85 :: 		}
L_EXTI_0_ISR4:
;rot_enc.c,86 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _EXTI_0_ISR

_Timer_3_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;rot_enc.c,92 :: 		ics ICS_AUTO
;rot_enc.c,94 :: 		switch(i)
	SJMP L_Timer_3_ISR5
;rot_enc.c,96 :: 		case 0:
L_Timer_3_ISR7:
;rot_enc.c,98 :: 		val = (value / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;rot_enc.c,99 :: 		break;
	LJMP L_Timer_3_ISR6
;rot_enc.c,101 :: 		case 1:
L_Timer_3_ISR8:
;rot_enc.c,103 :: 		val = ((value % 1000) / 100);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #100
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;rot_enc.c,104 :: 		break;
	SJMP L_Timer_3_ISR6
;rot_enc.c,106 :: 		case 2:
L_Timer_3_ISR9:
;rot_enc.c,108 :: 		val = ((value % 100) / 10);
	MOV R4, #100
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;rot_enc.c,109 :: 		break;
	SJMP L_Timer_3_ISR6
;rot_enc.c,111 :: 		case 3:
L_Timer_3_ISR10:
;rot_enc.c,113 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV _val+0, 0
;rot_enc.c,114 :: 		break;
	SJMP L_Timer_3_ISR6
;rot_enc.c,116 :: 		}
L_Timer_3_ISR5:
	MOV A, _i+0
	JZ L_Timer_3_ISR7
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_3_ISR8
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_3_ISR9
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_3_ISR10
L_Timer_3_ISR6:
;rot_enc.c,118 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, _val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;rot_enc.c,120 :: 		i++;
	INC _i+0
;rot_enc.c,122 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_3_ISR11
;rot_enc.c,124 :: 		i = 0;
	MOV _i+0, #0
;rot_enc.c,125 :: 		}
L_Timer_3_ISR11:
;rot_enc.c,127 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;rot_enc.c,128 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_3_ISR

_main:
	MOV SP+0, #128
;rot_enc.c,132 :: 		void main(void)
;rot_enc.c,134 :: 		Init_Device();
	LCALL _Init_Device+0
;rot_enc.c,136 :: 		while(1)
L_main12:
;rot_enc.c,138 :: 		if(ROT_ENC_SW == 0)
	JB P0_2_bit+0, L_main14
	NOP
;rot_enc.c,140 :: 		delay_ms(60);
	MOV R5, 4
	MOV R6, 187
	MOV R7, 135
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;rot_enc.c,141 :: 		while(ROT_ENC_SW == 0);
L_main15:
	JB P0_2_bit+0, L_main16
	NOP
	SJMP L_main15
L_main16:
;rot_enc.c,142 :: 		step_size *= 10;
	MOV R0, _step_size+0
	MOV R1, _step_size+1
	MOV R4, #10
	MOV R5, #0
	LCALL _Mul_16x16+0
	MOV _step_size+0, 0
	MOV _step_size+1, 1
;rot_enc.c,144 :: 		if(step_size > 1000)
	SETB C
	MOV A, R0
	SUBB A, #232
	MOV A, R1
	SUBB A, #3
	JC L_main17
;rot_enc.c,146 :: 		step_size = 1;
	MOV _step_size+0, #1
	MOV _step_size+1, #0
;rot_enc.c,147 :: 		}
L_main17:
;rot_enc.c,148 :: 		}
L_main14:
;rot_enc.c,149 :: 		};
	SJMP L_main12
;rot_enc.c,150 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;rot_enc.c,153 :: 		void PCA_Init(void)
;rot_enc.c,155 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;rot_enc.c,156 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;rot_enc.c,157 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;rot_enc.c,159 :: 		void Timer_Init(void)
;rot_enc.c,161 :: 		TCON = 0x01;
	MOV TCON+0, #1
;rot_enc.c,162 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;rot_enc.c,163 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;rot_enc.c,164 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;rot_enc.c,165 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;rot_enc.c,167 :: 		void Port_IO_Init(void)
;rot_enc.c,187 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;rot_enc.c,188 :: 		P0SKIP = 0x07;
	MOV P0SKIP+0, #7
;rot_enc.c,189 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;rot_enc.c,190 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;rot_enc.c,191 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;rot_enc.c,193 :: 		void Oscillator_Init(void)
;rot_enc.c,195 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;rot_enc.c,196 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;rot_enc.c,198 :: 		void Interrupts_Init(void)
;rot_enc.c,200 :: 		IE = 0x81;
	MOV IE+0, #129
;rot_enc.c,201 :: 		IP = 0x01;
	MOV IP+0, #1
;rot_enc.c,202 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;rot_enc.c,203 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;rot_enc.c,206 :: 		void Init_Device(void)
;rot_enc.c,208 :: 		PCA_Init();
	LCALL _PCA_Init+0
;rot_enc.c,209 :: 		Timer_Init();
	LCALL _Timer_Init+0
;rot_enc.c,210 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;rot_enc.c,211 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;rot_enc.c,212 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;rot_enc.c,213 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;rot_enc.c,216 :: 		void write_74HC595(unsigned char send_data)
;rot_enc.c,218 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;rot_enc.c,220 :: 		while(clks > 0)
L_write_74HC59518:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59519
;rot_enc.c,222 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59520
;rot_enc.c,224 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;rot_enc.c,225 :: 		}
	SJMP L_write_74HC59521
L_write_74HC59520:
;rot_enc.c,228 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;rot_enc.c,229 :: 		}
L_write_74HC59521:
;rot_enc.c,231 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;rot_enc.c,232 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59522
L__write_74HC59523:
	CLR C
	RLC A
L__write_74HC59522:
	DJNZ R0, L__write_74HC59523
	MOV FARG_write_74HC595_send_data+0, A
;rot_enc.c,233 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;rot_enc.c,234 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;rot_enc.c,235 :: 		}
	SJMP L_write_74HC59518
L_write_74HC59519:
;rot_enc.c,236 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;rot_enc.c,239 :: 		void segment_write(unsigned char disp, unsigned char pos)
;rot_enc.c,241 :: 		write_74HC595(segment_code[disp]);
	MOV A, FARG_segment_write_disp+0
	ADD A, #_segment_code+0
	MOV R1, A
	CLR A
	ADDC A, hi(#_segment_code+0)
	MOV R2, A
	MOV 130, 1
	MOV 131, 2
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_write_74HC595_send_data+0, 0
	LCALL _write_74HC595+0
;rot_enc.c,242 :: 		write_74HC595(display_pos[pos]);
	MOV A, FARG_segment_write_pos+0
	ADD A, #_display_pos+0
	MOV R1, A
	CLR A
	ADDC A, hi(#_display_pos+0)
	MOV R2, A
	MOV 130, 1
	MOV 131, 2
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_write_74HC595_send_data+0, 0
	LCALL _write_74HC595+0
;rot_enc.c,243 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;rot_enc.c,244 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;rot_enc.c,245 :: 		}
	RET
; end of _segment_write
