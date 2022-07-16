
_main:
	MOV SP+0, #128
;gpio_clk_sys.c,6 :: 		void main(void)
;gpio_clk_sys.c,8 :: 		unsigned char i = 0;
	MOV main_i_L0+0, #0
;gpio_clk_sys.c,10 :: 		Init_Device();
	LCALL _Init_Device+0
;gpio_clk_sys.c,12 :: 		P1_0_bit = 1;
	SETB P1_0_bit+0
;gpio_clk_sys.c,13 :: 		P1_1_bit = 0;
	CLR P1_1_bit+0
;gpio_clk_sys.c,15 :: 		while(1)
L_main0:
;gpio_clk_sys.c,17 :: 		if(P1_4_bit == 0)
	JB P1_4_bit+0, L_main2
	NOP
;gpio_clk_sys.c,19 :: 		delay_ms(100);
	MOV R5, 13
	MOV R6, 110
	MOV R7, 199
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;gpio_clk_sys.c,20 :: 		i++;
	INC main_i_L0+0
;gpio_clk_sys.c,21 :: 		}
L_main2:
;gpio_clk_sys.c,23 :: 		switch(i)
	SJMP L_main3
;gpio_clk_sys.c,25 :: 		case 0:
L_main5:
;gpio_clk_sys.c,27 :: 		OSCICN = 0x83;
	MOV OSCICN+0, #131
;gpio_clk_sys.c,28 :: 		break;
	SJMP L_main4
;gpio_clk_sys.c,30 :: 		case 1:
L_main6:
;gpio_clk_sys.c,32 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;gpio_clk_sys.c,33 :: 		break;
	SJMP L_main4
;gpio_clk_sys.c,35 :: 		case 2:
L_main7:
;gpio_clk_sys.c,37 :: 		OSCICN = 0x81;
	MOV OSCICN+0, #129
;gpio_clk_sys.c,38 :: 		break;
	SJMP L_main4
;gpio_clk_sys.c,40 :: 		case 3:
L_main8:
;gpio_clk_sys.c,42 :: 		OSCICN = 0x80;
	MOV OSCICN+0, #128
;gpio_clk_sys.c,43 :: 		break;
	SJMP L_main4
;gpio_clk_sys.c,45 :: 		default:
L_main9:
;gpio_clk_sys.c,47 :: 		i = 0;
	MOV main_i_L0+0, #0
;gpio_clk_sys.c,48 :: 		break;
	SJMP L_main4
;gpio_clk_sys.c,50 :: 		}
L_main3:
	MOV A, main_i_L0+0
	JZ L_main5
	MOV A, main_i_L0+0
	XRL A, #1
	JZ L_main6
	MOV A, main_i_L0+0
	XRL A, #2
	JZ L_main7
	MOV A, main_i_L0+0
	XRL A, #3
	JZ L_main8
	SJMP L_main9
L_main4:
;gpio_clk_sys.c,52 :: 		P1_0_bit ^= 1;
	MOV C, P1_0_bit+0
	CPL C
	MOV P1_0_bit+0, C
;gpio_clk_sys.c,53 :: 		P1_1_bit ^= 1;
	MOV C, P1_1_bit+0
	CPL C
	MOV P1_1_bit+0, C
;gpio_clk_sys.c,54 :: 		delay_ms(100);
	MOV R5, 13
	MOV R6, 110
	MOV R7, 199
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;gpio_clk_sys.c,55 :: 		};
	SJMP L_main0
;gpio_clk_sys.c,56 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;gpio_clk_sys.c,59 :: 		void PCA_Init(void)
;gpio_clk_sys.c,61 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;gpio_clk_sys.c,62 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;gpio_clk_sys.c,63 :: 		}
	RET
; end of _PCA_Init

_Port_IO_Init:
;gpio_clk_sys.c,66 :: 		void Port_IO_Init(void)
;gpio_clk_sys.c,86 :: 		P1MDOUT = 0x03;
	MOV P1MDOUT+0, #3
;gpio_clk_sys.c,87 :: 		P1SKIP = 0x13;
	MOV P1SKIP+0, #19
;gpio_clk_sys.c,88 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;gpio_clk_sys.c,89 :: 		}
	RET
; end of _Port_IO_Init

_Init_Device:
;gpio_clk_sys.c,92 :: 		void Init_Device(void)
;gpio_clk_sys.c,94 :: 		PCA_Init();
	LCALL _PCA_Init+0
;gpio_clk_sys.c,95 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;gpio_clk_sys.c,96 :: 		}
	RET
; end of _Init_Device
