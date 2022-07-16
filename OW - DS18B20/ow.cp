#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/OW - DS18B20/ow.c"









sbit OW_Bit at P1_4_bit;


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


void Reset_Sources_Init(void);
void PCA_Init(void);
void Timer_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_ISR(void)
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
 unsigned temp = 0x00;
 Init_Device();

 while(1)
 {
 Ow_Reset();
 Ow_Write( 0xCC );
 Ow_Write( 0x44 );
 Delay_us(120);

 Ow_Reset();
 Ow_Write( 0xCC );
 Ow_Write( 0xBE );

 temp = Ow_Read();
 temp = ((Ow_Read() << 0x08) + temp);
 value = temp >> 0x04;

 P0_1_bit = 1;
 delay_ms(300);
 P0_1_bit = 0;
 delay_ms(300);

 }
}


void Reset_Sources_Init(void)
{
 RSTSRC = 0x04;
}


void PCA_Init(void)
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
}

void Timer_Init(void)
{
 TMR3CN = 0x04;
 TMR3RLL = 0xCA;
 TMR3RLH = 0xFA;
}

void Port_IO_Init(void)
{
#line 165 "E:/Current_Works/C8051F3xx Tutorial/Code/OW - DS18B20/ow.c"
 P0MDIN = 0xF3;
 P0MDOUT = 0x02;
 P1MDOUT = 0xE0;
 P0SKIP = 0x0E;
 P1SKIP = 0xD0;
 XBR1 = 0x40;
}


void Oscillator_Init(void)
{
 int i = 0;
 OSCICN = 0x81;

 if(MCDRSF_bit == 1)
 {
 CLKSEL = 0x00;

 for(i = 0; i < 9; i++)
 {
 P0_1_bit = 1;
 delay_ms(60);
 P0_1_bit = 0;
 delay_ms(60);
 }
 }
 else
 {
 OSCXCN = 0x67;
 for (i = 0; i < 3000; i++);
 while ((OSCXCN & 0x80) == 0);
 CLKSEL = 0x01;

 for(i = 0; i < 9; i++)
 {
 P0_1_bit = 1;
 delay_ms(45);
 P0_1_bit = 0;
 delay_ms(45);
 }
 }

 delay_ms(2000);
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
 Port_IO_Init();
 Oscillator_Init();
 Reset_Sources_Init();
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
