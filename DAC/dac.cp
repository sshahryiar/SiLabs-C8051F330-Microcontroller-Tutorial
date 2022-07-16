#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/DAC/dac.c"









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


const unsigned int code LUT_sine[32] =
{
 512,
 615,
 714,
 804,
 882,
 946,
 991,
 1017,
 1023,
 1007,
 971,
 916,
 845,
 760,
 665,
 564,
 460,
 359,
 264,
 179,
 108,
 53,
 17,
 2,
 7,
 33,
 78,
 142,
 220,
 310,
 409,
 512
};


const unsigned int code LUT_triangle[32] =
{
 512,
 576,
 640,
 704,
 768,
 832,
 896,
 960,
 1023,
 960,
 896,
 832,
 768,
 704,
 640,
 576,
 512,
 448,
 384,
 320,
 256,
 192,
 128,
 64,
 0,
 64,
 128,
 192,
 256,
 320,
 384,
 448
};


const unsigned int code LUT_square[32] =
{
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023,
 1023
};


void PCA_Init(void);
void Timer_Init(void);
void DAC_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);
void DAC_write(unsigned int dac_value);


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
 signed char l = 0;
 unsigned int j = 0;
 signed int dly = 0;
 unsigned int dac_data = 0;
 unsigned char mode = 0;

 Init_Device();

 while(1)
 {
 if( P1_3_bit  == 0)
 {
 delay_ms(30);
 l = 0;
 dac_data = 0;
 mode++;
 }

 if(mode >= 3)
 {
 mode = 0;
 }

 if( P1_2_bit  == 0)
 {
 delay_ms(40);
 dly++;
 }

 if(dly > 9999)
 {
 dly = 0;
 }

 if( P1_1_bit  == 0)
 {
 delay_ms(40);
 dly--;
 }

 if(dly < 0)
 {
 dly = 9999;
 }

 value = dly;

 switch(mode)
 {
 case 1:
 {
 dac_data = LUT_triangle[l];
 break;
 }

 case 2:
 {
 dac_data = LUT_square[l];
 break;
 }

 default:
 {
 dac_data = LUT_sine[l];
 break;
 }
 }

 l++;
 if(l >= 32)
 {
 l = 0;
 }

 DAC_write(dac_data);

 for(j = 0; j < dly; j++)
 {
 delay_us(1);
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


void DAC_Init(void)
{
 IDA0CN = 0xF2;
}


void Port_IO_Init(void)
{
#line 333 "E:/Current_Works/C8051F3xx Tutorial/Code/DAC/dac.c"
 P0MDIN = 0xFD;
 P1MDOUT = 0xE0;
 P0SKIP = 0x02;
 P1SKIP = 0xEE;
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
 DAC_Init();
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


void DAC_write(unsigned int dac_value)
{
 unsigned char lb = 0x00;
 unsigned char hb = 0x00;

 dac_value <<= 0x06;

 lb = (dac_value & 0xC0);
 hb = ((dac_value & 0xFF00) >> 0x08);

 IDA0L = lb;
 IDA0H = hb;
}
