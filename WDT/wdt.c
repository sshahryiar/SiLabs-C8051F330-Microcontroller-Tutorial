#define LED_DOUT          P1_6_bit
#define LED_CLK           P1_5_bit
#define LED_LATCH         P1_7_bit
#define BUTTON            P1_4_bit


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
  0x7F, // .
  0xBF  // -
};


const unsigned char code display_pos[4] =
{
  0xF7, //1st Display
  0xFB, //2nd Display
  0xFD, //3rd Display
  0xFE  //4th Display
};


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
  signed int s = 200;
  
  Init_Device();

  while(1)
  {
      value++;
      delay_ms(20);
      if(BUTTON == 1)
      {
         PCA0CPH2 = 0;
         delay_ms(20);
         PCA0CPH2 = 0;
         delay_ms(20);
         PCA0CPH2 = 0;
      }
      else
      {
         PCA0CPH2 = 0;
         while(s > 0)
         {
             PCA0CPH2 = 0;
             delay_ms(30);
             s--;
         }
         while(1);
      }
  };
}


void PCA_Init()
{
    PCA0MD &= ~0x40;
    PCA0MD = 0x00;
    PCA0CPM2 = 0x01;
    PCA0CPL2 = 0xFF;
    PCA0MD |= 0x40;
    PCA0CPH2 = 0;
}


void Timer_Init(void)
{
    TMR3CN = 0x04;
    TMR3RLL = 0x02;
    TMR3RLH = 0xFC;
    PCA0CPH2 = 0;
}


void Port_IO_Init(void)
{
    // P0.0  -  Unassigned,  Open-Drain, Digital
    // P0.1  -  Unassigned,  Open-Drain, Digital
    // P0.2  -  Unassigned,  Open-Drain, Digital
    // P0.3  -  Unassigned,  Open-Drain, Digital
    // P0.4  -  Unassigned,  Open-Drain, Digital
    // P0.5  -  Unassigned,  Open-Drain, Digital
    // P0.6  -  Unassigned,  Open-Drain, Digital
    // P0.7  -  Unassigned,  Open-Drain, Digital

    // P1.0  -  Unassigned,  Open-Drain, Digital
    // P1.1  -  Unassigned,  Open-Drain, Digital
    // P1.2  -  Unassigned,  Open-Drain, Digital
    // P1.3  -  Unassigned,  Open-Drain, Digital
    // P1.4  -  Skipped,     Open-Drain, Digital
    // P1.5  -  Skipped,     Push-Pull,  Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P1MDOUT = 0xE0;
    P1SKIP = 0xF0;
    XBR1 = 0x40;
    PCA0CPH2 = 0;
}


void Oscillator_Init(void)
{
    OSCICN = 0x82;
    PCA0CPH2 = 0;
}


void Interrupts_Init(void)
{
    IE = 0x80;
    EIE1 = 0x80;
    PCA0CPH2 = 0;
}


void Init_Device(void)
{
    PCA0MD = 0x00;
    
    Timer_Init();
    Port_IO_Init();
    Oscillator_Init();
    Interrupts_Init();
    PCA_Init();
    
    LED_LATCH = 1;
    LED_CLK = 1;
    LED_DOUT = 0;
    PCA0CPH2 = 0;
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