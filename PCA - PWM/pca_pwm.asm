
_main:
	MOV SP+0, #128
;pca_pwm.c,122 :: 		void main(void)
;pca_pwm.c,124 :: 		unsigned int i = 0;
	MOV main_i_L0+0, #0
	MOV main_i_L0+1, #0
	MOV main_j_L0+0, #0
	MOV main_mode_L0+0, #1
;pca_pwm.c,125 :: 		unsigned char j = 0;
;pca_pwm.c,126 :: 		unsigned char mode = 1;
;pca_pwm.c,128 :: 		Init_Device();
	LCALL _Init_Device+0
;pca_pwm.c,130 :: 		while(1)
L_main0:
;pca_pwm.c,132 :: 		switch(mode)
	LJMP L_main2
;pca_pwm.c,134 :: 		case 1:
L_main4:
;pca_pwm.c,136 :: 		PWM_1_duty_cycle(0);
	MOV FARG_PWM_1_duty_cycle_value+0, #0
	MOV FARG_PWM_1_duty_cycle_value+1, #0
	LCALL _PWM_1_duty_cycle+0
;pca_pwm.c,137 :: 		PWM_2_duty_cycle(0);
	MOV FARG_PWM_2_duty_cycle_value+0, #0
	MOV FARG_PWM_2_duty_cycle_value+1, #0
	LCALL _PWM_2_duty_cycle+0
;pca_pwm.c,139 :: 		for(j = 0; j < 6; j++)
	MOV main_j_L0+0, #0
L_main5:
	CLR C
	MOV A, main_j_L0+0
	SUBB A, #6
	JNC L_main6
;pca_pwm.c,141 :: 		for(i = 0; i < 32; i++)
	MOV main_i_L0+0, #0
	MOV main_i_L0+1, #0
L_main8:
	CLR C
	MOV A, main_i_L0+0
	SUBB A, #32
	MOV A, main_i_L0+1
	SUBB A, #0
	JNC L_main9
;pca_pwm.c,143 :: 		PWM_0_duty_cycle(LUT_1[i]);
	MOV R2, #1
	MOV R1, main_i_L0+1
	MOV A, main_i_L0+0
	INC R2
	SJMP L__main33
L__main34:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main33:
	DJNZ R2, L__main34
	MOV R0, A
	MOV A, #_LUT_1+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_1+0)
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
	MOV FARG_PWM_0_duty_cycle_value+0, 0
	MOV FARG_PWM_0_duty_cycle_value+1, 1
	LCALL _PWM_0_duty_cycle+0
;pca_pwm.c,144 :: 		delay_ms(45);
	MOV R5, 3
	MOV R6, 204
	MOV R7, 229
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;pca_pwm.c,141 :: 		for(i = 0; i < 32; i++)
	MOV A, #1
	ADD A, main_i_L0+0
	MOV main_i_L0+0, A
	MOV A, #0
	ADDC A, main_i_L0+1
	MOV main_i_L0+1, A
;pca_pwm.c,145 :: 		}
	SJMP L_main8
L_main9:
;pca_pwm.c,139 :: 		for(j = 0; j < 6; j++)
	INC main_j_L0+0
;pca_pwm.c,146 :: 		}
	SJMP L_main5
L_main6:
;pca_pwm.c,147 :: 		break;
	LJMP L_main3
;pca_pwm.c,150 :: 		case 2:
L_main11:
;pca_pwm.c,152 :: 		PWM_0_duty_cycle(0);
	MOV FARG_PWM_0_duty_cycle_value+0, #0
	MOV FARG_PWM_0_duty_cycle_value+1, #0
	LCALL _PWM_0_duty_cycle+0
;pca_pwm.c,153 :: 		PWM_2_duty_cycle(0);
	MOV FARG_PWM_2_duty_cycle_value+0, #0
	MOV FARG_PWM_2_duty_cycle_value+1, #0
	LCALL _PWM_2_duty_cycle+0
;pca_pwm.c,155 :: 		for(j = 0; j < 6; j++)
	MOV main_j_L0+0, #0
L_main12:
	CLR C
	MOV A, main_j_L0+0
	SUBB A, #6
	JNC L_main13
;pca_pwm.c,157 :: 		for(i = 0; i < 32; i++)
	MOV main_i_L0+0, #0
	MOV main_i_L0+1, #0
L_main15:
	CLR C
	MOV A, main_i_L0+0
	SUBB A, #32
	MOV A, main_i_L0+1
	SUBB A, #0
	JNC L_main16
;pca_pwm.c,159 :: 		PWM_1_duty_cycle(LUT_1[i]);
	MOV R2, #1
	MOV R1, main_i_L0+1
	MOV A, main_i_L0+0
	INC R2
	SJMP L__main35
L__main36:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main35:
	DJNZ R2, L__main36
	MOV R0, A
	MOV A, #_LUT_1+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_1+0)
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
	MOV FARG_PWM_1_duty_cycle_value+0, 0
	MOV FARG_PWM_1_duty_cycle_value+1, 1
	LCALL _PWM_1_duty_cycle+0
;pca_pwm.c,160 :: 		delay_ms(45);
	MOV R5, 3
	MOV R6, 204
	MOV R7, 229
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;pca_pwm.c,157 :: 		for(i = 0; i < 32; i++)
	MOV A, #1
	ADD A, main_i_L0+0
	MOV main_i_L0+0, A
	MOV A, #0
	ADDC A, main_i_L0+1
	MOV main_i_L0+1, A
;pca_pwm.c,161 :: 		}
	SJMP L_main15
L_main16:
;pca_pwm.c,155 :: 		for(j = 0; j < 6; j++)
	INC main_j_L0+0
;pca_pwm.c,162 :: 		}
	SJMP L_main12
L_main13:
;pca_pwm.c,163 :: 		break;
	LJMP L_main3
;pca_pwm.c,166 :: 		case 3:
L_main18:
;pca_pwm.c,168 :: 		PWM_0_duty_cycle(0);
	MOV FARG_PWM_0_duty_cycle_value+0, #0
	MOV FARG_PWM_0_duty_cycle_value+1, #0
	LCALL _PWM_0_duty_cycle+0
;pca_pwm.c,169 :: 		PWM_1_duty_cycle(0);
	MOV FARG_PWM_1_duty_cycle_value+0, #0
	MOV FARG_PWM_1_duty_cycle_value+1, #0
	LCALL _PWM_1_duty_cycle+0
;pca_pwm.c,171 :: 		for(j = 0; j < 6; j++)
	MOV main_j_L0+0, #0
L_main19:
	CLR C
	MOV A, main_j_L0+0
	SUBB A, #6
	JNC L_main20
;pca_pwm.c,173 :: 		for(i = 0; i < 32; i++)
	MOV main_i_L0+0, #0
	MOV main_i_L0+1, #0
L_main22:
	CLR C
	MOV A, main_i_L0+0
	SUBB A, #32
	MOV A, main_i_L0+1
	SUBB A, #0
	JNC L_main23
;pca_pwm.c,175 :: 		PWM_2_duty_cycle(LUT_1[i]);
	MOV R2, #1
	MOV R1, main_i_L0+1
	MOV A, main_i_L0+0
	INC R2
	SJMP L__main37
L__main38:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main37:
	DJNZ R2, L__main38
	MOV R0, A
	MOV A, #_LUT_1+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_1+0)
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
	MOV FARG_PWM_2_duty_cycle_value+0, 0
	MOV FARG_PWM_2_duty_cycle_value+1, 1
	LCALL _PWM_2_duty_cycle+0
;pca_pwm.c,176 :: 		delay_ms(45);
	MOV R5, 3
	MOV R6, 204
	MOV R7, 229
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;pca_pwm.c,173 :: 		for(i = 0; i < 32; i++)
	MOV A, #1
	ADD A, main_i_L0+0
	MOV main_i_L0+0, A
	MOV A, #0
	ADDC A, main_i_L0+1
	MOV main_i_L0+1, A
;pca_pwm.c,177 :: 		}
	SJMP L_main22
L_main23:
;pca_pwm.c,171 :: 		for(j = 0; j < 6; j++)
	INC main_j_L0+0
;pca_pwm.c,178 :: 		}
	SJMP L_main19
L_main20:
;pca_pwm.c,179 :: 		break;
	LJMP L_main3
;pca_pwm.c,182 :: 		default:
L_main25:
;pca_pwm.c,184 :: 		for(j = 0; j < 10; j++)
	MOV main_j_L0+0, #0
L_main26:
	CLR C
	MOV A, main_j_L0+0
	SUBB A, #10
	JC #3
	LJMP L_main27
;pca_pwm.c,186 :: 		for(i = 0; i < 32; i++)
	MOV main_i_L0+0, #0
	MOV main_i_L0+1, #0
L_main29:
	CLR C
	MOV A, main_i_L0+0
	SUBB A, #32
	MOV A, main_i_L0+1
	SUBB A, #0
	JC #3
	LJMP L_main30
;pca_pwm.c,188 :: 		PWM_0_duty_cycle(LUT_1[i]);
	MOV R2, #1
	MOV R1, main_i_L0+1
	MOV A, main_i_L0+0
	INC R2
	SJMP L__main39
L__main40:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main39:
	DJNZ R2, L__main40
	MOV R0, A
	MOV A, #_LUT_1+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_1+0)
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
	MOV FARG_PWM_0_duty_cycle_value+0, 0
	MOV FARG_PWM_0_duty_cycle_value+1, 1
	LCALL _PWM_0_duty_cycle+0
;pca_pwm.c,189 :: 		PWM_1_duty_cycle(LUT_2[i]);
	MOV R2, #1
	MOV R1, main_i_L0+1
	MOV A, main_i_L0+0
	INC R2
	SJMP L__main41
L__main42:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main41:
	DJNZ R2, L__main42
	MOV R0, A
	MOV A, #_LUT_2+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_2+0)
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
	MOV FARG_PWM_1_duty_cycle_value+0, 0
	MOV FARG_PWM_1_duty_cycle_value+1, 1
	LCALL _PWM_1_duty_cycle+0
;pca_pwm.c,190 :: 		PWM_2_duty_cycle(LUT_3[i]);
	MOV R2, #1
	MOV R1, main_i_L0+1
	MOV A, main_i_L0+0
	INC R2
	SJMP L__main43
L__main44:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__main43:
	DJNZ R2, L__main44
	MOV R0, A
	MOV A, #_LUT_3+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_LUT_3+0)
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
	MOV FARG_PWM_2_duty_cycle_value+0, 0
	MOV FARG_PWM_2_duty_cycle_value+1, 1
	LCALL _PWM_2_duty_cycle+0
;pca_pwm.c,191 :: 		delay_ms(200);
	MOV R5, 13
	MOV R6, 110
	MOV R7, 199
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;pca_pwm.c,186 :: 		for(i = 0; i < 32; i++)
	MOV A, #1
	ADD A, main_i_L0+0
	MOV main_i_L0+0, A
	MOV A, #0
	ADDC A, main_i_L0+1
	MOV main_i_L0+1, A
;pca_pwm.c,192 :: 		}
	LJMP L_main29
L_main30:
;pca_pwm.c,184 :: 		for(j = 0; j < 10; j++)
	INC main_j_L0+0
;pca_pwm.c,193 :: 		}
	LJMP L_main26
L_main27:
;pca_pwm.c,194 :: 		break;
	SJMP L_main3
;pca_pwm.c,196 :: 		}
L_main2:
	MOV A, main_mode_L0+0
	XRL A, #1
	JNZ #3
	LJMP L_main4
	MOV A, main_mode_L0+0
	XRL A, #2
	JNZ #3
	LJMP L_main11
	MOV A, main_mode_L0+0
	XRL A, #3
	JNZ #3
	LJMP L_main18
	LJMP L_main25
L_main3:
;pca_pwm.c,198 :: 		mode++;
	INC main_mode_L0+0
;pca_pwm.c,199 :: 		if(mode > 3)
	SETB C
	MOV A, main_mode_L0+0
	SUBB A, #3
	JC L_main32
;pca_pwm.c,201 :: 		mode  = 0;
	MOV main_mode_L0+0, #0
;pca_pwm.c,202 :: 		}
L_main32:
;pca_pwm.c,203 :: 		};
	LJMP L_main0
;pca_pwm.c,204 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;pca_pwm.c,207 :: 		void PCA_Init(void)
;pca_pwm.c,209 :: 		PCA0CN = 0x40;
	MOV PCA0CN+0, #64
;pca_pwm.c,210 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;pca_pwm.c,211 :: 		PCA0MD = 0x02;
	MOV PCA0MD+0, #2
;pca_pwm.c,212 :: 		PCA0CPM0 = 0xC2;
	MOV PCA0CPM0+0, #194
;pca_pwm.c,213 :: 		PCA0CPM1 = 0xC2;
	MOV PCA0CPM1+0, #194
;pca_pwm.c,214 :: 		PCA0CPM2 = 0xC2;
	MOV PCA0CPM2+0, #194
;pca_pwm.c,215 :: 		PCA0L = 0xC0;
	MOV PCA0L+0, #192
;pca_pwm.c,216 :: 		PCA0H = 0x4F;
	MOV PCA0H+0, #79
;pca_pwm.c,217 :: 		PCA0CPL0 = 0xFF;
	MOV PCA0CPL0+0, #255
;pca_pwm.c,218 :: 		PCA0CPL1 = 0xFF;
	MOV PCA0CPL1+0, #255
;pca_pwm.c,219 :: 		PCA0CPL2 = 0xFF;
	MOV PCA0CPL2+0, #255
;pca_pwm.c,220 :: 		PCA0CPH0 = 0xFF;
	MOV PCA0CPH0+0, #255
;pca_pwm.c,221 :: 		PCA0CPH1 = 0xFF;
	MOV PCA0CPH1+0, #255
;pca_pwm.c,222 :: 		PCA0CPH2 = 0xFF;
	MOV PCA0CPH2+0, #255
;pca_pwm.c,223 :: 		}
	RET
; end of _PCA_Init

_Port_IO_Init:
;pca_pwm.c,226 :: 		void Port_IO_Init(void)
;pca_pwm.c,246 :: 		P0MDOUT = 0x07;
	MOV P0MDOUT+0, #7
;pca_pwm.c,247 :: 		XBR1 = 0x43;
	MOV XBR1+0, #67
;pca_pwm.c,248 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;pca_pwm.c,251 :: 		void Oscillator_Init(void)
;pca_pwm.c,253 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;pca_pwm.c,254 :: 		}
	RET
; end of _Oscillator_Init

_Init_Device:
;pca_pwm.c,257 :: 		void Init_Device(void)
;pca_pwm.c,259 :: 		PCA_Init();
	LCALL _PCA_Init+0
;pca_pwm.c,260 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;pca_pwm.c,261 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;pca_pwm.c,262 :: 		}
	RET
; end of _Init_Device

_get_HB_LB:
;pca_pwm.c,265 :: 		void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB)
;pca_pwm.c,267 :: 		*LB = (unsigned char)(value & 0x00FF);
	MOV A, #255
	ANL A, FARG_get_HB_LB_value+0
	MOV R1, A
	MOV R0, FARG_get_HB_LB_LB+0
	MOV @R0, 1
;pca_pwm.c,268 :: 		*HB = (unsigned char)((value & 0xFF00) >> 0x08);
	MOV A, FARG_get_HB_LB_value+0
	ANL A, #0
	MOV R0, A
	MOV A, FARG_get_HB_LB_value+1
	ANL A, #255
	MOV R1, A
	MOV R2, 1
	MOV R3, #0
	MOV R0, FARG_get_HB_LB_HB+0
	MOV @R0, 2
;pca_pwm.c,269 :: 		}
	RET
; end of _get_HB_LB

_PWM_0_duty_cycle:
;pca_pwm.c,273 :: 		void PWM_0_duty_cycle(unsigned int value)
;pca_pwm.c,275 :: 		unsigned char hb = 0x00;
	MOV PWM_0_duty_cycle_hb_L0+0, #0
	MOV PWM_0_duty_cycle_lb_L0+0, #0
;pca_pwm.c,276 :: 		unsigned char lb = 0x00;
;pca_pwm.c,278 :: 		get_HB_LB(value, &hb, &lb);
	MOV FARG_get_HB_LB_value+0, FARG_PWM_0_duty_cycle_value+0
	MOV FARG_get_HB_LB_value+1, FARG_PWM_0_duty_cycle_value+1
	MOV FARG_get_HB_LB_HB+0, #PWM_0_duty_cycle_hb_L0+0
	MOV FARG_get_HB_LB_LB+0, #PWM_0_duty_cycle_lb_L0+0
	LCALL _get_HB_LB+0
;pca_pwm.c,280 :: 		PCA0CPL0 = lb;
	MOV PCA0CPL0+0, PWM_0_duty_cycle_lb_L0+0
;pca_pwm.c,281 :: 		PCA0CPH0 = hb;
	MOV PCA0CPH0+0, PWM_0_duty_cycle_hb_L0+0
;pca_pwm.c,282 :: 		CCF0_bit = 0;
	CLR CCF0_bit+0
;pca_pwm.c,283 :: 		}
	RET
; end of _PWM_0_duty_cycle

_PWM_1_duty_cycle:
;pca_pwm.c,286 :: 		void PWM_1_duty_cycle(unsigned int value)
;pca_pwm.c,288 :: 		unsigned char hb = 0x00;
	MOV PWM_1_duty_cycle_hb_L0+0, #0
	MOV PWM_1_duty_cycle_lb_L0+0, #0
;pca_pwm.c,289 :: 		unsigned char lb = 0x00;
;pca_pwm.c,291 :: 		get_HB_LB(value, &hb, &lb);
	MOV FARG_get_HB_LB_value+0, FARG_PWM_1_duty_cycle_value+0
	MOV FARG_get_HB_LB_value+1, FARG_PWM_1_duty_cycle_value+1
	MOV FARG_get_HB_LB_HB+0, #PWM_1_duty_cycle_hb_L0+0
	MOV FARG_get_HB_LB_LB+0, #PWM_1_duty_cycle_lb_L0+0
	LCALL _get_HB_LB+0
;pca_pwm.c,293 :: 		PCA0CPL1 = lb;
	MOV PCA0CPL1+0, PWM_1_duty_cycle_lb_L0+0
;pca_pwm.c,294 :: 		PCA0CPH1 = hb;
	MOV PCA0CPH1+0, PWM_1_duty_cycle_hb_L0+0
;pca_pwm.c,295 :: 		CCF1_bit = 0;
	CLR CCF1_bit+0
;pca_pwm.c,296 :: 		}
	RET
; end of _PWM_1_duty_cycle

_PWM_2_duty_cycle:
;pca_pwm.c,299 :: 		void PWM_2_duty_cycle(unsigned int value)
;pca_pwm.c,301 :: 		unsigned char hb = 0x00;
	MOV PWM_2_duty_cycle_hb_L0+0, #0
	MOV PWM_2_duty_cycle_lb_L0+0, #0
;pca_pwm.c,302 :: 		unsigned char lb = 0x00;
;pca_pwm.c,304 :: 		get_HB_LB(value, &hb, &lb);
	MOV FARG_get_HB_LB_value+0, FARG_PWM_2_duty_cycle_value+0
	MOV FARG_get_HB_LB_value+1, FARG_PWM_2_duty_cycle_value+1
	MOV FARG_get_HB_LB_HB+0, #PWM_2_duty_cycle_hb_L0+0
	MOV FARG_get_HB_LB_LB+0, #PWM_2_duty_cycle_lb_L0+0
	LCALL _get_HB_LB+0
;pca_pwm.c,306 :: 		PCA0CPL2 = lb;
	MOV PCA0CPL2+0, PWM_2_duty_cycle_lb_L0+0
;pca_pwm.c,307 :: 		PCA0CPH2 = hb;
	MOV PCA0CPH2+0, PWM_2_duty_cycle_hb_L0+0
;pca_pwm.c,308 :: 		CCF2_bit = 0;
	CLR CCF2_bit+0
;pca_pwm.c,309 :: 		}
	RET
; end of _PWM_2_duty_cycle
