
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
	SJMP L__SW_I2C_read145
L__SW_I2C_read146:
	CLR C
	RLC A
L__SW_I2C_read145:
	DJNZ R0, L__SW_I2C_read146
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
	SJMP L__SW_I2C_write147
L__SW_I2C_write148:
	CLR C
	RRC A
L__SW_I2C_write147:
	DJNZ R0, L__SW_I2C_write148
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
	SJMP L__SW_I2C_write149
L__SW_I2C_write150:
	CLR C
	RLC A
L__SW_I2C_write149:
	DJNZ R0, L__SW_I2C_write150
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
	MOV cap_meter_bl_state+0, #1
;lcd_2_wire.c,14 :: 		data_value = 0x04;
	MOV cap_meter_data_value+0, #4
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
	MOV A, cap_meter_data_value+0
	ORL A, #4
	MOV R0, A
	MOV cap_meter_data_value+0, 0
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
	MOV A, cap_meter_data_value+0
	ANL A, #249
	MOV R0, A
	MOV cap_meter_data_value+0, 0
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
	ANL cap_meter_data_value+0, #244
;lcd_2_wire.c,47 :: 		break;
	SJMP L_LCD_send43
;lcd_2_wire.c,49 :: 		case DAT:
L_LCD_send45:
;lcd_2_wire.c,51 :: 		data_value |= 0x01;
	ORL cap_meter_data_value+0, #1
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
	ORL cap_meter_data_value+0, #8
;lcd_2_wire.c,61 :: 		break;
	SJMP L_LCD_send47
;lcd_2_wire.c,63 :: 		case BL_OFF:
L_LCD_send49:
;lcd_2_wire.c,65 :: 		data_value &= 0xF7;
	ANL cap_meter_data_value+0, #247
;lcd_2_wire.c,66 :: 		break;
	SJMP L_LCD_send47
;lcd_2_wire.c,68 :: 		}
L_LCD_send46:
	MOV A, cap_meter_bl_state+0
	XRL A, #1
	JZ L_LCD_send48
	MOV A, cap_meter_bl_state+0
	JZ L_LCD_send49
L_LCD_send47:
;lcd_2_wire.c,70 :: 		PCF8574_write(data_value);
	MOV FARG_PCF8574_write_data_byte+0, cap_meter_data_value+0
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
	MOV A, cap_meter_data_value+0
	ANL A, #15
	MOV R0, A
	MOV cap_meter_data_value+0, 0
;lcd_2_wire.c,82 :: 		data_value |= temp;
	MOV A, R1
	ORL 0, A
	MOV cap_meter_data_value+0, 0
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
	SJMP L__LCD_4bit_send151
L__LCD_4bit_send152:
	CLR C
	RLC A
L__LCD_4bit_send151:
	DJNZ R0, L__LCD_4bit_send152
	MOV R1, A
;lcd_2_wire.c,88 :: 		data_value &= 0x0F;
	MOV A, cap_meter_data_value+0
	ANL A, #15
	MOV R0, A
	MOV cap_meter_data_value+0, 0
;lcd_2_wire.c,89 :: 		data_value |= temp;
	MOV A, R1
	ORL 0, A
	MOV cap_meter_data_value+0, 0
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
L__LCD_putchar130:
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
L__print_C133:
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
L__print_C132:
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
L__print_C131:
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
L__print_I136:
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
L__print_I135:
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
L__print_I134:
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
	JC L__print_F153
	MOV R0, #0
	SJMP L__print_F154
L__print_F153:
	MOV R0, #1
L__print_F154:
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
	JNC L__print_F155
	MOV R0, #0
	SJMP L__print_F156
L__print_F155:
	MOV R0, #1
L__print_F156:
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
	JC L__print_F157
	MOV R0, #0
	SJMP L__print_F158
L__print_F157:
	MOV R0, #1
L__print_F158:
	MOV A, R0
	JZ L_print_F97
L__print_F140:
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
	JNC L__print_F159
	MOV R0, #0
	SJMP L__print_F160
L__print_F159:
	MOV R0, #1
L__print_F160:
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
	JC L__print_F161
	MOV R0, #0
	SJMP L__print_F162
L__print_F161:
	MOV R0, #1
L__print_F162:
	MOV A, R0
	JZ L_print_F101
L__print_F139:
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
	JNC L__print_F163
	MOV R0, #0
	SJMP L__print_F164
L__print_F163:
	MOV R0, #1
L__print_F164:
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
	JC L__print_F165
	MOV R0, #0
	SJMP L__print_F166
L__print_F165:
	MOV R0, #1
L__print_F166:
	MOV A, R0
	JZ L_print_F105
L__print_F138:
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
	JNC L__print_F167
	MOV R0, #0
	SJMP L__print_F168
L__print_F167:
	MOV R0, #1
L__print_F168:
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
	JC L__print_F169
	MOV R0, #0
	SJMP L__print_F170
L__print_F169:
	MOV R0, #1
L__print_F170:
	MOV A, R0
	JZ L_print_F109
L__print_F137:
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
	JC L__print_F171
	MOV R0, #0
	SJMP L__print_F172
L__print_F171:
	MOV R0, #1
L__print_F172:
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

_Timer_1_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;cap_meter.c,31 :: 		ics ICS_AUTO
;cap_meter.c,33 :: 		ovf++;
	INC _ovf+0
;cap_meter.c,34 :: 		TF1_bit = 0;
	CLR TF1_bit+0
;cap_meter.c,35 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer_1_ISR

_Analog_Comparator_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;cap_meter.c,41 :: 		ics ICS_AUTO
;cap_meter.c,43 :: 		if(CP0FIF_bit)
	MOV A, CP0FIF_bit+0
	JNB 224, L_Analog_Comparator_ISR112
	NOP
;cap_meter.c,45 :: 		measurement_done = 1;
	MOV _measurement_done+0, #1
;cap_meter.c,46 :: 		TCON = 0x00;
	MOV TCON+0, #0
;cap_meter.c,47 :: 		P0_2_bit = 0;
	CLR P0_2_bit+0
;cap_meter.c,48 :: 		CP0FIF_bit = 0;
	CLR C
	MOV A, CP0FIF_bit+0
	MOV #224, C
	MOV CP0FIF_bit+0, A
;cap_meter.c,49 :: 		}
L_Analog_Comparator_ISR112:
;cap_meter.c,50 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Analog_Comparator_ISR

_main:
	MOV SP+0, #128
;cap_meter.c,53 :: 		void main(void)
;cap_meter.c,55 :: 		float c = 0.0;
	MOV 130, #?ICSmain_c_L0+0
	MOV 131, hi(#?ICSmain_c_L0+0)
	MOV R0, #main_c_L0+0
	MOV R1, #8
	LCALL ___CC2D+0
;cap_meter.c,56 :: 		unsigned long cnt = 0;
;cap_meter.c,58 :: 		Init_Device();
	LCALL _Init_Device+0
;cap_meter.c,59 :: 		LCD_init();
	LCALL _LCD_init+0
;cap_meter.c,60 :: 		LCD_clear_home();
	LCALL _LCD_clear_home+0
;cap_meter.c,62 :: 		LCD_goto(0, 0);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #0
	LCALL _LCD_goto+0
;cap_meter.c,63 :: 		LCD_putstr("Capacitance/ F:");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr1_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,65 :: 		while(1)
L_main113:
;cap_meter.c,67 :: 		if((measure_button == 0) && (measurement_done == 0))
	JB P1_4_bit+0, L_main117
	NOP
	MOV A, _measurement_done+0
	JNZ L_main117
L__main144:
;cap_meter.c,69 :: 		reset_timer_1();
	LCALL _reset_timer_1+0
;cap_meter.c,70 :: 		LCD_goto(0, 1);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #1
	LCALL _LCD_goto+0
;cap_meter.c,71 :: 		LCD_putstr("Discharging!  ");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr2_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,72 :: 		P0MDIN = 0xFE;
	MOV P0MDIN+0, #254
;cap_meter.c,73 :: 		P0MDOUT = 0x06;
	MOV P0MDOUT+0, #6
;cap_meter.c,74 :: 		P0_1_bit = 0;
	CLR P0_1_bit+0
;cap_meter.c,75 :: 		P0_2_bit = 0;
	CLR P0_2_bit+0
;cap_meter.c,76 :: 		delay_ms(4000);
	MOV R5, 249
	MOV R6, 148
	MOV R7, 181
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;cap_meter.c,77 :: 		P0MDIN = 0xFC;
	MOV P0MDIN+0, #252
;cap_meter.c,78 :: 		P0MDOUT = 0x04;
	MOV P0MDOUT+0, #4
;cap_meter.c,79 :: 		TCON = 0x40;
	MOV TCON+0, #64
;cap_meter.c,80 :: 		P0_2_bit = 1;
	SETB P0_2_bit+0
;cap_meter.c,81 :: 		LCD_goto(0, 1);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #1
	LCALL _LCD_goto+0
;cap_meter.c,82 :: 		LCD_putstr("Measuring!    ");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr3_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,83 :: 		delay_ms(4000);
	MOV R5, 249
	MOV R6, 148
	MOV R7, 181
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
	NOP
;cap_meter.c,84 :: 		}
L_main117:
;cap_meter.c,86 :: 		if(measurement_done)
	MOV A, _measurement_done+0
	JNZ #3
	LJMP L_main118
;cap_meter.c,88 :: 		cnt = ovf;
	MOV main_cnt_L0+0, _ovf+0
	CLR A
	MOV main_cnt_L0+1, A
	CLR A
	MOV main_cnt_L0+2, A
	CLR A
	MOV main_cnt_L0+3, A
;cap_meter.c,89 :: 		cnt <<= 16;
	MOV R3, main_cnt_L0+1
	MOV R2, main_cnt_L0+0
	MOV R0, #0
	MOV R1, #0
	MOV main_cnt_L0+0, 0
	MOV main_cnt_L0+1, 1
	MOV main_cnt_L0+2, 2
	MOV main_cnt_L0+3, 3
;cap_meter.c,90 :: 		cnt += get_timer_1();
	LCALL _get_timer_1+0
	MOV A, R0
	ADD A, main_cnt_L0+0
	MOV R0, A
	MOV A, R1
	ADDC A, main_cnt_L0+1
	MOV R1, A
	CLR A
	ADDC A, main_cnt_L0+2
	MOV R2, A
	CLR A
	ADDC A, main_cnt_L0+3
	MOV R3, A
	MOV main_cnt_L0+0, 0
	MOV main_cnt_L0+1, 1
	MOV main_cnt_L0+2, 2
	MOV main_cnt_L0+3, 3
;cap_meter.c,91 :: 		c = ((cnt * us_per_tick) / div_factor);
	LCALL _LongWord2Double+0
	MOV R4, #135
	MOV R5, #198
	MOV R6, #122
	MOV 7, #63
	LCALL _Mul_32x32_FP+0
	MOV R4, #195
	MOV R5, #155
	MOV R6, #216
	MOV 7, #69
	LCALL _Div_32x32_FP+0
	MOV main_c_L0+0, 0
	MOV main_c_L0+1, 1
	MOV main_c_L0+2, 2
	MOV main_c_L0+3, 3
;cap_meter.c,92 :: 		c *= scale_factor;
	MOV R4, #0
	MOV R5, #0
	MOV R6, #72
	MOV 7, #66
	LCALL _Mul_32x32_FP+0
	MOV main_c_L0+0, 0
	MOV main_c_L0+1, 1
	MOV main_c_L0+2, 2
	MOV main_c_L0+3, 3
;cap_meter.c,94 :: 		LCD_goto(0, 1);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #1
	LCALL _LCD_goto+0
;cap_meter.c,95 :: 		LCD_putstr("             ");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr4_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,97 :: 		if((c > 0.0) && (c < 10000000.0))
	SETB C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Compare_Double+0
	JZ L__main173
	JC L__main173
	MOV R0, #1
	SJMP L__main174
L__main173:
	MOV R0, #0
L__main174:
	MOV A, R0
	JNZ #3
	LJMP L_main121
	CLR C
	MOV R4, #128
	MOV R5, #150
	MOV R6, #24
	MOV 7, #75
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Compare_Double+0
	JC L__main175
	MOV R0, #0
	SJMP L__main176
L__main175:
	MOV R0, #1
L__main176:
	MOV A, R0
	JNZ #3
	LJMP L_main121
L__main143:
;cap_meter.c,99 :: 		if((c > 0) && (c < 1000))
	SETB C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV 7, #0
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Compare_Double+0
	JZ L__main177
	JC L__main177
	MOV R0, #1
	SJMP L__main178
L__main177:
	MOV R0, #0
L__main178:
	MOV A, R0
	JZ L_main124
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Compare_Double+0
	JC L__main179
	MOV R0, #0
	SJMP L__main180
L__main179:
	MOV R0, #1
L__main180:
	MOV A, R0
	JZ L_main124
L__main142:
;cap_meter.c,101 :: 		LCD_goto(12, 0);
	MOV FARG_LCD_goto_x_pos+0, #12
	MOV FARG_LCD_goto_y_pos+0, #0
	LCALL _LCD_goto+0
;cap_meter.c,102 :: 		LCD_putstr("n");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr5_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,103 :: 		}
	LJMP L_main125
L_main124:
;cap_meter.c,104 :: 		else if((c >= 1000.0) && (c < 10000000.0))
	CLR C
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Compare_Double+0
	JNC L__main181
	MOV R0, #0
	SJMP L__main182
L__main181:
	MOV R0, #1
L__main182:
	MOV A, R0
	JZ L_main128
	CLR C
	MOV R4, #128
	MOV R5, #150
	MOV R6, #24
	MOV 7, #75
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Compare_Double+0
	JC L__main183
	MOV R0, #0
	SJMP L__main184
L__main183:
	MOV R0, #1
L__main184:
	MOV A, R0
	JZ L_main128
L__main141:
;cap_meter.c,106 :: 		c /= 1000.0;
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	MOV R0, main_c_L0+0
	MOV R1, main_c_L0+1
	MOV R2, main_c_L0+2
	MOV R3, main_c_L0+3
	LCALL _Div_32x32_FP+0
	MOV main_c_L0+0, 0
	MOV main_c_L0+1, 1
	MOV main_c_L0+2, 2
	MOV main_c_L0+3, 3
;cap_meter.c,107 :: 		LCD_goto(12, 0);
	MOV FARG_LCD_goto_x_pos+0, #12
	MOV FARG_LCD_goto_y_pos+0, #0
	LCALL _LCD_goto+0
;cap_meter.c,108 :: 		LCD_putstr("u");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr6_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,109 :: 		}
L_main128:
L_main125:
;cap_meter.c,111 :: 		print_F(0, 1, c, 1);
	MOV FARG_print_F_x_pos+0, #0
	MOV FARG_print_F_y_pos+0, #1
	MOV FARG_print_F_value+0, main_c_L0+0
	MOV FARG_print_F_value+1, main_c_L0+1
	MOV FARG_print_F_value+2, main_c_L0+2
	MOV FARG_print_F_value+3, main_c_L0+3
	MOV FARG_print_F_points+0, #1
	LCALL _print_F+0
;cap_meter.c,112 :: 		}
	SJMP L_main129
L_main121:
;cap_meter.c,116 :: 		LCD_goto(0, 1);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #1
	LCALL _LCD_goto+0
;cap_meter.c,117 :: 		LCD_putstr("O.L");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr7_cap_meter+0
	LCALL _LCD_putstr+0
;cap_meter.c,118 :: 		}
L_main129:
;cap_meter.c,120 :: 		measurement_done = 0;
	MOV _measurement_done+0, #0
;cap_meter.c,121 :: 		}
L_main118:
;cap_meter.c,122 :: 		};
	LJMP L_main113
;cap_meter.c,123 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;cap_meter.c,126 :: 		void PCA_Init(void)
;cap_meter.c,128 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;cap_meter.c,129 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;cap_meter.c,130 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;cap_meter.c,133 :: 		void Timer_Init(void)
;cap_meter.c,135 :: 		TMOD = 0x10;
	MOV TMOD+0, #16
;cap_meter.c,136 :: 		}
	RET
; end of _Timer_Init

_Comparator_Init:
;cap_meter.c,139 :: 		void Comparator_Init(void)
;cap_meter.c,141 :: 		CPT0CN = 0x8A;
	MOV CPT0CN+0, #138
;cap_meter.c,142 :: 		delay_us(20);
	MOV R7, 81
	DJNZ R7, 
	NOP
;cap_meter.c,143 :: 		CPT0CN &= ~0x30;
	ANL CPT0CN+0, #207
;cap_meter.c,144 :: 		CPT0MX = 0x00;
	MOV CPT0MX+0, #0
;cap_meter.c,145 :: 		CPT0MD = 0x11;
	MOV CPT0MD+0, #17
;cap_meter.c,146 :: 		}
	RET
; end of _Comparator_Init

_Port_IO_Init:
;cap_meter.c,148 :: 		void Port_IO_Init(void)
;cap_meter.c,168 :: 		P0MDIN = 0xFC;
	MOV P0MDIN+0, #252
;cap_meter.c,169 :: 		P0MDOUT = 0x04;
	MOV P0MDOUT+0, #4
;cap_meter.c,170 :: 		P1MDOUT = 0xC0;
	MOV P1MDOUT+0, #192
;cap_meter.c,171 :: 		P0SKIP = 0x07;
	MOV P0SKIP+0, #7
;cap_meter.c,172 :: 		P1SKIP = 0xD0;
	MOV P1SKIP+0, #208
;cap_meter.c,173 :: 		XBR1 = 0xC0;
	MOV XBR1+0, #192
;cap_meter.c,174 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;cap_meter.c,177 :: 		void Oscillator_Init(void)
;cap_meter.c,179 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;cap_meter.c,180 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;cap_meter.c,183 :: 		void Interrupts_Init(void)
;cap_meter.c,185 :: 		IE = 0x88;
	MOV IE+0, #136
;cap_meter.c,186 :: 		EIE1 = 0x20;
	MOV EIE1+0, #32
;cap_meter.c,187 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;cap_meter.c,190 :: 		void Init_Device(void)
;cap_meter.c,192 :: 		PCA_Init();
	LCALL _PCA_Init+0
;cap_meter.c,193 :: 		Comparator_Init();
	LCALL _Comparator_Init+0
;cap_meter.c,194 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;cap_meter.c,195 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;cap_meter.c,196 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;cap_meter.c,197 :: 		}
	RET
; end of _Init_Device

_reset_timer_1:
;cap_meter.c,200 :: 		void reset_timer_1(void)
;cap_meter.c,202 :: 		ovf = 0;
	MOV _ovf+0, #0
;cap_meter.c,203 :: 		TH1 = 0x00;
	MOV TH1+0, #0
;cap_meter.c,204 :: 		TL1 = 0x00;
	MOV TL1+0, #0
;cap_meter.c,205 :: 		}
	RET
; end of _reset_timer_1

_get_timer_1:
;cap_meter.c,208 :: 		unsigned int get_timer_1(void)
;cap_meter.c,210 :: 		unsigned int counts = 0;
	MOV get_timer_1_counts_L0+0, #0
	MOV get_timer_1_counts_L0+1, #0
;cap_meter.c,212 :: 		counts = TH1;
	MOV get_timer_1_counts_L0+0, ___CC2D+0
	CLR A
	MOV get_timer_1_counts_L0+1, A
;cap_meter.c,213 :: 		counts <<= 8;
	MOV R1, get_timer_1_counts_L0+0
	MOV R0, #0
	MOV get_timer_1_counts_L0+0, 0
	MOV get_timer_1_counts_L0+1, 1
;cap_meter.c,214 :: 		counts |= TL1;
	MOV A, TL1+0
	ORL 0, A
	CLR A
	ORL 1, A
	MOV get_timer_1_counts_L0+0, 0
	MOV get_timer_1_counts_L0+1, 1
;cap_meter.c,216 :: 		return counts;
;cap_meter.c,217 :: 		}
	RET
; end of _get_timer_1
