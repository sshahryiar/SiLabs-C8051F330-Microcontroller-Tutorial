#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/WDT/wdt.c"






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


void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_ISR()
iv IVT_ADDR_ET3
ilevel 0
ics ICS_AUTO
{
 switch(i)
 {
 case 0:
 {
 val = (value / 1000);
 break;
 }
 case 1:
 {
 val = ((value % 1000) / 100);
 break;
 }
 case 2:
 {
 val = ((value % 100) / 10);
 break;
 }
 case 3:
 {
 val = (value % 10);
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
 signed int s = 200;

 Init_Device();

 while(1)
 {
 value++;
 delay_ms(20);
 if( P1_4_bit  == 1)
 {
 PCA0CPH2 = 0;
 delay_ms(20);
 PCA0CPH2 = 0;
 delay_ms(20);
 PCA0CPH2 = 0;
 }
 else
 {
 PCA0CPH2 = 0;
 while(s > 0)
 {
 PCA0CPH2 = 0;
 delay_ms(30);
 s--;
 }
 while(1);
 }
 };
}


void PCA_Init()
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
 PCA0CPM2 = 0x01;
 PCA0CPL2 = 0xFF;
 PCA0MD |= 0x40;
 PCA0CPH2 = 0;
}


void Timer_Init(void)
{
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
 PCA0CPH2 = 0;
}


void Port_IO_Init(void)
{
#line 157 "E:/Current_Works/C8051F3xx Tutorial/Code/WDT/wdt.c"
 P1MDOUT = 0xE0;
 P1SKIP = 0xF0;
 XBR1 = 0x40;
 PCA0CPH2 = 0;
}


void Oscillator_Init(void)
{
 OSCICN = 0x82;
 PCA0CPH2 = 0;
}


void Interrupts_Init(void)
{
 IE = 0x80;
 EIE1 = 0x80;
 PCA0CPH2 = 0;
}


void Init_Device(void)
{
 PCA0MD = 0x00;

 Timer_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
 PCA_Init();

  P1_7_bit  = 1;
  P1_5_bit  = 1;
  P1_6_bit  = 0;
 PCA0CPH2 = 0;
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
