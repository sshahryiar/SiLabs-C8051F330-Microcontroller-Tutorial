
_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;ir_tx.c,58 :: 		ics ICS_AUTO
;ir_tx.c,60 :: 		switch(i)
	SJMP L_Timer_ISR0
;ir_tx.c,62 :: 		case 0:
L_Timer_ISR2:
;ir_tx.c,64 :: 		val = (value / 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;ir_tx.c,65 :: 		break;
	SJMP L_Timer_ISR1
;ir_tx.c,67 :: 		case 1:
L_Timer_ISR3:
;ir_tx.c,69 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;ir_tx.c,70 :: 		break;
	SJMP L_Timer_ISR1
;ir_tx.c,72 :: 		case 2:
L_Timer_ISR4:
;ir_tx.c,74 :: 		val = 10;
	MOV val+0, #10
;ir_tx.c,75 :: 		break;
	SJMP L_Timer_ISR1
;ir_tx.c,77 :: 		case 3:
L_Timer_ISR5:
;ir_tx.c,79 :: 		val = 11;
	MOV val+0, #11
;ir_tx.c,80 :: 		break;
	SJMP L_Timer_ISR1
;ir_tx.c,82 :: 		}
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
;ir_tx.c,84 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;ir_tx.c,86 :: 		i++;
	INC _i+0
;ir_tx.c,88 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;ir_tx.c,90 :: 		i = 0;
	MOV _i+0, #0
;ir_tx.c,91 :: 		}
L_Timer_ISR6:
;ir_tx.c,93 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;ir_tx.c,94 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;ir_tx.c,97 :: 		void main(void)
;ir_tx.c,99 :: 		unsigned int t = 0;
;ir_tx.c,100 :: 		char tmp = 0;
	MOV main_tmp_L0+0, #0
;ir_tx.c,101 :: 		Init_Device();
	LCALL _Init_Device+0
;ir_tx.c,102 :: 		UART1_Init(1200);
	ANL CKCON+0, #252
	ANL CKCON+0, #247
	MOV TH1+0, #43
	LCALL _UART1_Init+0
;ir_tx.c,103 :: 		ADC1_Init_Advanced(_INTERNAL_REF | _RIGHT_ADJUSTMENT);
	MOV FARG_ADC1_Init_Advanced_adv_setting+0, #8
	LCALL _ADC1_Init_Advanced+0
;ir_tx.c,105 :: 		while(1)
L_main7:
;ir_tx.c,107 :: 		t = (ADC1_Get_Sample(16) * VDD_mv);
	MOV FARG_ADC1_Get_Sample_channel+0, #16
	LCALL _ADC1_Get_Sample+0
	LCALL _Word2Double+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #72
	MOV 7, #69
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
;ir_tx.c,108 :: 		t /= 1023.0;
	LCALL _Word2Double+0
	MOV R4, #0
	MOV R5, #192
	MOV R6, #127
	MOV 7, #68
	LCALL _Div_32x32_FP+0
	LCALL _Double2Ints+0
;ir_tx.c,109 :: 		t = (((float)t - 776.0) / 2.86);
	LCALL _Word2Double+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #66
	MOV 7, #68
	LCALL _Sub_32x32_FP+0
	MOV R4, #61
	MOV R5, #10
	MOV R6, #55
	MOV 7, #64
	LCALL _Div_32x32_FP+0
	LCALL _Double2Ints+0
;ir_tx.c,110 :: 		value = t;
	MOV _value+0, 0
	MOV _value+1, 1
;ir_tx.c,111 :: 		tmp = t;
	MOV main_tmp_L0+0, 0
;ir_tx.c,112 :: 		UART1_Write(0xAA);
	MOV FARG_UART1_Write_data_+0, #170
	LCALL _UART1_Write+0
;ir_tx.c,113 :: 		UART1_Write((tmp / 10) + 0x30);
	MOV B+0, #10
	MOV A, main_tmp_L0+0
	DIV AB
	MOV R0, A
	ADD A, #48
	MOV FARG_UART1_Write_data_+0, A
	LCALL _UART1_Write+0
;ir_tx.c,114 :: 		UART1_Write((tmp % 10) + 0x30);
	MOV B+0, #10
	MOV A, main_tmp_L0+0
	DIV AB
	MOV A, B+0
	MOV R0, A
	ADD A, #48
	MOV FARG_UART1_Write_data_+0, A
	LCALL _UART1_Write+0
;ir_tx.c,115 :: 		delay_ms(400);
	MOV R5, 13
	MOV R6, 110
	MOV R7, 199
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ir_tx.c,116 :: 		};
	LJMP L_main7
;ir_tx.c,117 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;ir_tx.c,120 :: 		void PCA_Init(void)
;ir_tx.c,122 :: 		PCA0CN = 0x40;
	MOV PCA0CN+0, #64
;ir_tx.c,123 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;ir_tx.c,124 :: 		PCA0MD = 0x02;
	MOV PCA0MD+0, #2
;ir_tx.c,125 :: 		PCA0CPM1 = 0x46;
	MOV PCA0CPM1+0, #70
;ir_tx.c,126 :: 		PCA0CPH1 = 0x14;
	MOV PCA0CPH1+0, #20
;ir_tx.c,127 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;ir_tx.c,130 :: 		void Timer_Init(void)
;ir_tx.c,132 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;ir_tx.c,133 :: 		TMR3RLL = 0x01;
	MOV TMR3RLL+0, #1
;ir_tx.c,134 :: 		TMR3RLH = 0xFE;
	MOV TMR3RLH+0, #254
;ir_tx.c,135 :: 		}
	RET
; end of _Timer_Init

_UART_Init:
;ir_tx.c,138 :: 		void UART_Init(void)
;ir_tx.c,140 :: 		SCON0 = 0x10;
	MOV SCON0+0, #16
;ir_tx.c,141 :: 		}
	RET
; end of _UART_Init

_ADC_Init:
;ir_tx.c,144 :: 		void ADC_Init(void)
;ir_tx.c,146 :: 		AMX0P = 0x10;
	MOV AMX0P+0, #16
;ir_tx.c,147 :: 		AMX0N = 0x11;
	MOV AMX0N+0, #17
;ir_tx.c,148 :: 		ADC0CF = 0xF0;
	MOV ADC0CF+0, #240
;ir_tx.c,149 :: 		ADC0CN = 0x80;
	MOV ADC0CN+0, #128
;ir_tx.c,150 :: 		}
	RET
; end of _ADC_Init

_Voltage_Reference_Init:
;ir_tx.c,153 :: 		void Voltage_Reference_Init(void)
;ir_tx.c,155 :: 		REF0CN = 0x0F;
	MOV REF0CN+0, #15
;ir_tx.c,156 :: 		}
	RET
; end of _Voltage_Reference_Init

_Port_IO_Init:
;ir_tx.c,159 :: 		void Port_IO_Init(void)
;ir_tx.c,179 :: 		P0MDOUT = 0x12;
	MOV P0MDOUT+0, #18
;ir_tx.c,180 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;ir_tx.c,181 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;ir_tx.c,182 :: 		XBR0 = 0x01;
	MOV XBR0+0, #1
;ir_tx.c,183 :: 		XBR1 = 0x42;
	MOV XBR1+0, #66
;ir_tx.c,184 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;ir_tx.c,187 :: 		void Oscillator_Init(void)
;ir_tx.c,189 :: 		OSCICN = 0x81;
	MOV OSCICN+0, #129
;ir_tx.c,190 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;ir_tx.c,193 :: 		void Interrupts_Init(void)
;ir_tx.c,195 :: 		IE = 0x80;
	MOV IE+0, #128
;ir_tx.c,196 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;ir_tx.c,197 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;ir_tx.c,200 :: 		void Init_Device(void)
;ir_tx.c,202 :: 		PCA_Init();
	LCALL _PCA_Init+0
;ir_tx.c,203 :: 		Timer_Init();
	LCALL _Timer_Init+0
;ir_tx.c,204 :: 		UART_Init();
	LCALL _UART_Init+0
;ir_tx.c,205 :: 		ADC_Init();
	LCALL _ADC_Init+0
;ir_tx.c,206 :: 		Voltage_Reference_Init();
	LCALL _Voltage_Reference_Init+0
;ir_tx.c,207 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;ir_tx.c,208 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;ir_tx.c,209 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;ir_tx.c,210 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;ir_tx.c,213 :: 		void write_74HC595(unsigned char send_data)
;ir_tx.c,215 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;ir_tx.c,217 :: 		while(clks > 0)
L_write_74HC5959:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59510
;ir_tx.c,219 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59511
;ir_tx.c,221 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;ir_tx.c,222 :: 		}
	SJMP L_write_74HC59512
L_write_74HC59511:
;ir_tx.c,225 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;ir_tx.c,226 :: 		}
L_write_74HC59512:
;ir_tx.c,228 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;ir_tx.c,229 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59513
L__write_74HC59514:
	CLR C
	RLC A
L__write_74HC59513:
	DJNZ R0, L__write_74HC59514
	MOV FARG_write_74HC595_send_data+0, A
;ir_tx.c,230 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;ir_tx.c,231 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;ir_tx.c,232 :: 		}
	SJMP L_write_74HC5959
L_write_74HC59510:
;ir_tx.c,233 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;ir_tx.c,236 :: 		void segment_write(unsigned char disp, unsigned char pos)
;ir_tx.c,238 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;ir_tx.c,239 :: 		write_74HC595(segment_code[disp]);
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
;ir_tx.c,240 :: 		write_74HC595(display_pos[pos]);
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
;ir_tx.c,241 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;ir_tx.c,242 :: 		}
	RET
; end of _segment_write
