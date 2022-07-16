
_make_word:
;hmc5883l.c,4 :: 		unsigned int make_word(unsigned char HB, unsigned char LB)
;hmc5883l.c,6 :: 		unsigned int val = 0;
	MOV make_word_val_L0+0, #0
	MOV make_word_val_L0+1, #0
;hmc5883l.c,8 :: 		val = HB;
	MOV make_word_val_L0+0, FARG_make_word_HB+0
	CLR A
	MOV make_word_val_L0+1, A
;hmc5883l.c,9 :: 		val <<= 8;
	MOV R1, make_word_val_L0+0
	MOV R0, #0
	MOV make_word_val_L0+0, 0
	MOV make_word_val_L0+1, 1
;hmc5883l.c,10 :: 		val |= LB;
	MOV A, FARG_make_word_LB+0
	ORL 0, A
	CLR A
	ORL 1, A
	MOV make_word_val_L0+0, 0
	MOV make_word_val_L0+1, 1
;hmc5883l.c,12 :: 		return val;
;hmc5883l.c,13 :: 		}
	RET
; end of _make_word

_HMC5883L_init:
;hmc5883l.c,16 :: 		void HMC5883L_init(void)
;hmc5883l.c,18 :: 		SMBus1_Init(20000);
	ANL CKCON+0, #252
	ORL CKCON+0, #8
	MOV TH1+0, #52
	LCALL _SMBus1_Init+0
;hmc5883l.c,19 :: 		HMC5883L_write(Config_Reg_A, 0x70);
	MOV FARG_HMC5883L_write_reg_address+0, #0
	MOV FARG_HMC5883L_write_value+0, #112
	LCALL _HMC5883L_write+0
;hmc5883l.c,20 :: 		HMC5883L_write(Config_Reg_B, 0xA0);
	MOV FARG_HMC5883L_write_reg_address+0, #1
	MOV FARG_HMC5883L_write_value+0, #160
	LCALL _HMC5883L_write+0
;hmc5883l.c,21 :: 		HMC5883L_write(Mode_Reg, 0x00);
	MOV FARG_HMC5883L_write_reg_address+0, #2
	MOV FARG_HMC5883L_write_value+0, #0
	LCALL _HMC5883L_write+0
;hmc5883l.c,22 :: 		HMC5883L_set_scale(1.3);
	MOV FARG_HMC5883L_set_scale_gauss+0, #102
	MOV FARG_HMC5883L_set_scale_gauss+1, #102
	MOV FARG_HMC5883L_set_scale_gauss+2, #166
	MOV FARG_HMC5883L_set_scale_gauss+3, #63
	LCALL _HMC5883L_set_scale+0
;hmc5883l.c,23 :: 		}
	RET
; end of _HMC5883L_init

_HMC5883L_read:
;hmc5883l.c,26 :: 		unsigned char HMC5883L_read(unsigned char reg)
;hmc5883l.c,28 :: 		unsigned char val = 0;
	MOV HMC5883L_read_val_L0+0, #0
;hmc5883l.c,30 :: 		SMBus1_Start();
	LCALL _SMBus1_Start+0
;hmc5883l.c,31 :: 		SMBus1_Write(HMC5883L_WRITE_ADDR);
	MOV FARG_SMBus1_Write_tmp+0, #60
	LCALL _SMBus1_Write+0
;hmc5883l.c,32 :: 		SMBus1_Write(reg);
	MOV FARG_SMBus1_Write_tmp+0, FARG_HMC5883L_read_reg+0
	LCALL _SMBus1_Write+0
;hmc5883l.c,33 :: 		SMBus1_Repeated_Start();
	LCALL _SMBus1_Repeated_Start+0
;hmc5883l.c,34 :: 		SMBus1_Write(HMC5883L_READ_ADDR);
	MOV FARG_SMBus1_Write_tmp+0, #61
	LCALL _SMBus1_Write+0
;hmc5883l.c,35 :: 		val = SMBus1_Read(0);
	MOV FARG_SMBus1_Read_nack_+0, #0
	LCALL _SMBus1_Read+0
	MOV HMC5883L_read_val_L0+0, 0
;hmc5883l.c,36 :: 		SMBus1_Stop();
	LCALL _SMBus1_Stop+0
;hmc5883l.c,38 :: 		return(val);
	MOV R0, HMC5883L_read_val_L0+0
;hmc5883l.c,39 :: 		}
	RET
; end of _HMC5883L_read

_HMC5883L_write:
;hmc5883l.c,42 :: 		void HMC5883L_write(unsigned char reg_address, unsigned char value)
;hmc5883l.c,44 :: 		SMBus1_Start();
	LCALL _SMBus1_Start+0
;hmc5883l.c,45 :: 		SMBus1_Write(HMC5883L_WRITE_ADDR);
	MOV FARG_SMBus1_Write_tmp+0, #60
	LCALL _SMBus1_Write+0
;hmc5883l.c,46 :: 		SMBus1_Write(reg_address);
	MOV FARG_SMBus1_Write_tmp+0, FARG_HMC5883L_write_reg_address+0
	LCALL _SMBus1_Write+0
;hmc5883l.c,47 :: 		SMBus1_Write(value);
	MOV FARG_SMBus1_Write_tmp+0, FARG_HMC5883L_write_value+0
	LCALL _SMBus1_Write+0
;hmc5883l.c,48 :: 		SMBus1_Stop();
	LCALL _SMBus1_Stop+0
;hmc5883l.c,49 :: 		}
	RET
; end of _HMC5883L_write

_HMC5883L_read_data:
;hmc5883l.c,51 :: 		void HMC5883L_read_data(void)
;hmc5883l.c,53 :: 		unsigned char lsb = 0;
;hmc5883l.c,54 :: 		unsigned char msb = 0;
	MOV HMC5883L_read_data_msb_L0+0, #0
;hmc5883l.c,56 :: 		SMBus1_Start();
	LCALL _SMBus1_Start+0
;hmc5883l.c,57 :: 		SMBus1_Write(HMC5883L_WRITE_ADDR);
	MOV FARG_SMBus1_Write_tmp+0, #60
	LCALL _SMBus1_Write+0
;hmc5883l.c,58 :: 		SMBus1_Write(X_MSB_Reg);
	MOV FARG_SMBus1_Write_tmp+0, #3
	LCALL _SMBus1_Write+0
;hmc5883l.c,59 :: 		SMBus1_Repeated_Start();
	LCALL _SMBus1_Repeated_Start+0
;hmc5883l.c,60 :: 		SMBus1_Write(HMC5883L_READ_ADDR);
	MOV FARG_SMBus1_Write_tmp+0, #61
	LCALL _SMBus1_Write+0
;hmc5883l.c,62 :: 		msb = SMBus1_Read(1);
	MOV FARG_SMBus1_Read_nack_+0, #1
	LCALL _SMBus1_Read+0
	MOV HMC5883L_read_data_msb_L0+0, 0
;hmc5883l.c,63 :: 		lsb = SMBus1_Read(1);
	MOV FARG_SMBus1_Read_nack_+0, #1
	LCALL _SMBus1_Read+0
;hmc5883l.c,64 :: 		X_axis = make_word(msb, lsb);
	MOV FARG_make_word_HB+0, HMC5883L_read_data_msb_L0+0
	MOV FARG_make_word_LB+0, 0
	LCALL _make_word+0
	MOV _X_axis+0, 0
	MOV _X_axis+1, 1
;hmc5883l.c,66 :: 		msb = SMBus1_Read(1);
	MOV FARG_SMBus1_Read_nack_+0, #1
	LCALL _SMBus1_Read+0
	MOV HMC5883L_read_data_msb_L0+0, 0
;hmc5883l.c,67 :: 		lsb = SMBus1_Read(1);
	MOV FARG_SMBus1_Read_nack_+0, #1
	LCALL _SMBus1_Read+0
;hmc5883l.c,68 :: 		Z_axis = make_word(msb, lsb);
	MOV FARG_make_word_HB+0, HMC5883L_read_data_msb_L0+0
	MOV FARG_make_word_LB+0, 0
	LCALL _make_word+0
	MOV _Z_axis+0, 0
	MOV _Z_axis+1, 1
;hmc5883l.c,70 :: 		msb = SMBus1_Read(1);
	MOV FARG_SMBus1_Read_nack_+0, #1
	LCALL _SMBus1_Read+0
	MOV HMC5883L_read_data_msb_L0+0, 0
;hmc5883l.c,71 :: 		lsb = SMBus1_Read(0);
	MOV FARG_SMBus1_Read_nack_+0, #0
	LCALL _SMBus1_Read+0
;hmc5883l.c,72 :: 		Y_axis = make_word(msb, lsb);
	MOV FARG_make_word_HB+0, HMC5883L_read_data_msb_L0+0
	MOV FARG_make_word_LB+0, 0
	LCALL _make_word+0
	MOV _Y_axis+0, 0
	MOV _Y_axis+1, 1
;hmc5883l.c,74 :: 		SMBus1_Stop();
	LCALL _SMBus1_Stop+0
;hmc5883l.c,75 :: 		}
	RET
; end of _HMC5883L_read_data

_HMC5883L_scale_axes:
;hmc5883l.c,78 :: 		void HMC5883L_scale_axes(void)
;hmc5883l.c,80 :: 		X_axis *= m_scale;
	MOV R0, _X_axis+0
	MOV R1, _X_axis+1
	LCALL _Int2Double+0
	MOV R4, _m_scale+0
	MOV R5, _m_scale+1
	MOV R6, _m_scale+2
	MOV R7, _m_scale+3
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV _X_axis+0, 0
	MOV _X_axis+1, 1
;hmc5883l.c,81 :: 		Z_axis *= m_scale;
	MOV R0, _Z_axis+0
	MOV R1, _Z_axis+1
	LCALL _Int2Double+0
	MOV R4, _m_scale+0
	MOV R5, _m_scale+1
	MOV R6, _m_scale+2
	MOV R7, _m_scale+3
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV _Z_axis+0, 0
	MOV _Z_axis+1, 1
;hmc5883l.c,82 :: 		Y_Axis *= m_scale;
	MOV R0, _Y_axis+0
	MOV R1, _Y_axis+1
	LCALL _Int2Double+0
	MOV R4, _m_scale+0
	MOV R5, _m_scale+1
	MOV R6, _m_scale+2
	MOV R7, _m_scale+3
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV _Y_axis+0, 0
	MOV _Y_axis+1, 1
;hmc5883l.c,83 :: 		}
	RET
; end of _HMC5883L_scale_axes

_HMC5883L_set_scale:
;hmc5883l.c,86 :: 		void HMC5883L_set_scale(float gauss)
;hmc5883l.c,88 :: 		unsigned char value = 0;
	MOV HMC5883L_set_scale_value_L0+0, #0
;hmc5883l.c,90 :: 		if(gauss == 0.88)
	MOV R4, #174
	MOV R5, #71
	MOV R6, #97
	MOV 7, #63
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale30
	MOV R0, #0
	SJMP L__HMC5883L_set_scale31
L__HMC5883L_set_scale30:
	MOV R0, #1
L__HMC5883L_set_scale31:
	MOV A, R0
	JZ L_HMC5883L_set_scale0
;hmc5883l.c,92 :: 		value = 0x00;
	MOV HMC5883L_set_scale_value_L0+0, #0
;hmc5883l.c,93 :: 		m_scale = 0.73;
	MOV _m_scale+0, #72
	MOV _m_scale+1, #225
	MOV _m_scale+2, #58
	MOV _m_scale+3, #63
;hmc5883l.c,94 :: 		}
	LJMP L_HMC5883L_set_scale1
L_HMC5883L_set_scale0:
;hmc5883l.c,96 :: 		else if(gauss == 1.3)
	MOV R4, #102
	MOV R5, #102
	MOV R6, #166
	MOV 7, #63
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale32
	MOV R0, #0
	SJMP L__HMC5883L_set_scale33
L__HMC5883L_set_scale32:
	MOV R0, #1
L__HMC5883L_set_scale33:
	MOV A, R0
	JZ L_HMC5883L_set_scale2
;hmc5883l.c,98 :: 		value = 0x01;
	MOV HMC5883L_set_scale_value_L0+0, #1
;hmc5883l.c,99 :: 		m_scale = 0.92;
	MOV _m_scale+0, #31
	MOV _m_scale+1, #133
	MOV _m_scale+2, #107
	MOV _m_scale+3, #63
;hmc5883l.c,100 :: 		}
	LJMP L_HMC5883L_set_scale3
L_HMC5883L_set_scale2:
;hmc5883l.c,102 :: 		else if(gauss == 1.9)
	MOV R4, #51
	MOV R5, #51
	MOV R6, #243
	MOV 7, #63
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale34
	MOV R0, #0
	SJMP L__HMC5883L_set_scale35
L__HMC5883L_set_scale34:
	MOV R0, #1
L__HMC5883L_set_scale35:
	MOV A, R0
	JZ L_HMC5883L_set_scale4
;hmc5883l.c,104 :: 		value = 0x02;
	MOV HMC5883L_set_scale_value_L0+0, #2
;hmc5883l.c,105 :: 		m_scale = 1.22;
	MOV _m_scale+0, #246
	MOV _m_scale+1, #40
	MOV _m_scale+2, #156
	MOV _m_scale+3, #63
;hmc5883l.c,106 :: 		}
	LJMP L_HMC5883L_set_scale5
L_HMC5883L_set_scale4:
;hmc5883l.c,108 :: 		else if(gauss == 2.5)
	MOV R4, #0
	MOV R5, #0
	MOV R6, #32
	MOV 7, #64
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale36
	MOV R0, #0
	SJMP L__HMC5883L_set_scale37
L__HMC5883L_set_scale36:
	MOV R0, #1
L__HMC5883L_set_scale37:
	MOV A, R0
	JZ L_HMC5883L_set_scale6
;hmc5883l.c,110 :: 		value = 0x03;
	MOV HMC5883L_set_scale_value_L0+0, #3
;hmc5883l.c,111 :: 		m_scale = 1.52;
	MOV _m_scale+0, #92
	MOV _m_scale+1, #143
	MOV _m_scale+2, #194
	MOV _m_scale+3, #63
;hmc5883l.c,112 :: 		}
	LJMP L_HMC5883L_set_scale7
L_HMC5883L_set_scale6:
;hmc5883l.c,114 :: 		else if(gauss == 4.0)
	MOV R4, #0
	MOV R5, #0
	MOV R6, #128
	MOV 7, #64
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale38
	MOV R0, #0
	SJMP L__HMC5883L_set_scale39
L__HMC5883L_set_scale38:
	MOV R0, #1
L__HMC5883L_set_scale39:
	MOV A, R0
	JZ L_HMC5883L_set_scale8
;hmc5883l.c,116 :: 		value = 0x04;
	MOV HMC5883L_set_scale_value_L0+0, #4
;hmc5883l.c,117 :: 		m_scale = 2.27;
	MOV _m_scale+0, #174
	MOV _m_scale+1, #71
	MOV _m_scale+2, #17
	MOV _m_scale+3, #64
;hmc5883l.c,118 :: 		}
	LJMP L_HMC5883L_set_scale9
L_HMC5883L_set_scale8:
;hmc5883l.c,120 :: 		else if(gauss == 4.7)
	MOV R4, #102
	MOV R5, #102
	MOV R6, #150
	MOV 7, #64
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale40
	MOV R0, #0
	SJMP L__HMC5883L_set_scale41
L__HMC5883L_set_scale40:
	MOV R0, #1
L__HMC5883L_set_scale41:
	MOV A, R0
	JZ L_HMC5883L_set_scale10
;hmc5883l.c,122 :: 		value = 0x05;
	MOV HMC5883L_set_scale_value_L0+0, #5
;hmc5883l.c,123 :: 		m_scale = 2.56;
	MOV _m_scale+0, #10
	MOV _m_scale+1, #215
	MOV _m_scale+2, #35
	MOV _m_scale+3, #64
;hmc5883l.c,124 :: 		}
	SJMP L_HMC5883L_set_scale11
L_HMC5883L_set_scale10:
;hmc5883l.c,126 :: 		else if(gauss == 5.6)
	MOV R4, #51
	MOV R5, #51
	MOV R6, #179
	MOV 7, #64
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale42
	MOV R0, #0
	SJMP L__HMC5883L_set_scale43
L__HMC5883L_set_scale42:
	MOV R0, #1
L__HMC5883L_set_scale43:
	MOV A, R0
	JZ L_HMC5883L_set_scale12
;hmc5883l.c,128 :: 		value = 0x06;
	MOV HMC5883L_set_scale_value_L0+0, #6
;hmc5883l.c,129 :: 		m_scale = 3.03;
	MOV _m_scale+0, #133
	MOV _m_scale+1, #235
	MOV _m_scale+2, #65
	MOV _m_scale+3, #64
;hmc5883l.c,130 :: 		}
	SJMP L_HMC5883L_set_scale13
L_HMC5883L_set_scale12:
;hmc5883l.c,132 :: 		else if(gauss == 8.1)
	MOV R4, #154
	MOV R5, #153
	MOV R6, #1
	MOV 7, #65
	MOV R0, FARG_HMC5883L_set_scale_gauss+0
	MOV R1, FARG_HMC5883L_set_scale_gauss+1
	MOV R2, FARG_HMC5883L_set_scale_gauss+2
	MOV R3, FARG_HMC5883L_set_scale_gauss+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_set_scale44
	MOV R0, #0
	SJMP L__HMC5883L_set_scale45
L__HMC5883L_set_scale44:
	MOV R0, #1
L__HMC5883L_set_scale45:
	MOV A, R0
	JZ L_HMC5883L_set_scale14
;hmc5883l.c,134 :: 		value = 0x07;
	MOV HMC5883L_set_scale_value_L0+0, #7
;hmc5883l.c,135 :: 		m_scale = 4.35;
	MOV _m_scale+0, #51
	MOV _m_scale+1, #51
	MOV _m_scale+2, #139
	MOV _m_scale+3, #64
;hmc5883l.c,136 :: 		}
L_HMC5883L_set_scale14:
L_HMC5883L_set_scale13:
L_HMC5883L_set_scale11:
L_HMC5883L_set_scale9:
L_HMC5883L_set_scale7:
L_HMC5883L_set_scale5:
L_HMC5883L_set_scale3:
L_HMC5883L_set_scale1:
;hmc5883l.c,138 :: 		value <<= 5;
	MOV R1, #5
	MOV A, HMC5883L_set_scale_value_L0+0
	INC R1
	SJMP L__HMC5883L_set_scale46
L__HMC5883L_set_scale47:
	CLR C
	RLC A
L__HMC5883L_set_scale46:
	DJNZ R1, L__HMC5883L_set_scale47
	MOV R0, A
	MOV HMC5883L_set_scale_value_L0+0, 0
;hmc5883l.c,139 :: 		HMC5883L_write(Config_Reg_B, value);
	MOV FARG_HMC5883L_write_reg_address+0, #1
	MOV FARG_HMC5883L_write_value+0, 0
	LCALL _HMC5883L_write+0
;hmc5883l.c,140 :: 		}
	RET
; end of _HMC5883L_set_scale

_HMC5883L_heading:
;hmc5883l.c,143 :: 		float HMC5883L_heading(void)
;hmc5883l.c,145 :: 		float heading = 0.0;
	MOV HMC5883L_heading_heading_L0+0, #0
	MOV HMC5883L_heading_heading_L0+1, #0
	MOV HMC5883L_heading_heading_L0+2, #0
	MOV HMC5883L_heading_heading_L0+3, #0
;hmc5883l.c,147 :: 		HMC5883L_read_data();
	LCALL _HMC5883L_read_data+0
;hmc5883l.c,148 :: 		HMC5883L_scale_axes();
	LCALL _HMC5883L_scale_axes+0
;hmc5883l.c,149 :: 		heading = atan2(Y_axis, X_axis);
	MOV R0, _Y_axis+0
	MOV R1, _Y_axis+1
	LCALL _Int2Double+0
	MOV FARG_atan2_y+0, 0
	MOV FARG_atan2_y+1, 1
	MOV FARG_atan2_y+2, 2
	MOV FARG_atan2_y+3, 3
	MOV R0, _X_axis+0
	MOV R1, _X_axis+1
	LCALL _Int2Double+0
	MOV FARG_atan2_x+0, 0
	MOV FARG_atan2_x+1, 1
	MOV FARG_atan2_x+2, 2
	MOV FARG_atan2_x+3, 3
	LCALL _atan2+0
	MOV HMC5883L_heading_heading_L0+0, 0
	MOV HMC5883L_heading_heading_L0+1, 1
	MOV HMC5883L_heading_heading_L0+2, 2
	MOV HMC5883L_heading_heading_L0+3, 3
;hmc5883l.c,150 :: 		heading += declination_angle;
	MOV R4, #116
	MOV R5, #70
	MOV R6, #4
	MOV 7, #191
	LCALL _Add_32x32_FP+0
	MOV HMC5883L_heading_heading_L0+0, 0
	MOV HMC5883L_heading_heading_L0+1, 1
	MOV HMC5883L_heading_heading_L0+2, 2
	MOV HMC5883L_heading_heading_L0+3, 3
;hmc5883l.c,152 :: 		if(heading < 0.0)
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Compare_Double+0
	JC L__HMC5883L_heading48
	MOV R0, #0
	SJMP L__HMC5883L_heading49
L__HMC5883L_heading48:
	MOV R0, #1
L__HMC5883L_heading49:
	MOV A, R0
	JZ L_HMC5883L_heading15
;hmc5883l.c,154 :: 		heading += (2.0 * PI);
	MOV R0, HMC5883L_heading_heading_L0+0
	MOV R1, HMC5883L_heading_heading_L0+1
	MOV R2, HMC5883L_heading_heading_L0+2
	MOV R3, HMC5883L_heading_heading_L0+3
	MOV R4, #135
	MOV R5, #22
	MOV R6, #201
	MOV 7, #64
	LCALL _Add_32x32_FP+0
	MOV HMC5883L_heading_heading_L0+0, 0
	MOV HMC5883L_heading_heading_L0+1, 1
	MOV HMC5883L_heading_heading_L0+2, 2
	MOV HMC5883L_heading_heading_L0+3, 3
;hmc5883l.c,155 :: 		}
L_HMC5883L_heading15:
;hmc5883l.c,157 :: 		if(heading > (2.0 * PI))
	SETB C
	MOV R4, #135
	MOV R5, #22
	MOV R6, #201
	MOV 7, #64
	MOV R0, HMC5883L_heading_heading_L0+0
	MOV R1, HMC5883L_heading_heading_L0+1
	MOV R2, HMC5883L_heading_heading_L0+2
	MOV R3, HMC5883L_heading_heading_L0+3
	LCALL _Compare_Double+0
	JZ L__HMC5883L_heading50
	JC L__HMC5883L_heading50
	MOV R0, #1
	SJMP L__HMC5883L_heading51
L__HMC5883L_heading50:
	MOV R0, #0
L__HMC5883L_heading51:
	MOV A, R0
	JZ L_HMC5883L_heading16
;hmc5883l.c,159 :: 		heading -= (2.0 * PI);
	MOV R4, #135
	MOV R5, #22
	MOV R6, #201
	MOV 7, #64
	MOV R0, HMC5883L_heading_heading_L0+0
	MOV R1, HMC5883L_heading_heading_L0+1
	MOV R2, HMC5883L_heading_heading_L0+2
	MOV R3, HMC5883L_heading_heading_L0+3
	LCALL _Sub_32x32_FP+0
	MOV HMC5883L_heading_heading_L0+0, 0
	MOV HMC5883L_heading_heading_L0+1, 1
	MOV HMC5883L_heading_heading_L0+2, 2
	MOV HMC5883L_heading_heading_L0+3, 3
;hmc5883l.c,160 :: 		}
L_HMC5883L_heading16:
;hmc5883l.c,162 :: 		heading *= (180.0 / PI);
	MOV R0, HMC5883L_heading_heading_L0+0
	MOV R1, HMC5883L_heading_heading_L0+1
	MOV R2, HMC5883L_heading_heading_L0+2
	MOV R3, HMC5883L_heading_heading_L0+3
	MOV R4, #70
	MOV R5, #39
	MOV R6, #101
	MOV 7, #66
	LCALL _Mul_32x32_FP+0
	MOV HMC5883L_heading_heading_L0+0, 0
	MOV HMC5883L_heading_heading_L0+1, 1
	MOV HMC5883L_heading_heading_L0+2, 2
	MOV HMC5883L_heading_heading_L0+3, 3
;hmc5883l.c,164 :: 		return heading;
;hmc5883l.c,165 :: 		}
	RET
; end of _HMC5883L_heading

_Timer_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;compass.c,55 :: 		ics ICS_AUTO
;compass.c,57 :: 		switch(i)
	SJMP L_Timer_ISR17
;compass.c,59 :: 		case 0:
L_Timer_ISR19:
;compass.c,61 :: 		val = (h / 100);
	MOV R4, #100
	MOV R5, #0
	MOV R0, _h+0
	MOV R1, _h+1
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;compass.c,62 :: 		break;
	SJMP L_Timer_ISR18
;compass.c,64 :: 		case 1:
L_Timer_ISR20:
;compass.c,66 :: 		val = ((h % 100) / 10);
	MOV R4, #100
	MOV R5, #0
	MOV R0, _h+0
	MOV R1, _h+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV _val+0, 0
;compass.c,67 :: 		break;
	SJMP L_Timer_ISR18
;compass.c,69 :: 		case 2:
L_Timer_ISR21:
;compass.c,71 :: 		val = (h % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _h+0
	MOV R1, _h+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV _val+0, 0
;compass.c,72 :: 		break;
	SJMP L_Timer_ISR18
;compass.c,74 :: 		case 3:
L_Timer_ISR22:
;compass.c,76 :: 		val = 12;
	MOV _val+0, #12
;compass.c,77 :: 		break;
	SJMP L_Timer_ISR18
;compass.c,79 :: 		}
L_Timer_ISR17:
	MOV A, _i+0
	JZ L_Timer_ISR19
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_ISR20
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_ISR21
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_ISR22
L_Timer_ISR18:
;compass.c,81 :: 		segment_write(val, i);
	MOV FARG_segment_write_disp+0, _val+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;compass.c,83 :: 		i++;
	INC _i+0
;compass.c,85 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR23
;compass.c,87 :: 		i = 0;
	MOV _i+0, #0
;compass.c,88 :: 		}
L_Timer_ISR23:
;compass.c,90 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;compass.c,91 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;compass.c,94 :: 		void main(void)
;compass.c,96 :: 		Init_Device();
	LCALL _Init_Device+0
;compass.c,98 :: 		while(1)
L_main24:
;compass.c,100 :: 		h = HMC5883L_heading();
	LCALL _HMC5883L_heading+0
	LCALL _Double2Ints+0
	MOV _h+0, 0
	MOV _h+1, 1
;compass.c,101 :: 		delay_ms(200);
	MOV R5, 13
	MOV R6, 110
	MOV R7, 199
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;compass.c,102 :: 		}
	SJMP L_main24
;compass.c,103 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;compass.c,106 :: 		void PCA_Init(void)
;compass.c,108 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;compass.c,109 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;compass.c,110 :: 		}
	RET
; end of _PCA_Init

_SMBus_Init:
;compass.c,113 :: 		void SMBus_Init(void)
;compass.c,115 :: 		SMB0CF = 0x80;
	MOV SMB0CF+0, #128
;compass.c,116 :: 		}
	RET
; end of _SMBus_Init

_Timer_Init:
;compass.c,119 :: 		void Timer_Init(void)
;compass.c,121 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;compass.c,122 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;compass.c,123 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;compass.c,124 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;compass.c,127 :: 		void Port_IO_Init(void)
;compass.c,147 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;compass.c,148 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;compass.c,149 :: 		XBR0 = 0x04;
	MOV XBR0+0, #4
;compass.c,150 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;compass.c,151 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;compass.c,154 :: 		void Oscillator_Init(void)
;compass.c,156 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;compass.c,157 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;compass.c,160 :: 		void Interrupts_Init(void)
;compass.c,162 :: 		IE = 0x80;
	MOV IE+0, #128
;compass.c,163 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;compass.c,164 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;compass.c,167 :: 		void Init_Device(void)
;compass.c,169 :: 		PCA_Init();
	LCALL _PCA_Init+0
;compass.c,170 :: 		SMBus_Init();
	LCALL _SMBus_Init+0
;compass.c,171 :: 		Timer_Init();
	LCALL _Timer_Init+0
;compass.c,172 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;compass.c,173 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;compass.c,174 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;compass.c,175 :: 		HMC5883L_init();
	LCALL _HMC5883L_init+0
;compass.c,176 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;compass.c,179 :: 		void write_74HC595(unsigned char send_data)
;compass.c,181 :: 		signed char clks = 8;
	MOV write_74HC595_clks_L0+0, #8
;compass.c,183 :: 		while(clks > 0)
L_write_74HC59526:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59527
;compass.c,185 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59528
;compass.c,187 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;compass.c,188 :: 		}
	SJMP L_write_74HC59529
L_write_74HC59528:
;compass.c,191 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;compass.c,192 :: 		}
L_write_74HC59529:
;compass.c,194 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;compass.c,195 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59552
L__write_74HC59553:
	CLR C
	RLC A
L__write_74HC59552:
	DJNZ R0, L__write_74HC59553
	MOV FARG_write_74HC595_send_data+0, A
;compass.c,196 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;compass.c,197 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;compass.c,198 :: 		}
	SJMP L_write_74HC59526
L_write_74HC59527:
;compass.c,199 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;compass.c,202 :: 		void segment_write(unsigned char disp, unsigned char pos)
;compass.c,204 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;compass.c,205 :: 		write_74HC595(segment_code[disp]);
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
;compass.c,206 :: 		write_74HC595(display_pos[pos]);
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
;compass.c,207 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;compass.c,209 :: 		}
	RET
; end of _segment_write
