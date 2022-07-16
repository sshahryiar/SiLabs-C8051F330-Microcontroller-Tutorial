#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/Timer/tmr.c"










unsigned char i = 0;
register unsigned char val = 0;
signed int s = 0;
unsigned int ms = 0;

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
 0x7F,
 0xBF
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
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void data_converter(unsigned int val);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_2_ISR(void)
iv IVT_ADDR_ET2
ilevel 1
ics ICS_AUTO
{
 ms++;
 if(ms > 999)
 {
 ms = 0;
 s--;

 if(s < 0)
 {
 s = 0;
 TR2_bit = 0;
 }
 }

 TMR2CN &= 0x7F;
}


void Timer_3_ISR(void)
iv IVT_ADDR_ET3
ilevel 0
ics ICS_AUTO
{
 switch(i)
 {
 case 0:
 {
 val = (s / 1000);
 break;
 }
 case 1:
 {
 val = ((s % 1000) / 100);
 break;
 }
 case 2:
 {
 val = ((s % 100) / 10);
 break;
 }
 case 3:
 {
 val = (s % 10);
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
 unsigned char set_time = 0;
 Init_Device();

 while(1)
 {
 if( P1_4_bit  == 0)
 {
 delay_ms(40);
 while( P1_4_bit  == 0);

 set_time = 1;
 }

 if(set_time == 1)
 {
 if( P1_3_bit  == 0)
 {
 delay_ms(40);
 s++;

 if(s >= 9999)
 {
 s = 9999;
 }
 }

 if( P1_2_bit  == 0)
 {
 delay_ms(40);
 s--;

 if(s <= 0)
 {
 s = 0;
 }
 }

 if( P1_1_bit  == 0)
 {
 TR2_bit = 1;
 set_time = 0;
 }
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
 TMR2RLL = 0x02;
 TMR2RLH = 0xFC;
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}


void Port_IO_Init(void)
{
#line 203 "E:/Current_Works/C8051F3xx Tutorial/Code/Timer/tmr.c"
 P1MDOUT = 0xE0;
 P1SKIP = 0xFE;
 XBR1 = 0x40;
}


void Oscillator_Init(void)
{
 OSCICN = 0x82;
}


void Interrupts_Init(void)
{
 IE = 0xA0;
 EIE1 = 0x80;
}


void Init_Device(void)
{
 PCA_Init();
 Timer_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
  P1_7_bit  = 1;
  P1_5_bit  = 1;
  P1_6_bit  = 0;
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
