#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/Analog Comparator/cap_meter.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_2_wire.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_2_wire.h"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/pcf8574.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/pcf8574.h"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/sw_i2c.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/sw_i2c.h"
#line 38 "e:/current_works/c8051f3xx tutorial/code/analog comparator/sw_i2c.h"
void SW_I2C_init(void);
void SW_I2C_start(void);
void SW_I2C_stop(void);
unsigned char SW_I2C_read(unsigned char ack);
void SW_I2C_write(unsigned char value);
void SW_I2C_ACK_NACK(unsigned char mode);
unsigned char SW_I2C_wait_ACK(void);
#line 4 "e:/current_works/c8051f3xx tutorial/code/analog comparator/sw_i2c.c"
void SW_I2C_init(void)
{
 XBR1 = 0x40;
  do{ (P1MDOUT |= (1 << 6) ) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;
  do{ (P1MDOUT |= (1 << 7) ) ; (P0SKIP |= (1 << 7) ) ;}while(0) ;
 delay_us(100);
  (P1 |= (1 << 6) ) ;
  (P1 |= (1 << 7) ) ;
}


void SW_I2C_start(void)
{
  do{ (P1MDOUT |= (1 << 6) ) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;
  (P1 |= (1 << 6) ) ;
  (P1 |= (1 << 7) ) ;
 delay_us(40);
  (P1 &= (~ (1 << 6) )) ;
 delay_us(40);
  (P1 &= (~ (1 << 7) )) ;
}


void SW_I2C_stop(void)
{
  do{ (P1MDOUT |= (1 << 6) ) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;
  (P1 &= (~ (1 << 6) )) ;
  (P1 &= (~ (1 << 7) )) ;
 delay_us(40);
  (P1 |= (1 << 6) ) ;
  (P1 |= (1 << 7) ) ;
 delay_us(40);
}


unsigned char SW_I2C_read(unsigned char ack)
{
 unsigned char i = 8;
 unsigned char j = 0;

  do{ (P1MDOUT &= (~ (1 << 6) )) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;

 while(i > 0)
 {
  (P1 &= (~ (1 << 7) )) ;
 delay_us(20);
  (P1 |= (1 << 7) ) ;
 delay_us(20);
 j <<= 1;

 if( (P1 & (1 << 6) )  != 0x00)
 {
 j++;
 }

 delay_us(10);
 i--;
 };

 switch(ack)
 {
 case  0xFF :
 {
 SW_I2C_ACK_NACK( 0xFF );;
 break;
 }
 default:
 {
 SW_I2C_ACK_NACK( 0x00 );;
 break;
 }
 }

 return j;
}


void SW_I2C_write(unsigned char value)
{
 unsigned char i = 8;

  do{ (P1MDOUT |= (1 << 6) ) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;
  (P1 &= (~ (1 << 7) )) ;

 while(i > 0)
 {

 if(((value & 0x80) >> 7) != 0x00)
 {
  (P1 |= (1 << 6) ) ;
 }
 else
 {
  (P1 &= (~ (1 << 6) )) ;
 }


 value <<= 1;
 delay_us(20);
  (P1 |= (1 << 7) ) ;
 delay_us(20);
  (P1 &= (~ (1 << 7) )) ;
 delay_us(20);
 i--;
 };
}


void SW_I2C_ACK_NACK(unsigned char mode)
{
  (P1 &= (~ (1 << 7) )) ;
  do{ (P1MDOUT |= (1 << 6) ) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;

 switch(mode)
 {
 case  0xFF :
 {
  (P1 &= (~ (1 << 6) )) ;
 break;
 }
 default:
 {
  (P1 |= (1 << 6) ) ;
 break;
 }
 }

 delay_us(20);
  (P1 |= (1 << 7) ) ;
 delay_us(20);
  (P1 &= (~ (1 << 7) )) ;
}


unsigned char SW_I2C_wait_ACK(void)
{
 signed int timeout = 0;

  do{ (P1MDOUT &= (~ (1 << 6) )) ; (P0SKIP |= (1 << 6) ) ;}while(0) ;

  (P1 |= (1 << 6) ) ;
 delay_us(10);
  (P1 |= (1 << 7) ) ;
 delay_us(10);

 while( (P1 & (1 << 6) )  != 0x00)
 {
 timeout++;

 if(timeout >  1000 )
 {
 SW_I2C_stop();
 return 1;
 }
 };

  (P1 &= (~ (1 << 7) )) ;
 return 0;
}
#line 10 "e:/current_works/c8051f3xx tutorial/code/analog comparator/pcf8574.h"
void PCF8574_init(void);
unsigned char PCF8574_read(void);
void PCF8574_write(unsigned char data_byte);
#line 4 "e:/current_works/c8051f3xx tutorial/code/analog comparator/pcf8574.c"
void PCF8574_init(void)
{
 SW_I2C_init();
 delay_ms(20);
}


unsigned char PCF8574_read(void)
{
 unsigned char port_byte = 0;

 SW_I2C_start();
 SW_I2C_write( ( 0x4E  | 1) );
 port_byte = SW_I2C_read( 0x00 );
 SW_I2C_stop();

 return port_byte;
}


void PCF8574_write(unsigned char data_byte)
{
 SW_I2C_start();
 SW_I2C_write( 0x4E );
 SW_I2C_ACK_NACK( 0xFF );
 SW_I2C_write(data_byte);
 SW_I2C_ACK_NACK( 0xFF );
 SW_I2C_stop();
}
#line 35 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_2_wire.h"
void LCD_init(void);
void LCD_toggle_EN(void);
void LCD_send(unsigned char value, unsigned char mode);
void LCD_4bit_send(unsigned char lcd_data);
void LCD_putstr(char *lcd_string);
void LCD_putchar(char char_data);
void LCD_clear_home(void);
void LCD_goto(unsigned char x_pos, unsigned char y_pos);
#line 4 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_2_wire.c"
static unsigned char bl_state;
static unsigned char data_value;


void LCD_init(void)
{
 PCF8574_init();
 delay_ms(10);

 bl_state =  1 ;
 data_value = 0x04;
 PCF8574_write(data_value);

 delay_ms(10);

 LCD_send(0x33,  0 );
 LCD_send(0x32,  0 );

 LCD_send(( 0x20  |  0x28  |  0x20 ),  0 );
 LCD_send(( 0x0C  |  0x08  |  0x08 ),  0 );
 LCD_send(( 0x01 ),  0 );
 LCD_send(( 0x06  |  0x04 ),  0 );
}


void LCD_toggle_EN(void)
{
 data_value |= 0x04;
 PCF8574_write(data_value);
 delay_ms(1);
 data_value &= 0xF9;
 PCF8574_write(data_value);
 delay_ms(1);
}


void LCD_send(unsigned char value, unsigned char mode)
{
 switch(mode)
 {
 case  0 :
 {
 data_value &= 0xF4;
 break;
 }
 case  1 :
 {
 data_value |= 0x01;
 break;
 }
 }

 switch(bl_state)
 {
 case  1 :
 {
 data_value |= 0x08;
 break;
 }
 case  0 :
 {
 data_value &= 0xF7;
 break;
 }
 }

 PCF8574_write(data_value);
 LCD_4bit_send(value);
 delay_ms(1);
}


void LCD_4bit_send(unsigned char lcd_data)
{
 unsigned char temp = 0x00;

 temp = (lcd_data & 0xF0);
 data_value &= 0x0F;
 data_value |= temp;
 PCF8574_write(data_value);
 LCD_toggle_EN();

 temp = (lcd_data & 0x0F);
 temp <<= 0x04;
 data_value &= 0x0F;
 data_value |= temp;
 PCF8574_write(data_value);
 LCD_toggle_EN();
}


void LCD_putstr(char *lcd_string)
{
 do
 {
 LCD_putchar(*lcd_string++);
 }while(*lcd_string != '\0') ;
}


void LCD_putchar(char char_data)
{
 if((char_data >= 0x20) && (char_data <= 0x7F))
 {
 LCD_send(char_data,  1 );
 }
}


void LCD_clear_home(void)
{
 LCD_send( 0x01 ,  0 );
 LCD_send( 0x02 ,  0 );
}


void LCD_goto(unsigned char x_pos,unsigned char y_pos)
{
 if(y_pos == 0)
 {
 LCD_send((0x80 | x_pos),  0 );
 }
 else
 {
 LCD_send((0x80 | 0x40 | x_pos),  0 );
 }
}
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_print.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_print.h"





void load_custom_symbol(void);
void print_symbol(unsigned char x_pos, unsigned char y_pos, unsigned char symbol_index);
void print_C(unsigned char x_pos, unsigned char y_pos, signed int value);
void print_I(unsigned char x_pos, unsigned char y_pos, signed long value);
void print_D(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char points);
void print_F(unsigned char x_pos, unsigned char y_pos, float value, unsigned char points);
#line 4 "e:/current_works/c8051f3xx tutorial/code/analog comparator/lcd_print.c"
void load_custom_symbol(void)
{
 unsigned char s = 0;

 const unsigned char custom_symbol[ ( 8  * 1 ) ] =
 {
 0x00, 0x06, 0x09, 0x09, 0x06, 0x00, 0x00, 0x00
 };

 LCD_send(0x40,  0 );

 for(s = 0; s <  ( 8  * 1 ) ; s++)
 {
 LCD_send(custom_symbol[s],  1 );
 }

 LCD_send(0x80,  0 );
}


void print_symbol(unsigned char x_pos, unsigned char y_pos, unsigned char symbol_index)
{
 LCD_goto(x_pos, y_pos);
 LCD_send(symbol_index,  1 );
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
#line 13 "E:/Current_Works/C8051F3xx Tutorial/Code/Analog Comparator/cap_meter.c"
unsigned char ovf = 0;
unsigned char measurement_done = 0;


void PCA_Init(void);
void Timer_Init(void);
void Comparator_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void reset_timer_1(void);
unsigned int get_timer_1(void);


void Timer_1_ISR(void)
iv IVT_ADDR_ET1
ilevel 0
ics ICS_AUTO
{
 ovf++;
 TF1_bit = 0;
}


void Analog_Comparator_ISR(void)
iv IVT_ADDR_ECP0
ilevel 0
ics ICS_AUTO
{
 if(CP0FIF_bit)
 {
 measurement_done = 1;
 TCON = 0x00;
 P0_2_bit = 0;
 CP0FIF_bit = 0;
 }
}


void main(void)
{
 float c = 0.0;
 unsigned long cnt = 0;

 Init_Device();
 LCD_init();
 LCD_clear_home();

 LCD_goto(0, 0);
 LCD_putstr("Capacitance/ F:");

 while(1)
 {
 if(( P1_4_bit  == 0) && (measurement_done == 0))
 {
 reset_timer_1();
 LCD_goto(0, 1);
 LCD_putstr("Discharging!  ");
 P0MDIN = 0xFE;
 P0MDOUT = 0x06;
 P0_1_bit = 0;
 P0_2_bit = 0;
 delay_ms(4000);
 P0MDIN = 0xFC;
 P0MDOUT = 0x04;
 TCON = 0x40;
 P0_2_bit = 1;
 LCD_goto(0, 1);
 LCD_putstr("Measuring!    ");
 delay_ms(4000);
 }

 if(measurement_done)
 {
 cnt = ovf;
 cnt <<= 16;
 cnt += get_timer_1();
 c = ((cnt *  0.9795918 ) /  ( 10000.0  * 0.693147) );
 c *=  50 ;

 LCD_goto(0, 1);
 LCD_putstr("             ");

 if((c > 0.0) && (c < 10000000.0))
 {
 if((c > 0) && (c < 1000))
 {
 LCD_goto(12, 0);
 LCD_putstr("n");
 }
 else if((c >= 1000.0) && (c < 10000000.0))
 {
 c /= 1000.0;
 LCD_goto(12, 0);
 LCD_putstr("u");
 }

 print_F(0, 1, c, 1);
 }

 else
 {
 LCD_goto(0, 1);
 LCD_putstr("O.L");
 }

 measurement_done = 0;
 }
 };
}


void PCA_Init(void)
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
}


void Timer_Init(void)
{
 TMOD = 0x10;
}


void Comparator_Init(void)
{
 CPT0CN = 0x8A;
 delay_us(20);
 CPT0CN &= ~0x30;
 CPT0MX = 0x00;
 CPT0MD = 0x11;
}

void Port_IO_Init(void)
{
#line 168 "E:/Current_Works/C8051F3xx Tutorial/Code/Analog Comparator/cap_meter.c"
 P0MDIN = 0xFC;
 P0MDOUT = 0x04;
 P1MDOUT = 0xC0;
 P0SKIP = 0x07;
 P1SKIP = 0xD0;
 XBR1 = 0xC0;
}


void Oscillator_Init(void)
{
 OSCICN = 0x82;
}


void Interrupts_Init(void)
{
 IE = 0x88;
 EIE1 = 0x20;
}


void Init_Device(void)
{
 PCA_Init();
 Comparator_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
}


void reset_timer_1(void)
{
 ovf = 0;
 TH1 = 0x00;
 TL1 = 0x00;
}


unsigned int get_timer_1(void)
{
 unsigned int counts = 0;

 counts = TH1;
 counts <<= 8;
 counts |= TL1;

 return counts;
}
