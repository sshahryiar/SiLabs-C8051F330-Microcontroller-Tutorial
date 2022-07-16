#include "MAX31865.c"


#define LED_DOUT          P1_6_bit
#define LED_CLK           P1_5_bit
#define LED_LATCH         P1_7_bit


unsigned char i = 0;
register unsigned char val = 0;
unsigned int value = 0;

const unsigned char code segment_code[12] =
{
  0xC0, // 0
  0xF9, // 1
  0xA4, // 2
  0xB0, // 3
  0x99, // 4
  0x92, // 5
  0x82, // 6
  0xF8, // 7
  0x80, // 8
  0x90, // 9
  0x9C, // degree
  0xC6  // C

};


const unsigned char code display_pos[4] =
{
  0xF7, //1st Display
  0xFB, //2nd Display
  0xFD, //3rd Display
  0xFE  //4th Display
};


void PCA_Init(void);
void Timer_Init(void);
void SPI_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_ISR()
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
    Init_Device();
    MAX31865_init();

    while(1)
    {
        value = MAX31865_get_temperature();
        delay_ms(600);
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


void SPI_Init(void)
{
    SPI0CFG = 0x40;
    SPI0CN = 0x01;
    SPI0CKR = 0x05;
}


void Port_IO_Init(void)
{
    // P0.0  -  SCK  (SPI0), Push-Pull,  Digital
    // P0.1  -  MISO (SPI0), Open-Drain, Digital
    // P0.2  -  MOSI (SPI0), Push-Pull,  Digital
    // P0.3  -  Skipped,     Push-Pull,  Digital
    // P0.4  -  Unassigned,  Open-Drain, Digital
    // P0.5  -  Unassigned,  Open-Drain, Digital
    // P0.6  -  Unassigned,  Open-Drain, Digital
    // P0.7  -  Unassigned,  Open-Drain, Digital

    // P1.0  -  Unassigned,  Open-Drain, Digital
    // P1.1  -  Unassigned,  Open-Drain, Digital
    // P1.2  -  Unassigned,  Open-Drain, Digital
    // P1.3  -  Unassigned,  Open-Drain, Digital
    // P1.4  -  Unassigned,  Open-Drain, Digital
    // P1.5  -  Skipped,     Push-Pull,  Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P0MDOUT = 0x0D;
    P1MDOUT = 0xE0;
    P0SKIP = 0x08;
    P1SKIP = 0xE0;
    XBR0 = 0x02;
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
    SPI_Init();
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
          LED_DOUT = 0;
        }
        else
        {
          LED_DOUT = 1;
        }

        LED_CLK = 0;
        send_data <<= 1;
        clks--;
        LED_CLK = 1;
    }
}


void segment_write(unsigned char disp, unsigned char pos)
{
    LED_LATCH = 0;
    write_74HC595(segment_code[disp]);
    write_74HC595(display_pos[pos]);
    LED_LATCH = 1;
}