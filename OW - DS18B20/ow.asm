
_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;ow.c,58 :: 		ics ICS_AUTO
;ow.c,60 :: 		switch(i)
	SJMP L_Timer_ISR0
;ow.c,62 :: 		case 0:
L_Timer_ISR2:
;ow.c,64 :: 		val = (value / 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;ow.c,65 :: 		break;
	SJMP L_Timer_ISR1
;ow.c,67 :: 		case 1:
L_Timer_ISR3:
;ow.c,69 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;ow.c,70 :: 		break;
	SJMP L_Timer_ISR1
;ow.c,72 :: 		case 2:
L_Timer_ISR4:
;ow.c,74 :: 		val = 10;
	MOV val+0, #10
;ow.c,75 :: 		break;
	SJMP L_Timer_ISR1
;ow.c,77 :: 		case 3:
L_Timer_ISR5:
;ow.c,79 :: 		val = 11;
	MOV val+0, #11
;ow.c,80 :: 		break;
	SJMP L_Timer_ISR1
;ow.c,82 :: 		}
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
;ow.c,84 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;ow.c,86 :: 		i++;
	INC _i+0
;ow.c,88 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;ow.c,90 :: 		i = 0;
	MOV _i+0, #0
;ow.c,91 :: 		}
L_Timer_ISR6:
;ow.c,93 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;ow.c,94 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;ow.c,97 :: 		void main(void)
;ow.c,99 :: 		unsigned temp = 0x00;
	MOV main_temp_L0+0, #0
	MOV main_temp_L0+1, #0
;ow.c,100 :: 		Init_Device();
	LCALL _Init_Device+0
;ow.c,102 :: 		while(1)
L_main7:
;ow.c,104 :: 		Ow_Reset();
	LCALL _Ow_Reset+0
;ow.c,105 :: 		Ow_Write(DS18B20_SKIP_ROM);
	MOV FARG_Ow_Write_par+0, #204
	LCALL _Ow_Write+0
;ow.c,106 :: 		Ow_Write(DS18B20_CONVERT_T);
	MOV FARG_Ow_Write_par+0, #68
	LCALL _Ow_Write+0
;ow.c,107 :: 		Delay_us(120);
	MOV R6, 3
	MOV R7, 125
	DJNZ R7, 
	DJNZ R6, 
;ow.c,109 :: 		Ow_Reset();
	LCALL _Ow_Reset+0
;ow.c,110 :: 		Ow_Write(DS18B20_SKIP_ROM);
	MOV FARG_Ow_Write_par+0, #204
	LCALL _Ow_Write+0
;ow.c,111 :: 		Ow_Write(DS18B20_READ_SCRATCHPAD);
	MOV FARG_Ow_Write_par+0, #190
	LCALL _Ow_Write+0
;ow.c,113 :: 		temp =  Ow_Read();
	LCALL _Ow_Read+0
	MOV main_temp_L0+0, 0
	CLR A
	MOV main_temp_L0+1, A
;ow.c,114 :: 		temp = ((Ow_Read() << 0x08) + temp);
	LCALL _Ow_Read+0
	MOV R1, 0
	MOV R0, #0
	MOV R2, #0
	MOV A, R0
	ADD A, main_temp_L0+0
	MOV R2, A
	MOV A, R1
	ADDC A, main_temp_L0+1
	MOV R3, A
	MOV main_temp_L0+0, 2
	MOV main_temp_L0+1, 3
;ow.c,115 :: 		value = temp >> 0x04;
	MOV R0, #4
	MOV A, R3
	MOV _value+0, 2
	INC R0
	SJMP L__main26
L__main27:
	CLR C
	RRC A
	XCH A, _value+0
	RRC A
	XCH A, _value+0
L__main26:
	DJNZ R0, L__main27
	MOV _value+1, A
;ow.c,117 :: 		P0_1_bit = 1;
	SETB P0_1_bit+0
;ow.c,118 :: 		delay_ms(300);
	MOV R5, 25
	MOV R6, 90
	MOV R7, 177
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ow.c,119 :: 		P0_1_bit = 0;
	CLR P0_1_bit+0
;ow.c,120 :: 		delay_ms(300);
	MOV R5, 25
	MOV R6, 90
	MOV R7, 177
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ow.c,122 :: 		}
	LJMP L_main7
;ow.c,123 :: 		}
	SJMP #254
; end of _main

_Reset_Sources_Init:
;ow.c,126 :: 		void Reset_Sources_Init(void)
;ow.c,128 :: 		RSTSRC = 0x04;
	MOV RSTSRC+0, #4
;ow.c,129 :: 		}
	RET
; end of _Reset_Sources_Init

_PCA_Init:
;ow.c,132 :: 		void PCA_Init(void)
;ow.c,134 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;ow.c,135 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;ow.c,136 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;ow.c,138 :: 		void Timer_Init(void)
;ow.c,140 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;ow.c,141 :: 		TMR3RLL = 0xCA;
	MOV TMR3RLL+0, #202
;ow.c,142 :: 		TMR3RLH = 0xFA;
	MOV TMR3RLH+0, #250
;ow.c,143 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;ow.c,145 :: 		void Port_IO_Init(void)
;ow.c,165 :: 		P0MDIN = 0xF3;
	MOV P0MDIN+0, #243
;ow.c,166 :: 		P0MDOUT = 0x02;
	MOV P0MDOUT+0, #2
;ow.c,167 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;ow.c,168 :: 		P0SKIP = 0x0E;
	MOV P0SKIP+0, #14
;ow.c,169 :: 		P1SKIP = 0xD0;
	MOV P1SKIP+0, #208
;ow.c,170 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;ow.c,171 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;ow.c,174 :: 		void Oscillator_Init(void)
;ow.c,176 :: 		int i = 0;
	MOV Oscillator_Init_i_L0+0, #0
	MOV Oscillator_Init_i_L0+1, #0
;ow.c,177 :: 		OSCICN = 0x81;
	MOV OSCICN+0, #129
;ow.c,179 :: 		if(MCDRSF_bit == 1)
	MOV A, MCDRSF_bit+0
	JNB 224, L_Oscillator_Init9
	NOP
;ow.c,181 :: 		CLKSEL = 0x00;
	MOV CLKSEL+0, #0
;ow.c,183 :: 		for(i = 0; i < 9; i++)
	MOV Oscillator_Init_i_L0+0, #0
	MOV Oscillator_Init_i_L0+1, #0
L_Oscillator_Init10:
	CLR C
	MOV A, Oscillator_Init_i_L0+0
	SUBB A, #9
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, Oscillator_Init_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Oscillator_Init11
;ow.c,185 :: 		P0_1_bit = 1;
	SETB P0_1_bit+0
;ow.c,186 :: 		delay_ms(60);
	MOV R5, 5
	MOV R6, 223
	MOV R7, 187
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ow.c,187 :: 		P0_1_bit = 0;
	CLR P0_1_bit+0
;ow.c,188 :: 		delay_ms(60);
	MOV R5, 5
	MOV R6, 223
	MOV R7, 187
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ow.c,183 :: 		for(i = 0; i < 9; i++)
	MOV A, #1
	ADD A, Oscillator_Init_i_L0+0
	MOV Oscillator_Init_i_L0+0, A
	MOV A, #0
	ADDC A, Oscillator_Init_i_L0+1
	MOV Oscillator_Init_i_L0+1, A
;ow.c,189 :: 		}
	SJMP L_Oscillator_Init10
L_Oscillator_Init11:
;ow.c,190 :: 		}
	LJMP L_Oscillator_Init13
L_Oscillator_Init9:
;ow.c,193 :: 		OSCXCN = 0x67;
	MOV OSCXCN+0, #103
;ow.c,194 :: 		for (i = 0; i < 3000; i++);  // Wait 1ms for initialization
	MOV Oscillator_Init_i_L0+0, #0
	MOV Oscillator_Init_i_L0+1, #0
L_Oscillator_Init14:
	CLR C
	MOV A, Oscillator_Init_i_L0+0
	SUBB A, #184
	MOV A, #11
	XRL A, #128
	MOV R0, A
	MOV A, Oscillator_Init_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Oscillator_Init15
	MOV A, #1
	ADD A, Oscillator_Init_i_L0+0
	MOV Oscillator_Init_i_L0+0, A
	MOV A, #0
	ADDC A, Oscillator_Init_i_L0+1
	MOV Oscillator_Init_i_L0+1, A
	SJMP L_Oscillator_Init14
L_Oscillator_Init15:
;ow.c,195 :: 		while ((OSCXCN & 0x80) == 0);
L_Oscillator_Init17:
	MOV A, OSCXCN+0
	ANL A, #128
	MOV R1, A
	JNZ L_Oscillator_Init18
	SJMP L_Oscillator_Init17
L_Oscillator_Init18:
;ow.c,196 :: 		CLKSEL = 0x01;
	MOV CLKSEL+0, #1
;ow.c,198 :: 		for(i = 0; i < 9; i++)
	MOV Oscillator_Init_i_L0+0, #0
	MOV Oscillator_Init_i_L0+1, #0
L_Oscillator_Init19:
	CLR C
	MOV A, Oscillator_Init_i_L0+0
	SUBB A, #9
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, Oscillator_Init_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Oscillator_Init20
;ow.c,200 :: 		P0_1_bit = 1;
	SETB P0_1_bit+0
;ow.c,201 :: 		delay_ms(45);
	MOV R5, 4
	MOV R6, 168
	MOV R7, 11
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ow.c,202 :: 		P0_1_bit = 0;
	CLR P0_1_bit+0
;ow.c,203 :: 		delay_ms(45);
	MOV R5, 4
	MOV R6, 168
	MOV R7, 11
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ow.c,198 :: 		for(i = 0; i < 9; i++)
	MOV A, #1
	ADD A, Oscillator_Init_i_L0+0
	MOV Oscillator_Init_i_L0+0, A
	MOV A, #0
	ADDC A, Oscillator_Init_i_L0+1
	MOV Oscillator_Init_i_L0+1, A
;ow.c,204 :: 		}
	SJMP L_Oscillator_Init19
L_Oscillator_Init20:
;ow.c,205 :: 		}
L_Oscillator_Init13:
;ow.c,207 :: 		delay_ms(2000);
	MOV R5, 163
	MOV R6, 87
	MOV R7, 2
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;ow.c,208 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;ow.c,211 :: 		void Interrupts_Init(void)
;ow.c,213 :: 		IE = 0x80;
	MOV IE+0, #128
;ow.c,214 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;ow.c,215 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;ow.c,218 :: 		void Init_Device(void)
;ow.c,220 :: 		PCA_Init();
	LCALL _PCA_Init+0
;ow.c,221 :: 		Timer_Init();
	LCALL _Timer_Init+0
;ow.c,222 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;ow.c,223 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;ow.c,224 :: 		Reset_Sources_Init();
	LCALL _Reset_Sources_Init+0
;ow.c,225 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;ow.c,226 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;ow.c,229 :: 		void write_74HC595(unsigned char send_data)
;ow.c,231 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;ow.c,233 :: 		while(clks > 0)
L_write_74HC59522:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59523
;ow.c,235 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59524
;ow.c,237 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;ow.c,238 :: 		}
	SJMP L_write_74HC59525
L_write_74HC59524:
;ow.c,241 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;ow.c,242 :: 		}
L_write_74HC59525:
;ow.c,244 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;ow.c,245 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59528
L__write_74HC59529:
	CLR C
	RLC A
L__write_74HC59528:
	DJNZ R0, L__write_74HC59529
	MOV FARG_write_74HC595_send_data+0, A
;ow.c,246 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;ow.c,247 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;ow.c,248 :: 		}
	SJMP L_write_74HC59522
L_write_74HC59523:
;ow.c,249 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;ow.c,252 :: 		void segment_write(unsigned char disp, unsigned char pos)
;ow.c,254 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;ow.c,255 :: 		write_74HC595(segment_code[disp]);
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
;ow.c,256 :: 		write_74HC595(display_pos[pos]);
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
;ow.c,257 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;ow.c,258 :: 		}
	RET
; end of _segment_write
