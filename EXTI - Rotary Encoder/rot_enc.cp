#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/EXTI - Rotary Encoder/rot_enc.c"









unsigned char i = 0;
unsigned char val = 0;
unsigned char past_clock_state = 0;
unsigned char present_clock_state = 0;
unsigned char data_state = 0;
signed int value = 0;
unsigned int step_size = 1;


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


void EXTI_0_ISR(void)
iv IVT_ADDR_EX0
ilevel 0
ics ICS_AUTO
{
 present_clock_state =  P0_1_bit ;
 data_state =  P0_0_bit ;

 if(present_clock_state != past_clock_state)
 {
 if(data_state != present_clock_state)
 {
 value -= step_size;
 }
 else
 {
 value += step_size;
 }

 past_clock_state = present_clock_state;
 }

 if(value > 9999)
 {
 value = 0;
 }

 if(value < 0)
 {
 value = 9999;
 }
}


void Timer_3_ISR(void)
iv IVT_ADDR_ET3
ilevel 1
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
 if( P0_2_bit  == 0)
 {
 delay_ms(60);
 while( P0_2_bit  == 0);
 step_size *= 10;

 if(step_size > 1000)
 {
 step_size = 1;
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
 TCON = 0x01;
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}

void Port_IO_Init(void)
{
#line 187 "E:/Current_Works/C8051F3xx Tutorial/Code/EXTI - Rotary Encoder/rot_enc.c"
 P1MDOUT = 0xE0;
 P0SKIP = 0x07;
 P1SKIP = 0xE0;
 XBR1 = 0x40;
}

void Oscillator_Init(void)
{
 OSCICN = 0x82;
}

void Interrupts_Init(void)
{
 IE = 0x81;
 IP = 0x01;
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
