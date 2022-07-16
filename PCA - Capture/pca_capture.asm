
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
L__LCD_putchar79:
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
L__print_C82:
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
L__print_C81:
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
L__print_C80:
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
L__print_I85:
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
L__print_I84:
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
L__print_I83:
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
	JC L__print_F90
	MOV R0, #0
	SJMP L__print_F91
L__print_F90:
	MOV R0, #1
L__print_F91:
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
	JNC L__print_F92
	MOV R0, #0
	SJMP L__print_F93
L__print_F92:
	MOV R0, #1
L__print_F93:
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
	JC L__print_F94
	MOV R0, #0
	SJMP L__print_F95
L__print_F94:
	MOV R0, #1
L__print_F95:
	MOV A, R0
	JZ L_print_F47
L__print_F89:
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
	JNC L__print_F96
	MOV R0, #0
	SJMP L__print_F97
L__print_F96:
	MOV R0, #1
L__print_F97:
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
	JC L__print_F98
	MOV R0, #0
	SJMP L__print_F99
L__print_F98:
	MOV R0, #1
L__print_F99:
	MOV A, R0
	JZ L_print_F51
L__print_F88:
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
	JNC L__print_F100
	MOV R0, #0
	SJMP L__print_F101
L__print_F100:
	MOV R0, #1
L__print_F101:
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
	JC L__print_F102
	MOV R0, #0
	SJMP L__print_F103
L__print_F102:
	MOV R0, #1
L__print_F103:
	MOV A, R0
	JZ L_print_F55
L__print_F87:
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
	JNC L__print_F104
	MOV R0, #0
	SJMP L__print_F105
L__print_F104:
	MOV R0, #1
L__print_F105:
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
	JC L__print_F106
	MOV R0, #0
	SJMP L__print_F107
L__print_F106:
	MOV R0, #1
L__print_F107:
	MOV A, R0
	JZ L_print_F59
L__print_F86:
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
	JC L__print_F108
	MOV R0, #0
	SJMP L__print_F109
L__print_F108:
	MOV R0, #1
L__print_F109:
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

_PCA0_ISR:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;pca_capture.c,33 :: 		ics ICS_AUTO
;pca_capture.c,35 :: 		if(CF_bit)
	JNB CF_bit+0, L_PCA0_ISR62
	NOP
;pca_capture.c,37 :: 		overflow++;
	MOV A, #1
	ADD A, _overflow+0
	MOV _overflow+0, A
	MOV A, #0
	ADDC A, _overflow+1
	MOV _overflow+1, A
;pca_capture.c,38 :: 		CF_bit = 0;
	CLR CF_bit+0
;pca_capture.c,39 :: 		}
L_PCA0_ISR62:
;pca_capture.c,41 :: 		if(CCF0_bit)
	JNB CCF0_bit+0, L_PCA0_ISR63
	NOP
;pca_capture.c,43 :: 		current_capture = get_capture_count();
	LCALL _get_capture_count+0
	MOV _current_capture+0, 0
	MOV _current_capture+1, 1
;pca_capture.c,44 :: 		count = ((overflow << 16) + (current_capture - past_capture));
	MOV R5, _overflow+1
	MOV A, _overflow+0
	INC #16
	SJMP L__PCA0_ISR110
L__PCA0_ISR111:
	CLR C
	RLC A
	XCH A, R5
	RLC A
	XCH A, R5
L__PCA0_ISR110:
	DJNZ #16, L__PCA0_ISR111
	MOV R4, A
	CLR C
	MOV A, R0
	SUBB A, _past_capture+0
	MOV R2, A
	MOV A, R1
	SUBB A, _past_capture+1
	MOV R3, A
	MOV A, R4
	ADD A, R2
	MOV R2, A
	MOV A, R5
	ADDC A, R3
	MOV R3, A
	MOV _count+0, 2
	MOV _count+1, 3
	CLR A
	MOV _count+2, A
	CLR A
	MOV _count+3, A
;pca_capture.c,45 :: 		past_capture = current_capture;
	MOV _past_capture+0, 0
	MOV _past_capture+1, 1
;pca_capture.c,46 :: 		overflow = 0x00000;
	MOV _overflow+0, #0
	MOV _overflow+1, #0
;pca_capture.c,47 :: 		current_capture = 0;
	MOV _current_capture+0, #0
	MOV _current_capture+1, #0
;pca_capture.c,48 :: 		CCF0_bit = 0;
	CLR CCF0_bit+0
;pca_capture.c,49 :: 		}
L_PCA0_ISR63:
;pca_capture.c,50 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _PCA0_ISR

_main:
	MOV SP+0, #128
;pca_capture.c,53 :: 		void main(void)
;pca_capture.c,55 :: 		unsigned long f = 0;
	MOV 130, #?ICSmain_f_L0+0
	MOV 131, hi(#?ICSmain_f_L0+0)
	MOV R0, #main_f_L0+0
	MOV R1, #21
	LCALL ___CC2D+0
;pca_capture.c,56 :: 		unsigned long fr = 0;
;pca_capture.c,57 :: 		unsigned long fg = 0;
;pca_capture.c,58 :: 		unsigned long fb = 0;
;pca_capture.c,59 :: 		unsigned long fc = 0;
;pca_capture.c,60 :: 		unsigned char mode = 0;
;pca_capture.c,62 :: 		Init_Device();
	LCALL _Init_Device+0
;pca_capture.c,63 :: 		RGB_LCD_init();
	LCALL _RGB_LCD_init+0
;pca_capture.c,64 :: 		LCD_clear_home();
	LCALL _LCD_clear_home+0
;pca_capture.c,66 :: 		LCD_goto(0, 0);
	MOV FARG_LCD_goto_x_pos+0, #0
	MOV FARG_LCD_goto_y_pos+0, #0
	LCALL _LCD_goto+0
;pca_capture.c,67 :: 		LCD_putstr(" R%  G%  B%  fC");
	MOV FARG_LCD_putstr_lcd_string+0, #?lstr1_pca_capture+0
	LCALL _LCD_putstr+0
;pca_capture.c,69 :: 		while(1)
L_main64:
;pca_capture.c,71 :: 		switch(mode)
	SJMP L_main66
;pca_capture.c,73 :: 		case RED_filter:
L_main68:
;pca_capture.c,75 :: 		S2 = 0;
	CLR P1_4_bit+0
;pca_capture.c,76 :: 		S3 = 0;
	CLR P1_5_bit+0
;pca_capture.c,77 :: 		break;
	SJMP L_main67
;pca_capture.c,79 :: 		case BLUE_filter:
L_main69:
;pca_capture.c,81 :: 		S2 = 0;
	CLR P1_4_bit+0
;pca_capture.c,82 :: 		S3 = 1;
	SETB P1_5_bit+0
;pca_capture.c,83 :: 		break;
	SJMP L_main67
;pca_capture.c,85 :: 		case CLEAR_filter:
L_main70:
;pca_capture.c,87 :: 		S2 = 1;
	SETB P1_4_bit+0
;pca_capture.c,88 :: 		S3 = 0;
	CLR P1_5_bit+0
;pca_capture.c,89 :: 		break;
	SJMP L_main67
;pca_capture.c,91 :: 		case GREEN_filter:
L_main71:
;pca_capture.c,93 :: 		S2 = 1;
	SETB P1_4_bit+0
;pca_capture.c,94 :: 		S3 = 1;
	SETB P1_5_bit+0
;pca_capture.c,95 :: 		break;
	SJMP L_main67
;pca_capture.c,97 :: 		}
L_main66:
	MOV A, main_mode_L0+0
	JZ L_main68
	MOV A, main_mode_L0+0
	XRL A, #1
	JZ L_main69
	MOV A, main_mode_L0+0
	XRL A, #2
	JZ L_main70
	MOV A, main_mode_L0+0
	XRL A, #3
	JZ L_main71
L_main67:
;pca_capture.c,98 :: 		delay_ms(100);
	MOV R5, 7
	MOV R6, 55
	MOV R7, 226
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;pca_capture.c,100 :: 		f = (1020833 / ((float)count));
	MOV R0, _count+0
	MOV R1, _count+1
	MOV R2, _count+2
	MOV R3, _count+3
	LCALL _LongWord2Double+0
	MOV R4, 0
	MOV R5, 1
	MOV R6, 2
	MOV R7, 3
	MOV R0, #16
	MOV R1, #58
	MOV R2, #121
	MOV R3, #73
	LCALL _Div_32x32_FP+0
	LCALL _Double2Ints+0
	MOV main_f_L0+0, 0
	MOV main_f_L0+1, 1
	MOV main_f_L0+2, 2
	MOV main_f_L0+3, 3
;pca_capture.c,102 :: 		switch(mode)
	SJMP L_main72
;pca_capture.c,104 :: 		case RED_filter:
L_main74:
;pca_capture.c,106 :: 		fr = f;
	MOV main_fr_L0+0, main_f_L0+0
	MOV main_fr_L0+1, main_f_L0+1
	MOV main_fr_L0+2, main_f_L0+2
	MOV main_fr_L0+3, main_f_L0+3
;pca_capture.c,107 :: 		break;
	SJMP L_main73
;pca_capture.c,109 :: 		case BLUE_filter:
L_main75:
;pca_capture.c,111 :: 		fb = f;
	MOV main_fb_L0+0, main_f_L0+0
	MOV main_fb_L0+1, main_f_L0+1
	MOV main_fb_L0+2, main_f_L0+2
	MOV main_fb_L0+3, main_f_L0+3
;pca_capture.c,112 :: 		break;
	SJMP L_main73
;pca_capture.c,114 :: 		case CLEAR_filter:
L_main76:
;pca_capture.c,116 :: 		fc = f;
	MOV main_fc_L0+0, main_f_L0+0
	MOV main_fc_L0+1, main_f_L0+1
	MOV main_fc_L0+2, main_f_L0+2
	MOV main_fc_L0+3, main_f_L0+3
;pca_capture.c,117 :: 		break;
	SJMP L_main73
;pca_capture.c,119 :: 		case GREEN_filter:
L_main77:
;pca_capture.c,121 :: 		fg = f;
	MOV main_fg_L0+0, main_f_L0+0
	MOV main_fg_L0+1, main_f_L0+1
	MOV main_fg_L0+2, main_f_L0+2
	MOV main_fg_L0+3, main_f_L0+3
;pca_capture.c,122 :: 		break;
	SJMP L_main73
;pca_capture.c,124 :: 		}
L_main72:
	MOV A, main_mode_L0+0
	JZ L_main74
	MOV A, main_mode_L0+0
	XRL A, #1
	JZ L_main75
	MOV A, main_mode_L0+0
	XRL A, #2
	JZ L_main76
	MOV A, main_mode_L0+0
	XRL A, #3
	JZ L_main77
L_main73:
;pca_capture.c,126 :: 		mode++;
	INC main_mode_L0+0
;pca_capture.c,128 :: 		if(mode > 3)
	SETB C
	MOV A, main_mode_L0+0
	SUBB A, #3
	JNC #3
	LJMP L_main78
;pca_capture.c,130 :: 		fr = (((float)fr / (float)fc) * 100);
	MOV R0, main_fr_L0+0
	MOV R1, main_fr_L0+1
	MOV R2, main_fr_L0+2
	MOV R3, main_fr_L0+3
	LCALL _LongWord2Double+0
	MOV FLOC__main+4, 0
	MOV FLOC__main+5, 1
	MOV FLOC__main+6, 2
	MOV FLOC__main+7, 3
	MOV R0, main_fc_L0+0
	MOV R1, main_fc_L0+1
	MOV R2, main_fc_L0+2
	MOV R3, main_fc_L0+3
	LCALL _LongWord2Double+0
	MOV FLOC__main+0, 0
	MOV FLOC__main+1, 1
	MOV FLOC__main+2, 2
	MOV FLOC__main+3, 3
	MOV R4, FLOC__main+0
	MOV R5, FLOC__main+1
	MOV R6, FLOC__main+2
	MOV R7, FLOC__main+3
	MOV R0, FLOC__main+4
	MOV R1, FLOC__main+5
	MOV R2, FLOC__main+6
	MOV R3, FLOC__main+7
	LCALL _Div_32x32_FP+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #200
	MOV 7, #66
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV main_fr_L0+0, 0
	MOV main_fr_L0+1, 1
	MOV main_fr_L0+2, 2
	MOV main_fr_L0+3, 3
;pca_capture.c,131 :: 		fg = (((float)fg / (float)fc) * 100);
	MOV R0, main_fg_L0+0
	MOV R1, main_fg_L0+1
	MOV R2, main_fg_L0+2
	MOV R3, main_fg_L0+3
	LCALL _LongWord2Double+0
	MOV R4, FLOC__main+0
	MOV R5, FLOC__main+1
	MOV R6, FLOC__main+2
	MOV R7, FLOC__main+3
	LCALL _Div_32x32_FP+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #200
	MOV 7, #66
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV main_fg_L0+0, 0
	MOV main_fg_L0+1, 1
	MOV main_fg_L0+2, 2
	MOV main_fg_L0+3, 3
;pca_capture.c,132 :: 		fb = (((float)fb / (float)fc) * 100);
	MOV R0, main_fb_L0+0
	MOV R1, main_fb_L0+1
	MOV R2, main_fb_L0+2
	MOV R3, main_fb_L0+3
	LCALL _LongWord2Double+0
	MOV R4, FLOC__main+0
	MOV R5, FLOC__main+1
	MOV R6, FLOC__main+2
	MOV R7, FLOC__main+3
	LCALL _Div_32x32_FP+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #200
	MOV 7, #66
	LCALL _Mul_32x32_FP+0
	LCALL _Double2Ints+0
	MOV main_fb_L0+0, 0
	MOV main_fb_L0+1, 1
	MOV main_fb_L0+2, 2
	MOV main_fb_L0+3, 3
;pca_capture.c,134 :: 		print_C(0, 1, fr);
	MOV FARG_print_C_x_pos+0, #0
	MOV FARG_print_C_y_pos+0, #1
	MOV FARG_print_C_value+0, main_fr_L0+0
	MOV FARG_print_C_value+1, main_fr_L0+1
	LCALL _print_C+0
;pca_capture.c,135 :: 		print_C(4, 1, fg);
	MOV FARG_print_C_x_pos+0, #4
	MOV FARG_print_C_y_pos+0, #1
	MOV FARG_print_C_value+0, main_fg_L0+0
	MOV FARG_print_C_value+1, main_fg_L0+1
	LCALL _print_C+0
;pca_capture.c,136 :: 		print_C(8, 1, fb);
	MOV FARG_print_C_x_pos+0, #8
	MOV FARG_print_C_y_pos+0, #1
	MOV FARG_print_C_value+0, main_fb_L0+0
	MOV FARG_print_C_value+1, main_fb_L0+1
	LCALL _print_C+0
;pca_capture.c,137 :: 		print_I(12, 1, fc);
	MOV FARG_print_I_x_pos+0, #12
	MOV FARG_print_I_y_pos+0, #1
	MOV FARG_print_I_value+0, main_fc_L0+0
	MOV FARG_print_I_value+1, main_fc_L0+1
	MOV FARG_print_I_value+2, main_fc_L0+2
	MOV FARG_print_I_value+3, main_fc_L0+3
	LCALL _print_I+0
;pca_capture.c,139 :: 		fr <<= 1;
	MOV R4, #1
	MOV R0, main_fr_L0+0
	MOV R1, main_fr_L0+1
	MOV R2, main_fr_L0+2
	MOV R3, main_fr_L0+3
	LCALL __shl_long+0
	MOV main_fr_L0+0, 0
	MOV main_fr_L0+1, 1
	MOV main_fr_L0+2, 2
	MOV main_fr_L0+3, 3
;pca_capture.c,140 :: 		fg <<= 1;
	MOV R4, #1
	MOV R0, main_fg_L0+0
	MOV R1, main_fg_L0+1
	MOV R2, main_fg_L0+2
	MOV R3, main_fg_L0+3
	LCALL __shl_long+0
	MOV main_fg_L0+0, 0
	MOV main_fg_L0+1, 1
	MOV main_fg_L0+2, 2
	MOV main_fg_L0+3, 3
;pca_capture.c,141 :: 		fb <<= 1;
	MOV R4, #1
	MOV R0, main_fb_L0+0
	MOV R1, main_fb_L0+1
	MOV R2, main_fb_L0+2
	MOV R3, main_fb_L0+3
	LCALL __shl_long+0
	MOV main_fb_L0+0, 0
	MOV main_fb_L0+1, 1
	MOV main_fb_L0+2, 2
	MOV main_fb_L0+3, 3
;pca_capture.c,142 :: 		set_RGB(fr, fg, fb);
	MOV FARG_set_RGB_R+0, main_fr_L0+0
	MOV FARG_set_RGB_G+0, main_fg_L0+0
	MOV FARG_set_RGB_B+0, 0
	LCALL _set_RGB+0
;pca_capture.c,144 :: 		mode = 0;
	MOV main_mode_L0+0, #0
;pca_capture.c,145 :: 		delay_ms(400);
	MOV R5, 25
	MOV R6, 220
	MOV R7, 144
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
	NOP
;pca_capture.c,146 :: 		}
L_main78:
;pca_capture.c,147 :: 		};
	LJMP L_main64
;pca_capture.c,148 :: 		}
	SJMP #254
; end of _main

_PCA_Init:
;pca_capture.c,151 :: 		void PCA_Init(void)
;pca_capture.c,153 :: 		PCA0CN = 0x40;
	MOV PCA0CN+0, #64
;pca_capture.c,154 :: 		PCA0MD &= ~0x40;
	ANL PCA0MD+0, #191
;pca_capture.c,155 :: 		PCA0MD = 0x01;
	MOV PCA0MD+0, #1
;pca_capture.c,156 :: 		PCA0CPM0 = 0x11;
	MOV PCA0CPM0+0, #17
;pca_capture.c,157 :: 		}
	RET
; end of _PCA_Init

_Voltage_Reference_Init:
;pca_capture.c,160 :: 		void Voltage_Reference_Init(void)
;pca_capture.c,162 :: 		REF0CN = 0x08;
	MOV REF0CN+0, #8
;pca_capture.c,163 :: 		}
	RET
; end of _Voltage_Reference_Init

_Port_IO_Init:
;pca_capture.c,166 :: 		void Port_IO_Init(void)
;pca_capture.c,186 :: 		P1MDOUT = 0xF0;
	MOV P1MDOUT+0, #240
;pca_capture.c,187 :: 		P1SKIP = 0xF0;
	MOV P1SKIP+0, #240
;pca_capture.c,188 :: 		XBR1 = 0x41;
	MOV XBR1+0, #65
;pca_capture.c,189 :: 		}
	RET
; end of _Port_IO_Init

_Oscillator_Init:
;pca_capture.c,192 :: 		void Oscillator_Init(void)
;pca_capture.c,194 :: 		OSCICN = 0x82;
	MOV OSCICN+0, #130
;pca_capture.c,195 :: 		}
	RET
; end of _Oscillator_Init

_Interrupts_Init:
;pca_capture.c,198 :: 		void Interrupts_Init(void)
;pca_capture.c,200 :: 		IE = 0x80;
	MOV IE+0, #128
;pca_capture.c,201 :: 		EIE1 = 0x10;
	MOV EIE1+0, #16
;pca_capture.c,202 :: 		}
	RET
; end of _Interrupts_Init

_Init_Device:
;pca_capture.c,205 :: 		void Init_Device(void)
;pca_capture.c,207 :: 		PCA_Init();
	LCALL _PCA_Init+0
;pca_capture.c,208 :: 		Voltage_Reference_Init();
	LCALL _Voltage_Reference_Init+0
;pca_capture.c,209 :: 		Port_IO_Init();
	LCALL _Port_IO_Init+0
;pca_capture.c,210 :: 		Oscillator_Init();
	LCALL _Oscillator_Init+0
;pca_capture.c,211 :: 		Interrupts_Init();
	LCALL _Interrupts_Init+0
;pca_capture.c,212 :: 		}
	RET
; end of _Init_Device

_get_capture_count:
;pca_capture.c,215 :: 		unsigned int get_capture_count(void)
;pca_capture.c,217 :: 		unsigned char lb = 0x00;
	MOV get_capture_count_lb_L0+0, #0
	MOV get_capture_count_hb_L0+0, #0
	MOV get_capture_count_cnt_L0+0, #0
	MOV get_capture_count_cnt_L0+1, #0
;pca_capture.c,218 :: 		unsigned char hb = 0x00;
;pca_capture.c,219 :: 		unsigned int cnt = 0x0000;
;pca_capture.c,221 :: 		hb = PCA0CPH0;
	MOV get_capture_count_hb_L0+0, ___CC2D+0
;pca_capture.c,222 :: 		lb = PCA0CPL0;
	MOV get_capture_count_lb_L0+0, ___DoIFC+0
;pca_capture.c,224 :: 		cnt = hb;
	MOV get_capture_count_cnt_L0+0, get_capture_count_hb_L0+0
	CLR A
	MOV get_capture_count_cnt_L0+1, A
;pca_capture.c,225 :: 		cnt <<= 8;
	MOV R1, get_capture_count_cnt_L0+0
	MOV R0, #0
	MOV get_capture_count_cnt_L0+0, 0
	MOV get_capture_count_cnt_L0+1, 1
;pca_capture.c,226 :: 		cnt |= lb;
	MOV A, get_capture_count_lb_L0+0
	ORL 0, A
	CLR A
	ORL 1, A
	MOV get_capture_count_cnt_L0+0, 0
	MOV get_capture_count_cnt_L0+1, 1
;pca_capture.c,228 :: 		return cnt;
;pca_capture.c,229 :: 		}
	RET
; end of _get_capture_count
