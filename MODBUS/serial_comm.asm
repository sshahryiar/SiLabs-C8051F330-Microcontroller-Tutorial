
_make_word:
;tof200.c,4 :: 		unsigned int make_word(unsigned char HB, unsigned char LB)
;tof200.c,6 :: 		unsigned int tmp = 0;
	MOV make_word_tmp_L0+0, #0
	MOV make_word_tmp_L0+1, #0
;tof200.c,8 :: 		tmp = HB;
	MOV make_word_tmp_L0+0, FARG_make_word_HB+0
	CLR A
	MOV make_word_tmp_L0+1, A
;tof200.c,9 :: 		tmp <<= 8;
	MOV R1, make_word_tmp_L0+0
	MOV R0, #0
	MOV make_word_tmp_L0+0, 0
	MOV make_word_tmp_L0+1, 1
;tof200.c,10 :: 		tmp |= LB;
	MOV A, FARG_make_word_LB+0
	ORL 0, A
	CLR A
	ORL 1, A
	MOV make_word_tmp_L0+0, 0
	MOV make_word_tmp_L0+1, 1
;tof200.c,12 :: 		return tmp;
;tof200.c,13 :: 		}
	RET
; end of _make_word

_get_HB_LB:
;tof200.c,16 :: 		void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB)
;tof200.c,18 :: 		*LB = (unsigned char)(value & 0x00FF);
	MOV A, #255
	ANL A, FARG_get_HB_LB_value+0
	MOV R1, A
	MOV R0, FARG_get_HB_LB_LB+0
	MOV @R0, 1
;tof200.c,19 :: 		*HB = (unsigned char)((value & 0xFF00) >> 8);
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
;tof200.c,20 :: 		}
	RET
; end of _get_HB_LB

_MODBUS_RTU_CRC16:
;tof200.c,23 :: 		unsigned int MODBUS_RTU_CRC16(unsigned char *data_input, unsigned char data_length)
;tof200.c,25 :: 		unsigned char n = 8;
	MOV MODBUS_RTU_CRC16_n_L0+0, #8
	MOV MODBUS_RTU_CRC16_s_L0+0, #0
	MOV MODBUS_RTU_CRC16_CRC_word_L0+0, #255
	MOV MODBUS_RTU_CRC16_CRC_word_L0+1, #255
;tof200.c,26 :: 		unsigned char s = 0;
;tof200.c,27 :: 		unsigned int CRC_word = 0xFFFF;
;tof200.c,29 :: 		for(s = 0; s < data_length; s++)
	MOV MODBUS_RTU_CRC16_s_L0+0, #0
L_MODBUS_RTU_CRC160:
	CLR C
	MOV A, MODBUS_RTU_CRC16_s_L0+0
	SUBB A, FARG_MODBUS_RTU_CRC16_data_length+0
	JNC L_MODBUS_RTU_CRC161
;tof200.c,31 :: 		CRC_word ^= ((unsigned int)data_input[s]);
	MOV A, FARG_MODBUS_RTU_CRC16_data_input+0
	ADD A, MODBUS_RTU_CRC16_s_L0+0
	MOV R0, A
	MOV 0, @R0
	CLR A
	MOV R1, A
	MOV A, R0
	XRL MODBUS_RTU_CRC16_CRC_word_L0+0, A
	MOV A, R1
	XRL MODBUS_RTU_CRC16_CRC_word_L0+1, A
;tof200.c,33 :: 		n = 8;
	MOV MODBUS_RTU_CRC16_n_L0+0, #8
;tof200.c,34 :: 		while(n > 0)
L_MODBUS_RTU_CRC163:
	SETB C
	MOV A, MODBUS_RTU_CRC16_n_L0+0
	SUBB A, #0
	JC L_MODBUS_RTU_CRC164
;tof200.c,36 :: 		if((CRC_word & 0x0001) == 0)
	MOV A, #1
	ANL A, MODBUS_RTU_CRC16_CRC_word_L0+0
	MOV R1, A
	MOV A, #0
	ANL A, MODBUS_RTU_CRC16_CRC_word_L0+1
	MOV R2, A
	MOV A, R1
	ORL A, R2
	JNZ L_MODBUS_RTU_CRC165
;tof200.c,38 :: 		CRC_word >>= 1;
	MOV R0, #1
	MOV A, MODBUS_RTU_CRC16_CRC_word_L0+1
	INC R0
	SJMP L__MODBUS_RTU_CRC1633
L__MODBUS_RTU_CRC1634:
	CLR C
	RRC A
	XCH A, MODBUS_RTU_CRC16_CRC_word_L0+0
	RRC A
	XCH A, MODBUS_RTU_CRC16_CRC_word_L0+0
L__MODBUS_RTU_CRC1633:
	DJNZ R0, L__MODBUS_RTU_CRC1634
	MOV MODBUS_RTU_CRC16_CRC_word_L0+1, A
;tof200.c,39 :: 		}
	SJMP L_MODBUS_RTU_CRC166
L_MODBUS_RTU_CRC165:
;tof200.c,43 :: 		CRC_word >>= 1;
	MOV R0, #1
	MOV A, MODBUS_RTU_CRC16_CRC_word_L0+1
	INC R0
	SJMP L__MODBUS_RTU_CRC1635
L__MODBUS_RTU_CRC1636:
	CLR C
	RRC A
	XCH A, MODBUS_RTU_CRC16_CRC_word_L0+0
	RRC A
	XCH A, MODBUS_RTU_CRC16_CRC_word_L0+0
L__MODBUS_RTU_CRC1635:
	DJNZ R0, L__MODBUS_RTU_CRC1636
	MOV MODBUS_RTU_CRC16_CRC_word_L0+1, A
;tof200.c,44 :: 		CRC_word ^= 0xA001;
	XRL MODBUS_RTU_CRC16_CRC_word_L0+0, #1
	XRL MODBUS_RTU_CRC16_CRC_word_L0+1, #160
;tof200.c,45 :: 		}
L_MODBUS_RTU_CRC166:
;tof200.c,47 :: 		n--;
	DEC MODBUS_RTU_CRC16_n_L0+0
;tof200.c,48 :: 		}
	SJMP L_MODBUS_RTU_CRC163
L_MODBUS_RTU_CRC164:
;tof200.c,29 :: 		for(s = 0; s < data_length; s++)
	INC MODBUS_RTU_CRC16_s_L0+0
;tof200.c,49 :: 		}
	LJMP L_MODBUS_RTU_CRC160
L_MODBUS_RTU_CRC161:
;tof200.c,51 :: 		return CRC_word;
	MOV R0, MODBUS_RTU_CRC16_CRC_word_L0+0
	MOV R1, MODBUS_RTU_CRC16_CRC_word_L0+1
;tof200.c,52 :: 		}
	RET
; end of _MODBUS_RTU_CRC16

_flush_RX_buffer:
;tof200.c,55 :: 		void flush_RX_buffer(void)
;tof200.c,57 :: 		signed char s = (ToF200_TX_data_packet_size - 1);
	MOV flush_RX_buffer_s_L0+0, #7
;tof200.c,59 :: 		while(s > -1)
L_flush_RX_buffer7:
	SETB C
	MOV A, #255
	XRL A, #128
	MOV R0, A
	MOV A, flush_RX_buffer_s_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_flush_RX_buffer8
;tof200.c,61 :: 		rx_buffer[s] = 0x00;
	MOV A, #_rx_buffer+0
	ADD A, flush_RX_buffer_s_L0+0
	MOV R0, A
	MOV @R0, #0
;tof200.c,62 :: 		s--;
	DEC flush_RX_buffer_s_L0+0
;tof200.c,63 :: 		};
	SJMP L_flush_RX_buffer7
L_flush_RX_buffer8:
;tof200.c,64 :: 		}
	RET
; end of _flush_RX_buffer

_MODBUS_TX:
;tof200.c,67 :: 		void MODBUS_TX(unsigned char slave_ID, unsigned char function_code, unsigned char reg, unsigned char value)
;tof200.c,69 :: 		unsigned char i  = 0x00;
	MOV MODBUS_TX_i_L0+0, #0
	MOV MODBUS_TX_lb_L0+0, #0
	MOV MODBUS_TX_hb_L0+0, #0
;tof200.c,70 :: 		unsigned char lb = 0x00;
;tof200.c,71 :: 		unsigned char hb = 0x00;
;tof200.c,72 :: 		unsigned int temp = 0x0000;
;tof200.c,76 :: 		tx_buffer[0x00] = slave_ID;
	MOV MODBUS_TX_tx_buffer_L0+0, FARG_MODBUS_TX_slave_ID+0
;tof200.c,77 :: 		tx_buffer[0x01] = function_code;
	MOV MODBUS_TX_tx_buffer_L0+1, FARG_MODBUS_TX_function_code+0
;tof200.c,79 :: 		get_HB_LB(reg, &hb, &lb);
	MOV FARG_get_HB_LB_value+0, FARG_MODBUS_TX_reg+0
	CLR A
	MOV FARG_get_HB_LB_value+1, A
	MOV FARG_get_HB_LB_HB+0, #MODBUS_TX_hb_L0+0
	MOV FARG_get_HB_LB_LB+0, #MODBUS_TX_lb_L0+0
	LCALL _get_HB_LB+0
;tof200.c,81 :: 		tx_buffer[0x02] = hb;
	MOV MODBUS_TX_tx_buffer_L0+2, MODBUS_TX_hb_L0+0
;tof200.c,82 :: 		tx_buffer[0x03] = lb;
	MOV MODBUS_TX_tx_buffer_L0+3, MODBUS_TX_lb_L0+0
;tof200.c,84 :: 		get_HB_LB(value, &hb, &lb);
	MOV FARG_get_HB_LB_value+0, FARG_MODBUS_TX_value+0
	CLR A
	MOV FARG_get_HB_LB_value+1, A
	MOV FARG_get_HB_LB_HB+0, #MODBUS_TX_hb_L0+0
	MOV FARG_get_HB_LB_LB+0, #MODBUS_TX_lb_L0+0
	LCALL _get_HB_LB+0
;tof200.c,86 :: 		tx_buffer[0x04] = hb;
	MOV MODBUS_TX_tx_buffer_L0+4, MODBUS_TX_hb_L0+0
;tof200.c,87 :: 		tx_buffer[0x05] = lb;
	MOV MODBUS_TX_tx_buffer_L0+5, MODBUS_TX_lb_L0+0
;tof200.c,89 :: 		temp = MODBUS_RTU_CRC16(tx_buffer, 6);
	MOV FARG_MODBUS_RTU_CRC16_data_input+0, #MODBUS_TX_tx_buffer_L0+0
	MOV FARG_MODBUS_RTU_CRC16_data_length+0, #6
	LCALL _MODBUS_RTU_CRC16+0
;tof200.c,90 :: 		get_HB_LB(temp, &hb, &lb);
	MOV FARG_get_HB_LB_value+0, 0
	MOV FARG_get_HB_LB_value+1, 1
	MOV FARG_get_HB_LB_HB+0, #MODBUS_TX_hb_L0+0
	MOV FARG_get_HB_LB_LB+0, #MODBUS_TX_lb_L0+0
	LCALL _get_HB_LB+0
;tof200.c,92 :: 		tx_buffer[0x06] = lb;
	MOV MODBUS_TX_tx_buffer_L0+6, MODBUS_TX_lb_L0+0
;tof200.c,93 :: 		tx_buffer[0x07] = hb;
	MOV MODBUS_TX_tx_buffer_L0+7, MODBUS_TX_hb_L0+0
;tof200.c,95 :: 		flush_RX_buffer();
	LCALL _flush_RX_buffer+0
;tof200.c,97 :: 		for(i = 0; i < ToF200_TX_data_packet_size; i++)
	MOV MODBUS_TX_i_L0+0, #0
L_MODBUS_TX9:
	CLR C
	MOV A, MODBUS_TX_i_L0+0
	SUBB A, #8
	JNC L_MODBUS_TX10
;tof200.c,99 :: 		UART_Write(tx_buffer[i]);
	MOV A, #MODBUS_TX_tx_buffer_L0+0
	ADD A, MODBUS_TX_i_L0+0
	MOV R0, A
	MOV FARG_UART_Write__data+0, @R0
	LCALL _UART_Write+0
;tof200.c,97 :: 		for(i = 0; i < ToF200_TX_data_packet_size; i++)
	INC MODBUS_TX_i_L0+0
;tof200.c,100 :: 		}
	SJMP L_MODBUS_TX9
L_MODBUS_TX10:
;tof200.c,102 :: 		cnt = 0x00;
	MOV _cnt+0, #0
;tof200.c,103 :: 		delay_ms(40);
	MOV R5, 3
	MOV R6, 125
	MOV R7, 89
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;tof200.c,104 :: 		}
	RET
; end of _MODBUS_TX

_ToF_get_range:
;tof200.c,107 :: 		unsigned int ToF_get_range(void)
;tof200.c,109 :: 		unsigned int CRC_1 = 0x0000;
	MOV ToF_get_range_CRC_1_L0+0, #0
	MOV ToF_get_range_CRC_1_L0+1, #0
	MOV ToF_get_range_distance_L0+0, #136
	MOV ToF_get_range_distance_L0+1, #19
;tof200.c,110 :: 		unsigned int CRC_2 = 0x0000;
;tof200.c,112 :: 		unsigned int distance = 5000;
;tof200.c,114 :: 		MODBUS_TX(ToF200_slave_default_ID,
	MOV FARG_MODBUS_TX_slave_ID+0, #1
;tof200.c,115 :: 		MODBUS_read_holding_registers_function_code,
	MOV FARG_MODBUS_TX_function_code+0, #3
;tof200.c,116 :: 		ToF200_measurement_register,
	MOV FARG_MODBUS_TX_reg+0, #16
;tof200.c,117 :: 		0x0001);
	MOV FARG_MODBUS_TX_value+0, #1
	LCALL _MODBUS_TX+0
;tof200.c,119 :: 		if(rx_buffer[0x00] == ToF200_slave_default_ID)
	MOV A, _rx_buffer+0
	XRL A, #1
	JNZ L_ToF_get_range12
;tof200.c,121 :: 		if(rx_buffer[0x01] == MODBUS_read_holding_registers_function_code)
	MOV A, _rx_buffer+1
	XRL A, #3
	JNZ L_ToF_get_range13
;tof200.c,123 :: 		if(rx_buffer[0x02] == 0x02)
	MOV A, _rx_buffer+2
	XRL A, #2
	JNZ L_ToF_get_range14
;tof200.c,125 :: 		CRC_1 = MODBUS_RTU_CRC16(rx_buffer, 5);
	MOV FARG_MODBUS_RTU_CRC16_data_input+0, #_rx_buffer+0
	MOV FARG_MODBUS_RTU_CRC16_data_length+0, #5
	LCALL _MODBUS_RTU_CRC16+0
	MOV ToF_get_range_CRC_1_L0+0, 0
	MOV ToF_get_range_CRC_1_L0+1, 1
;tof200.c,126 :: 		CRC_2 = make_word(rx_buffer[0x06], rx_buffer[0x05]);
	MOV FARG_make_word_HB+0, _rx_buffer+6
	MOV FARG_make_word_LB+0, _rx_buffer+5
	LCALL _make_word+0
;tof200.c,128 :: 		if(CRC_1 == CRC_2)
	MOV A, ToF_get_range_CRC_1_L0+0
	XRL A, R0
	JNZ L__ToF_get_range37
	MOV A, ToF_get_range_CRC_1_L0+1
	XRL A, R1
L__ToF_get_range37:
	JNZ L_ToF_get_range15
;tof200.c,130 :: 		distance = make_word(rx_buffer[0x03], rx_buffer[0x04]);
	MOV FARG_make_word_HB+0, _rx_buffer+3
	MOV FARG_make_word_LB+0, _rx_buffer+4
	LCALL _make_word+0
	MOV ToF_get_range_distance_L0+0, 0
	MOV ToF_get_range_distance_L0+1, 1
;tof200.c,131 :: 		if(distance > ToF200_default_max_distance)
	SETB C
	MOV A, R0
	SUBB A, #208
	MOV A, R1
	SUBB A, #7
	JC L_ToF_get_range16
;tof200.c,133 :: 		distance = 40000;
	MOV ToF_get_range_distance_L0+0, #64
	MOV ToF_get_range_distance_L0+1, #156
;tof200.c,134 :: 		}
L_ToF_get_range16:
;tof200.c,135 :: 		}
	SJMP L_ToF_get_range17
L_ToF_get_range15:
;tof200.c,139 :: 		distance = 40000;
	MOV ToF_get_range_distance_L0+0, #64
	MOV ToF_get_range_distance_L0+1, #156
;tof200.c,140 :: 		}
L_ToF_get_range17:
;tof200.c,141 :: 		}
L_ToF_get_range14:
;tof200.c,142 :: 		}
L_ToF_get_range13:
;tof200.c,143 :: 		}
L_ToF_get_range12:
;tof200.c,145 :: 		return distance;
	MOV R0, ToF_get_range_distance_L0+0
	MOV R1, ToF_get_range_distance_L0+1
;tof200.c,146 :: 		}
	RET
; end of _ToF_get_range

_UART0_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;serial_comm.c,53 :: 		ics ICS_AUTO
;serial_comm.c,55 :: 		rx_buffer[cnt++] = UART_Read();
	MOV A, #_rx_buffer+0
	ADD A, _cnt+0
	MOV R0, A
	MOV FLOC__UART0_ISR+1, 0
	LCALL _UART_Read+0
	MOV FLOC__UART0_ISR+0, 0
	MOV R0, FLOC__UART0_ISR+1
	MOV @R0, FLOC__UART0_ISR+0
	INC _cnt+0
;serial_comm.c,56 :: 		RI0_bit = 0;
	CLR RI0_bit+0
;serial_comm.c,57 :: 		}
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
;serial_comm.c,63 :: 		ics ICS_AUTO
;serial_comm.c,65 :: 		switch(i)
	SJMP L_Timer_ISR18
;serial_comm.c,67 :: 		case 0:
L_Timer_ISR20:
;serial_comm.c,69 :: 		value = (d / 1000);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _d+0
	MOV R1, _d+1
	LCALL _Div_16x16_U+0
	MOV _value+0, 0
;serial_comm.c,70 :: 		break;
	LJMP L_Timer_ISR19
;serial_comm.c,72 :: 		case 1:
L_Timer_ISR21:
;serial_comm.c,74 :: 		value = ((d % 1000) / 100);
	MOV R4, #232
	MOV R5, #3
	MOV R0, _d+0
	MOV R1, _d+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #100
	MOV R5, #0
	LCALL _Div_16x16_U+0
	MOV _value+0, 0
;serial_comm.c,75 :: 		break;
	SJMP L_Timer_ISR19
;serial_comm.c,77 :: 		case 2:
L_Timer_ISR22:
;serial_comm.c,79 :: 		value = ((d % 100) / 10);
	MOV R4, #100
	MOV R5, #0
	MOV R0, _d+0
	MOV R1, _d+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_U+0
	MOV _value+0, 0
;serial_comm.c,80 :: 		break;
	SJMP L_Timer_ISR19
;serial_comm.c,82 :: 		case 3:
L_Timer_ISR23:
;serial_comm.c,84 :: 		value = (d % 10);
	MOV R4, #10
	MOV R5, #0
	MOV R0, _d+0
	MOV R1, _d+1
	LCALL _Div_16x16_U+0
	MOV R0, 4
	MOV R1, 5
	MOV _value+0, 0
;serial_comm.c,85 :: 		break;
	SJMP L_Timer_ISR19
;serial_comm.c,87 :: 		}
L_Timer_ISR18:
	MOV A, _i+0
	JZ L_Timer_ISR20
	MOV A, _i+0
	XRL A, #1
	JZ L_Timer_ISR21
	MOV A, _i+0
	XRL A, #2
	JZ L_Timer_ISR22
	MOV A, _i+0
	XRL A, #3
	JZ L_Timer_ISR23
L_Timer_ISR19:
;serial_comm.c,89 :: 		if(d >= 40000)
	CLR C
	MOV A, _d+0
	SUBB A, #64
	MOV A, _d+1
	SUBB A, #156
	JC L_Timer_ISR24
;serial_comm.c,91 :: 		segment_write(11, i);
	MOV FARG_segment_write_disp+0, #11
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;serial_comm.c,92 :: 		}
	SJMP L_Timer_ISR25
L_Timer_ISR24:
;serial_comm.c,95 :: 		segment_write(value, i);
	MOV FARG_segment_write_disp+0, _value+0
	MOV FARG_segment_write_pos+0, _i+0
	LCALL _segment_write+0
;serial_comm.c,96 :: 		}
L_Timer_ISR25:
;serial_comm.c,98 :: 		i++;
	INC _i+0
;serial_comm.c,100 :: 		if(i > 3)
	SETB C
	MOV A, _i+0
	SUBB A, #3
	JC L_Timer_ISR26
;serial_comm.c,102 :: 		i = 0;
	MOV _i+0, #0
;serial_comm.c,103 :: 		}
L_Timer_ISR26:
;serial_comm.c,105 :: 		TMR3CN &= 0x7F;
	ANL TMR3CN+0, #127
;serial_comm.c,106 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_ISR

_main:
	MOV SP+0, #128
;serial_comm.c,109 :: 		void main(void)
;serial_comm.c,111 :: 		Init_Device();
	LCALL _Init_Device+0
;serial_comm.c,113 :: 		while(1)
L_main27:
;serial_comm.c,115 :: 		d = ((float)ToF_get_range());
	LCALL _ToF_get_range+0
	LCALL _Word2Double+0
	LCALL _Double2Ints+0
	MOV _d+0, 0
	MOV _d+1, 1
;serial_comm.c,116 :: 		delay_ms(400);
	MOV R5, 25
	MOV R6, 220
	MOV R7, 144
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;serial_comm.c,117 :: 		};
	SJMP L_main27
;serial_comm.c,118 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;serial_comm.c,121 :: 		void PCA_Init(void)
;serial_comm.c,123 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;serial_comm.c,124 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;serial_comm.c,125 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;serial_comm.c,128 :: 		void Timer_Init(void)
;serial_comm.c,130 :: 		TMR3CN = 0x04;
	MOV TMR3CN+0, #4
;serial_comm.c,131 :: 		TMR3RLL = 0x02;
	MOV TMR3RLL+0, #2
;serial_comm.c,132 :: 		TMR3RLH = 0xFC;
	MOV TMR3RLH+0, #252
;serial_comm.c,133 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;serial_comm.c,136 :: 		void Port_IO_Init(void)
;serial_comm.c,156 :: 		P0MDOUT = 0x30;
	MOV P0MDOUT+0, #48
;serial_comm.c,157 :: 		P1MDOUT = 0xE0;
	MOV P1MDOUT+0, #224
;serial_comm.c,158 :: 		P1SKIP = 0xE0;
	MOV P1SKIP+0, #224
;serial_comm.c,159 :: 		XBR0 = 0x01;
	MOV XBR0+0, #1
;serial_comm.c,160 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;serial_comm.c,161 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;serial_comm.c,164 :: 		void Oscillator_Init(void)
;serial_comm.c,166 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;serial_comm.c,167 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;serial_comm.c,170 :: 		void Interrupts_Init(void)
;serial_comm.c,172 :: 		IE = 0x90;
	MOV IE+0, #144
;serial_comm.c,173 :: 		EIE1 = 0x80;
	MOV EIE1+0, #128
;serial_comm.c,174 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;serial_comm.c,177 :: 		void Init_Device(void)
;serial_comm.c,179 :: 		PCA_Init();
	LCALL _PCA_Init+0
;serial_comm.c,180 :: 		Timer_Init();
	LCALL _Timer_Init+0
;serial_comm.c,181 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;serial_comm.c,182 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;serial_comm.c,183 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;serial_comm.c,184 :: 		UART1_Init(115200);
	ANL CKCON+0, #252
	ORL CKCON+0, #8
	MOV TH1+0, #203
	LCALL _UART1_Init+0
;serial_comm.c,185 :: 		}
	RET
; end of _Init_Device

_write_74HC595:
;serial_comm.c,188 :: 		void write_74HC595(unsigned char send_data)
;serial_comm.c,190 :: 		signed char clks = 0x08;
	MOV write_74HC595_clks_L0+0, #8
;serial_comm.c,192 :: 		while(clks > 0)
L_write_74HC59529:
	SETB C
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_74HC595_clks_L0+0
	XRL A, #128
	SUBB A, R0
	JC L_write_74HC59530
;serial_comm.c,194 :: 		if((send_data & 0x80) == 0x00)
	MOV A, FARG_write_74HC595_send_data+0
	ANL A, #128
	MOV R1, A
	JNZ L_write_74HC59531
;serial_comm.c,196 :: 		LED_DOUT = 0;
	CLR P1_6_bit+0
;serial_comm.c,197 :: 		}
	SJMP L_write_74HC59532
L_write_74HC59531:
;serial_comm.c,200 :: 		LED_DOUT = 1;
	SETB P1_6_bit+0
;serial_comm.c,201 :: 		}
L_write_74HC59532:
;serial_comm.c,203 :: 		LED_CLK = 0;
	CLR P1_5_bit+0
;serial_comm.c,204 :: 		send_data <<= 1;
	MOV R0, #1
	MOV A, FARG_write_74HC595_send_data+0
	INC R0
	SJMP L__write_74HC59538
L__write_74HC59539:
	CLR C
	RLC A
L__write_74HC59538:
	DJNZ R0, L__write_74HC59539
	MOV FARG_write_74HC595_send_data+0, A
;serial_comm.c,205 :: 		clks--;
	DEC write_74HC595_clks_L0+0
;serial_comm.c,206 :: 		LED_CLK = 1;
	SETB P1_5_bit+0
;serial_comm.c,207 :: 		}
	SJMP L_write_74HC59529
L_write_74HC59530:
;serial_comm.c,208 :: 		}
	RET
; end of _write_74HC595

_segment_write:
;serial_comm.c,211 :: 		void segment_write(unsigned char disp, unsigned char pos)
;serial_comm.c,213 :: 		LED_LATCH = 0;
	CLR P1_7_bit+0
;serial_comm.c,214 :: 		write_74HC595(segment_code[disp]);
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
;serial_comm.c,215 :: 		write_74HC595(display_pos[pos]);
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
;serial_comm.c,216 :: 		LED_LATCH = 1;
	SETB P1_7_bit+0
;serial_comm.c,218 :: 		}
	RET
; end of _segment_write
