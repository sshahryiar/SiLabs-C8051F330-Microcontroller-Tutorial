
_Timer_2_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;tmr.c,56 :: 		ics ICS_AUTO
;tmr.c,58 :: 		ms++;
	MOV A, #1
	ADD A, _ms+0
	MOV _ms+0, A
	MOV A, #0
	ADDC A, _ms+1
	MOV _ms+1, A
;tmr.c,59 :: 		if(ms > 999)
	SETB C
	MOV A, _ms+0
	SUBB A, #231
	MOV A, _ms+1
	SUBB A, #3
	JC L_Timer_2_ISR0
;tmr.c,61 :: 		ms = 0;
	MOV _ms+0, #0
	MOV _ms+1, #0
;tmr.c,62 :: 		s--;
	CLR C
	MOV A, _s+0
	SUBB A, #1
	MOV _s+0, A
	MOV A, _s+1
	SUBB A, #0
	MOV _s+1, A
;tmr.c,64 :: 		if(s < 0)
	CLR C
	MOV A, _s+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _s+1
	XRL A, #128
	SUBB A, R0
	JNC L_Timer_2_ISR1
;tmr.c,66 :: 		s = 0;
	MOV _s+0, #0
	MOV _s+1, #0
;tmr.c,67 :: 		TR2_bit = 0;
	CLR TR2_bit+0
;tmr.c,68 :: 		}
L_Timer_2_ISR1:
;tmr.c,69 :: 		}
L_Timer_2_ISR0:
;tmr.c,71 :: 		TMR2CN &= 0x7F;
	ANL TMR2CN+0, #127
;tmr.c,72 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_2_ISR

_Timer_3_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;tmr.c,78 :: 		ics ICS_AUTO
;tmr.c,80 :: 		switch(i)
	SJMP L_Timer_3_ISR2
;tmr.c,82 :: 		case 0:
L_Timer_3_ISR4:
;tmr.c,84 :: 		val = (s / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _s+0
	MOV R1, _s+1
	LCALL _Div_16x16_S+0
	MOV val+0, 0
;tmr.c,85 :: 		break;
	LJMP L_Timer_3_ISR3
;tmr.c,87 :: 		case 1:
L_Timer_3_ISR5:
;tmr.c,89 :: 		val = ((s % 1000) / 100);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _s+0
	MOV R1, _s+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #100
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV val+0, 0
;tmr.c,90 :: 		break;
	SJMP L_Timer_3_ISR3
;tmr.c,92 :: 		case 2:
L_Timer_3_ISR6:
;tmr.c,94 :: 		val = ((s % 100) / 10);
	MOV R4, #100
	MOV R5, #0
	MOV R0, _s+0
	MOV R1, _s+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV val+0, 0
;tmr.c,95 :: 		break;
	SJMP L_Timer_3_ISR3
;tmr.c,97 :: 		case 3:
L_Timer_3_ISR7:
;tmr.c,99 :: 		val = (s % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _s+0
	MOV R1, _s+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;tmr.c,100 :: 		break;
	SJMP L_Timer_3_ISR3
;tmr.c,102 :: 		}
L_Timer_3_ISR2:
	MOV A, _i+0
	JZ L_Timer_3_ISR4
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_3_ISR5
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_3_ISR6
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_3_ISR7
L_Timer_3_ISR3:
;tmr.c,104 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;tmr.c,106 :: 		i++;
	INC _i+0
;tmr.c,108 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_3_ISR8
;tmr.c,110 :: 		i = 0;
	MOV _i+0, #0
;tmr.c,111 :: 		}
L_Timer_3_ISR8:
;tmr.c,113 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;tmr.c,114 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_3_ISR

_main:
	MOV SP+0, #128
;tmr.c,117 :: 		void main(void)
;tmr.c,119 :: 		unsigned char set_time = 0;
	MOV main_set_time_L0+0, #0
;tmr.c,120 :: 		Init_Device();
	LCALL _Init_Device+0
;tmr.c,122 :: 		while(1)
L_main9:
;tmr.c,124 :: 		if(SET == 0)
	JB P1_4_bit+0, L_main11
	NOP
;tmr.c,126 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;tmr.c,127 :: 		while(SET == 0);
L_main12:
	JB P1_4_bit+0, L_main13
	NOP
	SJMP L_main12
L_main13:
;tmr.c,129 :: 		set_time = 1;
	MOV main_set_time_L0+0, #1
;tmr.c,130 :: 		}
L_main11:
;tmr.c,132 :: 		if(set_time == 1)
	MOV A, main_set_time_L0+0
	XRL A, #1
	JZ #3
	LJMP L_main14
;tmr.c,134 :: 		if(INC == 0)
	JB P1_3_bit+0, L_main15
	NOP
;tmr.c,136 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;tmr.c,137 :: 		s++;
	MOV A, #1
	ADD A, _s+0
	MOV _s+0, A
	MOV A, #0
	ADDC A, _s+1
	MOV _s+1, A
;tmr.c,139 :: 		if(s >= 9999)
	CLR C
	MOV A, _s+0
	SUBB A, #15
	MOV A, #39
	XRL A, #128
	MOV R0, A
	MOV A, _s+1
	XRL A, #128
	SUBB A, R0
	JC L_main16
;tmr.c,141 :: 		s = 9999;
	MOV _s+0, #15
	MOV _s+1, #39
;tmr.c,142 :: 		}
L_main16:
;tmr.c,143 :: 		}
L_main15:
;tmr.c,145 :: 		if(DEC == 0)
	JB P1_2_bit+0, L_main17
	NOP
;tmr.c,147 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;tmr.c,148 :: 		s--;
	CLR C
	MOV A, _s+0
	SUBB A, #1
	MOV _s+0, A
	MOV A, _s+1
	SUBB A, #0
	MOV _s+1, A
;tmr.c,150 :: 		if(s <= 0)
	SETB C
	MOV A, _s+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _s+1
	XRL A, #128
	SUBB A, R0
	JNC L_main18
;tmr.c,152 :: 		s = 0;
	MOV _s+0, #0
	MOV _s+1, #0
;tmr.c,153 :: 		}
L_main18:
;tmr.c,154 :: 		}
L_main17:
;tmr.c,156 :: 		if(ESC == 0)
	JB P1_1_bit+0, L_main19
	NOP
;tmr.c,158 :: 		TR2_bit = 1;
	SETB TR2_bit+0
;tmr.c,159 :: 		set_time = 0;
	MOV main_set_time_L0+0, #0
;tmr.c,160 :: 		}
L_main19:
;tmr.c,161 :: 		}
L_main14:
;tmr.c,162 :: 		};
	LJMP L_main9
;tmr.c,163 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;tmr.c,166 :: 		void PCA_Init(void)
;tmr.c,168 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;tmr.c,169 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;tmr.c,170 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;tmr.c,173 :: 		void Timer_Init(void)
;tmr.c,175 :: 		TMR2RLL = 0x02;
	MOV TMR2RLL+0, #2
;tmr.c,176 :: 		TMR2RLH = 0xFC;
	MOV TMR2RLH+0, #252
;tmr.c,177 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;tmr.c,178 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;tmr.c,179 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;tmr.c,180 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;tmr.c,183 :: 		void Port_IO_Init(void)
;tmr.c,203 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;tmr.c,204 :: 		P1SKIP = 0xFE;
	MOV P1SKIP+0, #254
;tmr.c,205 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;tmr.c,206 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;tmr.c,209 :: 		void Oscillator_Init(void)
;tmr.c,211 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;tmr.c,212 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;tmr.c,215 :: 		void Interrupts_Init(void)
;tmr.c,217 :: 		IE = 0xA0;
	MOV IE+0, #160
;tmr.c,218 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;tmr.c,219 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;tmr.c,222 :: 		void Init_Device(void)
;tmr.c,224 :: 		PCA_Init();
	LCALL _PCA_Init+0
;tmr.c,225 :: 		Timer_Init();
	LCALL _Timer_Init+0
;tmr.c,226 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;tmr.c,227 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;tmr.c,228 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;tmr.c,229 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;tmr.c,230 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;tmr.c,231 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;tmr.c,232 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;tmr.c,235 :: 		void write_74HC595(unsigned char send_data)
;tmr.c,237 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;tmr.c,239 :: 		while(clks > 0)
L_write_74HC59520:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59521
;tmr.c,241 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59522
;tmr.c,243 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;tmr.c,244 :: 		}
	SJMP L_write_74HC59523
L_write_74HC59522:
;tmr.c,247 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;tmr.c,248 :: 		}
L_write_74HC59523:
;tmr.c,250 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;tmr.c,251 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59524
L__write_74HC59525:
	CLR C
	RLC A
L__write_74HC59524:
	DJNZ R0, L__write_74HC59525
	MOV FARG_write_74HC595_send_data+0, A
;tmr.c,252 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;tmr.c,253 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;tmr.c,254 :: 		}
	SJMP L_write_74HC59520
L_write_74HC59521:
;tmr.c,255 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;tmr.c,258 :: 		void segment_write(unsigned char disp, unsigned char pos)
;tmr.c,260 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;tmr.c,261 :: 		write_74HC595(segment_code[disp]);
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
;tmr.c,262 :: 		write_74HC595(display_pos[pos]);
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
;tmr.c,263 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;tmr.c,265 :: 		}
	RET
; end of _segment_write
