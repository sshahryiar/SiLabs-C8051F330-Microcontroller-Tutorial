
_UART0_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;ir_rx.c,55 :: 		ics ICS_AUTO
;ir_rx.c,57 :: 		rx_buffer[cnt++] = UART_Read();
	MOV A, #_rx_buffer+0
	ADD A, _cnt+0
	MOV R0, A
	MOV FLOC__UART0_ISR+1, 0
	LCALL _UART_Read+0
	MOV FLOC__UART0_ISR+0, 0
	MOV R0, FLOC__UART0_ISR+1
	MOV @R0, FLOC__UART0_ISR+0
	INC _cnt+0
;ir_rx.c,58 :: 		RI0_bit = 0;
	CLR RI0_bit+0
;ir_rx.c,59 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _UART0_ISR

_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;ir_rx.c,65 :: 		ics ICS_AUTO
;ir_rx.c,67 :: 		switch(i)
	SJMP L_Timer_ISR0
;ir_rx.c,69 :: 		case 0:
L_Timer_ISR2:
;ir_rx.c,71 :: 		val = (value / 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV val+0, 0
;ir_rx.c,72 :: 		break;
	SJMP L_Timer_ISR1
;ir_rx.c,74 :: 		case 1:
L_Timer_ISR3:
;ir_rx.c,76 :: 		val = (value % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _value+0
	MOV R1, _value+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV val+0, 0
;ir_rx.c,77 :: 		break;
	SJMP L_Timer_ISR1
;ir_rx.c,79 :: 		case 2:
L_Timer_ISR4:
;ir_rx.c,81 :: 		val = 10;
	MOV val+0, #10
;ir_rx.c,82 :: 		break;
	SJMP L_Timer_ISR1
;ir_rx.c,84 :: 		case 3:
L_Timer_ISR5:
;ir_rx.c,86 :: 		val = 11;
	MOV val+0, #11
;ir_rx.c,87 :: 		break;
	SJMP L_Timer_ISR1
;ir_rx.c,89 :: 		}
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
;ir_rx.c,91 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;ir_rx.c,93 :: 		i++;
	INC _i+0
;ir_rx.c,95 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR6
;ir_rx.c,97 :: 		i = 0;
	MOV _i+0, #0
;ir_rx.c,98 :: 		}
L_Timer_ISR6:
;ir_rx.c,100 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;ir_rx.c,101 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;ir_rx.c,104 :: 		void main(void)
;ir_rx.c,106 :: 		unsigned char tmp = 0x00;
;ir_rx.c,107 :: 		unsigned char temp = 0x00;
;ir_rx.c,109 :: 		Init_Device();
	LCALL _Init_Device+0
;ir_rx.c,110 :: 		UART1_Init(1200);
	ANL CKCON+0, #252
	ANL CKCON+0, #247
	ORL CKCON+0, #2
	MOV TH1+0, #150
	LCALL _UART1_Init+0
;ir_rx.c,112 :: 		while(1)
L_main7:
;ir_rx.c,114 :: 		if(cnt >= 3)
	CLR C
	MOV A, _cnt+0
	SUBB A, #3
	JC L_main9
;ir_rx.c,116 :: 		if(rx_buffer[0] == 0xAA)
	MOV A, _rx_buffer+0
	XRL A, #170
	JNZ L_main10
;ir_rx.c,118 :: 		temp = (rx_buffer[1] - 0x30);
	CLR C
	MOV A, _rx_buffer+1
	SUBB A, #48
	MOV R0, A
;ir_rx.c,119 :: 		tmp = (temp * 10);
	MOV B+0, #10
	MOV A, R0
	MUL AB
	MOV R1, A
;ir_rx.c,120 :: 		temp = (rx_buffer[2] - 0x30);
	CLR C
	MOV A, _rx_buffer+2
	SUBB A, #48
	MOV R0, A
;ir_rx.c,121 :: 		tmp += temp;
	MOV A, R1
	ADD A, R0
	MOV R0, A
;ir_rx.c,123 :: 		value = tmp;
	MOV _value+0, 0
	CLR A
	MOV _value+1, A
;ir_rx.c,124 :: 		}
L_main10:
;ir_rx.c,125 :: 		cnt = 0;
	MOV _cnt+0, #0
;ir_rx.c,126 :: 		}
L_main9:
;ir_rx.c,127 :: 		};
	SJMP L_main7
;ir_rx.c,128 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;ir_rx.c,131 :: 		void PCA_Init(void)
;ir_rx.c,133 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;ir_rx.c,134 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;ir_rx.c,135 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;ir_rx.c,138 :: 		void Timer_Init(void)
;ir_rx.c,140 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;ir_rx.c,141 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;ir_rx.c,142 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;ir_rx.c,143 :: 		}
	RET
; end of _Timer_Init

_UART_Init:
;ir_rx.c,146 :: 		void UART_Init(void)
;ir_rx.c,148 :: 		SCON0 = 0x10;
	MOV SCON0+0, #16
;ir_rx.c,149 :: 		}
	RET
; end of _UART_Init

_Port_IO_Init:
;ir_rx.c,152 :: 		void Port_IO_Init(void)
;ir_rx.c,172 :: 		P0MDOUT = 0x10;
	MOV P0MDOUT+0, #16
;ir_rx.c,173 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;ir_rx.c,174 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;ir_rx.c,175 :: 		XBR0 = 0x01;
	MOV XBR0+0, #1
;ir_rx.c,176 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;ir_rx.c,177 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;ir_rx.c,180 :: 		void Oscillator_Init(void)
;ir_rx.c,182 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;ir_rx.c,183 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;ir_rx.c,186 :: 		void Interrupts_Init(void)
;ir_rx.c,188 :: 		IE = 0x90;
	MOV IE+0, #144
;ir_rx.c,189 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;ir_rx.c,190 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;ir_rx.c,193 :: 		void Init_Device(void)
;ir_rx.c,195 :: 		PCA_Init();
	LCALL _PCA_Init+0
;ir_rx.c,196 :: 		Timer_Init();
	LCALL _Timer_Init+0
;ir_rx.c,197 :: 		UART_Init();
	LCALL _UART_Init+0
;ir_rx.c,198 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;ir_rx.c,199 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;ir_rx.c,200 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;ir_rx.c,201 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;ir_rx.c,204 :: 		void write_74HC595(unsigned char send_data)
;ir_rx.c,206 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;ir_rx.c,208 :: 		while(clks > 0)
L_write_74HC59511:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59512
;ir_rx.c,210 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59513
;ir_rx.c,212 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;ir_rx.c,213 :: 		}
	SJMP L_write_74HC59514
L_write_74HC59513:
;ir_rx.c,216 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;ir_rx.c,217 :: 		}
L_write_74HC59514:
;ir_rx.c,219 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;ir_rx.c,220 :: 		send_data <<= 1;
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
;ir_rx.c,221 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;ir_rx.c,222 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;ir_rx.c,223 :: 		}
	SJMP L_write_74HC59511
L_write_74HC59512:
;ir_rx.c,224 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;ir_rx.c,227 :: 		void segment_write(unsigned char disp, unsigned char pos)
;ir_rx.c,229 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;ir_rx.c,230 :: 		write_74HC595(segment_code[disp]);
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
;ir_rx.c,231 :: 		write_74HC595(display_pos[pos]);
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
;ir_rx.c,232 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;ir_rx.c,233 :: 		}
	RET
; end of _segment_write
