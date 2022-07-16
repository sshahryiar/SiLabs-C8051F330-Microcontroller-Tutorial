#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/Software PWM/sw_pwm.c"
#line 13 "E:/Current_Works/C8051F3xx Tutorial/Code/Software PWM/sw_pwm.c"
unsigned char i = 0;
register unsigned char val = 0;
unsigned char count = 0;
unsigned char duty_cycle_1 =  5 ;
unsigned char duty_cycle_2 =  25 ;

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


void Timer_2_ISR(void)
iv IVT_ADDR_ET2
ilevel 0
ics ICS_AUTO
{
 count++;

 if(count <=  240 )
 {
 if(count <= duty_cycle_1)
 {
 P0_0_bit = 1;
 }
 else
 {
 P0_0_bit = 0;
 }

 if(count <= duty_cycle_2)
 {
 P0_1_bit = 1;
 }
 else
 {
 P0_1_bit = 0;
 }
 }

 else
 {
 count = 0;
 }
 P0_2_bit = ~P0_2_bit;
 TF2H_bit = 0;
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
 val = (duty_cycle_1 / 1000);
 break;
 }
 case 1:
 {
 val = ((duty_cycle_1 % 1000) / 100);
 break;
 }
 case 2:
 {
 val = ((duty_cycle_1 % 100) / 10);
 break;
 }
 case 3:
 {
 val = (duty_cycle_1 % 10);
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
 if( P1_4_bit  == 0)
 {
 delay_ms(60);
 duty_cycle_1++;
 duty_cycle_2--;
 }

 if( P1_3_bit  == 0)
 {
 delay_ms(60);
 duty_cycle_1--;
 duty_cycle_2++;
 }

 if(duty_cycle_1 >=  25 )
 {
 duty_cycle_1 =  25 ;
 duty_cycle_2 =  5 ;
 }

 if(duty_cycle_1 <=  5 )
 {
 duty_cycle_1 =  5 ;
 duty_cycle_2 =  25 ;
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
 TMR2CN = 0x04;
 TMR2RLL = 0x99;
 TMR2RLH = 0xFF;
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}

void Port_IO_Init(void)
{
#line 205 "E:/Current_Works/C8051F3xx Tutorial/Code/Software PWM/sw_pwm.c"
 P0MDOUT = 0x07;
 P1MDOUT = 0xE0;
 P0SKIP = 0x07;
 P1SKIP = 0xF8;
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
