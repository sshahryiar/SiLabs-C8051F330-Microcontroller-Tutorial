#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/SMBUS/compass.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/smbus/hmc5883l.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/smbus/hmc5883l.h"
#line 22 "e:/current_works/c8051f3xx tutorial/code/smbus/hmc5883l.h"
signed int X_axis = 0;
signed int Y_axis = 0;
signed int Z_axis = 0;
float m_scale = 1.0;


unsigned int make_word(unsigned char HB, unsigned char LB);
void HMC5883L_init(void);
unsigned char HMC5883L_read(unsigned char reg);
void HMC5883L_write(unsigned char reg_address, unsigned char value);
void HMC5883L_read_data(void);
void HMC5883L_scale_axes(void);
void HMC5883L_set_scale(float gauss);
float HMC5883L_heading(void);
#line 4 "e:/current_works/c8051f3xx tutorial/code/smbus/hmc5883l.c"
unsigned int make_word(unsigned char HB, unsigned char LB)
{
 unsigned int val = 0;

 val = HB;
 val <<= 8;
 val |= LB;

 return val;
}


void HMC5883L_init(void)
{
 SMBus1_Init(20000);
 HMC5883L_write( 0x00 , 0x70);
 HMC5883L_write( 0x01 , 0xA0);
 HMC5883L_write( 0x02 , 0x00);
 HMC5883L_set_scale(1.3);
}


unsigned char HMC5883L_read(unsigned char reg)
{
 unsigned char val = 0;

 SMBus1_Start();
 SMBus1_Write( 0x3C );
 SMBus1_Write(reg);
 SMBus1_Repeated_Start();
 SMBus1_Write( 0x3D );
 val = SMBus1_Read(0);
 SMBus1_Stop();

 return(val);
}


void HMC5883L_write(unsigned char reg_address, unsigned char value)
{
 SMBus1_Start();
 SMBus1_Write( 0x3C );
 SMBus1_Write(reg_address);
 SMBus1_Write(value);
 SMBus1_Stop();
}

void HMC5883L_read_data(void)
{
 unsigned char lsb = 0;
 unsigned char msb = 0;

 SMBus1_Start();
 SMBus1_Write( 0x3C );
 SMBus1_Write( 0x03 );
 SMBus1_Repeated_Start();
 SMBus1_Write( 0x3D );

 msb = SMBus1_Read(1);
 lsb = SMBus1_Read(1);
 X_axis = make_word(msb, lsb);

 msb = SMBus1_Read(1);
 lsb = SMBus1_Read(1);
 Z_axis = make_word(msb, lsb);

 msb = SMBus1_Read(1);
 lsb = SMBus1_Read(0);
 Y_axis = make_word(msb, lsb);

 SMBus1_Stop();
}


void HMC5883L_scale_axes(void)
{
 X_axis *= m_scale;
 Z_axis *= m_scale;
 Y_Axis *= m_scale;
}


void HMC5883L_set_scale(float gauss)
{
 unsigned char value = 0;

 if(gauss == 0.88)
 {
 value = 0x00;
 m_scale = 0.73;
 }

 else if(gauss == 1.3)
 {
 value = 0x01;
 m_scale = 0.92;
 }

 else if(gauss == 1.9)
 {
 value = 0x02;
 m_scale = 1.22;
 }

 else if(gauss == 2.5)
 {
 value = 0x03;
 m_scale = 1.52;
 }

 else if(gauss == 4.0)
 {
 value = 0x04;
 m_scale = 2.27;
 }

 else if(gauss == 4.7)
 {
 value = 0x05;
 m_scale = 2.56;
 }

 else if(gauss == 5.6)
 {
 value = 0x06;
 m_scale = 3.03;
 }

 else if(gauss == 8.1)
 {
 value = 0x07;
 m_scale = 4.35;
 }

 value <<= 5;
 HMC5883L_write( 0x01 , value);
}


float HMC5883L_heading(void)
{
 float heading = 0.0;

 HMC5883L_read_data();
 HMC5883L_scale_axes();
 heading = atan2(Y_axis, X_axis);
 heading +=  -0.5167 ;

 if(heading < 0.0)
 {
 heading += (2.0 *  3.142 );
 }

 if(heading > (2.0 *  3.142 ))
 {
 heading -= (2.0 *  3.142 );
 }

 heading *= (180.0 /  3.142 );

 return heading;
}
#line 9 "E:/Current_Works/C8051F3xx Tutorial/Code/SMBUS/compass.c"
unsigned char i = 0;
signed int h = 0;
unsigned char val = 0;


const unsigned char code segment_code[13] =
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
 0xBF,
 0x9C
};


const unsigned char code display_pos[4] =
{
 0xF7,
 0xFB,
 0xFD,
 0xFE
};


void PCA_Init(void);
void SMBus_Init(void);
void Timer_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
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
 val = (h / 100);
 break;
 }
 case 1:
 {
 val = ((h % 100) / 10);
 break;
 }
 case 2:
 {
 val = (h % 10);
 break;
 }
 case 3:
 {
 val = 12;
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
 h = HMC5883L_heading();
 delay_ms(200);
 }
}


void PCA_Init(void)
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
}


void SMBus_Init(void)
{
 SMB0CF = 0x80;
}


void Timer_Init(void)
{
 TMR3CN = 0x04;
 TMR3RLL = 0x02;
 TMR3RLH = 0xFC;
}


void Port_IO_Init(void)
{
#line 147 "E:/Current_Works/C8051F3xx Tutorial/Code/SMBUS/compass.c"
 P1MDOUT = 0xE0;
 P1SKIP = 0xE0;
 XBR0 = 0x04;
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
 SMBus_Init();
 Timer_Init();
 Port_IO_Init();
 Oscillator_Init();
 Interrupts_Init();
 HMC5883L_init();
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
