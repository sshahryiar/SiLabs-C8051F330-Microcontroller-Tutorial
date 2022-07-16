#include "Waveshare_RGB_LCD.h"


void RGB_LCD_init(void)
{
    Soft_I2C_Init();
    delay_ms(20);
    
    LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
    delay_ms(5);
    
    LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
    delay_ms(5);
    
    LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
    delay_ms(5);
    
    LCD_I2C_write((LCD_FUNCTION_SET | LCD_2_LINE), CMD);
    LCD_I2C_write((LCD_DISPLAY_CONTROL | LCD_DISPLAY_ON | LCD_CURSOR_OFF | LCD_BLINK_OFF), CMD);
    
    LCD_clear_home();
    
    LCD_I2C_write((LCD_ENTRY_MODE_SET | LCD_ENTRY_LEFT | LCD_ENTRY_SHIFT_DECREMENT), CMD);
    
    RGB_I2C_write(REG_MODE_1, 0x00);
    RGB_I2C_write(REG_OUTPUT, 0xFF);
    RGB_I2C_write(REG_MODE_2, 0x20);
    
    set_RGB(127, 127, 127);
}


void I2C_bus_write(unsigned char address, unsigned char value_1, unsigned char value_2)
{
    Soft_I2C_Start();
    Soft_I2C_Write(address);
    Soft_I2C_Write(value_1);
    Soft_I2C_Write(value_2);
    Soft_I2C_Stop();
}


void LCD_I2C_write(unsigned char value, unsigned char mode)
{
    I2C_bus_write(LCD_I2C_address, mode, value);
}


void RGB_I2C_write(unsigned char reg, unsigned char value)
{
    I2C_bus_write(RGB_I2C_address, reg, value);
}


void set_RGB(unsigned char R, unsigned char G, unsigned char B)
{
    RGB_I2C_write(REG_RED, R);
    RGB_I2C_write(REG_GREEN, G);
    RGB_I2C_write(REG_BLUE, B);
}


void LCD_goto(unsigned char x_pos, unsigned char y_pos)
{
    if(y_pos == 0)
    {
        x_pos |= 0x80;
    }
    else
    {
        x_pos |= 0xC0;
    }
    
    I2C_bus_write(LCD_I2C_address, 0x80, x_pos);
}


void LCD_clear_home(void)
{
    LCD_I2C_write(LCD_CLEAR_DISPLAY, CMD);
    LCD_I2C_write(LCD_RETURN_HOME, CMD);
    delay_ms(2);
}


void LCD_putchar(char chr)
{
    if((chr >= 0x20) && (chr <= 0x7F))
    {
        LCD_I2C_write(chr, DAT);
    }
}


void LCD_putstr(char *lcd_string)
{
    do
    {
        LCD_putchar(*lcd_string++);
    }while(*lcd_string != '\0') ;
}