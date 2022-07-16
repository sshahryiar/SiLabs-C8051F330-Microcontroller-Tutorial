
_Timer_3_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;rf_rx.c,57 :: 		ics ICS_AUTO
;rf_rx.c,59 :: 		switch(i)
	SJMP L_Timer_3_ISR0
;rf_rx.c,61 :: 		case 0:
L_Timer_3_ISR2:
;rf_rx.c,63 :: 		val = (value / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;rf_rx.c,64 :: 		break;
	LJMP L_Timer_3_ISR1
;rf_rx.c,66 :: 		case 1:
L_Timer_3_ISR3:
;rf_rx.c,68 :: 		val = ((value % 1000) / 100);
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
;rf_rx.c,69 :: 		break;
	SJMP L_Timer_3_ISR1
;rf_rx.c,71 :: 		case 2:
L_Timer_3_ISR4:
;rf_rx.c,73 :: 		val = ((value % 100) / 10);
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
;rf_rx.c,74 :: 		break;
	SJMP L_Timer_3_ISR1
;rf_rx.c,76 :: 		case 3:
L_Timer_3_ISR5:
;rf_rx.c,78 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV _val+0, 0
;rf_rx.c,79 :: 		break;
	SJMP L_Timer_3_ISR1
;rf_rx.c,81 :: 		}
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
;rf_rx.c,83 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, _val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;rf_rx.c,85 :: 		i++;
	INC _i+0
;rf_rx.c,87 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_3_ISR6
;rf_rx.c,89 :: 		i = 0;
	MOV _i+0, #0
;rf_rx.c,90 :: 		}
L_Timer_3_ISR6:
;rf_rx.c,92 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;rf_rx.c,93 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_3_ISR

_main:
	MOV SP+0, #128
;rf_rx.c,96 :: 		void main(void)
;rf_rx.c,98 :: 		Init_Device();
	LCALL _Init_Device+0
;rf_rx.c,100 :: 		while(1)
L_main7:
;rf_rx.c,102 :: 		value = decode_data();
	LCALL _decode_data+0
	MOV _value+0, 0
	MOV _value+1, 1
;rf_rx.c,103 :: 		};
	SJMP L_main7
;rf_rx.c,104 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;rf_rx.c,107 :: 		void PCA_Init(void)
;rf_rx.c,109 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;rf_rx.c,110 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;rf_rx.c,111 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;rf_rx.c,114 :: 		void Timer_Init(void)
;rf_rx.c,116 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;rf_rx.c,117 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;rf_rx.c,118 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;rf_rx.c,119 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;rf_rx.c,122 :: 		void Port_IO_Init(void)
;rf_rx.c,142 :: 		P0MDOUT = 0x02;
	MOV P0MDOUT+0, #2
;rf_rx.c,143 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;rf_rx.c,144 :: 		P0SKIP = 0x03;
	MOV P0SKIP+0, #3
;rf_rx.c,145 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;rf_rx.c,146 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;rf_rx.c,147 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;rf_rx.c,150 :: 		void Oscillator_Init(void)
;rf_rx.c,152 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;rf_rx.c,153 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;rf_rx.c,156 :: 		void Interrupts_Init(void)
;rf_rx.c,158 :: 		IE = 0x80;
	MOV IE+0, #128
;rf_rx.c,159 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;rf_rx.c,160 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;rf_rx.c,163 :: 		void Init_Device(void)
;rf_rx.c,165 :: 		PCA_Init();
	LCALL _PCA_Init+0
;rf_rx.c,166 :: 		Timer_Init();
	LCALL _Timer_Init+0
;rf_rx.c,167 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;rf_rx.c,168 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;rf_rx.c,169 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;rf_rx.c,170 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;rf_rx.c,173 :: 		void write_74HC595(unsigned char send_data)
;rf_rx.c,175 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;rf_rx.c,177 :: 		while(clks > 0)
L_write_74HC5959:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59510
;rf_rx.c,179 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59511
;rf_rx.c,181 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;rf_rx.c,182 :: 		}
	SJMP L_write_74HC59512
L_write_74HC59511:
;rf_rx.c,185 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;rf_rx.c,186 :: 		}
L_write_74HC59512:
;rf_rx.c,188 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;rf_rx.c,189 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59546
L__write_74HC59547:
	CLR C
	RLC A
L__write_74HC59546:
	DJNZ R0, L__write_74HC59547
	MOV FARG_write_74HC595_send_data+0, A
;rf_rx.c,190 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;rf_rx.c,191 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;rf_rx.c,192 :: 		}
	SJMP L_write_74HC5959
L_write_74HC59510:
;rf_rx.c,193 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;rf_rx.c,196 :: 		void segment_write(unsigned char disp, unsigned char pos)
;rf_rx.c,198 :: 		write_74HC595(segment_code[disp]);
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
;rf_rx.c,199 :: 		write_74HC595(display_pos[pos]);
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
;rf_rx.c,200 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;rf_rx.c,201 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;rf_rx.c,202 :: 		}
	RET
; end of _segment_write

_receive_data:
;rf_rx.c,205 :: 		unsigned char receive_data(void)
;rf_rx.c,207 :: 		unsigned char t = 0;
	MOV receive_data_t_L0+0, #0
;rf_rx.c,209 :: 		while(!RF_RX);
L_receive_data13:
	JB P0_0_bit+0, L_receive_data14
	NOP
	SJMP L_receive_data13
L_receive_data14:
;rf_rx.c,210 :: 		while(RF_RX)
L_receive_data15:
	JNB P0_0_bit+0, L_receive_data16
	NOP
;rf_rx.c,212 :: 		t++;
	INC receive_data_t_L0+0
;rf_rx.c,213 :: 		delay_us(10);
	MOV R7, 40
	DJNZ R7, 
	NOP
;rf_rx.c,214 :: 		};
	SJMP L_receive_data15
L_receive_data16:
;rf_rx.c,216 :: 		if((t > 25) && (t < 75))
	SETB C
	MOV A, receive_data_t_L0+0
	SUBB A, #25
	JC L_receive_data19
	CLR C
	MOV A, receive_data_t_L0+0
	SUBB A, #75
	JNC L_receive_data19
L__receive_data45:
;rf_rx.c,218 :: 		return sync;
	MOV R0, #9
	RET
;rf_rx.c,219 :: 		}
L_receive_data19:
;rf_rx.c,220 :: 		else if((t > 175) && (t < 225))
	SETB C
	MOV A, receive_data_t_L0+0
	SUBB A, #175
	JC L_receive_data23
	CLR C
	MOV A, receive_data_t_L0+0
	SUBB A, #225
	JNC L_receive_data23
L__receive_data44:
;rf_rx.c,222 :: 		return 1;
	MOV R0, #1
	RET
;rf_rx.c,223 :: 		}
L_receive_data23:
;rf_rx.c,224 :: 		else if((t > 75) && (t < 125))
	SETB C
	MOV A, receive_data_t_L0+0
	SUBB A, #75
	JC L_receive_data27
	CLR C
	MOV A, receive_data_t_L0+0
	SUBB A, #125
	JNC L_receive_data27
L__receive_data43:
;rf_rx.c,226 :: 		return 0;
	MOV R0, #0
	RET
;rf_rx.c,227 :: 		}
L_receive_data27:
;rf_rx.c,230 :: 		return error;
	MOV R0, #6
;rf_rx.c,232 :: 		}
	RET
; end of _receive_data

_decode_data:
;rf_rx.c,235 :: 		signed long decode_data(void)
;rf_rx.c,237 :: 		unsigned char d = 0;
	MOV 130, #?ICSdecode_data_d_L0+0
	MOV 131, hi(#?ICSdecode_data_d_L0+0)
	MOV R0, #decode_data_d_L0+0
	MOV R1, #8
	LCALL ___CC2D+0
;rf_rx.c,238 :: 		unsigned char s = 0;
;rf_rx.c,239 :: 		unsigned long value = 0;
;rf_rx.c,240 :: 		unsigned char v1 = 0;
;rf_rx.c,241 :: 		unsigned char v2 = 0;
;rf_rx.c,243 :: 		while(receive_data() != sync);
L_decode_data29:
	LCALL _receive_data+0
	MOV A, R0
	XRL A, #9
	JZ L_decode_data30
	SJMP L_decode_data29
L_decode_data30:
;rf_rx.c,245 :: 		d = receive_data();
	LCALL _receive_data+0
	MOV decode_data_d_L0+0, 0
;rf_rx.c,246 :: 		while(d == sync)
L_decode_data31:
	MOV A, decode_data_d_L0+0
	XRL A, #9
	JNZ L_decode_data32
;rf_rx.c,248 :: 		d = receive_data();
	LCALL _receive_data+0
	MOV decode_data_d_L0+0, 0
;rf_rx.c,249 :: 		};
	SJMP L_decode_data31
L_decode_data32:
;rf_rx.c,251 :: 		while(s < 15)
L_decode_data33:
	CLR C
	MOV A, decode_data_s_L0+0
	SUBB A, #15
	JNC L_decode_data34
;rf_rx.c,253 :: 		switch(d)
	SJMP L_decode_data35
;rf_rx.c,255 :: 		case 1:
L_decode_data37:
;rf_rx.c,257 :: 		value |= 1;
	ORL decode_data_value_L0+0, #1
	ORL decode_data_value_L0+1, #0
	ORL decode_data_value_L0+2, #0
	ORL decode_data_value_L0+3, #0
;rf_rx.c,258 :: 		break;
	SJMP L_decode_data36
;rf_rx.c,260 :: 		case 0:
L_decode_data38:
;rf_rx.c,262 :: 		break;
	SJMP L_decode_data36
;rf_rx.c,264 :: 		case sync:
L_decode_data39:
;rf_rx.c,265 :: 		case error:
L_decode_data40:
;rf_rx.c,267 :: 		return -1;
	MOV R0, #255
	MOV R1, #255
	MOV R2, #255
	MOV R3, #255
	RET
;rf_rx.c,269 :: 		}
L_decode_data35:
	MOV A, decode_data_d_L0+0
	XRL A, #1
	JZ L_decode_data37
	MOV A, decode_data_d_L0+0
	JZ L_decode_data38
	MOV A, decode_data_d_L0+0
	XRL A, #9
	JZ L_decode_data39
	MOV A, decode_data_d_L0+0
	XRL A, #6
	JZ L_decode_data40
L_decode_data36:
;rf_rx.c,270 :: 		s++;
	INC decode_data_s_L0+0
;rf_rx.c,271 :: 		value <<= 1;
	MOV R4, #1
	MOV R0, decode_data_value_L0+0
	MOV R1, decode_data_value_L0+1
	MOV R2, decode_data_value_L0+2
	MOV R3, decode_data_value_L0+3
	LCALL __shl_long+0
	MOV decode_data_value_L0+0, 0
	MOV decode_data_value_L0+1, 1
	MOV decode_data_value_L0+2, 2
	MOV decode_data_value_L0+3, 3
;rf_rx.c,272 :: 		d = receive_data();
	LCALL _receive_data+0
	MOV decode_data_d_L0+0, 0
;rf_rx.c,273 :: 		}
	SJMP L_decode_data33
L_decode_data34:
;rf_rx.c,275 :: 		v1 = (value >> 8);
	MOV R0, decode_data_value_L0+1
	MOV R1, decode_data_value_L0+2
	MOV R2, decode_data_value_L0+3
	MOV R3, #0
	MOV decode_data_v1_L0+0, 0
;rf_rx.c,276 :: 		v2 = (value & 0x00FF);
	MOV A, #255
	ANL A, decode_data_value_L0+0
	MOV decode_data_v2_L0+0, A
;rf_rx.c,277 :: 		delay_ms(4);
	MOV R6, 64
	MOV R7, 161
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;rf_rx.c,279 :: 		if((v1 & 0xAA) == v2)
	MOV A, decode_data_v1_L0+0
	ANL A, #170
	MOV R1, A
	XRL A, decode_data_v2_L0+0
	JNZ L_decode_data41
;rf_rx.c,281 :: 		return v1;
	MOV R0, decode_data_v1_L0+0
	CLR A
	MOV R1, A
	CLR A
	MOV R2, A
	CLR A
	MOV R3, A
	RET
;rf_rx.c,282 :: 		}
L_decode_data41:
;rf_rx.c,285 :: 		return -1;
	MOV R0, #255
	MOV R1, #255
	MOV R2, #255
	MOV R3, #255
;rf_rx.c,287 :: 		}
	RET
; end of _decode_data
