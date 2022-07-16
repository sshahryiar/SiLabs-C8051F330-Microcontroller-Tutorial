sbit Soft_I2C_Scl at P1_7_bit;
sbit Soft_I2C_Sda at P1_6_bit;


#define LCD_I2C_address             0x7C
#define RGB_I2C_address             0xC0


/*    Colour Definitions    */
#define REG_RED                     0x04
#define REG_GREEN                   0x03
#define REG_BLUE                    0x02
#define REG_MODE_1                  0x00
#define REG_MODE_2                  0x01
#define REG_OUTPUT                  0x08

/*    LCD Definitions    */
#define LCD_CLEAR_DISPLAY           0x01
#define LCD_RETURN_HOME             0x02
#define LCD_ENTRY_MODE_SET          0x04
#define LCD_DISPLAY_CONTROL         0x08
#define LCD_CURSOR_SHIFT            0x10
#define LCD_FUNCTION_SET            0x20
#define LCD_SET_CGRAM_ADDR          0x40
#define LCD_SET_DDRAM_ADDR          0x80

/*    flags for display entry mode    */
#define LCD_ENTRY_RIGHT             0x00
#define LCD_ENTRY_LEFT              0x02
#define LCD_ENTRY_SHIFT_INCREMENT   0x01
#define LCD_ENTRY_SHIFT_DECREMENT   0x00

/*    flags for display on/off control    */
#define LCD_DISPLAY_ON              0x04
#define LCD_DISPLAY_OFF             0x00
#define LCD_CURSOR_ON               0x02
#define LCD_CURSOR_OFF              0x00
#define LCD_BLINK_ON                0x01
#define LCD_BLINK_OFF               0x00

/*    flags for display/cursor shift    */
#define LCD_DISPLAY_MOVE            0x08
#define LCD_CURSOR_MOVE             0x00
#define LCD_MOVE_RIGHT              0x04
#define LCD_MOVE_LEFT               0x00

/*    flags for function set    */
#define LCD_8_BIT_MODE              0x10
#define LCD_4_BIT_MODE              0x00
#define LCD_2_LINE                  0x08
#define LCD_1_LINE                  0x00
#define LCD_5x8_DOTS                0x00

/*   Data / Command selection   */
#define DAT                         0x40
#define CMD                         0x80


void RGB_LCD_init(void);
void I2C_bus_write(unsigned char address, unsigned char value_1, unsigned char value_2);
void LCD_I2C_write(unsigned char value, unsigned char mode);
void RGB_I2C_write(unsigned char reg, unsigned char value);
void set_RGB(unsigned char R, unsigned char G, unsigned char B);
void LCD_goto(unsigned char x_pos, unsigned char y_pos);
void LCD_clear_home(void);
void LCD_putchar(char chr);
void LCD_putstr(char *lcd_string);