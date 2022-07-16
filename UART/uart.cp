#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/UART/uart.c"





unsigned int d = 0;
unsigned char i = 0;
unsigned char cnt = 0;
unsigned char value = 0;
char rx_buffer[18];


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
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void UART0_ISR(void)
iv IVT_ADDR_ES0
ilevel 0
ics ICS_AUTO
{
 rx_buffer[cnt++] = UART_Read();
 RI0_bit = 0;
}


void Timer_ISR(void)
iv IVT_ADDR_ET3
ilevel 1
ics ICS_AUTO
{
 switch(i)
 {
 case 0:
 {
 value = (d / 1000);
 break;
 }
 case 1:
 {
 value = ((d % 1000) / 100);
 break;
 }
 case 2:
 {
 value = ((d % 100) / 10);
 break;
 }
 case 3:
 {
 value = (d % 10);
 break;
 }
 }

 if(d >= 40000)
 {
 segment_write(11, i);
 }
 else
 {
 segment_write(value, i);
 }

 i++;

 if(i > 3)
 {
 i = 0;
 }

 TMR3CN &= 0x7F;
}


void main(void)
{
 unsigned char i = 0x00;
 unsigned char j = 0x00;
 unsigned char k = 0x00;
 unsigned char l = 0x00;
 unsigned int multiplier = 1;
 unsigned int range = 0x0000;

 Init_Device();
 UART1_Init(9600);

 while(1)
 {
 if(cnt >= 18)
 {
 for(i = 0; i < 18; i++)
 {
 if(rx_buffer[i] == 'D')
 {
 j = i;
 j += 2;
 break;
 }
 }

 for(i = j; i < 18; i++)
 {
 if(rx_buffer[i] == ' ')
 {
 k = i;
 break;
 }
 }

 range = 0;
 multiplier = 1;
 l = ((k - j) - 1);
 for(i = 0; i < l; i++)
 {
 multiplier *= 10;
 }

 for(i = j; i < k; i++)
 {
 range += ((rx_buffer[i] - 0x30) * multiplier);
 multiplier /= 10;
 }

 d = range;
 cnt = 0x00;
 }

 delay_ms(40);
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


void Port_IO_Init(void)
{
#line 201 "E:/Current_Works/C8051F3xx Tutorial/Code/UART/uart.c"
 P0MDOUT = 0x30;
 P1MDOUT = 0xE0;
 P1SKIP = 0xE0;
 XBR0 = 0x01;
 XBR1 = 0x40;
}


void Oscillator_Init(void)
{
 OSCICN = 0x82;
}


void Interrupts_Init(void)
{
 IE = 0x90;
 EIE1 = 0x80;
}


void Init_Device(void)
{
 PCA_Init();
 Timer_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
}


void write_74HC595(unsigned char send_data)
{
 signed char clks = 0x08;

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
