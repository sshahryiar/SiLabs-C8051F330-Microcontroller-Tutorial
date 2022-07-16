
_RGB_LCD_init:
;waveshare_rgb_lcd.c,4 :: 		void RGB_LCD_init(void)
;waveshare_rgb_lcd.c,6 :: 		Soft_I2C_Init();
	LCALL _Soft_I2C_Init+0
;waveshare_rgb_lcd.c,7 :: 		delay_ms(20);
	MOV R5, 2
	MOV R6, 63
	MOV R7, 43
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;waveshare_rgb_lcd.c,9 :: 		LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
	MOV FARG_LCD_I2C_write_value+0, #40
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,10 :: 		delay_ms(5);
	MOV R6, 80
	MOV R7, 138
	DJNZ R7, 
	DJNZ R6, 
	NOP
;waveshare_rgb_lcd.c,12 :: 		LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
	MOV FARG_LCD_I2C_write_value+0, #40
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,13 :: 		delay_ms(5);
	MOV R6, 80
	MOV R7, 138
	DJNZ R7, 
	DJNZ R6, 
	NOP
;waveshare_rgb_lcd.c,15 :: 		LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
	MOV FARG_LCD_I2C_write_value+0, #40
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,16 :: 		delay_ms(5);
	MOV R6, 80
	MOV R7, 138
	DJNZ R7, 
	DJNZ R6, 
	NOP
;waveshare_rgb_lcd.c,18 :: 		LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
	MOV FARG_LCD_I2C_write_value+0, #40
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,19 :: 		LCD_I2C_write((LCD_DISPLAY_CONTROL | LCD_DISPLAY_ON | LCD_CURSOR_OFF | LCD_BLINK_OFF), CMD);
	MOV FARG_LCD_I2C_write_value+0, #12
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,21 :: 		LCD_clear_home();
	LCALL _LCD_clear_home+0
;waveshare_rgb_lcd.c,23 :: 		LCD_I2C_write((LCD_ENTRY_MODE_SET | LCD_ENTRY_LEFT | LCD_ENTRY_SHIFT_DECREMENT), CMD);
	MOV FARG_LCD_I2C_write_value+0, #6
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,25 :: 		RGB_I2C_write(REG_MODE_1, 0x00);
	MOV FARG_RGB_I2C_write_reg+0, #0
	MOV FARG_RGB_I2C_write_value+0, #0
	LCALL _RGB_I2C_write+0
;waveshare_rgb_lcd.c,26 :: 		RGB_I2C_write(REG_OUTPUT, 0xFF);
	MOV FARG_RGB_I2C_write_reg+0, #8
	MOV FARG_RGB_I2C_write_value+0, #255
	LCALL _RGB_I2C_write+0
;waveshare_rgb_lcd.c,27 :: 		RGB_I2C_write(REG_MODE_2, 0x20);
	MOV FARG_RGB_I2C_write_reg+0, #1
	MOV FARG_RGB_I2C_write_value+0, #32
	LCALL _RGB_I2C_write+0
;waveshare_rgb_lcd.c,29 :: 		set_RGB(127, 127, 127);
	MOV FARG_set_RGB_R+0, #127
	MOV FARG_set_RGB_G+0, #127
	MOV FARG_set_RGB_B+0, #127
	LCALL _set_RGB+0
;waveshare_rgb_lcd.c,30 :: 		}
	RET
; end of _RGB_LCD_init

_I2C_bus_write:
;waveshare_rgb_lcd.c,33 :: 		void I2C_bus_write(unsigned char address, unsigned char value_1, unsigned char value_2)
;waveshare_rgb_lcd.c,35 :: 		Soft_I2C_Start();
	LCALL _Soft_I2C_Start+0
;waveshare_rgb_lcd.c,36 :: 		Soft_I2C_Write(address);
	MOV FARG_Soft_I2C_Write_data_+0, FARG_I2C_bus_write_address+0
	LCALL _Soft_I2C_Write+0
;waveshare_rgb_lcd.c,37 :: 		Soft_I2C_Write(value_1);
	MOV FARG_Soft_I2C_Write_data_+0, FARG_I2C_bus_write_value_1+0
	LCALL _Soft_I2C_Write+0
;waveshare_rgb_lcd.c,38 :: 		Soft_I2C_Write(value_2);
	MOV FARG_Soft_I2C_Write_data_+0, FARG_I2C_bus_write_value_2+0
	LCALL _Soft_I2C_Write+0
;waveshare_rgb_lcd.c,39 :: 		Soft_I2C_Stop();
	LCALL _Soft_I2C_Stop+0
;waveshare_rgb_lcd.c,40 :: 		}
	RET
; end of _I2C_bus_write

_LCD_I2C_write:
;waveshare_rgb_lcd.c,43 :: 		void LCD_I2C_write(unsigned char value, unsigned char mode)
;waveshare_rgb_lcd.c,45 :: 		I2C_bus_write(LCD_I2C_address, mode, value);
	MOV FARG_I2C_bus_write_address+0, #124
	MOV FARG_I2C_bus_write_value_1+0, FARG_LCD_I2C_write_mode+0
	MOV FARG_I2C_bus_write_value_2+0, FARG_LCD_I2C_write_value+0
	LCALL _I2C_bus_write+0
;waveshare_rgb_lcd.c,46 :: 		}
	RET
; end of _LCD_I2C_write

_RGB_I2C_write:
;waveshare_rgb_lcd.c,49 :: 		void RGB_I2C_write(unsigned char reg, unsigned char value)
;waveshare_rgb_lcd.c,51 :: 		I2C_bus_write(RGB_I2C_address, reg, value);
	MOV FARG_I2C_bus_write_address+0, #192
	MOV FARG_I2C_bus_write_value_1+0, FARG_RGB_I2C_write_reg+0
	MOV FARG_I2C_bus_write_value_2+0, FARG_RGB_I2C_write_value+0
	LCALL _I2C_bus_write+0
;waveshare_rgb_lcd.c,52 :: 		}
	RET
; end of _RGB_I2C_write

_set_RGB:
;waveshare_rgb_lcd.c,55 :: 		void set_RGB(unsigned char R, unsigned char G, unsigned char B)
;waveshare_rgb_lcd.c,57 :: 		RGB_I2C_write(REG_RED, R);
	MOV FARG_RGB_I2C_write_reg+0, #4
	MOV FARG_RGB_I2C_write_value+0, FARG_set_RGB_R+0
	LCALL _RGB_I2C_write+0
;waveshare_rgb_lcd.c,58 :: 		RGB_I2C_write(REG_GREEN, G);
	MOV FARG_RGB_I2C_write_reg+0, #3
	MOV FARG_RGB_I2C_write_value+0, FARG_set_RGB_G+0
	LCALL _RGB_I2C_write+0
;waveshare_rgb_lcd.c,59 :: 		RGB_I2C_write(REG_BLUE, B);
	MOV FARG_RGB_I2C_write_reg+0, #2
	MOV FARG_RGB_I2C_write_value+0, FARG_set_RGB_B+0
	LCALL _RGB_I2C_write+0
;waveshare_rgb_lcd.c,60 :: 		}
	RET
; end of _set_RGB

_LCD_goto:
;waveshare_rgb_lcd.c,63 :: 		void LCD_goto(unsigned char x_pos, unsigned char y_pos)
;waveshare_rgb_lcd.c,65 :: 		if(y_pos == 0)
	MOV A, FARG_LCD_goto_y_pos+0
	JNZ L_LCD_goto0
;waveshare_rgb_lcd.c,67 :: 		x_pos |= 0x80;
	ORL FARG_LCD_goto_x_pos+0, #128
;waveshare_rgb_lcd.c,68 :: 		}
	SJMP L_LCD_goto1
L_LCD_goto0:
;waveshare_rgb_lcd.c,71 :: 		x_pos |= 0xC0;
	ORL FARG_LCD_goto_x_pos+0, #192
;waveshare_rgb_lcd.c,72 :: 		}
L_LCD_goto1:
;waveshare_rgb_lcd.c,74 :: 		I2C_bus_write(LCD_I2C_address, 0x80, x_pos);
	MOV FARG_I2C_bus_write_address+0, #124
	MOV FARG_I2C_bus_write_value_1+0, #128
	MOV FARG_I2C_bus_write_value_2+0, FARG_LCD_goto_x_pos+0
	LCALL _I2C_bus_write+0
;waveshare_rgb_lcd.c,75 :: 		}
	RET
; end of _LCD_goto

_LCD_clear_home:
;waveshare_rgb_lcd.c,78 :: 		void LCD_clear_home(void)
;waveshare_rgb_lcd.c,80 :: 		LCD_I2C_write(LCD_CLEAR_DISPLAY, CMD);
	MOV FARG_LCD_I2C_write_value+0, #1
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,81 :: 		LCD_I2C_write(LCD_RETURN_HOME, CMD);
	MOV FARG_LCD_I2C_write_value+0, #2
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,82 :: 		delay_ms(2);
	MOV R6, 32
	MOV R7, 208
	DJNZ R7, 
	DJNZ R6, 
	NOP
;waveshare_rgb_lcd.c,83 :: 		}
	RET
; end of _LCD_clear_home

_LCD_putchar:
;waveshare_rgb_lcd.c,86 :: 		void LCD_putchar(char chr)
;waveshare_rgb_lcd.c,88 :: 		if((chr >= 0x20) && (chr <= 0x7F))
	CLR C
	MOV A, FARG_LCD_putchar_chr+0
	SUBB A, #32
	JC L_LCD_putchar4
	SETB C
	MOV A, FARG_LCD_putchar_chr+0
	SUBB A, #127
	JNC L_LCD_putchar4
L__LCD_putchar65:
;waveshare_rgb_lcd.c,90 :: 		LCD_I2C_write(chr, DAT);
	MOV FARG_LCD_I2C_write_value+0, FARG_LCD_putchar_chr+0
	MOV FARG_LCD_I2C_write_mode+0, #64
	LCALL _LCD_I2C_write+0
;waveshare_rgb_lcd.c,91 :: 		}
L_LCD_putchar4:
;waveshare_rgb_lcd.c,92 :: 		}
	RET
; end of _LCD_putchar

_LCD_putstr:
;waveshare_rgb_lcd.c,95 :: 		void LCD_putstr(char *lcd_string)
;waveshare_rgb_lcd.c,97 :: 		do
L_LCD_putstr5:
;waveshare_rgb_lcd.c,99 :: 		LCD_putchar(*lcd_string++);
	MOV R0, FARG_LCD_putstr_lcd_string+0
	MOV FARG_LCD_putchar_chr+0, @R0
	LCALL _LCD_putchar+0
	INC FARG_LCD_putstr_lcd_string+0
;waveshare_rgb_lcd.c,100 :: 		}while(*lcd_string != '\0') ;
	MOV R0, FARG_LCD_putstr_lcd_string+0
	MOV 1, @R0
	MOV A, R1
	JNZ L_LCD_putstr5
;waveshare_rgb_lcd.c,101 :: 		}
	RET
; end of _LCD_putstr

_load_custom_symbol:
;lcd_print_rgb.c,4 :: 		void load_custom_symbol(void)
;lcd_print_rgb.c,6 :: 		unsigned char s = 0;
	MOV load_custom_symbol_s_L0+0, #0
;lcd_print_rgb.c,13 :: 		LCD_I2C_write(0x40, CMD);
	MOV FARG_LCD_I2C_write_value+0, #64
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;lcd_print_rgb.c,15 :: 		for(s = 0; s < array_size; s++)
	MOV load_custom_symbol_s_L0+0, #0
L_load_custom_symbol8:
	CLR C
	MOV A, load_custom_symbol_s_L0+0
	SUBB A, #8
	JNC L_load_custom_symbol9
;lcd_print_rgb.c,17 :: 		LCD_I2C_write(custom_symbol[s], DAT);
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
	MOV FARG_LCD_I2C_write_value+0, 0
	MOV FARG_LCD_I2C_write_mode+0, #64
	LCALL _LCD_I2C_write+0
;lcd_print_rgb.c,15 :: 		for(s = 0; s < array_size; s++)
	INC load_custom_symbol_s_L0+0
;lcd_print_rgb.c,18 :: 		}
	SJMP L_load_custom_symbol8
L_load_custom_symbol9:
;lcd_print_rgb.c,20 :: 		LCD_I2C_write(0x80, CMD);
	MOV FARG_LCD_I2C_write_value+0, #128
	MOV FARG_LCD_I2C_write_mode+0, #128
	LCALL _LCD_I2C_write+0
;lcd_print_rgb.c,21 :: 		}
	RET
; end of _load_custom_symbol

_print_symbol:
;lcd_print_rgb.c,24 :: 		void print_symbol(unsigned char x_pos, unsigned char y_pos, unsigned char symbol_index)
;lcd_print_rgb.c,26 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_symbol_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_symbol_y_pos+0
	LCALL _LCD_goto+0
;lcd_print_rgb.c,27 :: 		LCD_I2C_write(symbol_index, DAT);
	MOV FARG_LCD_I2C_write_value+0, FARG_print_symbol_symbol_index+0
	MOV FARG_LCD_I2C_write_mode+0, #64
	LCALL _LCD_I2C_write+0
;lcd_print_rgb.c,28 :: 		}
	RET
; end of _print_symbol

_print_C:
;lcd_print_rgb.c,31 :: 		void print_C(unsigned char x_pos, unsigned char y_pos, signed int value)
;lcd_print_rgb.c,33 :: 		char ch[5] = {0x20, 0x20, 0x20, 0x20, '\0'};
	MOV print_C_ch_L0+0, #32
	MOV print_C_ch_L0+1, #32
	MOV print_C_ch_L0+2, #32
	MOV print_C_ch_L0+3, #32
	MOV print_C_ch_L0+4, #0
;lcd_print_rgb.c,35 :: 		if(value < 0x00)
	CLR C
	MOV A, FARG_print_C_value+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C11
;lcd_print_rgb.c,37 :: 		ch[0] = 0x2D;
	MOV print_C_ch_L0+0, #45
;lcd_print_rgb.c,38 :: 		value = -value;
	CLR C
	MOV A, #0
	SUBB A, FARG_print_C_value+0
	MOV FARG_print_C_value+0, A
	MOV A, #0
	SUBB A, FARG_print_C_value+1
	MOV FARG_print_C_value+1, A
;lcd_print_rgb.c,39 :: 		}
	SJMP L_print_C12
L_print_C11:
;lcd_print_rgb.c,42 :: 		ch[0] = 0x20;
	MOV print_C_ch_L0+0, #32
;lcd_print_rgb.c,43 :: 		}
L_print_C12:
;lcd_print_rgb.c,45 :: 		if((value > 99) && (value <= 999))
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #99
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JC L_print_C15
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #231
	MOV A, #3
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C15
L__print_C68:
;lcd_print_rgb.c,47 :: 		ch[1] = ((value / 100) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R0, FARG_print_C_value+0
	MOV R1, FARG_print_C_value+1
	LCALL _Div_16x16_S+0
	MOV A, #48
	ADD A, R0
	MOV print_C_ch_L0+1, A
;lcd_print_rgb.c,48 :: 		ch[2] = (((value % 100) / 10) + 0x30);
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
;lcd_print_rgb.c,49 :: 		ch[3] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,50 :: 		}
	LJMP L_print_C16
L_print_C15:
;lcd_print_rgb.c,51 :: 		else if((value > 9) && (value <= 99))
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #9
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JC L_print_C19
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #99
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C19
L__print_C67:
;lcd_print_rgb.c,53 :: 		ch[1] = (((value % 100) / 10) + 0x30);
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
;lcd_print_rgb.c,54 :: 		ch[2] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,55 :: 		ch[3] = 0x20;
	MOV print_C_ch_L0+3, #32
;lcd_print_rgb.c,56 :: 		}
	SJMP L_print_C20
L_print_C19:
;lcd_print_rgb.c,57 :: 		else if((value >= 0) && (value <= 9))
	CLR C
	MOV A, FARG_print_C_value+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JC L_print_C23
	SETB C
	MOV A, FARG_print_C_value+0
	SUBB A, #9
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_print_C_value+1
	XRL A, #128
	SUBB A, R0
	JNC L_print_C23
L__print_C66:
;lcd_print_rgb.c,59 :: 		ch[1] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,60 :: 		ch[2] = 0x20;
	MOV print_C_ch_L0+2, #32
;lcd_print_rgb.c,61 :: 		ch[3] = 0x20;
	MOV print_C_ch_L0+3, #32
;lcd_print_rgb.c,62 :: 		}
L_print_C23:
L_print_C20:
L_print_C16:
;lcd_print_rgb.c,64 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_C_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_C_y_pos+0
	LCALL _LCD_goto+0
;lcd_print_rgb.c,65 :: 		LCD_putstr(ch);
	MOV FARG_LCD_putstr_lcd_string+0, #print_C_ch_L0+0
	LCALL _LCD_putstr+0
;lcd_print_rgb.c,66 :: 		}
	RET
; end of _print_C

_print_I:
;lcd_print_rgb.c,69 :: 		void print_I(unsigned char x_pos, unsigned char y_pos, signed long value)
;lcd_print_rgb.c,71 :: 		char ch[7] = {0x20, 0x20, 0x20, 0x20, 0x20, 0x20, '\0'};
	MOV print_I_ch_L0+0, #32
	MOV print_I_ch_L0+1, #32
	MOV print_I_ch_L0+2, #32
	MOV print_I_ch_L0+3, #32
	MOV print_I_ch_L0+4, #32
	MOV print_I_ch_L0+5, #32
	MOV print_I_ch_L0+6, #0
;lcd_print_rgb.c,73 :: 		if(value < 0)
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
	JNC L_print_I24
;lcd_print_rgb.c,75 :: 		ch[0] = 0x2D;
	MOV print_I_ch_L0+0, #45
;lcd_print_rgb.c,76 :: 		value = -value;
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
;lcd_print_rgb.c,77 :: 		}
	SJMP L_print_I25
L_print_I24:
;lcd_print_rgb.c,80 :: 		ch[0] = 0x20;
	MOV print_I_ch_L0+0, #32
;lcd_print_rgb.c,81 :: 		}
L_print_I25:
;lcd_print_rgb.c,83 :: 		if(value > 9999)
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
	LJMP L_print_I26
;lcd_print_rgb.c,85 :: 		ch[1] = ((value / 10000) + 0x30);
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
;lcd_print_rgb.c,86 :: 		ch[2] = (((value % 10000)/ 1000) + 0x30);
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
;lcd_print_rgb.c,87 :: 		ch[3] = (((value % 1000) / 100) + 0x30);
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
;lcd_print_rgb.c,88 :: 		ch[4] = (((value % 100) / 10) + 0x30);
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
;lcd_print_rgb.c,89 :: 		ch[5] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,90 :: 		}
	LJMP L_print_I27
L_print_I26:
;lcd_print_rgb.c,92 :: 		else if((value > 999) && (value <= 9999))
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
	LJMP L_print_I30
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
	LJMP L_print_I30
L__print_I71:
;lcd_print_rgb.c,94 :: 		ch[1] = (((value % 10000)/ 1000) + 0x30);
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
;lcd_print_rgb.c,95 :: 		ch[2] = (((value % 1000) / 100) + 0x30);
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
;lcd_print_rgb.c,96 :: 		ch[3] = (((value % 100) / 10) + 0x30);
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
;lcd_print_rgb.c,97 :: 		ch[4] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,98 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print_rgb.c,99 :: 		}
	LJMP L_print_I31
L_print_I30:
;lcd_print_rgb.c,100 :: 		else if((value > 99) && (value <= 999))
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
	LJMP L_print_I34
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
	LJMP L_print_I34
L__print_I70:
;lcd_print_rgb.c,102 :: 		ch[1] = (((value % 1000) / 100) + 0x30);
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
;lcd_print_rgb.c,103 :: 		ch[2] = (((value % 100) / 10) + 0x30);
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
;lcd_print_rgb.c,104 :: 		ch[3] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,105 :: 		ch[4] = 0x20;
	MOV print_I_ch_L0+4, #32
;lcd_print_rgb.c,106 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print_rgb.c,107 :: 		}
	LJMP L_print_I35
L_print_I34:
;lcd_print_rgb.c,108 :: 		else if((value > 9) && (value <= 99))
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
	LJMP L_print_I38
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
	JNC L_print_I38
L__print_I69:
;lcd_print_rgb.c,110 :: 		ch[1] = (((value % 100) / 10) + 0x30);
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
;lcd_print_rgb.c,111 :: 		ch[2] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,112 :: 		ch[3] = 0x20;
	MOV print_I_ch_L0+3, #32
;lcd_print_rgb.c,113 :: 		ch[4] = 0x20;
	MOV print_I_ch_L0+4, #32
;lcd_print_rgb.c,114 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print_rgb.c,115 :: 		}
	SJMP L_print_I39
L_print_I38:
;lcd_print_rgb.c,118 :: 		ch[1] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,119 :: 		ch[2] = 0x20;
	MOV print_I_ch_L0+2, #32
;lcd_print_rgb.c,120 :: 		ch[3] = 0x20;
	MOV print_I_ch_L0+3, #32
;lcd_print_rgb.c,121 :: 		ch[4] = 0x20;
	MOV print_I_ch_L0+4, #32
;lcd_print_rgb.c,122 :: 		ch[5] = 0x20;
	MOV print_I_ch_L0+5, #32
;lcd_print_rgb.c,123 :: 		}
L_print_I39:
L_print_I35:
L_print_I31:
L_print_I27:
;lcd_print_rgb.c,125 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_I_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_I_y_pos+0
	LCALL _LCD_goto+0
;lcd_print_rgb.c,126 :: 		LCD_putstr(ch);
	MOV FARG_LCD_putstr_lcd_string+0, #print_I_ch_L0+0
	LCALL _LCD_putstr+0
;lcd_print_rgb.c,127 :: 		}
	RET
; end of _print_I

_print_D:
;lcd_print_rgb.c,130 :: 		void print_D(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char points)
;lcd_print_rgb.c,132 :: 		char ch[5] = {0x2E, 0x20, 0x20, 0x20, 0x20};
	MOV print_D_ch_L0+0, #46
	MOV print_D_ch_L0+1, #32
	MOV print_D_ch_L0+2, #32
	MOV print_D_ch_L0+3, #32
	MOV print_D_ch_L0+4, #32
;lcd_print_rgb.c,134 :: 		ch[1] = ((value / 100) + 0x30);
	MOV R4, #100
	MOV R5, #0
	MOV R0, FARG_print_D_value+0
	MOV R1, FARG_print_D_value+1
	LCALL _Div_16x16_S+0
	MOV A, #48
	ADD A, R0
	MOV print_D_ch_L0+1, A
;lcd_print_rgb.c,136 :: 		if(points > 1)
	SETB C
	MOV A, FARG_print_D_points+0
	SUBB A, #1
	JC L_print_D40
;lcd_print_rgb.c,138 :: 		ch[2] = (((value / 10) % 10) + 0x30);
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
;lcd_print_rgb.c,140 :: 		if(points > 1)
	SETB C
	MOV A, FARG_print_D_points+0
	SUBB A, #1
	JC L_print_D41
;lcd_print_rgb.c,142 :: 		ch[3] = ((value % 10) + 0x30);
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
;lcd_print_rgb.c,143 :: 		}
L_print_D41:
;lcd_print_rgb.c,144 :: 		}
L_print_D40:
;lcd_print_rgb.c,146 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_D_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_D_y_pos+0
	LCALL _LCD_goto+0
;lcd_print_rgb.c,147 :: 		LCD_putstr(ch);
	MOV FARG_LCD_putstr_lcd_string+0, #print_D_ch_L0+0
	LCALL _LCD_putstr+0
;lcd_print_rgb.c,148 :: 		}
	RET
; end of _print_D

_print_F:
;lcd_print_rgb.c,151 :: 		void print_F(unsigned char x_pos, unsigned char y_pos, float value, unsigned char points)
;lcd_print_rgb.c,153 :: 		signed long tmp = 0x00000000;
	MOV print_F_tmp_L0+0, #0
	MOV print_F_tmp_L0+1, #0
	MOV print_F_tmp_L0+2, #0
	MOV print_F_tmp_L0+3, #0
;lcd_print_rgb.c,155 :: 		tmp = value;
	MOV R0, FARG_print_F_value+0
	MOV R1, FARG_print_F_value+1
	MOV R2, FARG_print_F_value+2
	MOV R3, FARG_print_F_value+3
	LCALL _Double2Ints+0
	MOV print_F_tmp_L0+0, 0
	MOV print_F_tmp_L0+1, 1
	MOV print_F_tmp_L0+2, 2
	MOV print_F_tmp_L0+3, 3
;lcd_print_rgb.c,156 :: 		print_I(x_pos, y_pos, tmp);
	MOV FARG_print_I_x_pos+0, FARG_print_F_x_pos+0
	MOV FARG_print_I_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_I_value+0, 0
	MOV FARG_print_I_value+1, 1
	MOV FARG_print_I_value+2, 2
	MOV FARG_print_I_value+3, 3
	LCALL _print_I+0
;lcd_print_rgb.c,157 :: 		tmp = ((value - tmp) * 1000);
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
;lcd_print_rgb.c,159 :: 		if(tmp < 0)
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
	JNC L_print_F42
;lcd_print_rgb.c,161 :: 		tmp = -tmp;
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
;lcd_print_rgb.c,162 :: 		}
L_print_F42:
;lcd_print_rgb.c,164 :: 		if(value < 0)
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
	JC L__print_F76
	MOV R0, #0
	SJMP L__print_F77
L__print_F76:
	MOV R0, #1
L__print_F77:
	MOV A, R0
	JZ L_print_F43
;lcd_print_rgb.c,166 :: 		value = -value;
	XRL FARG_print_F_value+0, #0
	XRL FARG_print_F_value+1, #0
	XRL FARG_print_F_value+2, #0
	XRL FARG_print_F_value+3, #128
;lcd_print_rgb.c,167 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_F_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_F_y_pos+0
	LCALL _LCD_goto+0
;lcd_print_rgb.c,168 :: 		LCD_putchar(0x2D);
	MOV FARG_LCD_putchar_chr+0, #45
	LCALL _LCD_putchar+0
;lcd_print_rgb.c,169 :: 		}
	SJMP L_print_F44
L_print_F43:
;lcd_print_rgb.c,172 :: 		LCD_goto(x_pos, y_pos);
	MOV FARG_LCD_goto_x_pos+0, FARG_print_F_x_pos+0
	MOV FARG_LCD_goto_y_pos+0, FARG_print_F_y_pos+0
	LCALL _LCD_goto+0
;lcd_print_rgb.c,173 :: 		LCD_putchar(0x20);
	MOV FARG_LCD_putchar_chr+0, #32
	LCALL _LCD_putchar+0
;lcd_print_rgb.c,174 :: 		}
L_print_F44:
;lcd_print_rgb.c,176 :: 		if((value >= 10000) && (value < 100000))
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
	JNC L__print_F78
	MOV R0, #0
	SJMP L__print_F79
L__print_F78:
	MOV R0, #1
L__print_F79:
	MOV A, R0
	JZ L_print_F47
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
	JC L__print_F80
	MOV R0, #0
	SJMP L__print_F81
L__print_F80:
	MOV R0, #1
L__print_F81:
	MOV A, R0
	JZ L_print_F47
L__print_F75:
;lcd_print_rgb.c,178 :: 		print_D((x_pos + 6), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #6
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print_rgb.c,179 :: 		}
	LJMP L_print_F48
L_print_F47:
;lcd_print_rgb.c,180 :: 		else if((value >= 1000) && (value < 10000))
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
	JNC L__print_F82
	MOV R0, #0
	SJMP L__print_F83
L__print_F82:
	MOV R0, #1
L__print_F83:
	MOV A, R0
	JZ L_print_F51
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
	JC L__print_F84
	MOV R0, #0
	SJMP L__print_F85
L__print_F84:
	MOV R0, #1
L__print_F85:
	MOV A, R0
	JZ L_print_F51
L__print_F74:
;lcd_print_rgb.c,182 :: 		print_D((x_pos + 5), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #5
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print_rgb.c,183 :: 		}
	LJMP L_print_F52
L_print_F51:
;lcd_print_rgb.c,184 :: 		else if((value >= 100) && (value < 1000))
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
	JNC L__print_F86
	MOV R0, #0
	SJMP L__print_F87
L__print_F86:
	MOV R0, #1
L__print_F87:
	MOV A, R0
	JZ L_print_F55
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
	JC L__print_F88
	MOV R0, #0
	SJMP L__print_F89
L__print_F88:
	MOV R0, #1
L__print_F89:
	MOV A, R0
	JZ L_print_F55
L__print_F73:
;lcd_print_rgb.c,186 :: 		print_D((x_pos + 4), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #4
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print_rgb.c,187 :: 		}
	LJMP L_print_F56
L_print_F55:
;lcd_print_rgb.c,188 :: 		else if((value >= 10) && (value < 100))
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
	JNC L__print_F90
	MOV R0, #0
	SJMP L__print_F91
L__print_F90:
	MOV R0, #1
L__print_F91:
	MOV A, R0
	JZ L_print_F59
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
	JC L__print_F92
	MOV R0, #0
	SJMP L__print_F93
L__print_F92:
	MOV R0, #1
L__print_F93:
	MOV A, R0
	JZ L_print_F59
L__print_F72:
;lcd_print_rgb.c,190 :: 		print_D((x_pos + 3), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #3
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print_rgb.c,191 :: 		}
	SJMP L_print_F60
L_print_F59:
;lcd_print_rgb.c,192 :: 		else if(value < 10)
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
	JC L__print_F94
	MOV R0, #0
	SJMP L__print_F95
L__print_F94:
	MOV R0, #1
L__print_F95:
	MOV A, R0
	JZ L_print_F61
;lcd_print_rgb.c,194 :: 		print_D((x_pos + 2), y_pos, tmp, points);
	MOV A, FARG_print_F_x_pos+0
	ADD A, #2
	MOV FARG_print_D_x_pos+0, A
	MOV FARG_print_D_y_pos+0, FARG_print_F_y_pos+0
	MOV FARG_print_D_value+0, print_F_tmp_L0+0
	MOV FARG_print_D_value+1, print_F_tmp_L0+1
	MOV FARG_print_D_points+0, FARG_print_F_points+0
	LCALL _print_D+0
;lcd_print_rgb.c,195 :: 		}
L_print_F61:
L_print_F60:
L_print_F56:
L_print_F52:
L_print_F48:
;lcd_print_rgb.c,196 :: 		}
	RET
; end of _print_F

_EXTI_0_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;wiegand_26_rfid.c,20 :: 		ics ICS_AUTO
;wiegand_26_rfid.c,22 :: 		raw_card_data <<= 1;
	MOV R4, #1
	MOV R0, _raw_card_data+0
	MOV R1, _raw_card_data+1
	MOV R2, _raw_card_data+2
	MOV R3, _raw_card_data+3
	LCALL __shl_long+0
	MOV _raw_card_data+0, 0
	MOV _raw_card_data+1, 1
	MOV _raw_card_data+2, 2
	MOV _raw_card_data+3, 3
;wiegand_26_rfid.c,23 :: 		count++;
	INC _count+0
;wiegand_26_rfid.c,24 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _EXTI_0_ISR

_EXTI_1_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;wiegand_26_rfid.c,30 :: 		ics ICS_AUTO
;wiegand_26_rfid.c,32 :: 		raw_card_data <<= 1;
	MOV R4, #1
	MOV R0, _raw_card_data+0
	MOV R1, _raw_card_data+1
	MOV R2, _raw_card_data+2
	MOV R3, _raw_card_data+3
	LCALL __shl_long+0
	MOV _raw_card_data+0, 0
	MOV _raw_card_data+1, 1
	MOV _raw_card_data+2, 2
	MOV _raw_card_data+3, 3
;wiegand_26_rfid.c,33 :: 		raw_card_data |= 1;
	MOV A, #1
	ORL A, R0
	MOV _raw_card_data+0, A
	MOV A, #0
	ORL A, R1
	MOV _raw_card_data+1, A
	MOV A, #0
	ORL A, R2
	MOV _raw_card_data+2, A
	MOV A, #0
	ORL A, R3
	MOV _raw_card_data+3, A
;wiegand_26_rfid.c,34 :: 		count++;
	INC _count+0
;wiegand_26_rfid.c,35 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _EXTI_1_ISR

_main:
	MOV SP+0, #128
;wiegand_26_rfid.c,38 :: 		void main(void)
;wiegand_26_rfid.c,40 :: 		unsigned char facility_code = 0;
;wiegand_26_rfid.c,41 :: 		unsigned int card_number = 0;
	MOV main_card_number_L0+0, #0
	MOV main_card_number_L0+1, #0
;wiegand_26_rfid.c,43 :: 		Init_Device();
	LCALL _Init_Device+0
;wiegand_26_rfid.c,44 :: 		RGB_LCD_init();
	LCALL _RGB_LCD_init+0
;wiegand_26_rfid.c,45 :: 		LCD_clear_home();
	LCALL _LCD_clear_home+0
;wiegand_26_rfid.c,47 :: 		LCD_goto(0, 0);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #0
	LCALL _LCD_goto+0
;wiegand_26_rfid.c,48 :: 		LCD_putstr("Facility:");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr1_wiegand_26_rfid+0
	LCALL _LCD_putstr+0
;wiegand_26_rfid.c,50 :: 		LCD_goto(0, 1);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #1
	LCALL _LCD_goto+0
;wiegand_26_rfid.c,51 :: 		LCD_putstr("Card I.D:");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr2_wiegand_26_rfid+0
	LCALL _LCD_putstr+0
;wiegand_26_rfid.c,53 :: 		while(1)
L_main62:
;wiegand_26_rfid.c,55 :: 		if(count >= 25)
	CLR C
	MOV A, _count+0
	SUBB A, #25
	JC L_main64
;wiegand_26_rfid.c,57 :: 		card_number = (raw_card_data & 0xFFFF);
	MOV A, #255
	ANL A, _raw_card_data+0
	MOV main_card_number_L0+0, A
	MOV A, #255
	ANL A, _raw_card_data+1
	MOV main_card_number_L0+1, A
;wiegand_26_rfid.c,58 :: 		facility_code = (0xFF & (raw_card_data >> 0x10));
	MOV R0, _raw_card_data+2
	MOV R1, _raw_card_data+3
	MOV R2, #0
	ANL 0, #255
;wiegand_26_rfid.c,59 :: 		print_C(12, 0, facility_code);
	MOV FARG_print_C_x_pos+0, #12
	MOV FARG_print_C_y_pos+0, #0
	MOV FARG_print_C_value+0, 0
	CLR A
	MOV FARG_print_C_value+1, A
	LCALL _print_C+0
;wiegand_26_rfid.c,60 :: 		print_I(10, 1, card_number);
	MOV FARG_print_I_x_pos+0, #10
	MOV FARG_print_I_y_pos+0, #1
	MOV FARG_print_I_value+0, main_card_number_L0+0
	MOV FARG_print_I_value+1, main_card_number_L0+1
	CLR A
	MOV FARG_print_I_value+2, A
	CLR A
	MOV FARG_print_I_value+3, A
	LCALL _print_I+0
;wiegand_26_rfid.c,61 :: 		raw_card_data = 0;
	MOV _raw_card_data+0, #0
	MOV _raw_card_data+1, #0
	MOV _raw_card_data+2, #0
	MOV _raw_card_data+3, #0
;wiegand_26_rfid.c,62 :: 		count = 0;
	MOV _count+0, #0
;wiegand_26_rfid.c,63 :: 		}
L_main64:
;wiegand_26_rfid.c,64 :: 		};
	SJMP L_main62
;wiegand_26_rfid.c,65 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;wiegand_26_rfid.c,68 :: 		void PCA_Init(void)
;wiegand_26_rfid.c,70 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;wiegand_26_rfid.c,71 :: 		PCA0MD = 0x00;
	MOV PCA0MD+0, #0
;wiegand_26_rfid.c,72 :: 		}
	RET
; end of _PCA_Init

_Timer_Init:
;wiegand_26_rfid.c,75 :: 		void Timer_Init(void)
;wiegand_26_rfid.c,77 :: 		TCON = 0x05;
	MOV TCON+0, #5
;wiegand_26_rfid.c,78 :: 		}
	RET
; end of _Timer_Init

_Port_IO_Init:
;wiegand_26_rfid.c,81 :: 		void Port_IO_Init()
;wiegand_26_rfid.c,101 :: 		P1MDOUT = 0xC0;
	MOV P1MDOUT+0, #192
;wiegand_26_rfid.c,102 :: 		P0SKIP = 0x03;
	MOV P0SKIP+0, #3
;wiegand_26_rfid.c,103 :: 		P1SKIP = 0xC0;
	MOV P1SKIP+0, #192
;wiegand_26_rfid.c,104 :: 		XBR1 = 0x40;
	MOV XBR1+0, #64
;wiegand_26_rfid.c,105 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;wiegand_26_rfid.c,108 :: 		void Oscillator_Init(void)
;wiegand_26_rfid.c,110 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;wiegand_26_rfid.c,111 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;wiegand_26_rfid.c,114 :: 		void Interrupts_Init(void)
;wiegand_26_rfid.c,116 :: 		IE = 0x85;
	MOV IE+0, #133
;wiegand_26_rfid.c,117 :: 		IP = 0x05;
	MOV IP+0, #5
;wiegand_26_rfid.c,118 :: 		IT01CF = 0x10;
	MOV IT01CF+0, #16
;wiegand_26_rfid.c,119 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;wiegand_26_rfid.c,122 :: 		void Init_Device(void)
;wiegand_26_rfid.c,124 :: 		PCA_Init();
	LCALL _PCA_Init+0
;wiegand_26_rfid.c,125 :: 		Timer_Init();
	LCALL _Timer_Init+0
;wiegand_26_rfid.c,126 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;wiegand_26_rfid.c,127 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;wiegand_26_rfid.c,128 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;wiegand_26_rfid.c,129 :: 		}
	RET
; end of _Init_Device
