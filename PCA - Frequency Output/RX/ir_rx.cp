#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Frequency Output/RX/ir_rx.c"





unsigned char i = 0;
register unsigned char val = 0;
unsigned int value = 0;
unsigned char cnt = 0;

unsigned char rx_buffer[3] = {0x00, 0x00, 0x00};


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
 unsigned char tmp = 0x00;
 unsigned char temp = 0x00;

 Init_Device();
 UART1_Init(1200);

 while(1)
 {
 if(cnt >= 3)
 {
 if(rx_buffer[0] == 0xAA)
 {
 temp = (rx_buffer[1] - 0x30);
 tmp = (temp * 10);
 temp = (rx_buffer[2] - 0x30);
 tmp += temp;

 value = tmp;
 }
 cnt = 0;
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
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}


void UART_Init(void)
{
 SCON0 = 0x10;
}


void Port_IO_Init(void)
{
#line 172 "E:/Current_Works/C8051F3xx Tutorial/Code/PCA - Frequency Output/RX/ir_rx.c"
 P0MDOUT = 0x10;
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
 UART_Init();
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
