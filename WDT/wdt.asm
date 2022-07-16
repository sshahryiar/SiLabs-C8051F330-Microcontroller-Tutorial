
_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;wdt.c,45 :: 		ics ICS_AUTO
;wdt.c,47 :: 		switch(i)
	SJMP L_Timer_ISR0
;wdt.c,49 :: 		case 0:
L_Timer_ISR2:
;wdt.c,51 :: 		val = (value / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;wdt.c,52 :: 		break;
	LJMP L_Timer_ISR1
;wdt.c,54 :: 		case 1:
L_Timer_ISR3:
;wdt.c,56 :: 		val = ((value % 1000) / 100);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #100
	MOV R5, #0
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;wdt.c,57 :: 		break;
	SJMP L_Timer_ISR1
;wdt.c,59 :: 		case 2:
L_Timer_ISR4:
;wdt.c,61 :: 		val = ((value % 100) / 10);
	MOV R4, #100
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;wdt.c,62 :: 		break;
	SJMP L_Timer_ISR1
;wdt.c,64 :: 		case 3:
L_Timer_ISR5:
;wdt.c,66 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;wdt.c,67 :: 		break;
	SJMP L_Timer_ISR1
;wdt.c,69 :: 		}
L_Timer_ISR0:
	MOV A, _i+0
	JZ L_Timer_ISR2
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_ISR3
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_ISR4
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_ISR5
L_Timer_ISR1:
;wdt.c,71 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;wdt.c,73 :: 		i++;
	INC _i+0
;wdt.c,75 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;wdt.c,77 :: 		i = 0;
	MOV _i+0, #0
;wdt.c,78 :: 		}
L_Timer_ISR6:
;wdt.c,80 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;wdt.c,81 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;wdt.c,84 :: 		void main(void)
;wdt.c,86 :: 		signed int s = 200;
	MOV main_s_L0+0, #200
	MOV main_s_L0+1, #0
;wdt.c,88 :: 		Init_Device();
	LCALL _Init_Device+0
;wdt.c,90 :: 		while(1)
L_main7:
;wdt.c,92 :: 		value++;
	MOV A, #1
	ADD A, _value+0
	MOV _value+0, A
	MOV A, #0
	ADDC A, _value+1
	MOV _value+1, A
;wdt.c,93 :: 		delay_ms(20);
	MOV R5, 2
	MOV R6, 63
	MOV R7, 43
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;wdt.c,94 :: 		if(BUTTON == 1)
	JNB P1_4_bit+0, L_main9
	NOP
;wdt.c,96 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,97 :: 		delay_ms(20);
	MOV R5, 2
	MOV R6, 63
	MOV R7, 43
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;wdt.c,98 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,99 :: 		delay_ms(20);
	MOV R5, 2
	MOV R6, 63
	MOV R7, 43
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;wdt.c,100 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,101 :: 		}
	SJMP L_main10
L_main9:
;wdt.c,104 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,105 :: 		while(s > 0)
L_main11:
	SETB C
	MOV A, main_s_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, main_s_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_main12
;wdt.c,107 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,108 :: 		delay_ms(30);
	MOV R5, 2
	MOV R6, 222
	MOV R7, 66
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;wdt.c,109 :: 		s--;
	CLR C
	MOV A, main_s_L0+0
	SUBB A, #1
	MOV main_s_L0+0, A
	MOV A, main_s_L0+1
	SUBB A, #0
	MOV main_s_L0+1, A
;wdt.c,110 :: 		}
	SJMP L_main11
L_main12:
;wdt.c,111 :: 		while(1);
L_main13:
	SJMP L_main13
;wdt.c,112 :: 		}
L_main10:
;wdt.c,113 :: 		};
	SJMP L_main7
;wdt.c,114 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;wdt.c,117 :: 		void PCA_Init()
;wdt.c,119 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;wdt.c,120 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;wdt.c,121 :: 		PCA0CPM2 = 0x01;
	MOV PCA0CPM2+0, #1
;wdt.c,122 :: 		PCA0CPL2 = 0xFF;
	MOV PCA0CPL2+0, #255
;wdt.c,123 :: 		PCA0MD |= 0x40;
	MOV PCA0MD+0, #64
;wdt.c,124 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,125 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;wdt.c,128 :: 		void Timer_Init(void)
;wdt.c,130 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;wdt.c,131 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;wdt.c,132 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;wdt.c,133 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,134 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;wdt.c,137 :: 		void Port_IO_Init(void)
;wdt.c,157 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;wdt.c,158 :: 		P1SKIP = 0xF0;
	MOV P1SKIP+0, #240
;wdt.c,159 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;wdt.c,160 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,161 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;wdt.c,164 :: 		void Oscillator_Init(void)
;wdt.c,166 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;wdt.c,167 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,168 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;wdt.c,171 :: 		void Interrupts_Init(void)
;wdt.c,173 :: 		IE = 0x80;
	MOV IE+0, #128
;wdt.c,174 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;wdt.c,175 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,176 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;wdt.c,179 :: 		void Init_Device(void)
;wdt.c,181 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;wdt.c,183 :: 		Timer_Init();
	LCALL _Timer_Init+0
;wdt.c,184 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;wdt.c,185 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;wdt.c,186 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;wdt.c,187 :: 		PCA_Init();
	LCALL _PCA_Init+0
;wdt.c,189 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;wdt.c,190 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;wdt.c,191 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;wdt.c,192 :: 		PCA0CPH2 = 0;
	MOV PCA0CPH2+0, #0
;wdt.c,193 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;wdt.c,196 :: 		void write_74HC595(unsigned char send_data)
;wdt.c,198 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;wdt.c,200 :: 		while(clks > 0)
L_write_74HC59515:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59516
;wdt.c,202 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59517
;wdt.c,204 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;wdt.c,205 :: 		}
	SJMP L_write_74HC59518
L_write_74HC59517:
;wdt.c,208 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;wdt.c,209 :: 		}
L_write_74HC59518:
;wdt.c,211 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;wdt.c,212 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59519
L__write_74HC59520:
	CLR C
	RLC A
L__write_74HC59519:
	DJNZ R0, L__write_74HC59520
	MOV FARG_write_74HC595_send_data+0, A
;wdt.c,213 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;wdt.c,214 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;wdt.c,215 :: 		}
	SJMP L_write_74HC59515
L_write_74HC59516:
;wdt.c,216 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;wdt.c,219 :: 		void segment_write(unsigned char disp, unsigned char pos)
;wdt.c,221 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;wdt.c,222 :: 		write_74HC595(segment_code[disp]);
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
;wdt.c,223 :: 		write_74HC595(display_pos[pos]);
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
;wdt.c,224 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;wdt.c,226 :: 		}
	RET
; end of _segment_write
