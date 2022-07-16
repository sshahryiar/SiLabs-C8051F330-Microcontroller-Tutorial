
_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;adc_timer_interrupt.c,58 :: 		ics ICS_AUTO
;adc_timer_interrupt.c,60 :: 		switch(i)
	LJMP L_Timer_ISR0
;adc_timer_interrupt.c,62 :: 		case 0:
L_Timer_ISR2:
;adc_timer_interrupt.c,64 :: 		val = (value / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;adc_timer_interrupt.c,65 :: 		pt = 0;
	MOV _pt+0, #0
;adc_timer_interrupt.c,66 :: 		break;
	LJMP L_Timer_ISR1
;adc_timer_interrupt.c,68 :: 		case 1:
L_Timer_ISR3:
;adc_timer_interrupt.c,70 :: 		val = ((value % 1000) / 100);
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
;adc_timer_interrupt.c,71 :: 		pt = 1;
	MOV _pt+0, #1
;adc_timer_interrupt.c,72 :: 		break;
	SJMP L_Timer_ISR1
;adc_timer_interrupt.c,74 :: 		case 2:
L_Timer_ISR4:
;adc_timer_interrupt.c,76 :: 		val = ((value % 100) / 10);
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
;adc_timer_interrupt.c,77 :: 		pt = 0;
	MOV _pt+0, #0
;adc_timer_interrupt.c,78 :: 		break;
	SJMP L_Timer_ISR1
;adc_timer_interrupt.c,80 :: 		case 3:
L_Timer_ISR5:
;adc_timer_interrupt.c,82 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;adc_timer_interrupt.c,83 :: 		pt = 0;
	MOV _pt+0, #0
;adc_timer_interrupt.c,84 :: 		break;
	SJMP L_Timer_ISR1
;adc_timer_interrupt.c,86 :: 		}
L_Timer_ISR0:
	MOV A, _i+0
	JNZ #3
	LJMP L_Timer_ISR2
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
;adc_timer_interrupt.c,88 :: 		segment_write(val, i, pt);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	MOV FARG_segment_write_point+0, _pt+0
	LCALL _segment_write+0
;adc_timer_interrupt.c,90 :: 		i++;
	INC _i+0
;adc_timer_interrupt.c,92 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;adc_timer_interrupt.c,94 :: 		i = 0;
	MOV _i+0, #0
;adc_timer_interrupt.c,95 :: 		}
L_Timer_ISR6:
;adc_timer_interrupt.c,97 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;adc_timer_interrupt.c,98 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;adc_timer_interrupt.c,101 :: 		void main(void)
;adc_timer_interrupt.c,103 :: 		float t = 0;
;adc_timer_interrupt.c,105 :: 		Init_Device();
	LCALL _Init_Device+0
;adc_timer_interrupt.c,107 :: 		while(1)
L_main7:
;adc_timer_interrupt.c,109 :: 		t = (adc_avg(0) * VDD_mv);
	MOV FARG_adc_avg_channel+0, #0
	LCALL _adc_avg+0
	LCALL _Word2Double+0
	MOV R4, #0
	MOV R5, #64
	MOV R6, #78
	MOV 7, #69
	LCALL _Mul_32x32_FP+0
;adc_timer_interrupt.c,110 :: 		t /= ADC_res;
	MOV R4, #0
	MOV R5, #192
	MOV R6, #127
	MOV 7, #68
	LCALL _Div_32x32_FP+0
;adc_timer_interrupt.c,111 :: 		value = (t / 0.3);
	MOV R4, #154
	MOV R5, #153
	MOV R6, #153
	MOV 7, #62
	LCALL _Div_32x32_FP+0
	LCALL _Double2Ints+0
	MOV _value+0, 0
	MOV _value+1, 1
;adc_timer_interrupt.c,112 :: 		delay_ms(100);
	MOV R5, 7
	MOV R6, 55
	MOV R7, 226
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;adc_timer_interrupt.c,113 :: 		};
	SJMP L_main7
;adc_timer_interrupt.c,114 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;adc_timer_interrupt.c,117 :: 		void PCA_Init(void)
;adc_timer_interrupt.c,119 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;adc_timer_interrupt.c,120 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;adc_timer_interrupt.c,121 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;adc_timer_interrupt.c,124 :: 		void Timer_Init()
;adc_timer_interrupt.c,126 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;adc_timer_interrupt.c,127 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;adc_timer_interrupt.c,128 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;adc_timer_interrupt.c,129 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;adc_timer_interrupt.c,132 :: 		void Port_IO_Init()
;adc_timer_interrupt.c,152 :: 		P0MDIN = 0xFE;
	MOV P0MDIN+0, #254
;adc_timer_interrupt.c,153 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;adc_timer_interrupt.c,154 :: 		P0SKIP = 0x01;
	MOV P0SKIP+0, #1
;adc_timer_interrupt.c,155 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;adc_timer_interrupt.c,156 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;adc_timer_interrupt.c,157 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;adc_timer_interrupt.c,160 :: 		void Oscillator_Init()
;adc_timer_interrupt.c,162 :: 		OSCLCN = 0x82;
	MOV OSCLCN+0, #130
;adc_timer_interrupt.c,163 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;adc_timer_interrupt.c,166 :: 		void Interrupts_Init()
;adc_timer_interrupt.c,168 :: 		IE = 0x80;
	MOV IE+0, #128
;adc_timer_interrupt.c,169 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;adc_timer_interrupt.c,170 :: 		}
	RET
; end of _Interrupts_Init

_ADC_Init:
;adc_timer_interrupt.c,173 :: 		void ADC_Init(void)
;adc_timer_interrupt.c,175 :: 		AMX0P = 0x00;
	MOV AMX0P+0, #0
;adc_timer_interrupt.c,176 :: 		AMX0N = 0x11;
	MOV AMX0N+0, #17
;adc_timer_interrupt.c,177 :: 		ADC0CF = 0x58;
	MOV ADC0CF+0, #88
;adc_timer_interrupt.c,178 :: 		ADC0CN = 0x80;
	MOV ADC0CN+0, #128
;adc_timer_interrupt.c,179 :: 		}
	RET
; end of _ADC_Init

_Voltage_Reference_Init:
;adc_timer_interrupt.c,182 :: 		void Voltage_Reference_Init(void)
;adc_timer_interrupt.c,184 :: 		REF0CN = 0x0A;
	MOV REF0CN+0, #10
;adc_timer_interrupt.c,185 :: 		}
	RET
; end of _Voltage_Reference_Init

_Init_Device:
;adc_timer_interrupt.c,188 :: 		void Init_Device(void)
;adc_timer_interrupt.c,190 :: 		PCA_Init();
	LCALL _PCA_Init+0
;adc_timer_interrupt.c,191 :: 		Timer_Init();
	LCALL _Timer_Init+0
;adc_timer_interrupt.c,192 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;adc_timer_interrupt.c,193 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;adc_timer_interrupt.c,194 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;adc_timer_interrupt.c,195 :: 		ADC_Init();
	LCALL _ADC_Init+0
;adc_timer_interrupt.c,196 :: 		Voltage_Reference_Init();
	LCALL _Voltage_Reference_Init+0
;adc_timer_interrupt.c,197 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;adc_timer_interrupt.c,200 :: 		void write_74HC595(unsigned char send_data)
;adc_timer_interrupt.c,202 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;adc_timer_interrupt.c,204 :: 		while(clks > 0)
L_write_74HC5959:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59510
;adc_timer_interrupt.c,206 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59511
;adc_timer_interrupt.c,208 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;adc_timer_interrupt.c,209 :: 		}
	SJMP L_write_74HC59512
L_write_74HC59511:
;adc_timer_interrupt.c,212 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;adc_timer_interrupt.c,213 :: 		}
L_write_74HC59512:
;adc_timer_interrupt.c,215 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;adc_timer_interrupt.c,216 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59518
L__write_74HC59519:
	CLR C
	RLC A
L__write_74HC59518:
	DJNZ R0, L__write_74HC59519
	MOV FARG_write_74HC595_send_data+0, A
;adc_timer_interrupt.c,217 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;adc_timer_interrupt.c,218 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;adc_timer_interrupt.c,219 :: 		}
	SJMP L_write_74HC5959
L_write_74HC59510:
;adc_timer_interrupt.c,220 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;adc_timer_interrupt.c,223 :: 		void segment_write(unsigned char disp, unsigned char pos, unsigned char point)
;adc_timer_interrupt.c,225 :: 		unsigned char write_value = segment_code[disp];
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
	MOV segment_write_write_value_L0+0, 0
;adc_timer_interrupt.c,227 :: 		if(point)
	MOV A, FARG_segment_write_point+0
	JZ L_segment_write13
;adc_timer_interrupt.c,229 :: 		write_value &= segment_code[10];
	ANL segment_write_write_value_L0+0, #127
;adc_timer_interrupt.c,230 :: 		}
L_segment_write13:
;adc_timer_interrupt.c,232 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;adc_timer_interrupt.c,233 :: 		write_74HC595(write_value);
	MOV FARG_write_74HC595_send_data+0, segment_write_write_value_L0+0
	LCALL _write_74HC595+0
;adc_timer_interrupt.c,234 :: 		write_74HC595(display_pos[pos]);
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
;adc_timer_interrupt.c,235 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;adc_timer_interrupt.c,237 :: 		}
	RET
; end of _segment_write

_adc_read:
;adc_timer_interrupt.c,240 :: 		unsigned int adc_read(void)
;adc_timer_interrupt.c,242 :: 		unsigned int ad_value = 0;
	MOV adc_read_ad_value_L0+0, #0
	MOV adc_read_ad_value_L0+1, #0
;adc_timer_interrupt.c,244 :: 		ad_value = ADC0H;
	MOV adc_read_ad_value_L0+0, AD0INT_bit+0
	CLR A
	MOV adc_read_ad_value_L0+1, A
;adc_timer_interrupt.c,245 :: 		ad_value <<= 8;
	MOV R1, adc_read_ad_value_L0+0
	MOV R0, #0
	MOV adc_read_ad_value_L0+0, 0
	MOV adc_read_ad_value_L0+1, 1
;adc_timer_interrupt.c,246 :: 		ad_value |= ADC0L;
	MOV A, ADC0L+0
	ORL 0, A
	CLR A
	ORL 1, A
	MOV adc_read_ad_value_L0+0, 0
	MOV adc_read_ad_value_L0+1, 1
;adc_timer_interrupt.c,248 :: 		return ad_value;
;adc_timer_interrupt.c,249 :: 		}
	RET
; end of _adc_read

_adc_avg:
;adc_timer_interrupt.c,252 :: 		unsigned int adc_avg(unsigned char channel)
;adc_timer_interrupt.c,254 :: 		unsigned int avg_value = 0;
	MOV adc_avg_avg_value_L0+0, #0
	MOV adc_avg_avg_value_L0+1, #0
	MOV adc_avg_samples_L0+0, #16
;adc_timer_interrupt.c,255 :: 		signed char samples = 16;
;adc_timer_interrupt.c,257 :: 		AMX0P = (channel & 0x1F);
	MOV A, FARG_adc_avg_channel+0
	ANL A, #31
	MOV AMX0P+0, A
;adc_timer_interrupt.c,258 :: 		delay_ms(1);
	MOV R6, 16
	MOV R7, 231
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;adc_timer_interrupt.c,260 :: 		while(samples > 0)
L_adc_avg14:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, adc_avg_samples_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_adc_avg15
;adc_timer_interrupt.c,262 :: 		AD0INT_bit = 0;
	CLR AD0INT_bit+0
;adc_timer_interrupt.c,263 :: 		AD0BUSY_bit = 1;
	SETB AD0BUSY_bit+0
;adc_timer_interrupt.c,265 :: 		while(AD0INT_bit == 0);
L_adc_avg16:
	JB AD0INT_bit+0, L_adc_avg17
	NOP
	SJMP L_adc_avg16
L_adc_avg17:
;adc_timer_interrupt.c,266 :: 		avg_value += adc_read();
	LCALL _adc_read+0
	MOV A, adc_avg_avg_value_L0+0
	ADD A, R0
	MOV adc_avg_avg_value_L0+0, A
	MOV A, adc_avg_avg_value_L0+1
	ADDC A, R1
	MOV adc_avg_avg_value_L0+1, A
;adc_timer_interrupt.c,268 :: 		samples--;
	DEC adc_avg_samples_L0+0
;adc_timer_interrupt.c,269 :: 		};
	SJMP L_adc_avg14
L_adc_avg15:
;adc_timer_interrupt.c,271 :: 		avg_value >>= 4;
	MOV R2, #4
	MOV A, adc_avg_avg_value_L0+1
	MOV R0, adc_avg_avg_value_L0+0
	INC R2
	SJMP L__adc_avg20
L__adc_avg21:
	CLR C
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__adc_avg20:
	DJNZ R2, L__adc_avg21
	MOV R1, A
	MOV adc_avg_avg_value_L0+0, 0
	MOV adc_avg_avg_value_L0+1, 1
;adc_timer_interrupt.c,273 :: 		return avg_value;
;adc_timer_interrupt.c,274 :: 		}
	RET
; end of _adc_avg
