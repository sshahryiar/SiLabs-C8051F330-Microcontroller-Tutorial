#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/SPI/thermo.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/spi/max31865.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/spi/max31865.h"
#line 38 "e:/current_works/c8051f3xx tutorial/code/spi/max31865.h"
void MAX31865_init(void);
unsigned char MAX31865_read_byte(unsigned char address);
unsigned int MAX31865_read_word(unsigned char address);
void MAX31865_write_byte(unsigned char address, unsigned char value);
void MAX31865_write_word(unsigned char address, unsigned char lb, unsigned char hb);
unsigned int MAX31865_get_RTD(void);
signed int MAX31865_get_temperature(void);
#line 4 "e:/current_works/c8051f3xx tutorial/code/spi/max31865.c"
void MAX31865_init(void)
{
 SPI1_Init_Advanced(1000000, _SPI_CLK_IDLE_LO | _SPI_CLK_ACTIVE_2_IDLE | _SPI_MASTER);
 delay_ms(10);

  P0_3_bit  = 1;
#line 16 "e:/current_works/c8051f3xx tutorial/code/spi/max31865.c"
 MAX31865_write_byte( 0x00 ,  0x80  |  0x40  |  0x10  |  0x02  |  0x01 );
}


unsigned char MAX31865_read_byte(unsigned char address)
{
 unsigned char retval = 0x00;

  P0_3_bit  = 0;
 SPI_Write(address & 0x7F);
 retval = SPI_Read(0x00);
  P0_3_bit  = 1;

 return retval;
}


unsigned int MAX31865_read_word(unsigned char address)
{
 unsigned char lb = 0x00;
 unsigned char hb = 0x00;
 unsigned int retval = 0x0000;

 hb = MAX31865_read_byte(address);
 lb = MAX31865_read_byte(address + 1);

 retval = hb;
 retval <<= 0x08;
 retval |= lb;

 return retval;
}


void MAX31865_write_byte(unsigned char address, unsigned char value)
{
  P0_3_bit  = 0;
 SPI_Write(address | 0x80);
 SPI_Write(value);
  P0_3_bit  = 1;
}


void MAX31865_write_word(unsigned char address, unsigned char lb, unsigned char hb)
{
 MAX31865_write_byte(address, hb);
 MAX31865_write_byte((address + 1), lb);
}


unsigned int MAX31865_get_RTD(void)
{
 unsigned int rtd_value = 0x00;

 rtd_value = MAX31865_read_word( 0x01 );
 rtd_value >>= 1;

 return rtd_value;
}


signed int MAX31865_get_temperature(void)
{
 float rt = 0.0;
 signed int t_value = 0;

 t_value = MAX31865_get_RTD();
 rt = ( 430.0  * t_value);
 rt /= 32768.0;

 rt /=  100.0 ;
 rt = (rt - 1.0);
 t_value = (rt /  0.00390803 );

 return t_value;
}
#line 9 "E:/Current_Works/C8051F3xx Tutorial/Code/SPI/thermo.c"
unsigned char i = 0;
register unsigned char val = 0;
unsigned int value = 0;

const unsigned char code segment_code[12] =
{
 0xC0,
 0xF9,
 0xA4,
 0xB0,
 0x99,
 0x92,
 0x82,
 0xF8,
 0x80,
 0x90,
 0x9C,
 0xC6

};


const unsigned char code display_pos[4] =
{
 0xF7,
 0xFB,
 0xFD,
 0xFE
};


void PCA_Init(void);
void Timer_Init(void);
void SPI_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_ISR()
iv IVT_ADDR_ET3
ilevel 1
ics ICS_AUTO
{
 switch(i)
 {
 case 0:
 {
 val = (value / 10);
 break;
 }
 case 1:
 {
 val = (value % 10);
 break;
 }
 case 2:
 {
 val = 10;
 break;
 }
 case 3:
 {
 val = 11;
 break;
 }
 }

 segment_write(val, i);

 i++;

 if(i > 3)
 {
 i = 0;
 }

 TMR3CN &= 0x7F;
}


void main(void)
{
 Init_Device();
 MAX31865_init();

 while(1)
 {
 value = MAX31865_get_temperature();
 delay_ms(600);
 };
}


void PCA_Init(void)
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
}


void Timer_Init(void)
{
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}


void SPI_Init(void)
{
 SPI0CFG = 0x40;
 SPI0CN = 0x01;
 SPI0CKR = 0x05;
}


void Port_IO_Init(void)
{
#line 148 "E:/Current_Works/C8051F3xx Tutorial/Code/SPI/thermo.c"
 P0MDOUT = 0x0D;
 P1MDOUT = 0xE0;
 P0SKIP = 0x08;
 P1SKIP = 0xE0;
 XBR0 = 0x02;
 XBR1 = 0x40;
}


void Oscillator_Init(void)
{
 OSCICN = 0x82;
}


void Interrupts_Init(void)
{
 IE = 0x80;
 EIE1 = 0x80;
}


void Init_Device(void)
{
 PCA_Init();
 Timer_Init();
 SPI_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
}


void write_74HC595(unsigned char send_data)
{
 signed char clks = 8;

 while(clks > 0)
 {
 if((send_data & 0x80) == 0x00)
 {
  P1_6_bit  = 0;
 }
 else
 {
  P1_6_bit  = 1;
 }

  P1_5_bit  = 0;
 send_data <<= 1;
 clks--;
  P1_5_bit  = 1;
 }
}


void segment_write(unsigned char disp, unsigned char pos)
{
  P1_7_bit  = 0;
 write_74HC595(segment_code[disp]);
 write_74HC595(display_pos[pos]);
  P1_7_bit  = 1;
}
