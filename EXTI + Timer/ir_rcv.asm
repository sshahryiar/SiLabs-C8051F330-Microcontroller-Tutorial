
_SW_I2C_init:
;sw_i2c.c,4 :: 		void SW_I2C_init(void)
;sw_i2c.c,6 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;sw_i2c.c,7 :: 		SDA_DIR_OUT();
	ORL P1MDOUT+0, #64
	ORL P0SKIP+0, #64
;sw_i2c.c,8 :: 		SCL_DIR_OUT();
	ORL P1MDOUT+0, #128
	ORL P0SKIP+0, #128
;sw_i2c.c,9 :: 		delay_us(100);
	MOV R6, 2
	MOV R7, 150
	DJNZ R7, 
	DJNZ R6, 
;sw_i2c.c,10 :: 		SDA_HIGH();
	ORL P1+0, #64
;sw_i2c.c,11 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,12 :: 		}
	RET
; end of _SW_I2C_init

_SW_I2C_start:
;sw_i2c.c,15 :: 		void SW_I2C_start(void)
;sw_i2c.c,17 :: 		SDA_DIR_OUT();
	ORL P1MDOUT+0, #64
	ORL P0SKIP+0, #64
;sw_i2c.c,18 :: 		SDA_HIGH();
	ORL P1+0, #64
;sw_i2c.c,19 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,20 :: 		delay_us(40);
	MOV R7, 163
	DJNZ R7, 
;sw_i2c.c,21 :: 		SDA_LOW();
	ANL P1+0, #191
;sw_i2c.c,22 :: 		delay_us(40);
	MOV R7, 163
	DJNZ R7, 
;sw_i2c.c,23 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,24 :: 		}
	RET
; end of _SW_I2C_start

_SW_I2C_stop:
;sw_i2c.c,27 :: 		void SW_I2C_stop(void)
;sw_i2c.c,29 :: 		SDA_DIR_OUT();
	ORL P1MDOUT+0, #64
	ORL P0SKIP+0, #64
;sw_i2c.c,30 :: 		SDA_LOW();
	ANL P1+0, #191
;sw_i2c.c,31 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,32 :: 		delay_us(40);
	MOV R7, 163
	DJNZ R7, 
;sw_i2c.c,33 :: 		SDA_HIGH();
	ORL P1+0, #64
;sw_i2c.c,34 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,35 :: 		delay_us(40);
	MOV R7, 163
	DJNZ R7, 
;sw_i2c.c,36 :: 		}
	RET
; end of _SW_I2C_stop

_SW_I2C_read:
;sw_i2c.c,39 :: 		unsigned char SW_I2C_read(unsigned char ack)
;sw_i2c.c,41 :: 		unsigned char i = 8;
	MOV SW_I2C_read_i_L0+0, #8
	MOV SW_I2C_read_j_L0+0, #0
;sw_i2c.c,42 :: 		unsigned char j = 0;
;sw_i2c.c,44 :: 		SDA_DIR_IN();
	ANL P1MDOUT+0, #191
	ORL P0SKIP+0, #64
;sw_i2c.c,46 :: 		while(i > 0)
L_SW_I2C_read15:
	SETB C
	MOV A, SW_I2C_read_i_L0+0
	SUBB A, #0
	JC L_SW_I2C_read16
;sw_i2c.c,48 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,49 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,50 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,51 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,52 :: 		j <<= 1;
	MOV R0, #1
	MOV A, SW_I2C_read_j_L0+0
	INC R0
	SJMP L__SW_I2C_read147
L__SW_I2C_read148:
	CLR C
	RLC A
L__SW_I2C_read147:
	DJNZ R0, L__SW_I2C_read148
	MOV SW_I2C_read_j_L0+0, A
;sw_i2c.c,54 :: 		if(SDA_IN() != 0x00)
	MOV A, P1+0
	ANL A, #64
	MOV R1, A
	JZ L_SW_I2C_read17
;sw_i2c.c,56 :: 		j++;
	INC SW_I2C_read_j_L0+0
;sw_i2c.c,57 :: 		}
L_SW_I2C_read17:
;sw_i2c.c,59 :: 		delay_us(10);
	MOV R7, 40
	DJNZ R7, 
	NOP
;sw_i2c.c,60 :: 		i--;
	DEC SW_I2C_read_i_L0+0
;sw_i2c.c,61 :: 		};
	SJMP L_SW_I2C_read15
L_SW_I2C_read16:
;sw_i2c.c,63 :: 		switch(ack)
	SJMP L_SW_I2C_read18
;sw_i2c.c,65 :: 		case I2C_ACK:
L_SW_I2C_read20:
;sw_i2c.c,67 :: 		SW_I2C_ACK_NACK(I2C_ACK);;
	MOV FARG_SW_I2C_ACK_NACK_mode+0, #255
	LCALL _SW_I2C_ACK_NACK+0
;sw_i2c.c,68 :: 		break;
	SJMP L_SW_I2C_read19
;sw_i2c.c,70 :: 		default:
L_SW_I2C_read21:
;sw_i2c.c,72 :: 		SW_I2C_ACK_NACK(I2C_NACK);;
	MOV FARG_SW_I2C_ACK_NACK_mode+0, #0
	LCALL _SW_I2C_ACK_NACK+0
;sw_i2c.c,73 :: 		break;
	SJMP L_SW_I2C_read19
;sw_i2c.c,75 :: 		}
L_SW_I2C_read18:
	MOV A, FARG_SW_I2C_read_ack+0
	XRL A, #255
	JZ L_SW_I2C_read20
	SJMP L_SW_I2C_read21
L_SW_I2C_read19:
;sw_i2c.c,77 :: 		return j;
	MOV R0, SW_I2C_read_j_L0+0
;sw_i2c.c,78 :: 		}
	RET
; end of _SW_I2C_read

_SW_I2C_write:
;sw_i2c.c,81 :: 		void SW_I2C_write(unsigned char value)
;sw_i2c.c,83 :: 		unsigned char i = 8;
	MOV SW_I2C_write_i_L0+0, #8
;sw_i2c.c,85 :: 		SDA_DIR_OUT();
	ORL P1MDOUT+0, #64
	ORL P0SKIP+0, #64
;sw_i2c.c,86 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,88 :: 		while(i > 0)
L_SW_I2C_write25:
	SETB C
	MOV A, SW_I2C_write_i_L0+0
	SUBB A, #0
	JC L_SW_I2C_write26
;sw_i2c.c,91 :: 		if(((value & 0x80) >> 7) != 0x00)
	MOV A, FARG_SW_I2C_write_value+0
	ANL A, #128
	MOV R2, A
	MOV R0, #7
	MOV A, R2
	INC R0
	SJMP L__SW_I2C_write149
L__SW_I2C_write150:
	CLR C
	RRC A
L__SW_I2C_write149:
	DJNZ R0, L__SW_I2C_write150
	MOV R1, A
	JZ L_SW_I2C_write27
;sw_i2c.c,93 :: 		SDA_HIGH();
	ORL P1+0, #64
;sw_i2c.c,94 :: 		}
	SJMP L_SW_I2C_write28
L_SW_I2C_write27:
;sw_i2c.c,97 :: 		SDA_LOW();
	ANL P1+0, #191
;sw_i2c.c,98 :: 		}
L_SW_I2C_write28:
;sw_i2c.c,101 :: 		value <<= 1;
	MOV R0, #1
	MOV A, FARG_SW_I2C_write_value+0
	INC R0
	SJMP L__SW_I2C_write151
L__SW_I2C_write152:
	CLR C
	RLC A
L__SW_I2C_write151:
	DJNZ R0, L__SW_I2C_write152
	MOV FARG_SW_I2C_write_value+0, A
;sw_i2c.c,102 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,103 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,104 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,105 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,106 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,107 :: 		i--;
	DEC SW_I2C_write_i_L0+0
;sw_i2c.c,108 :: 		};
	SJMP L_SW_I2C_write25
L_SW_I2C_write26:
;sw_i2c.c,109 :: 		}
	RET
; end of _SW_I2C_write

_SW_I2C_ACK_NACK:
;sw_i2c.c,112 :: 		void SW_I2C_ACK_NACK(unsigned char mode)
;sw_i2c.c,114 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,115 :: 		SDA_DIR_OUT();
	ORL P1MDOUT+0, #64
	ORL P0SKIP+0, #64
;sw_i2c.c,117 :: 		switch(mode)
	SJMP L_SW_I2C_ACK_NACK32
;sw_i2c.c,119 :: 		case I2C_ACK:
L_SW_I2C_ACK_NACK34:
;sw_i2c.c,121 :: 		SDA_LOW();
	ANL P1+0, #191
;sw_i2c.c,122 :: 		break;
	SJMP L_SW_I2C_ACK_NACK33
;sw_i2c.c,124 :: 		default:
L_SW_I2C_ACK_NACK35:
;sw_i2c.c,126 :: 		SDA_HIGH();
	ORL P1+0, #64
;sw_i2c.c,127 :: 		break;
	SJMP L_SW_I2C_ACK_NACK33
;sw_i2c.c,129 :: 		}
L_SW_I2C_ACK_NACK32:
	MOV A, FARG_SW_I2C_ACK_NACK_mode+0
	XRL A, #255
	JZ L_SW_I2C_ACK_NACK34
	SJMP L_SW_I2C_ACK_NACK35
L_SW_I2C_ACK_NACK33:
;sw_i2c.c,131 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,132 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,133 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;sw_i2c.c,134 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,135 :: 		}
	RET
; end of _SW_I2C_ACK_NACK

_SW_I2C_wait_ACK:
;sw_i2c.c,138 :: 		unsigned char SW_I2C_wait_ACK(void)
;sw_i2c.c,140 :: 		signed int timeout = 0;
	MOV SW_I2C_wait_ACK_timeout_L0+0, #0
	MOV SW_I2C_wait_ACK_timeout_L0+1, #0
;sw_i2c.c,142 :: 		SDA_DIR_IN();
	ANL P1MDOUT+0, #191
	ORL P0SKIP+0, #64
;sw_i2c.c,144 :: 		SDA_HIGH();
	ORL P1+0, #64
;sw_i2c.c,145 :: 		delay_us(10);
	MOV R7, 40
	DJNZ R7, 
	NOP
;sw_i2c.c,146 :: 		SCL_HIGH();
	ORL P1+0, #128
;sw_i2c.c,147 :: 		delay_us(10);
	MOV R7, 40
	DJNZ R7, 
	NOP
;sw_i2c.c,149 :: 		while(SDA_IN() != 0x00)
L_SW_I2C_wait_ACK39:
	MOV A, P1+0
	ANL A, #64
	MOV R1, A
	JZ L_SW_I2C_wait_ACK40
;sw_i2c.c,151 :: 		timeout++;
	MOV A, #1
	ADD A, SW_I2C_wait_ACK_timeout_L0+0
	MOV SW_I2C_wait_ACK_timeout_L0+0, A
	MOV A, #0
	ADDC A, SW_I2C_wait_ACK_timeout_L0+1
	MOV SW_I2C_wait_ACK_timeout_L0+1, A
;sw_i2c.c,153 :: 		if(timeout > I2C_timeout)
	SETB C
	MOV A, SW_I2C_wait_ACK_timeout_L0+0
	SUBB A, #232
	MOV A, #3
	XRL A, #128
	MOV R0, A
	MOV A, SW_I2C_wait_ACK_timeout_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_SW_I2C_wait_ACK41
;sw_i2c.c,155 :: 		SW_I2C_stop();
	LCALL _SW_I2C_stop+0
;sw_i2c.c,156 :: 		return 1;
	MOV R0, #1
	RET
;sw_i2c.c,157 :: 		}
L_SW_I2C_wait_ACK41:
;sw_i2c.c,158 :: 		};
	SJMP L_SW_I2C_wait_ACK39
L_SW_I2C_wait_ACK40:
;sw_i2c.c,160 :: 		SCL_LOW();
	ANL P1+0, #127
;sw_i2c.c,161 :: 		return 0;
	MOV R0, #0
;sw_i2c.c,162 :: 		}
	RET
; end of _SW_I2C_wait_ACK

_PCF8574_init:
;pcf8574.c,4 :: 		void PCF8574_init(void)
;pcf8574.c,6 :: 		SW_I2C_init();
	LCALL _SW_I2C_init+0
;pcf8574.c,7 :: 		delay_ms(20);
	MOV R5, 2
	MOV R6, 63
	MOV R7, 43
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;pcf8574.c,8 :: 		}
	RET
; end of _PCF8574_init

_PCF8574_read:
;pcf8574.c,11 :: 		unsigned char PCF8574_read(void)
;pcf8574.c,13 :: 		unsigned char port_byte = 0;
	MOV PCF8574_read_port_byte_L0+0, #0
;pcf8574.c,15 :: 		SW_I2C_start();
	LCALL _SW_I2C_start+0
;pcf8574.c,16 :: 		SW_I2C_write(PCF8574_read_cmd);
	MOV FARG_SW_I2C_write_value+0, #79
	LCALL _SW_I2C_write+0
;pcf8574.c,17 :: 		port_byte = SW_I2C_read(I2C_NACK);
	MOV FARG_SW_I2C_read_ack+0, #0
	LCALL _SW_I2C_read+0
	MOV PCF8574_read_port_byte_L0+0, 0
;pcf8574.c,18 :: 		SW_I2C_stop();
	LCALL _SW_I2C_stop+0
;pcf8574.c,20 :: 		return port_byte;
	MOV R0, PCF8574_read_port_byte_L0+0
;pcf8574.c,21 :: 		}
	RET
; end of _PCF8574_read

_PCF8574_write:
;pcf8574.c,24 :: 		void PCF8574_write(unsigned char data_byte)
;pcf8574.c,26 :: 		SW_I2C_start();
	LCALL _SW_I2C_start+0
;pcf8574.c,27 :: 		SW_I2C_write(PCF8574_write_cmd);
	MOV FARG_SW_I2C_write_value+0, #78
	LCALL _SW_I2C_write+0
;pcf8574.c,28 :: 		SW_I2C_ACK_NACK(I2C_ACK);
	MOV FARG_SW_I2C_ACK_NACK_mode+0, #255
	LCALL _SW_I2C_ACK_NACK+0
;pcf8574.c,29 :: 		SW_I2C_write(data_byte);
	MOV FARG_SW_I2C_write_value+0, FARG_PCF8574_write_data_byte+0
	LCALL _SW_I2C_write+0
;pcf8574.c,30 :: 		SW_I2C_ACK_NACK(I2C_ACK);
	MOV FARG_SW_I2C_ACK_NACK_mode+0, #255
	LCALL _SW_I2C_ACK_NACK+0
;pcf8574.c,31 :: 		SW_I2C_stop();
	LCALL _SW_I2C_stop+0
;pcf8574.c,32 :: 		}
	RET
; end of _PCF8574_write

_LCD_init:
;lcd_2_wire.c,8 :: 		void LCD_init(void)
;lcd_2_wire.c,10 :: 		PCF8574_init();
	LCALL _PCF8574_init+0
;lcd_2_wire.c,11 :: 		delay_ms(10);
	MOV R6, 160
	MOV R7, 21
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;lcd_2_wire.c,13 :: 		bl_state = BL_ON;
	MOV ir_rcv_bl_state+0, #1
;lcd_2_wire.c,14 :: 		data_value = 0x04;
	MOV ir_rcv_data_value+0, #4
;lcd_2_wire.c,15 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, #4
	LCALL _PCF8574_write+0
;lcd_2_wire.c,17 :: 		delay_ms(10);
	MOV R6, 160
	MOV R7, 21
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;lcd_2_wire.c,19 :: 		LCD_send(0x33, CMD);
	MOV FARG_LCD_send_value+0, #51
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,20 :: 		LCD_send(0x32, CMD);
	MOV FARG_LCD_send_value+0, #50
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,22 :: 		LCD_send((_4_pin_interface | _2_row_display | _5x7_dots), CMD);
	MOV FARG_LCD_send_value+0, #40
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,23 :: 		LCD_send((display_on | cursor_off | blink_off), CMD);
	MOV FARG_LCD_send_value+0, #12
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,24 :: 		LCD_send((clear_display), CMD);
	MOV FARG_LCD_send_value+0, #1
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,25 :: 		LCD_send((cursor_direction_inc | display_no_shift), CMD);
	MOV FARG_LCD_send_value+0, #6
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,26 :: 		}
	RET
; end of _LCD_init

_LCD_toggle_EN:
;lcd_2_wire.c,29 :: 		void LCD_toggle_EN(void)
;lcd_2_wire.c,31 :: 		data_value |= 0x04;
	MOV A, ir_rcv_data_value+0
	ORL A, #4
	MOV R0, A
	MOV ir_rcv_data_value+0, 0
;lcd_2_wire.c,32 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, 0
	LCALL _PCF8574_write+0
;lcd_2_wire.c,33 :: 		delay_ms(1);
	MOV R6, 16
	MOV R7, 231
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;lcd_2_wire.c,34 :: 		data_value &= 0xF9;
	MOV A, ir_rcv_data_value+0
	ANL A, #249
	MOV R0, A
	MOV ir_rcv_data_value+0, 0
;lcd_2_wire.c,35 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, 0
	LCALL _PCF8574_write+0
;lcd_2_wire.c,36 :: 		delay_ms(1);
	MOV R6, 16
	MOV R7, 231
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;lcd_2_wire.c,37 :: 		}
	RET
; end of _LCD_toggle_EN

_LCD_send:
;lcd_2_wire.c,40 :: 		void LCD_send(unsigned char value, unsigned char mode)
;lcd_2_wire.c,42 :: 		switch(mode)
	SJMP L_LCD_send42
;lcd_2_wire.c,44 :: 		case CMD:
L_LCD_send44:
;lcd_2_wire.c,46 :: 		data_value &= 0xF4;
	ANL ir_rcv_data_value+0, #244
;lcd_2_wire.c,47 :: 		break;
	SJMP L_LCD_send43
;lcd_2_wire.c,49 :: 		case DAT:
L_LCD_send45:
;lcd_2_wire.c,51 :: 		data_value |= 0x01;
	ORL ir_rcv_data_value+0, #1
;lcd_2_wire.c,52 :: 		break;
	SJMP L_LCD_send43
;lcd_2_wire.c,54 :: 		}
L_LCD_send42:
	MOV A, FARG_LCD_send_mode+0
	JZ L_LCD_send44
	MOV A, FARG_LCD_send_mode+0
	XRL A, #1
	JZ L_LCD_send45
L_LCD_send43:
;lcd_2_wire.c,56 :: 		switch(bl_state)
	SJMP L_LCD_send46
;lcd_2_wire.c,58 :: 		case BL_ON:
L_LCD_send48:
;lcd_2_wire.c,60 :: 		data_value |= 0x08;
	ORL ir_rcv_data_value+0, #8
;lcd_2_wire.c,61 :: 		break;
	SJMP L_LCD_send47
;lcd_2_wire.c,63 :: 		case BL_OFF:
L_LCD_send49:
;lcd_2_wire.c,65 :: 		data_value &= 0xF7;
	ANL ir_rcv_data_value+0, #247
;lcd_2_wire.c,66 :: 		break;
	SJMP L_LCD_send47
;lcd_2_wire.c,68 :: 		}
L_LCD_send46:
	MOV A, ir_rcv_bl_state+0
	XRL A, #1
	JZ L_LCD_send48
	MOV A, ir_rcv_bl_state+0
	JZ L_LCD_send49
L_LCD_send47:
;lcd_2_wire.c,70 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, ir_rcv_data_value+0
	LCALL _PCF8574_write+0
;lcd_2_wire.c,71 :: 		LCD_4bit_send(value);
	MOV FARG_LCD_4bit_send_lcd_data+0, FARG_LCD_send_value+0
	LCALL _LCD_4bit_send+0
;lcd_2_wire.c,72 :: 		delay_ms(1);
	MOV R6, 16
	MOV R7, 231
	DJNZ R7, 
	DJNZ R6, 
	NOP
	NOP
;lcd_2_wire.c,73 :: 		}
	RET
; end of _LCD_send

_LCD_4bit_send:
;lcd_2_wire.c,76 :: 		void LCD_4bit_send(unsigned char lcd_data)
;lcd_2_wire.c,78 :: 		unsigned char temp = 0x00;
;lcd_2_wire.c,80 :: 		temp = (lcd_data & 0xF0);
	MOV A, FARG_LCD_4bit_send_lcd_data+0
	ANL A, #240
	MOV R1, A
;lcd_2_wire.c,81 :: 		data_value &= 0x0F;
	MOV A, ir_rcv_data_value+0
	ANL A, #15
	MOV R0, A
	MOV ir_rcv_data_value+0, 0
;lcd_2_wire.c,82 :: 		data_value |= temp;
	MOV A, R1
	ORL 0, A
	MOV ir_rcv_data_value+0, 0
;lcd_2_wire.c,83 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, 0
	LCALL _PCF8574_write+0
;lcd_2_wire.c,84 :: 		LCD_toggle_EN();
	LCALL _LCD_toggle_EN+0
;lcd_2_wire.c,86 :: 		temp = (lcd_data & 0x0F);
	MOV A, FARG_LCD_4bit_send_lcd_data+0
	ANL A, #15
	MOV R2, A
;lcd_2_wire.c,87 :: 		temp <<= 0x04;
	MOV R0, #4
	MOV A, R2
	INC R0
	SJMP L__LCD_4bit_send153
L__LCD_4bit_send154:
	CLR C
	RLC A
L__LCD_4bit_send153:
	DJNZ R0, L__LCD_4bit_send154
	MOV R1, A
;lcd_2_wire.c,88 :: 		data_value &= 0x0F;
	MOV A, ir_rcv_data_value+0
	ANL A, #15
	MOV R0, A
	MOV ir_rcv_data_value+0, 0
;lcd_2_wire.c,89 :: 		data_value |= temp;
	MOV A, R1
	ORL 0, A
	MOV ir_rcv_data_value+0, 0
;lcd_2_wire.c,90 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, 0
	LCALL _PCF8574_write+0
;lcd_2_wire.c,91 :: 		LCD_toggle_EN();
	LCALL _LCD_toggle_EN+0
;lcd_2_wire.c,92 :: 		}
	RET
; end of _LCD_4bit_send

_LCD_putstr:
;lcd_2_wire.c,95 :: 		void LCD_putstr(char *lcd_string)
;lcd_2_wire.c,97 :: 		do
L_LCD_putstr50:
;lcd_2_wire.c,99 :: 		LCD_putchar(*lcd_string++);
	MOV R0, FARG_LCD_putstr_lcd_string+0
	MOV FARG_LCD_putchar_char_data+0, @R0
	LCALL _LCD_putchar+0
	INC FARG_LCD_putstr_lcd_string+0
;lcd_2_wire.c,100 :: 		}while(*lcd_string != '\0') ;
	MOV R0, FARG_LCD_putstr_lcd_string+0
	MOV 1, @R0
	MOV A, R1
	JNZ L_LCD_putstr50
;lcd_2_wire.c,101 :: 		}
	RET
; end of _LCD_putstr

_LCD_putchar:
;lcd_2_wire.c,104 :: 		void LCD_putchar(char char_data)
;lcd_2_wire.c,106 :: 		if((char_data >= 0x20) && (char_data <= 0x7F))
	CLR C
	MOV A, FARG_LCD_putchar_char_data+0
	SUBB A, #32
	JC L_LCD_putchar55
	SETB C
	MOV A, FARG_LCD_putchar_char_data+0
	SUBB A, #127
	JNC L_LCD_putchar55
L__LCD_putchar133:
;lcd_2_wire.c,108 :: 		LCD_send(char_data, DAT);
	MOV FARG_LCD_send_value+0, FARG_LCD_putchar_char_data+0
	MOV FARG_LCD_send_mode+0, #1
	LCALL _LCD_send+0
;lcd_2_wire.c,109 :: 		}
L_LCD_putchar55:
;lcd_2_wire.c,110 :: 		}
	RET
; end of _LCD_putchar

_LCD_clear_home:
;lcd_2_wire.c,113 :: 		void LCD_clear_home(void)
;lcd_2_wire.c,115 :: 		LCD_send(clear_display, CMD);
	MOV FARG_LCD_send_value+0, #1
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,116 :: 		LCD_send(goto_home, CMD);
	MOV FARG_LCD_send_value+0, #2
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,117 :: 		}
	RET
; end of _LCD_clear_home

_LCD_goto:
;lcd_2_wire.c,120 :: 		void LCD_goto(unsigned char x_pos,unsigned char y_pos)
;lcd_2_wire.c,122 :: 		if(y_pos == 0)
	MOV A, FARG_LCD_goto_y_pos+0
	JNZ L_LCD_goto56
;lcd_2_wire.c,124 :: 		LCD_send((0x80 | x_pos), CMD);
	MOV A, #128
	ORL A, FARG_LCD_goto_x_pos+0
	MOV FARG_LCD_send_value+0, A
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,125 :: 		}
	SJMP L_LCD_goto57
L_LCD_goto56:
;lcd_2_wire.c,128 :: 		LCD_send((0x80 | 0x40 | x_pos), CMD);
	MOV A, #192
	ORL A, FARG_LCD_goto_x_pos+0
	MOV FARG_LCD_send_value+0, A
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_2_wire.c,129 :: 		}
L_LCD_goto57:
;lcd_2_wire.c,130 :: 		}
	RET
; end of _LCD_goto

_load_custom_symbol:
;lcd_print.c,4 :: 		void load_custom_symbol(void)
;lcd_print.c,6 :: 		unsigned char s = 0;
	MOV load_custom_symbol_s_L0+0, #0
;lcd_print.c,13 :: 		LCD_send(0x40, CMD);
	MOV FARG_LCD_send_value+0, #64
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_print.c,15 :: 		for(s = 0; s < array_size; s++)
	MOV load_custom_symbol_s_L0+0, #0
L_load_custom_symbol58:
	CLR C
	MOV A, load_custom_symbol_s_L0+0
	SUBB A, #8
	JNC L_load_custom_symbol59
;lcd_print.c,17 :: 		LCD_send(custom_symbol[s], DAT);
	MOV A, load_custom_symbol_s_L0+0
	ADD A, #load_custom_symbol_custom_symbol_L0+0
	MOV R1, A
	CLR A
	ADDC A, hi(#load_custom_symbol_custom_symbol_L0+0)
	MOV R2, A
	MOV 130, 1
	MOV 131, 2
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_LCD_send_value+0, 0
	MOV FARG_LCD_send_mode+0, #1
	LCALL _LCD_send+0
;lcd_print.c,15 :: 		for(s = 0; s < array_size; s++)
	INC load_custom_symbol_s_L0+0
;lcd_print.c,18 :: 		}
	SJMP L_load_custom_symbol58
L_load_custom_symbol59:
;lcd_print.c,20 :: 		LCD_send(0x80, CMD);
	MOV FARG_LCD_send_value+0, #128
	MOV FARG_LCD_send_mode+0, #0
	LCALL _LCD_send+0
;lcd_print.c,21 :: 		}
	RET
; end of _load_custom_symbol

_print_symbol:
;lcd_print.c,24 :: 		void print_symbol(unsigned char x_pos, unsigned char y_pos, unsigned char symbol_index)
;lcd_print.c,26 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_symbol_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_symbol_y_pos+0
	LCALL _LCD_goto+0
;lcd_print.c,27 :: 		LCD_send(symbol_index, DAT);
	MOV FARG_LCD_send_value+0, FARG_print_symbol_symbol_index+0
	MOV FARG_LCD_send_mode+0, #1
	LCALL _LCD_send+0
;lcd_print.c,28 :: 		}
	RET
; end of _print_symbol

_print_C:
;lcd_print.c,31 :: 		void print_C(unsigned char x_pos, unsigned char y_pos, signed int value)
;lcd_print.c,33 :: 		char ch[5] = {0x20, 0x20, 0x20, 0x20, '\0'};
	MOV print_C_ch_L0+0, #32
	MOV print_C_ch_L0+1, #32
	MOV print_C_ch_L0+2, #32
	MOV print_C_ch_L0+3, #32
	MOV print_C_ch_L0+4, #0
;lcd_print.c,35 :: 		if(value < 0x00)
	CLR C
	MOV A, FARG_print_C_value+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C61
;lcd_print.c,37 :: 		ch[0] = 0x2D;
	MOV print_C_ch_L0+0, #45
;lcd_print.c,38 :: 		value = -value;
	CLR C
	MOV A, #0
	SUBB A, FARG_print_C_value+0
	MOV FARG_print_C_value+0, A
	MOV A, #0
	SUBB A, FARG_print_C_value+1
	MOV FARG_print_C_value+1, A
;lcd_print.c,39 :: 		}
	SJMP L_print_C62
L_print_C61:
;lcd_print.c,42 :: 		ch[0] = 0x20;
	MOV print_C_ch_L0+0, #32
;lcd_print.c,43 :: 		}
L_print_C62:
;lcd_print.c,45 :: 		if((value > 99) && (value <= 999))
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #99
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JC L_print_C65
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #231
	MOV A, #3
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C65
L__print_C136:
;lcd_print.c,47 :: 		ch[1] = ((value / 100) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+1, A
;lcd_print.c,48 :: 		ch[2] = (((value % 100) / 10) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+2, A
;lcd_print.c,49 :: 		ch[3] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+3, A
;lcd_print.c,50 :: 		}
	LJMP L_print_C66
L_print_C65:
;lcd_print.c,51 :: 		else if((value > 9) && (value <= 99))
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #9
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JC L_print_C69
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #99
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C69
L__print_C135:
;lcd_print.c,53 :: 		ch[1] = (((value % 100) / 10) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+1, A
;lcd_print.c,54 :: 		ch[2] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+2, A
;lcd_print.c,55 :: 		ch[3] = 0x20;
	MOV print_C_ch_L0+3, #32
;lcd_print.c,56 :: 		}
	SJMP L_print_C70
L_print_C69:
;lcd_print.c,57 :: 		else if((value >= 0) && (value <= 9))
	CLR C
	MOV A, FARG_print_C_value+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JC L_print_C73
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #9
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C73
L__print_C134:
;lcd_print.c,59 :: 		ch[1] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+1, A
;lcd_print.c,60 :: 		ch[2] = 0x20;
	MOV print_C_ch_L0+2, #32
;lcd_print.c,61 :: 		ch[3] = 0x20;
	MOV print_C_ch_L0+3, #32
;lcd_print.c,62 :: 		}
L_print_C73:
L_print_C70:
L_print_C66:
;lcd_print.c,64 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_C_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_C_y_pos+0
	LCALL _LCD_goto+0
;lcd_print.c,65 :: 		LCD_putstr(ch);
	MOV FARG_LCD_putstr_lcd_string+0, #print_C_ch_L0+0
	LCALL _LCD_putstr+0
;lcd_print.c,66 :: 		}
	RET
; end of _print_C

_print_I:
;lcd_print.c,69 :: 		void print_I(unsigned char x_pos, unsigned char y_pos, signed long value)
;lcd_print.c,71 :: 		char ch[7] = {0x20, 0x20, 0x20, 0x20, 0x20, 0x20, '\0'};
	MOV print_I_ch_L0+0, #32
	MOV print_I_ch_L0+1, #32
	MOV print_I_ch_L0+2, #32
	MOV print_I_ch_L0+3, #32
	MOV print_I_ch_L0+4, #32
	MOV print_I_ch_L0+5, #32
	MOV print_I_ch_L0+6, #0
;lcd_print.c,73 :: 		if(value < 0)
	CLR C
	MOV A, FARG_print_I_value+0
	SUBB A, #0
	MOV A, FARG_print_I_value+1
	SUBB A, #0
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JNC L_print_I74
;lcd_print.c,75 :: 		ch[0] = 0x2D;
	MOV print_I_ch_L0+0, #45
;lcd_print.c,76 :: 		value = -value;
	CLR C
	MOV A, #0
	SUBB A, FARG_print_I_value+0
	MOV FARG_print_I_value+0, A
	MOV A, #0
	SUBB A, FARG_print_I_value+1
	MOV FARG_print_I_value+1, A
	MOV A, #0
	SUBB A, FARG_print_I_value+2
	MOV FARG_print_I_value+2, A
	MOV A, #0
	SUBB A, FARG_print_I_value+3
	MOV FARG_print_I_value+3, A
;lcd_print.c,77 :: 		}
	SJMP L_print_I75
L_print_I74:
;lcd_print.c,80 :: 		ch[0] = 0x20;
	MOV print_I_ch_L0+0, #32
;lcd_print.c,81 :: 		}
L_print_I75:
;lcd_print.c,83 :: 		if(value > 9999)
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #15
	MOV A, FARG_print_I_value+1
	SUBB A, #39
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JNC #3
	LJMP L_print_I76
;lcd_print.c,85 :: 		ch[1] = ((value / 10000) + 0x30);
	MOV R4, #16
	MOV R5, #39
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+1, A
;lcd_print.c,86 :: 		ch[2] = (((value % 10000)/ 1000) + 0x30);
	MOV R4, #16
	MOV R5, #39
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #232
	MOV R5, #3
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+2, A
;lcd_print.c,87 :: 		ch[3] = (((value % 1000) / 100) + 0x30);
	MOV R4, #232
	MOV R5, #3
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+3, A
;lcd_print.c,88 :: 		ch[4] = (((value % 100) / 10) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+4, A
;lcd_print.c,89 :: 		ch[5] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+5, A
;lcd_print.c,90 :: 		}
	LJMP L_print_I77
L_print_I76:
;lcd_print.c,92 :: 		else if((value > 999) && (value <= 9999))
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #231
	MOV A, FARG_print_I_value+1
	SUBB A, #3
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JNC #3
	LJMP L_print_I80
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #15
	MOV A, FARG_print_I_value+1
	SUBB A, #39
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JC #3
	LJMP L_print_I80
L__print_I139:
;lcd_print.c,94 :: 		ch[1] = (((value % 10000)/ 1000) + 0x30);
	MOV R4, #16
	MOV R5, #39
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #232
	MOV R5, #3
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+1, A
;lcd_print.c,95 :: 		ch[2] = (((value % 1000) / 100) + 0x30);
	MOV R4, #232
	MOV R5, #3
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+2, A
;lcd_print.c,96 :: 		ch[3] = (((value % 100) / 10) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+3, A
;lcd_print.c,97 :: 		ch[4] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+4, A
;lcd_print.c,98 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print.c,99 :: 		}
	LJMP L_print_I81
L_print_I80:
;lcd_print.c,100 :: 		else if((value > 99) && (value <= 999))
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #99
	MOV A, FARG_print_I_value+1
	SUBB A, #0
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JNC #3
	LJMP L_print_I84
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #231
	MOV A, FARG_print_I_value+1
	SUBB A, #3
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JC #3
	LJMP L_print_I84
L__print_I138:
;lcd_print.c,102 :: 		ch[1] = (((value % 1000) / 100) + 0x30);
	MOV R4, #232
	MOV R5, #3
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+1, A
;lcd_print.c,103 :: 		ch[2] = (((value % 100) / 10) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+2, A
;lcd_print.c,104 :: 		ch[3] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+3, A
;lcd_print.c,105 :: 		ch[4] = 0x20;
	MOV print_I_ch_L0+4, #32
;lcd_print.c,106 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print.c,107 :: 		}
	LJMP L_print_I85
L_print_I84:
;lcd_print.c,108 :: 		else if((value > 9) && (value <= 99))
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #9
	MOV A, FARG_print_I_value+1
	SUBB A, #0
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JNC #3
	LJMP L_print_I88
	SETB C
	MOV A, FARG_print_I_value+0
	SUBB A, #99
	MOV A, FARG_print_I_value+1
	SUBB A, #0
	MOV A, FARG_print_I_value+2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_I_value+3
	XRL A, #128
	SUBB A, R0
	JNC L_print_I88
L__print_I137:
;lcd_print.c,110 :: 		ch[1] = (((value % 100) / 10) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	LCALL _Div_32x32_S+0
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+1, A
;lcd_print.c,111 :: 		ch[2] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+2, A
;lcd_print.c,112 :: 		ch[3] = 0x20;
	MOV print_I_ch_L0+3, #32
;lcd_print.c,113 :: 		ch[4] = 0x20;
	MOV print_I_ch_L0+4, #32
;lcd_print.c,114 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print.c,115 :: 		}
	SJMP L_print_I89
L_print_I88:
;lcd_print.c,118 :: 		ch[1] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_I_value+0
	MOV R1, FARG_print_I_value+1
	MOV R2, FARG_print_I_value+2
	MOV R3, FARG_print_I_value+3
	LCALL _Div_32x32_S+0
	MOV R0, 4
	MOV R1, 5
	MOV R2, 6
	MOV R3, 7
	MOV A, #48
	ADD A, R0
	MOV print_I_ch_L0+1, A
;lcd_print.c,119 :: 		ch[2] = 0x20;
	MOV print_I_ch_L0+2, #32
;lcd_print.c,120 :: 		ch[3] = 0x20;
	MOV print_I_ch_L0+3, #32
;lcd_print.c,121 :: 		ch[4] = 0x20;
	MOV print_I_ch_L0+4, #32
;lcd_print.c,122 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print.c,123 :: 		}
L_print_I89:
L_print_I85:
L_print_I81:
L_print_I77:
;lcd_print.c,125 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_I_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_I_y_pos+0
	LCALL _LCD_goto+0
;lcd_print.c,126 :: 		LCD_putstr(ch);
	MOV FARG_LCD_putstr_lcd_string+0, #print_I_ch_L0+0
	LCALL _LCD_putstr+0
;lcd_print.c,127 :: 		}
	RET
; end of _print_I

_print_D:
;lcd_print.c,130 :: 		void print_D(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char points)
;lcd_print.c,132 :: 		char ch[5] = {0x2E, 0x20, 0x20, 0x20, 0x20};
	MOV print_D_ch_L0+0, #46
	MOV print_D_ch_L0+1, #32
	MOV print_D_ch_L0+2, #32
	MOV print_D_ch_L0+3, #32
	MOV print_D_ch_L0+4, #32
;lcd_print.c,134 :: 		ch[1] = ((value / 100) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R0, FARG_print_D_value+0
	MOV R1, FARG_print_D_value+1
	LCALL _Div_16x16_S+0
	MOV A, #48
	ADD A, R0
	MOV print_D_ch_L0+1, A
;lcd_print.c,136 :: 		if(points > 1)
	SETB C
	MOV A, FARG_print_D_points+0
	SUBB A, #1
	JC L_print_D90
;lcd_print.c,138 :: 		ch[2] = (((value / 10) % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_print_D_value+0
	MOV R1, FARG_print_D_value+1
	LCALL _Div_16x16_S+0
	MOV R4, #10
	MOV R5, #0
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV print_D_ch_L0+2, A
;lcd_print.c,140 :: 		if(points > 1)
	SETB C
	MOV A, FARG_print_D_points+0
	SUBB A, #1
	JC L_print_D91
;lcd_print.c,142 :: 		ch[3] = ((value % 10) + 0x30);
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_print_D_value+0
	MOV R1, FARG_print_D_value+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV print_D_ch_L0+3, A
;lcd_print.c,143 :: 		}
L_print_D91:
;lcd_print.c,144 :: 		}
L_print_D90:
;lcd_print.c,146 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_D_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_D_y_pos+0
	LCALL _LCD_goto+0
;lcd_print.c,147 :: 		LCD_putstr(ch);
	MOV FARG_LCD_putstr_lcd_string+0, #print_D_ch_L0+0
	LCALL _LCD_putstr+0
;lcd_print.c,148 :: 		}
	RET
; end of _print_D

_print_F:
;lcd_print.c,151 :: 		void print_F(unsigned char x_pos, unsigned char y_pos, float value, unsigned char points)
;lcd_print.c,153 :: 		signed long tmp = 0x00000000;
	MOV print_F_tmp_L0+0, #0
	MOV print_F_tmp_L0+1, #0
	MOV print_F_tmp_L0+2, #0
	MOV print_F_tmp_L0+3, #0
;lcd_print.c,155 :: 		tmp = value;
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Double2Ints+0
	MOV print_F_tmp_L0+0, 0
	MOV print_F_tmp_L0+1, 1
	MOV print_F_tmp_L0+2, 2
	MOV print_F_tmp_L0+3, 3
;lcd_print.c,156 :: 		print_I(x_pos, y_pos, tmp);
	MOV FARG_print_I_x_pos+0, FARG_print_F_x_pos+0
	MOV FARG_print_I_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_I_value+0, 0
	MOV FARG_print_I_value+1, 1
	MOV FARG_print_I_value+2, 2
	MOV FARG_print_I_value+3, 3
	LCALL _print_I+0
;lcd_print.c,157 :: 		tmp = ((value - tmp) * 1000);
	MOV R0, print_F_tmp_L0+0
	MOV R1, print_F_tmp_L0+1
	MOV R2, print_F_tmp_L0+2
	MOV R3, print_F_tmp_L0+3
	LCALL _Long2Double+0
	MOV R4, 0
	MOV R5, 1
	MOV R6, 2
	MOV R7, 3
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Sub_32x32_FP+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV print_F_tmp_L0+0, 0
	MOV print_F_tmp_L0+1, 1
	MOV print_F_tmp_L0+2, 2
	MOV print_F_tmp_L0+3, 3
;lcd_print.c,159 :: 		if(tmp < 0)
	CLR C
	MOV A, R0
	SUBB A, #0
	MOV A, R1
	SUBB A, #0
	MOV A, R2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R4, A
	MOV A, R3
	XRL A, #128
	SUBB A, R4
	JNC L_print_F92
;lcd_print.c,161 :: 		tmp = -tmp;
	CLR C
	MOV A, #0
	SUBB A, print_F_tmp_L0+0
	MOV print_F_tmp_L0+0, A
	MOV A, #0
	SUBB A, print_F_tmp_L0+1
	MOV print_F_tmp_L0+1, A
	MOV A, #0
	SUBB A, print_F_tmp_L0+2
	MOV print_F_tmp_L0+2, A
	MOV A, #0
	SUBB A, print_F_tmp_L0+3
	MOV print_F_tmp_L0+3, A
;lcd_print.c,162 :: 		}
L_print_F92:
;lcd_print.c,164 :: 		if(value < 0)
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JC L__print_F155
	MOV R0, #0
	SJMP L__print_F156
L__print_F155:
	MOV R0, #1
L__print_F156:
	MOV A, R0
	JZ L_print_F93
;lcd_print.c,166 :: 		value = -value;
	XRL FARG_print_F_value+0, #0
	XRL FARG_print_F_value+1, #0
	XRL FARG_print_F_value+2, #0
	XRL FARG_print_F_value+3, #128
;lcd_print.c,167 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_F_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_F_y_pos+0
	LCALL _LCD_goto+0
;lcd_print.c,168 :: 		LCD_putchar(0x2D);
	MOV FARG_LCD_putchar_char_data+0, #45
	LCALL _LCD_putchar+0
;lcd_print.c,169 :: 		}
	SJMP L_print_F94
L_print_F93:
;lcd_print.c,172 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_F_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_F_y_pos+0
	LCALL _LCD_goto+0
;lcd_print.c,173 :: 		LCD_putchar(0x20);
	MOV FARG_LCD_putchar_char_data+0, #32
	LCALL _LCD_putchar+0
;lcd_print.c,174 :: 		}
L_print_F94:
;lcd_print.c,176 :: 		if((value >= 10000) && (value < 100000))
	CLR C
	MOV R4, #0
	MOV R5, #64
	MOV R6, #28
	MOV 7, #70
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JNC L__print_F157
	MOV R0, #0
	SJMP L__print_F158
L__print_F157:
	MOV R0, #1
L__print_F158:
	MOV A, R0
	JZ L_print_F97
	CLR C
	MOV R4, #0
	MOV R5, #80
	MOV R6, #195
	MOV 7, #71
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JC L__print_F159
	MOV R0, #0
	SJMP L__print_F160
L__print_F159:
	MOV R0, #1
L__print_F160:
	MOV A, R0
	JZ L_print_F97
L__print_F143:
;lcd_print.c,178 :: 		print_D((x_pos + 6), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #6
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print.c,179 :: 		}
	LJMP L_print_F98
L_print_F97:
;lcd_print.c,180 :: 		else if((value >= 1000) && (value < 10000))
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JNC L__print_F161
	MOV R0, #0
	SJMP L__print_F162
L__print_F161:
	MOV R0, #1
L__print_F162:
	MOV A, R0
	JZ L_print_F101
	CLR C
	MOV R4, #0
	MOV R5, #64
	MOV R6, #28
	MOV 7, #70
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JC L__print_F163
	MOV R0, #0
	SJMP L__print_F164
L__print_F163:
	MOV R0, #1
L__print_F164:
	MOV A, R0
	JZ L_print_F101
L__print_F142:
;lcd_print.c,182 :: 		print_D((x_pos + 5), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #5
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print.c,183 :: 		}
	LJMP L_print_F102
L_print_F101:
;lcd_print.c,184 :: 		else if((value >= 100) && (value < 1000))
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #200
	MOV 7, #66
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JNC L__print_F165
	MOV R0, #0
	SJMP L__print_F166
L__print_F165:
	MOV R0, #1
L__print_F166:
	MOV A, R0
	JZ L_print_F105
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JC L__print_F167
	MOV R0, #0
	SJMP L__print_F168
L__print_F167:
	MOV R0, #1
L__print_F168:
	MOV A, R0
	JZ L_print_F105
L__print_F141:
;lcd_print.c,186 :: 		print_D((x_pos + 4), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #4
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print.c,187 :: 		}
	LJMP L_print_F106
L_print_F105:
;lcd_print.c,188 :: 		else if((value >= 10) && (value < 100))
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #32
	MOV 7, #65
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JNC L__print_F169
	MOV R0, #0
	SJMP L__print_F170
L__print_F169:
	MOV R0, #1
L__print_F170:
	MOV A, R0
	JZ L_print_F109
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #200
	MOV 7, #66
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JC L__print_F171
	MOV R0, #0
	SJMP L__print_F172
L__print_F171:
	MOV R0, #1
L__print_F172:
	MOV A, R0
	JZ L_print_F109
L__print_F140:
;lcd_print.c,190 :: 		print_D((x_pos + 3), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #3
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print.c,191 :: 		}
	SJMP L_print_F110
L_print_F109:
;lcd_print.c,192 :: 		else if(value < 10)
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #32
	MOV 7, #65
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Compare_Double+0
	JC L__print_F173
	MOV R0, #0
	SJMP L__print_F174
L__print_F173:
	MOV R0, #1
L__print_F174:
	MOV A, R0
	JZ L_print_F111
;lcd_print.c,194 :: 		print_D((x_pos + 2), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #2
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print.c,195 :: 		}
L_print_F111:
L_print_F110:
L_print_F106:
L_print_F102:
L_print_F98:
;lcd_print.c,196 :: 		}
	RET
; end of _print_F

_IR_receive:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;ir_rcv.c,34 :: 		ics ICS_AUTO
;ir_rcv.c,36 :: 		frames[bits] = get_timer();
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__IR_receive175
L__IR_receive176:
	CLR C
	RLC A
L__IR_receive175:
	DJNZ R1, L__IR_receive176
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV FLOC__IR_receive+2, 0
	LCALL _get_timer+0
	MOV FLOC__IR_receive+0, 0
	MOV FLOC__IR_receive+1, 1
	MOV R0, FLOC__IR_receive+2
	MOV @R0, FLOC__IR_receive+0
	INC R0
	MOV @R0, FLOC__IR_receive+1
;ir_rcv.c,37 :: 		bits++;
	INC _bits+0
;ir_rcv.c,38 :: 		TR0_bit = 1;
	SETB TR0_bit+0
;ir_rcv.c,40 :: 		if(bits >= 33)
	CLR C
	MOV A, _bits+0
	SUBB A, #33
	JC L_IR_receive112
;ir_rcv.c,42 :: 		received = 1;
	SETB C
	MOV A, _received+0
	MOV #224, C
	MOV _received+0, A
;ir_rcv.c,43 :: 		TR0_bit = 0;
	CLR TR0_bit+0
;ir_rcv.c,44 :: 		}
L_IR_receive112:
;ir_rcv.c,45 :: 		set_timer();
	LCALL _set_timer+0
;ir_rcv.c,46 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _IR_receive

_main:
	MOV SP+0, #128
;ir_rcv.c,49 :: 		void main(void)
;ir_rcv.c,51 :: 		unsigned char i = 0;
;ir_rcv.c,53 :: 		unsigned char address = 0;
	MOV main_address_L0+0, #0
	MOV main_command_L0+0, #0
;ir_rcv.c,54 :: 		unsigned char command = 0;
;ir_rcv.c,56 :: 		Init_Device();
	LCALL _Init_Device+0
;ir_rcv.c,57 :: 		LCD_init();
	LCALL _LCD_init+0
;ir_rcv.c,58 :: 		LCD_clear_home();
	LCALL _LCD_clear_home+0
;ir_rcv.c,60 :: 		LCD_goto(0, 0);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #0
	LCALL _LCD_goto+0
;ir_rcv.c,61 :: 		LCD_putstr("ADR:");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr1_ir_rcv+0
	LCALL _LCD_putstr+0
;ir_rcv.c,62 :: 		LCD_goto(0, 1);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #1
	LCALL _LCD_goto+0
;ir_rcv.c,63 :: 		LCD_putstr("CMD:");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr2_ir_rcv+0
	LCALL _LCD_putstr+0
;ir_rcv.c,65 :: 		while(1)
L_main113:
;ir_rcv.c,67 :: 		if(received)
	MOV A, _received+0
	JNB 224, L_main115
	NOP
;ir_rcv.c,69 :: 		decode_NEC(&address, &command);
	MOV FARG_decode_NEC_addr+0, #main_address_L0+0
	MOV FARG_decode_NEC_cmd+0, #main_command_L0+0
	LCALL _decode_NEC+0
;ir_rcv.c,70 :: 		print_I(12, 0, address);
	MOV FARG_print_I_x_pos+0, #12
	MOV FARG_print_I_y_pos+0, #0
	MOV FARG_print_I_value+0, main_address_L0+0
	CLR A
	MOV FARG_print_I_value+1, A
	CLR A
	MOV FARG_print_I_value+2, A
	CLR A
	MOV FARG_print_I_value+3, A
	LCALL _print_I+0
;ir_rcv.c,71 :: 		print_I(12, 1, command);
	MOV FARG_print_I_x_pos+0, #12
	MOV FARG_print_I_y_pos+0, #1
	MOV FARG_print_I_value+0, main_command_L0+0
	CLR A
	MOV FARG_print_I_value+1, A
	CLR A
	MOV FARG_print_I_value+2, A
	CLR A
	MOV FARG_print_I_value+3, A
	LCALL _print_I+0
;ir_rcv.c,72 :: 		erase_frames();
	LCALL _erase_frames+0
;ir_rcv.c,73 :: 		}
L_main115:
;ir_rcv.c,74 :: 		};
	SJMP L_main113
;ir_rcv.c,75 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;ir_rcv.c,78 :: 		void PCA_Init(void)
;ir_rcv.c,80 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;ir_rcv.c,81 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;ir_rcv.c,82 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;ir_rcv.c,85 :: 		void Timer_Init(void)
;ir_rcv.c,87 :: 		TCON = 0x01;
	MOV TCON+0, #1
;ir_rcv.c,88 :: 		TMOD = 0x01;
	MOV TMOD+0, #1
;ir_rcv.c,89 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;ir_rcv.c,92 :: 		void Port_IO_Init(void)
;ir_rcv.c,112 :: 		P1MDOUT = 0xC0;
	MOV P1MDOUT+0, #192
;ir_rcv.c,113 :: 		P0SKIP = 0x01;
	MOV P0SKIP+0, #1
;ir_rcv.c,114 :: 		P1SKIP = 0xC0;
	MOV P1SKIP+0, #192
;ir_rcv.c,115 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;ir_rcv.c,116 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;ir_rcv.c,119 :: 		void Oscillator_Init(void)
;ir_rcv.c,121 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;ir_rcv.c,122 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;ir_rcv.c,125 :: 		void Interrupts_Init(void)
;ir_rcv.c,127 :: 		IE = 0x81;
	MOV IE+0, #129
;ir_rcv.c,128 :: 		IT01CF = 0x00;
	MOV IT01CF+0, #0
;ir_rcv.c,129 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;ir_rcv.c,132 :: 		void Init_Device(void)
;ir_rcv.c,134 :: 		PCA_Init();
	LCALL _PCA_Init+0
;ir_rcv.c,135 :: 		Timer_Init();
	LCALL _Timer_Init+0
;ir_rcv.c,136 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;ir_rcv.c,137 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;ir_rcv.c,138 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;ir_rcv.c,139 :: 		}
	RET
; end of _Init_Device

_erase_frames:
;ir_rcv.c,142 :: 		void erase_frames(void)
;ir_rcv.c,144 :: 		delay_ms(90);
	MOV R5, 6
	MOV R6, 152
	MOV R7, 203
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;ir_rcv.c,146 :: 		for(bits = 0; bits < 33; bits++)
	MOV _bits+0, #0
L_erase_frames116:
	CLR C
	MOV A, _bits+0
	SUBB A, #33
	JNC L_erase_frames117
;ir_rcv.c,148 :: 		frames[bits] = 0x0000;
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__erase_frames177
L__erase_frames178:
	CLR C
	RLC A
L__erase_frames177:
	DJNZ R1, L__erase_frames178
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV @R0, #0
	INC R0
	MOV @R0, #0
;ir_rcv.c,146 :: 		for(bits = 0; bits < 33; bits++)
	INC _bits+0
;ir_rcv.c,149 :: 		}
	SJMP L_erase_frames116
L_erase_frames117:
;ir_rcv.c,151 :: 		set_timer();
	LCALL _set_timer+0
;ir_rcv.c,152 :: 		received = 0;
	CLR C
	MOV A, _received+0
	MOV #224, C
	MOV _received+0, A
;ir_rcv.c,153 :: 		bits = 0;
	MOV _bits+0, #0
;ir_rcv.c,154 :: 		}
	RET
; end of _erase_frames

_get_timer:
;ir_rcv.c,157 :: 		unsigned int get_timer(void)
;ir_rcv.c,159 :: 		unsigned int time = 0;
	MOV get_timer_time_L0+0, #0
	MOV get_timer_time_L0+1, #0
;ir_rcv.c,161 :: 		time = TH0;
	MOV get_timer_time_L0+0, ___CC2D+0
	CLR A
	MOV get_timer_time_L0+1, A
;ir_rcv.c,162 :: 		time <<= 8;
	MOV R1, get_timer_time_L0+0
	MOV R0, #0
	MOV get_timer_time_L0+0, 0
	MOV get_timer_time_L0+1, 1
;ir_rcv.c,163 :: 		time |= TL0;
	MOV A, TL0+0
	ORL 0, A
	CLR A
	ORL 1, A
	MOV get_timer_time_L0+0, 0
	MOV get_timer_time_L0+1, 1
;ir_rcv.c,165 :: 		return time;
;ir_rcv.c,166 :: 		}
	RET
; end of _get_timer

_set_timer:
;ir_rcv.c,169 :: 		void set_timer(void)
;ir_rcv.c,171 :: 		TH0 = 0;
	MOV TH0+0, #0
;ir_rcv.c,172 :: 		TL0 = 0;
	MOV TL0+0, #0
;ir_rcv.c,173 :: 		}
	RET
; end of _set_timer

_decode:
;ir_rcv.c,176 :: 		unsigned char decode(unsigned char start_pos, unsigned char end_pos)
;ir_rcv.c,178 :: 		unsigned char value = 0;
	MOV decode_value_L0+0, #0
;ir_rcv.c,180 :: 		for(bits = start_pos; bits <= end_pos; bits++)
	MOV _bits+0, FARG_decode_start_pos+0
L_decode119:
	SETB C
	MOV A, _bits+0
	SUBB A, FARG_decode_end_pos+0
	JC #3
	LJMP L_decode120
;ir_rcv.c,182 :: 		value <<= 1;
	MOV R0, #1
	MOV A, decode_value_L0+0
	INC R0
	SJMP L__decode179
L__decode180:
	CLR C
	RLC A
L__decode179:
	DJNZ R0, L__decode180
	MOV decode_value_L0+0, A
;ir_rcv.c,183 :: 		if((frames[bits] >= one_low) && (frames[bits] <= one_high))
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__decode181
L__decode182:
	CLR C
	RLC A
L__decode181:
	DJNZ R1, L__decode182
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV 1, @R0
	INC R0
	MOV 2, @R0
	CLR C
	MOV A, R1
	SUBB A, #8
	MOV A, R2
	SUBB A, #7
	JC L_decode124
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__decode183
L__decode184:
	CLR C
	RLC A
L__decode183:
	DJNZ R1, L__decode184
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV 1, @R0
	INC R0
	MOV 2, @R0
	SETB C
	MOV A, R1
	SUBB A, #140
	MOV A, R2
	SUBB A, #10
	JNC L_decode124
L__decode146:
;ir_rcv.c,185 :: 		value |= 1;
	ORL decode_value_L0+0, #1
;ir_rcv.c,186 :: 		}
	LJMP L_decode125
L_decode124:
;ir_rcv.c,187 :: 		else if((frames[bits] >= zero_low) && (frames[bits] <= zero_high))
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__decode185
L__decode186:
	CLR C
	RLC A
L__decode185:
	DJNZ R1, L__decode186
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV 1, @R0
	INC R0
	MOV 2, @R0
	CLR C
	MOV A, R1
	SUBB A, #132
	MOV A, R2
	SUBB A, #3
	JC L_decode128
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__decode187
L__decode188:
	CLR C
	RLC A
L__decode187:
	DJNZ R1, L__decode188
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV 1, @R0
	INC R0
	MOV 2, @R0
	SETB C
	MOV A, R1
	SUBB A, #120
	MOV A, R2
	SUBB A, #5
	JNC L_decode128
L__decode145:
;ir_rcv.c,189 :: 		value |= 0;
;ir_rcv.c,190 :: 		}
	SJMP L_decode129
L_decode128:
;ir_rcv.c,191 :: 		else if((frames[bits] >= sync_low) && (frames[bits] <= sync_high))
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__decode189
L__decode190:
	CLR C
	RLC A
L__decode189:
	DJNZ R1, L__decode190
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV 1, @R0
	INC R0
	MOV 2, @R0
	CLR C
	MOV A, R1
	SUBB A, #48
	MOV A, R2
	SUBB A, #42
	JC L_decode132
	MOV R1, #1
	MOV A, _bits+0
	INC R1
	SJMP L__decode191
L__decode192:
	CLR C
	RLC A
L__decode191:
	DJNZ R1, L__decode192
	MOV R0, A
	MOV A, #_frames+0
	ADD A, R0
	MOV R0, A
	MOV 1, @R0
	INC R0
	MOV 2, @R0
	SETB C
	MOV A, R1
	SUBB A, #128
	MOV A, R2
	SUBB A, #62
	JNC L_decode132
L__decode144:
;ir_rcv.c,193 :: 		return 0xFF;
	MOV R0, #255
	RET
;ir_rcv.c,194 :: 		}
L_decode132:
L_decode129:
L_decode125:
;ir_rcv.c,180 :: 		for(bits = start_pos; bits <= end_pos; bits++)
	INC _bits+0
;ir_rcv.c,195 :: 		}
	LJMP L_decode119
L_decode120:
;ir_rcv.c,197 :: 		return value;
	MOV R0, decode_value_L0+0
;ir_rcv.c,198 :: 		}
	RET
; end of _decode

_decode_NEC:
;ir_rcv.c,201 :: 		void decode_NEC(unsigned char *addr, unsigned char *cmd)
;ir_rcv.c,203 :: 		*addr = decode(2, 9);
	MOV FARG_decode_start_pos+0, #2
	MOV FARG_decode_end_pos+0, #9
	LCALL _decode+0
	MOV FLOC__decode_NEC+0, 0
	MOV R0, FARG_decode_NEC_addr+0
	MOV @R0, FLOC__decode_NEC+0
;ir_rcv.c,204 :: 		*cmd = decode(18, 25);
	MOV FARG_decode_start_pos+0, #18
	MOV FARG_decode_end_pos+0, #25
	LCALL _decode+0
	MOV FLOC__decode_NEC+0, 0
	MOV R0, FARG_decode_NEC_cmd+0
	MOV @R0, FLOC__decode_NEC+0
;ir_rcv.c,205 :: 		}
	RET
; end of _decode_NEC
