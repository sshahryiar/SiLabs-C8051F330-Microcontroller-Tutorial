#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/RF Data Transmission/RX/rf_rx.c"
#line 12 "E:/Current_Works/C8051F3xx Tutorial/Code/RF Data Transmission/RX/rf_rx.c"
void PCA_Init(void);
void Timer_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);
unsigned char receive_data(void);
signed long decode_data(void);


unsigned char i = 0;
unsigned char val = 0;
signed int value = 0;

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


void Timer_3_ISR(void)
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
 Init_Device();

 while(1)
 {
 value = decode_data();
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
#line 142 "E:/Current_Works/C8051F3xx Tutorial/Code/RF Data Transmission/RX/rf_rx.c"
 P0MDOUT = 0x02;
 P1MDOUT = 0xE0;
 P0SKIP = 0x03;
 P1SKIP = 0xE0;
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
 write_74HC595(segment_code[disp]);
 write_74HC595(display_pos[pos]);
  P1_7_bit  = 0;
  P1_7_bit  = 1;
}


unsigned char receive_data(void)
{
 unsigned char t = 0;

 while(! P0_0_bit );
 while( P0_0_bit )
 {
 t++;
 delay_us(10);
 };

 if((t > 25) && (t < 75))
 {
 return  0x09 ;
 }
 else if((t > 175) && (t < 225))
 {
 return 1;
 }
 else if((t > 75) && (t < 125))
 {
 return 0;
 }
 else
 {
 return  0x06 ;
 }
}


signed long decode_data(void)
{
 unsigned char d = 0;
 unsigned char s = 0;
 unsigned long value = 0;
 unsigned char v1 = 0;
 unsigned char v2 = 0;

 while(receive_data() !=  0x09 );

 d = receive_data();
 while(d ==  0x09 )
 {
 d = receive_data();
 };

 while(s < 15)
 {
 switch(d)
 {
 case 1:
 {
 value |= 1;
 break;
 }
 case 0:
 {
 break;
 }
 case  0x09 :
 case  0x06 :
 {
 return -1;
 }
 }
 s++;
 value <<= 1;
 d = receive_data();
 }

 v1 = (value >> 8);
 v2 = (value & 0x00FF);
 delay_ms(4);

 if((v1 & 0xAA) == v2)
 {
 return v1;
 }
 else
 {
 return -1;
 }
}
