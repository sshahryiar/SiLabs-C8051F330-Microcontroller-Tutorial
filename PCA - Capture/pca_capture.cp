#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Capture/pca_capture.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/pca - capture/waveshare_rgb_lcd.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/pca - capture/waveshare_rgb_lcd.h"
sbit Soft_I2C_Scl at P1_7_bit;
sbit Soft_I2C_Sda at P1_6_bit;
#line 59 "e:/current_works/c8051f3xx tutorial/code/pca - capture/waveshare_rgb_lcd.h"
void RGB_LCD_init(void);
void I2C_bus_write(unsigned char address, unsigned char value_1, unsigned char value_2);
void LCD_I2C_write(unsigned char value, unsigned char mode);
void RGB_I2C_write(unsigned char reg, unsigned char value);
void set_RGB(unsigned char R, unsigned char G, unsigned char B);
void LCD_goto(unsigned char x_pos, unsigned char y_pos);
void LCD_clear_home(void);
void LCD_putchar(char chr);
void LCD_putstr(char *lcd_string);
#line 4 "e:/current_works/c8051f3xx tutorial/code/pca - capture/waveshare_rgb_lcd.c"
void RGB_LCD_init(void)
{
 Soft_I2C_Init();
 delay_ms(20);

 LCD_I2C_write(( 0x20  |  0x08 ),  0x80 );
 delay_ms(5);

 LCD_I2C_write(( 0x20  |  0x08 ),  0x80 );
 delay_ms(5);

 LCD_I2C_write(( 0x20  |  0x08 ),  0x80 );
 delay_ms(5);

 LCD_I2C_write(( 0x20  |  0x08 ),  0x80 );
 LCD_I2C_write(( 0x08  |  0x04  |  0x00  |  0x00 ),  0x80 );

 LCD_clear_home();

 LCD_I2C_write(( 0x04  |  0x02  |  0x00 ),  0x80 );

 RGB_I2C_write( 0x00 , 0x00);
 RGB_I2C_write( 0x08 , 0xFF);
 RGB_I2C_write( 0x01 , 0x20);

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
 I2C_bus_write( 0x7C , mode, value);
}


void RGB_I2C_write(unsigned char reg, unsigned char value)
{
 I2C_bus_write( 0xC0 , reg, value);
}


void set_RGB(unsigned char R, unsigned char G, unsigned char B)
{
 RGB_I2C_write( 0x04 , R);
 RGB_I2C_write( 0x03 , G);
 RGB_I2C_write( 0x02 , B);
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

 I2C_bus_write( 0x7C , 0x80, x_pos);
}


void LCD_clear_home(void)
{
 LCD_I2C_write( 0x01 ,  0x80 );
 LCD_I2C_write( 0x02 ,  0x80 );
 delay_ms(2);
}


void LCD_putchar(char chr)
{
 if((chr >= 0x20) && (chr <= 0x7F))
 {
 LCD_I2C_write(chr,  0x40 );
 }
}


void LCD_putstr(char *lcd_string)
{
 do
 {
 LCD_putchar(*lcd_string++);
 }while(*lcd_string != '\0') ;
}
#line 1 "e:/current_works/c8051f3xx tutorial/code/pca - capture/lcd_print_rgb.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/pca - capture/lcd_print_rgb.h"





void load_custom_symbol(void);
void print_symbol(unsigned char x_pos, unsigned char y_pos, unsigned char symbol_index);
void print_C(unsigned char x_pos, unsigned char y_pos, signed int value);
void print_I(unsigned char x_pos, unsigned char y_pos, signed long value);
void print_D(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char points);
void print_F(unsigned char x_pos, unsigned char y_pos, float value, unsigned char points);
#line 4 "e:/current_works/c8051f3xx tutorial/code/pca - capture/lcd_print_rgb.c"
void load_custom_symbol(void)
{
 unsigned char s = 0;

 const unsigned char custom_symbol[ ( 8  * 1 ) ] =
 {
 0x00, 0x06, 0x09, 0x09, 0x06, 0x00, 0x00, 0x00
 };

 LCD_I2C_write(0x40,  0x80 );

 for(s = 0; s <  ( 8  * 1 ) ; s++)
 {
 LCD_I2C_write(custom_symbol[s],  0x40 );
 }

 LCD_I2C_write(0x80,  0x80 );
}


void print_symbol(unsigned char x_pos, unsigned char y_pos, unsigned char symbol_index)
{
 LCD_goto(x_pos, y_pos);
 LCD_I2C_write(symbol_index,  0x40 );
}


void print_C(unsigned char x_pos, unsigned char y_pos, signed int value)
{
 char ch[5] = {0x20, 0x20, 0x20, 0x20, '\0'};

 if(value < 0x00)
 {
 ch[0] = 0x2D;
 value = -value;
 }
 else
 {
 ch[0] = 0x20;
 }

 if((value > 99) && (value <= 999))
 {
 ch[1] = ((value / 100) + 0x30);
 ch[2] = (((value % 100) / 10) + 0x30);
 ch[3] = ((value % 10) + 0x30);
 }
 else if((value > 9) && (value <= 99))
 {
 ch[1] = (((value % 100) / 10) + 0x30);
 ch[2] = ((value % 10) + 0x30);
 ch[3] = 0x20;
 }
 else if((value >= 0) && (value <= 9))
 {
 ch[1] = ((value % 10) + 0x30);
 ch[2] = 0x20;
 ch[3] = 0x20;
 }

 LCD_goto(x_pos, y_pos);
 LCD_putstr(ch);
}


void print_I(unsigned char x_pos, unsigned char y_pos, signed long value)
{
 char ch[7] = {0x20, 0x20, 0x20, 0x20, 0x20, 0x20, '\0'};

 if(value < 0)
 {
 ch[0] = 0x2D;
 value = -value;
 }
 else
 {
 ch[0] = 0x20;
 }

 if(value > 9999)
 {
 ch[1] = ((value / 10000) + 0x30);
 ch[2] = (((value % 10000)/ 1000) + 0x30);
 ch[3] = (((value % 1000) / 100) + 0x30);
 ch[4] = (((value % 100) / 10) + 0x30);
 ch[5] = ((value % 10) + 0x30);
 }

 else if((value > 999) && (value <= 9999))
 {
 ch[1] = (((value % 10000)/ 1000) + 0x30);
 ch[2] = (((value % 1000) / 100) + 0x30);
 ch[3] = (((value % 100) / 10) + 0x30);
 ch[4] = ((value % 10) + 0x30);
 ch[5] = 0x20;
 }
 else if((value > 99) && (value <= 999))
 {
 ch[1] = (((value % 1000) / 100) + 0x30);
 ch[2] = (((value % 100) / 10) + 0x30);
 ch[3] = ((value % 10) + 0x30);
 ch[4] = 0x20;
 ch[5] = 0x20;
 }
 else if((value > 9) && (value <= 99))
 {
 ch[1] = (((value % 100) / 10) + 0x30);
 ch[2] = ((value % 10) + 0x30);
 ch[3] = 0x20;
 ch[4] = 0x20;
 ch[5] = 0x20;
 }
 else
 {
 ch[1] = ((value % 10) + 0x30);
 ch[2] = 0x20;
 ch[3] = 0x20;
 ch[4] = 0x20;
 ch[5] = 0x20;
 }

 LCD_goto(x_pos, y_pos);
 LCD_putstr(ch);
}


void print_D(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char points)
{
 char ch[5] = {0x2E, 0x20, 0x20, 0x20, 0x20};

 ch[1] = ((value / 100) + 0x30);

 if(points > 1)
 {
 ch[2] = (((value / 10) % 10) + 0x30);

 if(points > 1)
 {
 ch[3] = ((value % 10) + 0x30);
 }
 }

 LCD_goto(x_pos, y_pos);
 LCD_putstr(ch);
}


void print_F(unsigned char x_pos, unsigned char y_pos, float value, unsigned char points)
{
 signed long tmp = 0x00000000;

 tmp = value;
 print_I(x_pos, y_pos, tmp);
 tmp = ((value - tmp) * 1000);

 if(tmp < 0)
 {
 tmp = -tmp;
 }

 if(value < 0)
 {
 value = -value;
 LCD_goto(x_pos, y_pos);
 LCD_putchar(0x2D);
 }
 else
 {
 LCD_goto(x_pos, y_pos);
 LCD_putchar(0x20);
 }

 if((value >= 10000) && (value < 100000))
 {
 print_D((x_pos + 6), y_pos, tmp, points);
 }
 else if((value >= 1000) && (value < 10000))
 {
 print_D((x_pos + 5), y_pos, tmp, points);
 }
 else if((value >= 100) && (value < 1000))
 {
 print_D((x_pos + 4), y_pos, tmp, points);
 }
 else if((value >= 10) && (value < 100))
 {
 print_D((x_pos + 3), y_pos, tmp, points);
 }
 else if(value < 10)
 {
 print_D((x_pos + 2), y_pos, tmp, points);
 }
}
#line 15 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Capture/pca_capture.c"
unsigned long count = 0;
unsigned int overflow = 0;
unsigned int past_capture = 0;
unsigned int current_capture = 0;


void PCA_Init(void);
void Voltage_Reference_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
unsigned int get_capture_count(void);


void PCA0_ISR(void)
iv IVT_ADDR_EPCA0
ilevel 0
ics ICS_AUTO
{
 if(CF_bit)
 {
 overflow++;
 CF_bit = 0;
 }

 if(CCF0_bit)
 {
 current_capture = get_capture_count();
 count = ((overflow << 16) + (current_capture - past_capture));
 past_capture = current_capture;
 overflow = 0x00000;
 current_capture = 0;
 CCF0_bit = 0;
 }
}


void main(void)
{
 unsigned long f = 0;
 unsigned long fr = 0;
 unsigned long fg = 0;
 unsigned long fb = 0;
 unsigned long fc = 0;
 unsigned char mode = 0;

 Init_Device();
 RGB_LCD_init();
 LCD_clear_home();

 LCD_goto(0, 0);
 LCD_putstr(" R%  G%  B%  fC");

 while(1)
 {
 switch(mode)
 {
 case  0x00 :
 {
  P1_4_bit  = 0;
  P1_5_bit  = 0;
 break;
 }
 case  0x01 :
 {
  P1_4_bit  = 0;
  P1_5_bit  = 1;
 break;
 }
 case  0x02 :
 {
  P1_4_bit  = 1;
  P1_5_bit  = 0;
 break;
 }
 case  0x03 :
 {
  P1_4_bit  = 1;
  P1_5_bit  = 1;
 break;
 }
 }
 delay_ms(100);

 f = (1020833 / ((float)count));

 switch(mode)
 {
 case  0x00 :
 {
 fr = f;
 break;
 }
 case  0x01 :
 {
 fb = f;
 break;
 }
 case  0x02 :
 {
 fc = f;
 break;
 }
 case  0x03 :
 {
 fg = f;
 break;
 }
 }

 mode++;

 if(mode > 3)
 {
 fr = (((float)fr / (float)fc) * 100);
 fg = (((float)fg / (float)fc) * 100);
 fb = (((float)fb / (float)fc) * 100);

 print_C(0, 1, fr);
 print_C(4, 1, fg);
 print_C(8, 1, fb);
 print_I(12, 1, fc);

 fr <<= 1;
 fg <<= 1;
 fb <<= 1;
 set_RGB(fr, fg, fb);

 mode = 0;
 delay_ms(400);
 }
 };
}


void PCA_Init(void)
{
 PCA0CN = 0x40;
 PCA0MD &= ~0x40;
 PCA0MD = 0x01;
 PCA0CPM0 = 0x11;
}


void Voltage_Reference_Init(void)
{
 REF0CN = 0x08;
}


void Port_IO_Init(void)
{
#line 186 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Capture/pca_capture.c"
 P1MDOUT = 0xF0;
 P1SKIP = 0xF0;
 XBR1 = 0x41;
}


void Oscillator_Init(void)
{
 OSCICN = 0x82;
}


void Interrupts_Init(void)
{
 IE = 0x80;
 EIE1 = 0x10;
}


void Init_Device(void)
{
 PCA_Init();
 Voltage_Reference_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
}


unsigned int get_capture_count(void)
{
 unsigned char lb = 0x00;
 unsigned char hb = 0x00;
 unsigned int cnt = 0x0000;

 hb = PCA0CPH0;
 lb = PCA0CPL0;

 cnt = hb;
 cnt <<= 8;
 cnt |= lb;

 return cnt;
}
