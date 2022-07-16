
_MAX31865_init:
;max31865.c,4 :: 		void MAX31865_init(void)
;max31865.c,6 :: 		SPI1_Init_Advanced(1000000, _SPI_CLK_IDLE_LO | _SPI_CLK_ACTIVE_2_IDLE | _SPI_MASTER);
	MOV SPI0CKR+0, #5
	MOV FARG_SPI1_Init_Advanced_adv_setting+0, #96
	LCALL _SPI1_Init_Advanced+0
;max31865.c,7 :: 		delay_ms(10);
	MOV R6, 160
	MOV R7, 21
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;max31865.c,9 :: 		MAX31865_CS = 1;
	SETB P0_3_bit+0
;max31865.c,16 :: 		MAX31865_CONFIG_FILTER_50Hz);
	MOV FARG_MAX31865_write_byte_address+0, #0
	MOV FARG_MAX31865_write_byte_value+0, #211
	LCALL _MAX31865_write_byte+0
;max31865.c,17 :: 		}
	RET
; end of _MAX31865_init

_MAX31865_read_byte:
;max31865.c,20 :: 		unsigned char MAX31865_read_byte(unsigned char address)
;max31865.c,22 :: 		unsigned char retval = 0x00;
;max31865.c,24 :: 		MAX31865_CS = 0;
	CLR P0_3_bit+0
;max31865.c,25 :: 		SPI_Write(address & 0x7F);
	MOV A, FARG_MAX31865_read_byte_address+0
	ANL A, #127
	MOV FARG_SPI_Write_data_out+0, A
	LCALL _SPI_Write+0
;max31865.c,26 :: 		retval = SPI_Read(0x00);
	MOV FARG_SPI_Read_buffer+0, #0
	LCALL _SPI_Read+0
;max31865.c,27 :: 		MAX31865_CS = 1;
	SETB P0_3_bit+0
;max31865.c,29 :: 		return retval;
;max31865.c,30 :: 		}
	RET
; end of _MAX31865_read_byte

_MAX31865_read_word:
;max31865.c,33 :: 		unsigned int MAX31865_read_word(unsigned char address)
;max31865.c,35 :: 		unsigned char lb = 0x00;
;max31865.c,36 :: 		unsigned char hb = 0x00;
	MOV MAX31865_read_word_hb_L0+0, #0
	MOV MAX31865_read_word_retval_L0+0, #0
	MOV MAX31865_read_word_retval_L0+1, #0
;max31865.c,37 :: 		unsigned int retval = 0x0000;
;max31865.c,39 :: 		hb = MAX31865_read_byte(address);
	MOV FARG_MAX31865_read_byte_address+0, FARG_MAX31865_read_word_address+0
	LCALL _MAX31865_read_byte+0
	MOV MAX31865_read_word_hb_L0+0, 0
;max31865.c,40 :: 		lb = MAX31865_read_byte(address + 1);
	MOV A, FARG_MAX31865_read_word_address+0
	ADD A, #1
	MOV FARG_MAX31865_read_byte_address+0, A
	LCALL _MAX31865_read_byte+0
;max31865.c,42 :: 		retval = hb;
	MOV MAX31865_read_word_retval_L0+0, MAX31865_read_word_hb_L0+0
	CLR A
	MOV MAX31865_read_word_retval_L0+1, A
;max31865.c,43 :: 		retval <<= 0x08;
	MOV R3, MAX31865_read_word_retval_L0+0
	MOV R2, #0
	MOV MAX31865_read_word_retval_L0+0, 2
	MOV MAX31865_read_word_retval_L0+1, 3
;max31865.c,44 :: 		retval |= lb;
	MOV A, R2
	ORL 0, A
	MOV A, R3
	ORL 1, A
	MOV MAX31865_read_word_retval_L0+0, 0
	MOV MAX31865_read_word_retval_L0+1, 1
;max31865.c,46 :: 		return retval;
;max31865.c,47 :: 		}
	RET
; end of _MAX31865_read_word

_MAX31865_write_byte:
;max31865.c,50 :: 		void MAX31865_write_byte(unsigned char address, unsigned char value)
;max31865.c,52 :: 		MAX31865_CS = 0;
	CLR P0_3_bit+0
;max31865.c,53 :: 		SPI_Write(address | 0x80);
	MOV A, FARG_MAX31865_write_byte_address+0
	ORL A, #128
	MOV FARG_SPI_Write_data_out+0, A
	LCALL _SPI_Write+0
;max31865.c,54 :: 		SPI_Write(value);
	MOV FARG_SPI_Write_data_out+0, FARG_MAX31865_write_byte_value+0
	LCALL _SPI_Write+0
;max31865.c,55 :: 		MAX31865_CS = 1;
	SETB P0_3_bit+0
;max31865.c,56 :: 		}
	RET
; end of _MAX31865_write_byte

_MAX31865_write_word:
;max31865.c,59 :: 		void MAX31865_write_word(unsigned char address, unsigned char lb, unsigned char hb)
;max31865.c,61 :: 		MAX31865_write_byte(address, hb);
	MOV FARG_MAX31865_write_byte_address+0, FARG_MAX31865_write_word_address+0
	MOV FARG_MAX31865_write_byte_value+0, FARG_MAX31865_write_word_hb+0
	LCALL _MAX31865_write_byte+0
;max31865.c,62 :: 		MAX31865_write_byte((address + 1), lb);
	MOV A, FARG_MAX31865_write_word_address+0
	ADD A, #1
	MOV FARG_MAX31865_write_byte_address+0, A
	MOV FARG_MAX31865_write_byte_value+0, FARG_MAX31865_write_word_lb+0
	LCALL _MAX31865_write_byte+0
;max31865.c,63 :: 		}
	RET
; end of _MAX31865_write_word

_MAX31865_get_RTD:
;max31865.c,66 :: 		unsigned int MAX31865_get_RTD(void)
;max31865.c,68 :: 		unsigned int rtd_value = 0x00;
;max31865.c,70 :: 		rtd_value = MAX31865_read_word(MAX31865_RTD_MSB_REG);
	MOV FARG_MAX31865_read_word_address+0, #1
	LCALL _MAX31865_read_word+0
;max31865.c,71 :: 		rtd_value >>= 1;
	MOV R4, #1
	MOV A, R1
	MOV R2, 0
	INC R4
	SJMP L__MAX31865_get_RTD13
L__MAX31865_get_RTD14:
	CLR C
	RRC A
	XCH A, R2
	RRC A
	XCH A, R2
L__MAX31865_get_RTD13:
	DJNZ R4, L__MAX31865_get_RTD14
	MOV R3, A
;max31865.c,73 :: 		return rtd_value;
	MOV R0, 2
	MOV R1, 3
;max31865.c,74 :: 		}
	RET
; end of _MAX31865_get_RTD

_MAX31865_get_temperature:
;max31865.c,77 :: 		signed int MAX31865_get_temperature(void)
;max31865.c,79 :: 		float rt = 0.0;
;max31865.c,80 :: 		signed int t_value = 0;
;max31865.c,82 :: 		t_value = MAX31865_get_RTD();
	LCALL _MAX31865_get_RTD+0
;max31865.c,83 :: 		rt = (MAX31865_Reference_Resistance * t_value);
	LCALL _Int2Double+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #215
	MOV 7, #67
	LCALL _Mul_32x32_FP+0
;max31865.c,84 :: 		rt /= 32768.0;
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV 7, #71
	LCALL _Div_32x32_FP+0
;max31865.c,86 :: 		rt /= MAX31865_RTD_Nominal_Value;
	MOV R4, #0
	MOV R5, #0
	MOV R6, #200
	MOV 7, #66
	LCALL _Div_32x32_FP+0
;max31865.c,87 :: 		rt = (rt - 1.0);
	MOV R4, #0
	MOV R5, #0
	MOV R6, #128
	MOV 7, #63
	LCALL _Sub_32x32_FP+0
;max31865.c,88 :: 		t_value = (rt / MAX31865_RTD_A);
	MOV R4, #239
	MOV R5, #14
	MOV R6, #128
	MOV 7, #59
	LCALL _Div_32x32_FP+0
	LCALL _Double2Ints+0
;max31865.c,90 :: 		return t_value;
;max31865.c,91 :: 		}
	RET
; end of _MAX31865_get_temperature

_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;thermo.c,53 :: 		ics ICS_AUTO
;thermo.c,55 :: 		switch(i)
	SJMP L_Timer_ISR0
;thermo.c,57 :: 		case 0:
L_Timer_ISR2:
;thermo.c,59 :: 		val = (value / 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;thermo.c,60 :: 		break;
	SJMP L_Timer_ISR1
;thermo.c,62 :: 		case 1:
L_Timer_ISR3:
;thermo.c,64 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;thermo.c,65 :: 		break;
	SJMP L_Timer_ISR1
;thermo.c,67 :: 		case 2:
L_Timer_ISR4:
;thermo.c,69 :: 		val = 10;
	MOV val+0, #10
;thermo.c,70 :: 		break;
	SJMP L_Timer_ISR1
;thermo.c,72 :: 		case 3:
L_Timer_ISR5:
;thermo.c,74 :: 		val = 11;
	MOV val+0, #11
;thermo.c,75 :: 		break;
	SJMP L_Timer_ISR1
;thermo.c,77 :: 		}
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
;thermo.c,79 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;thermo.c,81 :: 		i++;
	INC _i+0
;thermo.c,83 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;thermo.c,85 :: 		i = 0;
	MOV _i+0, #0
;thermo.c,86 :: 		}
L_Timer_ISR6:
;thermo.c,88 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;thermo.c,89 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;thermo.c,92 :: 		void main(void)
;thermo.c,94 :: 		Init_Device();
	LCALL _Init_Device+0
;thermo.c,95 :: 		MAX31865_init();
	LCALL _MAX31865_init+0
;thermo.c,97 :: 		while(1)
L_main7:
;thermo.c,99 :: 		value = MAX31865_get_temperature();
	LCALL _MAX31865_get_temperature+0
	MOV _value+0, 0
	MOV _value+1, 1
;thermo.c,100 :: 		delay_ms(600);
	MOV R5, 38
	MOV R6, 74
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;thermo.c,101 :: 		};
	SJMP L_main7
;thermo.c,102 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;thermo.c,105 :: 		void PCA_Init(void)
;thermo.c,107 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;thermo.c,108 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;thermo.c,109 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;thermo.c,112 :: 		void Timer_Init(void)
;thermo.c,114 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;thermo.c,115 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;thermo.c,116 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;thermo.c,117 :: 		}
	RET
; end of _Timer_Init

_SPI_Init:
;thermo.c,120 :: 		void SPI_Init(void)
;thermo.c,122 :: 		SPI0CFG = 0x40;
	MOV SPI0CFG+0, #64
;thermo.c,123 :: 		SPI0CN = 0x01;
	MOV SPI0CN+0, #1
;thermo.c,124 :: 		SPI0CKR = 0x05;
	MOV SPI0CKR+0, #5
;thermo.c,125 :: 		}
	RET
; end of _SPI_Init

_Port_IO_Init:
;thermo.c,128 :: 		void Port_IO_Init(void)
;thermo.c,148 :: 		P0MDOUT = 0x0D;
	MOV P0MDOUT+0, #13
;thermo.c,149 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;thermo.c,150 :: 		P0SKIP = 0x08;
	MOV P0SKIP+0, #8
;thermo.c,151 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;thermo.c,152 :: 		XBR0 = 0x02;
	MOV XBR0+0, #2
;thermo.c,153 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;thermo.c,154 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;thermo.c,157 :: 		void Oscillator_Init(void)
;thermo.c,159 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;thermo.c,160 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;thermo.c,163 :: 		void Interrupts_Init(void)
;thermo.c,165 :: 		IE = 0x80;
	MOV IE+0, #128
;thermo.c,166 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;thermo.c,167 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;thermo.c,170 :: 		void Init_Device(void)
;thermo.c,172 :: 		PCA_Init();
	LCALL _PCA_Init+0
;thermo.c,173 :: 		Timer_Init();
	LCALL _Timer_Init+0
;thermo.c,174 :: 		SPI_Init();
	LCALL _SPI_Init+0
;thermo.c,175 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;thermo.c,176 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;thermo.c,177 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;thermo.c,178 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;thermo.c,181 :: 		void write_74HC595(unsigned char send_data)
;thermo.c,183 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;thermo.c,185 :: 		while(clks > 0)
L_write_74HC5959:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59510
;thermo.c,187 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59511
;thermo.c,189 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;thermo.c,190 :: 		}
	SJMP L_write_74HC59512
L_write_74HC59511:
;thermo.c,193 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;thermo.c,194 :: 		}
L_write_74HC59512:
;thermo.c,196 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;thermo.c,197 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59515
L__write_74HC59516:
	CLR C
	RLC A
L__write_74HC59515:
	DJNZ R0, L__write_74HC59516
	MOV FARG_write_74HC595_send_data+0, A
;thermo.c,198 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;thermo.c,199 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;thermo.c,200 :: 		}
	SJMP L_write_74HC5959
L_write_74HC59510:
;thermo.c,201 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;thermo.c,204 :: 		void segment_write(unsigned char disp, unsigned char pos)
;thermo.c,206 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;thermo.c,207 :: 		write_74HC595(segment_code[disp]);
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
;thermo.c,208 :: 		write_74HC595(display_pos[pos]);
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
;thermo.c,209 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;thermo.c,210 :: 		}
	RET
; end of _segment_write
