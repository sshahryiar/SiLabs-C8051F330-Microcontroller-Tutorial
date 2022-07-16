#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/ADC + Timer Interrupt/adc_timer_interrupt.c"








unsigned char i = 0;
unsigned char pt = 0;
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


void PCA_Init(void);
void Timer_Init();
void Port_IO_Init();
void Oscillator_Init();
void Interrupts_Init();
void ADC_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos, unsigned char point);
unsigned int adc_read(void);
void Voltage_Reference_Init(void);
unsigned int adc_avg(unsigned char channel);


void Timer_ISR(void)
iv IVT_ADDR_ET3
ilevel 0
ics ICS_AUTO
{
 switch(i)
 {
 case 0:
 {
 val = (value / 1000);
 pt = 0;
 break;
 }
 case 1:
 {
 val = ((value % 1000) / 100);
 pt = 1;
 break;
 }
 case 2:
 {
 val = ((value % 100) / 10);
 pt = 0;
 break;
 }
 case 3:
 {
 val = (value % 10);
 pt = 0;
 break;
 }
 }

 segment_write(val, i, pt);

 i++;

 if(i > 3)
 {
 i = 0;
 }

 TMR3CN &= 0x7F;
}


void main(void)
{
 float t = 0;

 Init_Device();

 while(1)
 {
 t = (adc_avg(0) *  3300.0 );
 t /=  1023.0 ;
 value = (t / 0.3);
 delay_ms(100);
 };
}


void PCA_Init(void)
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
}


void Timer_Init()
{
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}


void Port_IO_Init()
{
#line 152 "E:/Current_Works/C8051F3xx Tutorial/Code/ADC + Timer Interrupt/adc_timer_interrupt.c"
 P0MDIN = 0xFE;
 P1MDOUT = 0xE0;
 P0SKIP = 0x01;
 P1SKIP = 0xE0;
 XBR1 = 0x40;
}


void Oscillator_Init()
{
 OSCLCN = 0x82;
}


void Interrupts_Init()
{
 IE = 0x80;
 EIE1 = 0x80;
}


void ADC_Init(void)
{
 AMX0P = 0x00;
 AMX0N = 0x11;
 ADC0CF = 0x58;
 ADC0CN = 0x80;
}


void Voltage_Reference_Init(void)
{
 REF0CN = 0x0A;
}


void Init_Device(void)
{
 PCA_Init();
 Timer_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
 ADC_Init();
 Voltage_Reference_Init();
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


void segment_write(unsigned char disp, unsigned char pos, unsigned char point)
{
 unsigned char write_value = segment_code[disp];

 if(point)
 {
 write_value &= segment_code[10];
 }

  P1_7_bit  = 0;
 write_74HC595(write_value);
 write_74HC595(display_pos[pos]);
  P1_7_bit  = 1;

}


unsigned int adc_read(void)
{
 unsigned int ad_value = 0;

 ad_value = ADC0H;
 ad_value <<= 8;
 ad_value |= ADC0L;

 return ad_value;
}


unsigned int adc_avg(unsigned char channel)
{
 unsigned int avg_value = 0;
 signed char samples = 16;

 AMX0P = (channel & 0x1F);
 delay_ms(1);

 while(samples > 0)
 {
 AD0INT_bit = 0;
 AD0BUSY_bit = 1;

 while(AD0INT_bit == 0);
 avg_value += adc_read();

 samples--;
 };

 avg_value >>= 4;

 return avg_value;
}
