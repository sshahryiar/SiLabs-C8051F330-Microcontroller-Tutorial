
_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;dac.c,167 :: 		ics ICS_AUTO
;dac.c,169 :: 		switch(i)
	SJMP L_Timer_ISR0
;dac.c,171 :: 		case 0:
L_Timer_ISR2:
;dac.c,173 :: 		val = (value / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;dac.c,174 :: 		break;
	LJMP L_Timer_ISR1
;dac.c,176 :: 		case 1:
L_Timer_ISR3:
;dac.c,178 :: 		val = ((value % 1000) / 100);
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
;dac.c,179 :: 		break;
	SJMP L_Timer_ISR1
;dac.c,181 :: 		case 2:
L_Timer_ISR4:
;dac.c,183 :: 		val = ((value % 100) / 10);
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
;dac.c,184 :: 		break;
	SJMP L_Timer_ISR1
;dac.c,186 :: 		case 3:
L_Timer_ISR5:
;dac.c,188 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;dac.c,189 :: 		break;
	SJMP L_Timer_ISR1
;dac.c,191 :: 		}
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
;dac.c,193 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;dac.c,195 :: 		i++;
	INC _i+0
;dac.c,197 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;dac.c,199 :: 		i = 0;
	MOV _i+0, #0
;dac.c,200 :: 		}
L_Timer_ISR6:
;dac.c,202 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;dac.c,203 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;dac.c,206 :: 		void main(void)
;dac.c,208 :: 		signed char l = 0;
	MOV 130, #?ICSmain_l_L0+0
	MOV 131, hi(#?ICSmain_l_L0+0)
	MOV R0, #main_l_L0+0
	MOV R1, #8
	LCALL ___CC2D+0
;dac.c,209 :: 		unsigned int j = 0;
;dac.c,210 :: 		signed int dly = 0;
;dac.c,211 :: 		unsigned int dac_data = 0;
;dac.c,212 :: 		unsigned char mode = 0;
;dac.c,214 :: 		Init_Device();
	LCALL _Init_Device+0
;dac.c,216 :: 		while(1)
L_main7:
;dac.c,218 :: 		if(MODE_SW == 0)
	JB P1_3_bit+0, L_main9
	NOP
;dac.c,220 :: 		delay_ms(30);
	MOV R5, 2
	MOV R6, 222
	MOV R7, 66
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;dac.c,221 :: 		l = 0;
	MOV main_l_L0+0, #0
;dac.c,222 :: 		dac_data = 0;
	MOV main_dac_data_L0+0, #0
	MOV main_dac_data_L0+1, #0
;dac.c,223 :: 		mode++;
	INC main_mode_L0+0
;dac.c,224 :: 		}
L_main9:
;dac.c,226 :: 		if(mode >= 3)
	CLR C
	MOV A, main_mode_L0+0
	SUBB A, #3
	JC L_main10
;dac.c,228 :: 		mode = 0;
	MOV main_mode_L0+0, #0
;dac.c,229 :: 		}
L_main10:
;dac.c,231 :: 		if(INC_SW == 0)
	JB P1_2_bit+0, L_main11
	NOP
;dac.c,233 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;dac.c,234 :: 		dly++;
	MOV A, #1
	ADD A, main_dly_L0+0
	MOV main_dly_L0+0, A
	MOV A, #0
	ADDC A, main_dly_L0+1
	MOV main_dly_L0+1, A
;dac.c,235 :: 		}
L_main11:
;dac.c,237 :: 		if(dly > 9999)
	SETB C
	MOV A, main_dly_L0+0
	SUBB A, #15
	MOV A, #39
	XRL A, #128
	MOV R0, A
	MOV A, main_dly_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_main12
;dac.c,239 :: 		dly = 0;
	MOV main_dly_L0+0, #0
	MOV main_dly_L0+1, #0
;dac.c,240 :: 		}
L_main12:
;dac.c,242 :: 		if(DEC_SW == 0)
	JB P1_1_bit+0, L_main13
	NOP
;dac.c,244 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;dac.c,245 :: 		dly--;
	CLR C
	MOV A, main_dly_L0+0
	SUBB A, #1
	MOV main_dly_L0+0, A
	MOV A, main_dly_L0+1
	SUBB A, #0
	MOV main_dly_L0+1, A
;dac.c,246 :: 		}
L_main13:
;dac.c,248 :: 		if(dly < 0)
	CLR C
	MOV A, main_dly_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, main_dly_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_main14
;dac.c,250 :: 		dly = 9999;
	MOV main_dly_L0+0, #15
	MOV main_dly_L0+1, #39
;dac.c,251 :: 		}
L_main14:
;dac.c,253 :: 		value = dly;
	MOV _value+0, main_dly_L0+0
	MOV _value+1, main_dly_L0+1
;dac.c,255 :: 		switch(mode)
	LJMP L_main15
;dac.c,257 :: 		case 1:
L_main17:
;dac.c,259 :: 		dac_data = LUT_triangle[l];
	MOV R2, #1
	MOV A, main_l_L0+0
	RLC A
	CLR A
	SUBB A, 224
	MOV R1, A
	MOV A, main_l_L0+0
	INC R2
	SJMP L__main28
L__main29:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main28:
	DJNZ R2, L__main29
	MOV R0, A
	MOV A, #_LUT_triangle+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_triangle+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	CLR A
	INC DPTR
	MOVC A, @A+DPTR
	MOV R1, A
	MOV main_dac_data_L0+0, 0
	MOV main_dac_data_L0+1, 1
;dac.c,260 :: 		break;
	LJMP L_main16
;dac.c,263 :: 		case 2:
L_main18:
;dac.c,265 :: 		dac_data = LUT_square[l];
	MOV R2, #1
	MOV A, main_l_L0+0
	RLC A
	CLR A
	SUBB A, 224
	MOV R1, A
	MOV A, main_l_L0+0
	INC R2
	SJMP L__main30
L__main31:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main30:
	DJNZ R2, L__main31
	MOV R0, A
	MOV A, #_LUT_square+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_square+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	CLR A
	INC DPTR
	MOVC A, @A+DPTR
	MOV R1, A
	MOV main_dac_data_L0+0, 0
	MOV main_dac_data_L0+1, 1
;dac.c,266 :: 		break;
	SJMP L_main16
;dac.c,269 :: 		default:
L_main19:
;dac.c,271 :: 		dac_data = LUT_sine[l];
	MOV R2, #1
	MOV A, main_l_L0+0
	RLC A
	CLR A
	SUBB A, 224
	MOV R1, A
	MOV A, main_l_L0+0
	INC R2
	SJMP L__main32
L__main33:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main32:
	DJNZ R2, L__main33
	MOV R0, A
	MOV A, #_LUT_sine+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_sine+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	CLR A
	INC DPTR
	MOVC A, @A+DPTR
	MOV R1, A
	MOV main_dac_data_L0+0, 0
	MOV main_dac_data_L0+1, 1
;dac.c,272 :: 		break;
	SJMP L_main16
;dac.c,274 :: 		}
L_main15:
	MOV A, main_mode_L0+0
	XRL A, #1
	JNZ #3
	LJMP L_main17
	MOV A, main_mode_L0+0
	XRL A, #2
	JNZ #3
	LJMP L_main18
	SJMP L_main19
L_main16:
;dac.c,276 :: 		l++;
	INC main_l_L0+0
;dac.c,277 :: 		if(l >= 32)
	CLR C
	MOV A, #32
	XRL A, #128
	MOV R0, A
	MOV A, main_l_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_main20
;dac.c,279 :: 		l = 0;
	MOV main_l_L0+0, #0
;dac.c,280 :: 		}
L_main20:
;dac.c,282 :: 		DAC_write(dac_data);
	MOV FARG_DAC_write_dac_value+0, main_dac_data_L0+0
	MOV FARG_DAC_write_dac_value+1, main_dac_data_L0+1
	LCALL _DAC_write+0
;dac.c,284 :: 		for(j = 0; j < dly; j++)
	MOV main_j_L0+0, #0
	MOV main_j_L0+1, #0
L_main21:
	CLR C
	MOV A, main_j_L0+0
	SUBB A, main_dly_L0+0
	MOV A, main_j_L0+1
	SUBB A, main_dly_L0+1
	JNC L_main22
;dac.c,286 :: 		delay_us(1);
	MOV R7, 3
	DJNZ R7, 
	NOP
	NOP
;dac.c,284 :: 		for(j = 0; j < dly; j++)
	MOV A, #1
	ADD A, main_j_L0+0
	MOV main_j_L0+0, A
	MOV A, #0
	ADDC A, main_j_L0+1
	MOV main_j_L0+1, A
;dac.c,287 :: 		}
	SJMP L_main21
L_main22:
;dac.c,288 :: 		};
	LJMP L_main7
;dac.c,289 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;dac.c,292 :: 		void PCA_Init(void)
;dac.c,294 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;dac.c,295 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;dac.c,296 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;dac.c,299 :: 		void Timer_Init(void)
;dac.c,301 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;dac.c,302 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;dac.c,303 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;dac.c,304 :: 		}
	RET
; end of _Timer_Init

_DAC_Init:
;dac.c,307 :: 		void DAC_Init(void)
;dac.c,309 :: 		IDA0CN = 0xF2;
	MOV IDA0CN+0, #242
;dac.c,310 :: 		}
	RET
; end of _DAC_Init

_Port_IO_Init:
;dac.c,313 :: 		void Port_IO_Init(void)
;dac.c,333 :: 		P0MDIN = 0xFD;
	MOV P0MDIN+0, #253
;dac.c,334 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;dac.c,335 :: 		P0SKIP = 0x02;
	MOV P0SKIP+0, #2
;dac.c,336 :: 		P1SKIP = 0xEE;
	MOV P1SKIP+0, #238
;dac.c,337 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;dac.c,338 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;dac.c,341 :: 		void Oscillator_Init(void)
;dac.c,343 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;dac.c,344 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;dac.c,347 :: 		void Interrupts_Init(void)
;dac.c,349 :: 		IE = 0x80;
	MOV IE+0, #128
;dac.c,350 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;dac.c,351 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;dac.c,354 :: 		void Init_Device(void)
;dac.c,356 :: 		PCA_Init();
	LCALL _PCA_Init+0
;dac.c,357 :: 		Timer_Init();
	LCALL _Timer_Init+0
;dac.c,358 :: 		DAC_Init();
	LCALL _DAC_Init+0
;dac.c,359 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;dac.c,360 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;dac.c,361 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;dac.c,362 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;dac.c,365 :: 		void write_74HC595(unsigned char send_data)
;dac.c,367 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;dac.c,369 :: 		while(clks > 0)
L_write_74HC59524:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59525
;dac.c,371 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59526
;dac.c,373 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;dac.c,374 :: 		}
	SJMP L_write_74HC59527
L_write_74HC59526:
;dac.c,377 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;dac.c,378 :: 		}
L_write_74HC59527:
;dac.c,380 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;dac.c,381 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59534
L__write_74HC59535:
	CLR C
	RLC A
L__write_74HC59534:
	DJNZ R0, L__write_74HC59535
	MOV FARG_write_74HC595_send_data+0, A
;dac.c,382 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;dac.c,383 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;dac.c,384 :: 		}
	SJMP L_write_74HC59524
L_write_74HC59525:
;dac.c,385 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;dac.c,388 :: 		void segment_write(unsigned char disp, unsigned char pos)
;dac.c,390 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;dac.c,391 :: 		write_74HC595(segment_code[disp]);
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
;dac.c,392 :: 		write_74HC595(display_pos[pos]);
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
;dac.c,393 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;dac.c,394 :: 		}
	RET
; end of _segment_write

_DAC_write:
;dac.c,397 :: 		void DAC_write(unsigned int dac_value)
;dac.c,399 :: 		unsigned char lb = 0x00;
;dac.c,400 :: 		unsigned char hb = 0x00;
;dac.c,402 :: 		dac_value <<= 0x06;
	MOV R2, #6
	MOV R1, FARG_DAC_write_dac_value+1
	MOV A, FARG_DAC_write_dac_value+0
	INC R2
	SJMP L__DAC_write36
L__DAC_write37:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__DAC_write36:
	DJNZ R2, L__DAC_write37
	MOV R0, A
	MOV FARG_DAC_write_dac_value+0, 0
	MOV FARG_DAC_write_dac_value+1, 1
;dac.c,404 :: 		lb = (dac_value & 0xC0);
	MOV A, #192
	ANL A, R0
	MOV IDA0L+0, A
;dac.c,405 :: 		hb = ((dac_value & 0xFF00) >> 0x08);
	ANL 0, #0
	ANL 1, #255
	MOV R0, 1
	MOV R1, #0
;dac.c,407 :: 		IDA0L = lb;
;dac.c,408 :: 		IDA0H = hb;
	MOV IDA0H+0, 0
;dac.c,409 :: 		}
	RET
; end of _DAC_write
