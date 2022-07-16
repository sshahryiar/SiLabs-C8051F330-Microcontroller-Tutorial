#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/MODBUS/serial_comm.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/modbus/tof200.c"
#line 1 "e:/current_works/c8051f3xx tutorial/code/modbus/tof200.h"
#line 46 "e:/current_works/c8051f3xx tutorial/code/modbus/tof200.h"
unsigned char cnt;
unsigned char rx_buffer[ 16 ];


unsigned int make_word(unsigned char HB, unsigned char LB);
void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB);
unsigned int MODBUS_RTU_CRC16(unsigned char *data_input, unsigned char data_length);
void flush_RX_buffer(void);
void MODBUS_TX(unsigned char slave_ID, unsigned char function_code, unsigned char reg, unsigned char value);
unsigned int ToF_get_range(void);
#line 4 "e:/current_works/c8051f3xx tutorial/code/modbus/tof200.c"
unsigned int make_word(unsigned char HB, unsigned char LB)
{
 unsigned int tmp = 0;

 tmp = HB;
 tmp <<= 8;
 tmp |= LB;

 return tmp;
}


void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB)
{
 *LB = (unsigned char)(value & 0x00FF);
 *HB = (unsigned char)((value & 0xFF00) >> 8);
}


unsigned int MODBUS_RTU_CRC16(unsigned char *data_input, unsigned char data_length)
{
 unsigned char n = 8;
 unsigned char s = 0;
 unsigned int CRC_word = 0xFFFF;

 for(s = 0; s < data_length; s++)
 {
 CRC_word ^= ((unsigned int)data_input[s]);

 n = 8;
 while(n > 0)
 {
 if((CRC_word & 0x0001) == 0)
 {
 CRC_word >>= 1;
 }

 else
 {
 CRC_word >>= 1;
 CRC_word ^= 0xA001;
 }

 n--;
 }
 }

 return CRC_word;
}


void flush_RX_buffer(void)
{
 signed char s = ( 8  - 1);

 while(s > -1)
 {
 rx_buffer[s] = 0x00;
 s--;
 };
}


void MODBUS_TX(unsigned char slave_ID, unsigned char function_code, unsigned char reg, unsigned char value)
{
 unsigned char i = 0x00;
 unsigned char lb = 0x00;
 unsigned char hb = 0x00;
 unsigned int temp = 0x0000;

 unsigned char tx_buffer[ 8 ];

 tx_buffer[0x00] = slave_ID;
 tx_buffer[0x01] = function_code;

 get_HB_LB(reg, &hb, &lb);

 tx_buffer[0x02] = hb;
 tx_buffer[0x03] = lb;

 get_HB_LB(value, &hb, &lb);

 tx_buffer[0x04] = hb;
 tx_buffer[0x05] = lb;

 temp = MODBUS_RTU_CRC16(tx_buffer, 6);
 get_HB_LB(temp, &hb, &lb);

 tx_buffer[0x06] = lb;
 tx_buffer[0x07] = hb;

 flush_RX_buffer();

 for(i = 0; i <  8 ; i++)
 {
 UART_Write(tx_buffer[i]);
 }

 cnt = 0x00;
 delay_ms(40);
}


unsigned int ToF_get_range(void)
{
 unsigned int CRC_1 = 0x0000;
 unsigned int CRC_2 = 0x0000;

 unsigned int distance = 5000;

 MODBUS_TX( 0x01 ,
  0x03 ,
  0x0010 ,
 0x0001);

 if(rx_buffer[0x00] ==  0x01 )
 {
 if(rx_buffer[0x01] ==  0x03 )
 {
 if(rx_buffer[0x02] == 0x02)
 {
 CRC_1 = MODBUS_RTU_CRC16(rx_buffer, 5);
 CRC_2 = make_word(rx_buffer[0x06], rx_buffer[0x05]);

 if(CRC_1 == CRC_2)
 {
 distance = make_word(rx_buffer[0x03], rx_buffer[0x04]);
 if(distance >  2000 )
 {
 distance = 40000;
 }
 }

 else
 {
 distance = 40000;
 }
 }
 }
 }

 return distance;
}
#line 9 "E:/Current_Works/C8051F3xx Tutorial/Code/MODBUS/serial_comm.c"
unsigned int d = 0;
unsigned char i = 0;
unsigned char value = 0;


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
 Init_Device();

 while(1)
 {
 d = ((float)ToF_get_range());
 delay_ms(400);
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
#line 156 "E:/Current_Works/C8051F3xx Tutorial/Code/MODBUS/serial_comm.c"
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
 UART1_Init(115200);
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
