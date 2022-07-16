
_Timer_2_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;sw_pwm.c,58 :: 		ics ICS_AUTO
;sw_pwm.c,60 :: 		count++;
	INC _count+0
;sw_pwm.c,62 :: 		if(count <= counts)
	SETB C
	MOV A, _count+0
	SUBB A, #240
	JNC L_Timer_2_ISR0
;sw_pwm.c,64 :: 		if(count <= duty_cycle_1)
	SETB C
	MOV A, _count+0
	SUBB A, _duty_cycle_1+0
	JNC L_Timer_2_ISR1
;sw_pwm.c,66 :: 		P0_0_bit = 1;
	SETB P0_0_bit+0
;sw_pwm.c,67 :: 		}
	SJMP L_Timer_2_ISR2
L_Timer_2_ISR1:
;sw_pwm.c,70 :: 		P0_0_bit = 0;
	CLR P0_0_bit+0
;sw_pwm.c,71 :: 		}
L_Timer_2_ISR2:
;sw_pwm.c,73 :: 		if(count <= duty_cycle_2)
	SETB C
	MOV A, _count+0
	SUBB A, _duty_cycle_2+0
	JNC L_Timer_2_ISR3
;sw_pwm.c,75 :: 		P0_1_bit = 1;
	SETB P0_1_bit+0
;sw_pwm.c,76 :: 		}
	SJMP L_Timer_2_ISR4
L_Timer_2_ISR3:
;sw_pwm.c,79 :: 		P0_1_bit = 0;
	CLR P0_1_bit+0
;sw_pwm.c,80 :: 		}
L_Timer_2_ISR4:
;sw_pwm.c,81 :: 		}
	SJMP L_Timer_2_ISR5
L_Timer_2_ISR0:
;sw_pwm.c,85 :: 		count = 0;
	MOV _count+0, #0
;sw_pwm.c,86 :: 		}
L_Timer_2_ISR5:
;sw_pwm.c,87 :: 		P0_2_bit = ~P0_2_bit;
	MOV C, P0_2_bit+0
	CPL C
	MOV P0_2_bit+0, C
;sw_pwm.c,88 :: 		TF2H_bit = 0;
	CLR TF2H_bit+0
;sw_pwm.c,89 :: 		}
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
;sw_pwm.c,95 :: 		ics ICS_AUTO
;sw_pwm.c,97 :: 		switch(i)
	SJMP L_Timer_3_ISR6
;sw_pwm.c,99 :: 		case 0:
L_Timer_3_ISR8:
;sw_pwm.c,101 :: 		val = (duty_cycle_1 / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _duty_cycle_1+0
	CLR A
	MOV R1, A
	LCALL _Div_16x16_S+0
	MOV val+0, 0
;sw_pwm.c,102 :: 		break;
	SJMP L_Timer_3_ISR7
;sw_pwm.c,104 :: 		case 1:
L_Timer_3_ISR9:
;sw_pwm.c,106 :: 		val = ((duty_cycle_1 % 1000) / 100);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _duty_cycle_1+0
	CLR A
	MOV R1, A
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #100
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV val+0, 0
;sw_pwm.c,107 :: 		break;
	SJMP L_Timer_3_ISR7
;sw_pwm.c,109 :: 		case 2:
L_Timer_3_ISR10:
;sw_pwm.c,111 :: 		val = ((duty_cycle_1 % 100) / 10);
	MOV B+0, #100
	MOV A, _duty_cycle_1+0
	DIV AB
	MOV A, B+0
	MOV R0, A
	MOV B+0, #10
	MOV A, R0
	DIV AB
	MOV R0, A
	MOV val+0, 0
;sw_pwm.c,112 :: 		break;
	SJMP L_Timer_3_ISR7
;sw_pwm.c,114 :: 		case 3:
L_Timer_3_ISR11:
;sw_pwm.c,116 :: 		val = (duty_cycle_1 % 10);
	MOV B+0, #10
	MOV A, _duty_cycle_1+0
	DIV AB
	MOV A, B+0
	MOV R0, A
	MOV val+0, 0
;sw_pwm.c,117 :: 		break;
	SJMP L_Timer_3_ISR7
;sw_pwm.c,119 :: 		}
L_Timer_3_ISR6:
	MOV A, _i+0
	JZ L_Timer_3_ISR8
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_3_ISR9
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_3_ISR10
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_3_ISR11
L_Timer_3_ISR7:
;sw_pwm.c,121 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;sw_pwm.c,123 :: 		i++;
	INC _i+0
;sw_pwm.c,125 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_3_ISR12
;sw_pwm.c,127 :: 		i = 0;
	MOV _i+0, #0
;sw_pwm.c,128 :: 		}
L_Timer_3_ISR12:
;sw_pwm.c,130 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;sw_pwm.c,131 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_3_ISR

_main:
	MOV SP+0, #128
;sw_pwm.c,134 :: 		void main(void)
;sw_pwm.c,136 :: 		Init_Device();
	LCALL _Init_Device+0
;sw_pwm.c,138 :: 		while(1)
L_main13:
;sw_pwm.c,140 :: 		if(INC_SW == 0)
	JB P1_4_bit+0, L_main15
	NOP
;sw_pwm.c,142 :: 		delay_ms(60);
	MOV R5, 4
	MOV R6, 187
	MOV R7, 135
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;sw_pwm.c,143 :: 		duty_cycle_1++;
	INC _duty_cycle_1+0
;sw_pwm.c,144 :: 		duty_cycle_2--;
	DEC _duty_cycle_2+0
;sw_pwm.c,145 :: 		}
L_main15:
;sw_pwm.c,147 :: 		if(DEC_SW == 0)
	JB P1_3_bit+0, L_main16
	NOP
;sw_pwm.c,149 :: 		delay_ms(60);
	MOV R5, 4
	MOV R6, 187
	MOV R7, 135
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;sw_pwm.c,150 :: 		duty_cycle_1--;
	DEC _duty_cycle_1+0
;sw_pwm.c,151 :: 		duty_cycle_2++;
	INC _duty_cycle_2+0
;sw_pwm.c,152 :: 		}
L_main16:
;sw_pwm.c,154 :: 		if(duty_cycle_1 >= duty_max)
	CLR C
	MOV A, _duty_cycle_1+0
	SUBB A, #25
	JC L_main17
;sw_pwm.c,156 :: 		duty_cycle_1 = duty_max;
	MOV _duty_cycle_1+0, #25
;sw_pwm.c,157 :: 		duty_cycle_2 = duty_min;
	MOV _duty_cycle_2+0, #5
;sw_pwm.c,158 :: 		}
L_main17:
;sw_pwm.c,160 :: 		if(duty_cycle_1 <= duty_min)
	SETB C
	MOV A, _duty_cycle_1+0
	SUBB A, #5
	JNC L_main18
;sw_pwm.c,162 :: 		duty_cycle_1 = duty_min;
	MOV _duty_cycle_1+0, #5
;sw_pwm.c,163 :: 		duty_cycle_2 = duty_max;
	MOV _duty_cycle_2+0, #25
;sw_pwm.c,164 :: 		}
L_main18:
;sw_pwm.c,165 :: 		};
	SJMP L_main13
;sw_pwm.c,166 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;sw_pwm.c,169 :: 		void PCA_Init(void)
;sw_pwm.c,171 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;sw_pwm.c,172 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;sw_pwm.c,173 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;sw_pwm.c,175 :: 		void Timer_Init(void)
;sw_pwm.c,177 :: 		TMR2CN = 0x04;
	MOV TMR2CN+0, #4
;sw_pwm.c,178 :: 		TMR2RLL = 0x99;
	MOV TMR2RLL+0, #153
;sw_pwm.c,179 :: 		TMR2RLH = 0xFF;
	MOV TMR2RLH+0, #255
;sw_pwm.c,180 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;sw_pwm.c,181 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;sw_pwm.c,182 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;sw_pwm.c,183 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;sw_pwm.c,185 :: 		void Port_IO_Init(void)
;sw_pwm.c,205 :: 		P0MDOUT = 0x07;
	MOV P0MDOUT+0, #7
;sw_pwm.c,206 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;sw_pwm.c,207 :: 		P0SKIP = 0x07;
	MOV P0SKIP+0, #7
;sw_pwm.c,208 :: 		P1SKIP = 0xF8;
	MOV P1SKIP+0, #248
;sw_pwm.c,209 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;sw_pwm.c,210 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;sw_pwm.c,212 :: 		void Oscillator_Init(void)
;sw_pwm.c,214 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;sw_pwm.c,215 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;sw_pwm.c,217 :: 		void Interrupts_Init(void)
;sw_pwm.c,219 :: 		IE = 0xA0;
	MOV IE+0, #160
;sw_pwm.c,220 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;sw_pwm.c,221 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;sw_pwm.c,224 :: 		void Init_Device(void)
;sw_pwm.c,226 :: 		PCA_Init();
	LCALL _PCA_Init+0
;sw_pwm.c,227 :: 		Timer_Init();
	LCALL _Timer_Init+0
;sw_pwm.c,228 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;sw_pwm.c,229 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;sw_pwm.c,230 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;sw_pwm.c,231 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;sw_pwm.c,234 :: 		void write_74HC595(unsigned char send_data)
;sw_pwm.c,236 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;sw_pwm.c,238 :: 		while(clks > 0)
L_write_74HC59519:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59520
;sw_pwm.c,240 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59521
;sw_pwm.c,242 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;sw_pwm.c,243 :: 		}
	SJMP L_write_74HC59522
L_write_74HC59521:
;sw_pwm.c,246 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;sw_pwm.c,247 :: 		}
L_write_74HC59522:
;sw_pwm.c,249 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;sw_pwm.c,250 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59523
L__write_74HC59524:
	CLR C
	RLC A
L__write_74HC59523:
	DJNZ R0, L__write_74HC59524
	MOV FARG_write_74HC595_send_data+0, A
;sw_pwm.c,251 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;sw_pwm.c,252 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;sw_pwm.c,253 :: 		}
	SJMP L_write_74HC59519
L_write_74HC59520:
;sw_pwm.c,254 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;sw_pwm.c,257 :: 		void segment_write(unsigned char disp, unsigned char pos)
;sw_pwm.c,259 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;sw_pwm.c,260 :: 		write_74HC595(segment_code[disp]);
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
;sw_pwm.c,261 :: 		write_74HC595(display_pos[pos]);
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
;sw_pwm.c,262 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;sw_pwm.c,264 :: 		}
	RET
; end of _segment_write
