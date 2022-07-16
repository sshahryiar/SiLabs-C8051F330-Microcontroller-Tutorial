#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Frequency Output/TX/ir_tx.c"










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
void UART_Init(void);
void ADC_Init(void);
void Voltage_Reference_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_ISR(void)
iv IVT_ADDR_ET3
ilevel 0
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
 unsigned int t = 0;
 char tmp = 0;
 Init_Device();
 UART1_Init(1200);
 ADC1_Init_Advanced(_INTERNAL_REF | _RIGHT_ADJUSTMENT);

 while(1)
 {
 t = (ADC1_Get_Sample(16) *  3200.0 );
 t /= 1023.0;
 t = (((float)t - 776.0) / 2.86);
 value = t;
 tmp = t;
 UART1_Write(0xAA);
 UART1_Write((tmp / 10) + 0x30);
 UART1_Write((tmp % 10) + 0x30);
 delay_ms(400);
 };
}


void PCA_Init(void)
{
 PCA0CN = 0x40;
 PCA0MD &= ~0x40;
 PCA0MD = 0x02;
 PCA0CPM1 = 0x46;
 PCA0CPH1 = 0x14;
}


void Timer_Init(void)
{
 TMR3CN = 0x04;
 TMR3RLL = 0x01;
 TMR3RLH = 0xFE;
}


void UART_Init(void)
{
 SCON0 = 0x10;
}


void ADC_Init(void)
{
 AMX0P = 0x10;
 AMX0N = 0x11;
 ADC0CF = 0xF0;
 ADC0CN = 0x80;
}


void Voltage_Reference_Init(void)
{
 REF0CN = 0x0F;
}


void Port_IO_Init(void)
{
#line 179 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Frequency Output/TX/ir_tx.c"
 P0MDOUT = 0x12;
 P1MDOUT = 0xE0;
 P1SKIP = 0xE0;
 XBR0 = 0x01;
 XBR1 = 0x42;
}


void Oscillator_Init(void)
{
 OSCICN = 0x81;
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
 UART_Init();
 ADC_Init();
 Voltage_Reference_Init();
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
