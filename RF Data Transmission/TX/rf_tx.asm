
_Timer_3_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;rf_tx.c,57 :: 		ics ICS_AUTO
;rf_tx.c,59 :: 		switch(i)
	SJMP L_Timer_3_ISR0
;rf_tx.c,61 :: 		case 0:
L_Timer_3_ISR2:
;rf_tx.c,63 :: 		val = (value / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;rf_tx.c,64 :: 		break;
	LJMP L_Timer_3_ISR1
;rf_tx.c,66 :: 		case 1:
L_Timer_3_ISR3:
;rf_tx.c,68 :: 		val = ((value % 1000) / 100);
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
;rf_tx.c,69 :: 		break;
	SJMP L_Timer_3_ISR1
;rf_tx.c,71 :: 		case 2:
L_Timer_3_ISR4:
;rf_tx.c,73 :: 		val = ((value % 100) / 10);
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
;rf_tx.c,74 :: 		break;
	SJMP L_Timer_3_ISR1
;rf_tx.c,76 :: 		case 3:
L_Timer_3_ISR5:
;rf_tx.c,78 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV _val+0, 0
;rf_tx.c,79 :: 		break;
	SJMP L_Timer_3_ISR1
;rf_tx.c,81 :: 		}
L_Timer_3_ISR0:
	MOV A, _i+0
	JZ L_Timer_3_ISR2
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_3_ISR3
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_3_ISR4
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_3_ISR5
L_Timer_3_ISR1:
;rf_tx.c,83 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, _val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;rf_tx.c,85 :: 		i++;
	INC _i+0
;rf_tx.c,87 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_3_ISR6
;rf_tx.c,89 :: 		i = 0;
	MOV _i+0, #0
;rf_tx.c,90 :: 		}
L_Timer_3_ISR6:
;rf_tx.c,92 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;rf_tx.c,93 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_3_ISR

_main:
	MOV SP+0, #128
;rf_tx.c,96 :: 		void main(void)
;rf_tx.c,98 :: 		Init_Device();
	LCALL _Init_Device+0
;rf_tx.c,100 :: 		while(1)
L_main7:
;rf_tx.c,102 :: 		if(INC_SW == 0)
	JB P1_4_bit+0, L_main9
	NOP
;rf_tx.c,104 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;rf_tx.c,105 :: 		value++;
	MOV A, #1
	ADD A, _value+0
	MOV _value+0, A
	MOV A, #0
	ADDC A, _value+1
	MOV _value+1, A
;rf_tx.c,106 :: 		}
L_main9:
;rf_tx.c,108 :: 		if(DEC_SW == 0)
	JB P1_3_bit+0, L_main10
	NOP
;rf_tx.c,110 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;rf_tx.c,111 :: 		value--;
	CLR C
	MOV A, _value+0
	SUBB A, #1
	MOV _value+0, A
	MOV A, _value+1
	SUBB A, #0
	MOV _value+1, A
;rf_tx.c,112 :: 		}
L_main10:
;rf_tx.c,114 :: 		if(value > 200)
	SETB C
	MOV A, _value+0
	SUBB A, #200
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _value+1
	XRL A, #128
	SUBB A, R0
	JC L_main11
;rf_tx.c,116 :: 		value = 0;
	MOV _value+0, #0
	MOV _value+1, #0
;rf_tx.c,117 :: 		}
L_main11:
;rf_tx.c,119 :: 		if(value < 0)
	CLR C
	MOV A, _value+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _value+1
	XRL A, #128
	SUBB A, R0
	JNC L_main12
;rf_tx.c,121 :: 		value = 99;
	MOV _value+0, #99
	MOV _value+1, #0
;rf_tx.c,122 :: 		}
L_main12:
;rf_tx.c,124 :: 		send_data(value);
	MOV FARG_send_data_value+0, _value+0
	LCALL _send_data+0
;rf_tx.c,125 :: 		delay_ms(100);
	MOV R5, 7
	MOV R6, 55
	MOV R7, 226
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;rf_tx.c,126 :: 		};
	LJMP L_main7
;rf_tx.c,127 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;rf_tx.c,130 :: 		void PCA_Init(void)
;rf_tx.c,132 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;rf_tx.c,133 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;rf_tx.c,134 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;rf_tx.c,137 :: 		void Timer_Init(void)
;rf_tx.c,139 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;rf_tx.c,140 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;rf_tx.c,141 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;rf_tx.c,142 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;rf_tx.c,145 :: 		void Port_IO_Init(void)
;rf_tx.c,165 :: 		P0MDOUT = 0x02;
	MOV P0MDOUT+0, #2
;rf_tx.c,166 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;rf_tx.c,167 :: 		P0SKIP = 0x03;
	MOV P0SKIP+0, #3
;rf_tx.c,168 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;rf_tx.c,169 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;rf_tx.c,170 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;rf_tx.c,173 :: 		void Oscillator_Init(void)
;rf_tx.c,175 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;rf_tx.c,176 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;rf_tx.c,179 :: 		void Interrupts_Init(void)
;rf_tx.c,181 :: 		IE = 0x80;
	MOV IE+0, #128
;rf_tx.c,182 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;rf_tx.c,183 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;rf_tx.c,186 :: 		void Init_Device(void)
;rf_tx.c,188 :: 		PCA_Init();
	LCALL _PCA_Init+0
;rf_tx.c,189 :: 		Timer_Init();
	LCALL _Timer_Init+0
;rf_tx.c,190 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;rf_tx.c,191 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;rf_tx.c,192 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;rf_tx.c,193 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;rf_tx.c,196 :: 		void write_74HC595(unsigned char send_data)
;rf_tx.c,198 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;rf_tx.c,200 :: 		while(clks > 0)
L_write_74HC59513:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59514
;rf_tx.c,202 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59515
;rf_tx.c,204 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;rf_tx.c,205 :: 		}
	SJMP L_write_74HC59516
L_write_74HC59515:
;rf_tx.c,208 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;rf_tx.c,209 :: 		}
L_write_74HC59516:
;rf_tx.c,211 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;rf_tx.c,212 :: 		send_data <<= 1;
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
;rf_tx.c,213 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;rf_tx.c,214 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;rf_tx.c,215 :: 		}
	SJMP L_write_74HC59513
L_write_74HC59514:
;rf_tx.c,216 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;rf_tx.c,219 :: 		void segment_write(unsigned char disp, unsigned char pos)
;rf_tx.c,221 :: 		write_74HC595(segment_code[disp]);
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
;rf_tx.c,222 :: 		write_74HC595(display_pos[pos]);
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
;rf_tx.c,223 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;rf_tx.c,224 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;rf_tx.c,225 :: 		}
	RET
; end of _segment_write

_send_data:
;rf_tx.c,228 :: 		void send_data(unsigned char value)
;rf_tx.c,230 :: 		signed char s = 20;
	MOV send_data_s_L0+0, #20
	MOV send_data_CRC_L0+0, #0
;rf_tx.c,231 :: 		unsigned char CRC = 0;
;rf_tx.c,233 :: 		CRC = (value & 0xAA);
	MOV A, FARG_send_data_value+0
	ANL A, #170
	MOV send_data_CRC_L0+0, A
;rf_tx.c,235 :: 		while(s > 0x00)
L_send_data17:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, send_data_s_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_send_data18
;rf_tx.c,237 :: 		RF_TX = 1;
	SETB P0_1_bit+0
;rf_tx.c,238 :: 		delay_us(500);
	MOV R6, 8
	MOV R7, 243
	DJNZ R7, 
	DJNZ R6, 
	NOP
;rf_tx.c,239 :: 		RF_TX = 0;
	CLR P0_1_bit+0
;rf_tx.c,240 :: 		delay_us(500);
	MOV R6, 8
	MOV R7, 243
	DJNZ R7, 
	DJNZ R6, 
	NOP
;rf_tx.c,241 :: 		s--;
	DEC send_data_s_L0+0
;rf_tx.c,242 :: 		}
	SJMP L_send_data17
L_send_data18:
;rf_tx.c,243 :: 		delay_us(100);
	MOV R6, 2
	MOV R7, 150
	DJNZ R7, 
	DJNZ R6, 
;rf_tx.c,245 :: 		RF_send(value);
	MOV FARG_RF_send_rf_data+0, FARG_send_data_value+0
	LCALL _RF_send+0
;rf_tx.c,246 :: 		RF_send(CRC);
	MOV FARG_RF_send_rf_data+0, send_data_CRC_L0+0
	LCALL _RF_send+0
;rf_tx.c,247 :: 		}
	RET
; end of _send_data

_RF_send:
;rf_tx.c,250 :: 		void RF_send(unsigned char rf_data)
;rf_tx.c,252 :: 		signed char s = 0x08;
	MOV RF_send_s_L0+0, #8
;rf_tx.c,254 :: 		while(s > 0x00)
L_RF_send19:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, RF_send_s_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_RF_send20
;rf_tx.c,256 :: 		RF_TX = 1;
	SETB P0_1_bit+0
;rf_tx.c,258 :: 		if(rf_data & 0x80)
	MOV A, FARG_RF_send_rf_data+0
	ANL A, #128
	JZ L_RF_send21
;rf_tx.c,260 :: 		delay_ms(2);
	MOV R6, 32
	MOV R7, 208
	DJNZ R7, 
	DJNZ R6, 
	NOP
;rf_tx.c,261 :: 		}
	SJMP L_RF_send22
L_RF_send21:
;rf_tx.c,264 :: 		delay_ms(1);
	MOV R6, 16
	MOV R7, 231
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;rf_tx.c,265 :: 		}
L_RF_send22:
;rf_tx.c,267 :: 		RF_TX = 0;
	CLR P0_1_bit+0
;rf_tx.c,268 :: 		delay_ms(1);
	MOV R6, 16
	MOV R7, 231
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;rf_tx.c,269 :: 		rf_data <<= 1;
	MOV R0, #1
	MOV A, FARG_RF_send_rf_data+0
	INC R0
	SJMP L__RF_send25
L__RF_send26:
	CLR C
	RLC A
L__RF_send25:
	DJNZ R0, L__RF_send26
	MOV FARG_RF_send_rf_data+0, A
;rf_tx.c,270 :: 		s--;
	DEC RF_send_s_L0+0
;rf_tx.c,271 :: 		}
	SJMP L_RF_send19
L_RF_send20:
;rf_tx.c,272 :: 		}
	RET
; end of _RF_send
