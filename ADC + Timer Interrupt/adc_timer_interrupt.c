#define LED_DOUT  P1_6_bit
#define LED_CLK   P1_5_bit
#define LED_LATCH P1_7_bit

#define ADC_res    1023.0
#define VDD_mv     3300.0


unsigned char i = 0;
unsigned char pt = 0;
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


void PCA_Init(void);
void Timer_Init();
void Port_IO_Init();
void Oscillator_Init();
void Interrupts_Init();
void ADC_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos, unsigned char point);
unsigned int adc_read(void);
void Voltage_Reference_Init(void);
unsigned int adc_avg(unsigned char channel);


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
            pt = 0;
            break;
        }
        case 1:
        {
            val = ((value % 1000) / 100);
            pt = 1;
            break;
        }
        case 2:
        {
            val = ((value % 100) / 10);
            pt = 0;
            break;
        }
        case 3:
        {
            val = (value % 10);
            pt = 0;
            break;
        }
    }

    segment_write(val, i, pt);

    i++;

    if(i > 3)
    {
       i = 0;
    }

    TMR3CN &= 0x7F;
}


void main(void)
{
  float t = 0;
  
  Init_Device();
  
  while(1)
  {
     t = (adc_avg(0) * VDD_mv);
     t /= ADC_res;
     value = (t / 0.3);
     delay_ms(100);
  };
}


void PCA_Init(void)
{
    PCA0MD &= ~0x40;
    PCA0MD = 0x00;
}


void Timer_Init()
{
    TMR3CN = 0x04;
    TMR3RLL = 0x02;
    TMR3RLH = 0xFC;
}


void Port_IO_Init()
{
    // P0.0  -  Skipped,     Open-Drain, Analog
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
    // P1.4  -  Unassigned,  Open-Drain, Digital
    // P1.5  -  Skipped,     Push-Pull,  Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P0MDIN = 0xFE;
    P1MDOUT = 0xE0;
    P0SKIP = 0x01;
    P1SKIP = 0xE0;
    XBR1 = 0x40;
}


void Oscillator_Init()
{
    OSCLCN = 0x82;
}


void Interrupts_Init()
{
    IE = 0x80;
    EIE1 = 0x80;
}


void ADC_Init(void)
{
    AMX0P = 0x00;
    AMX0N = 0x11;
    ADC0CF = 0x58;
    ADC0CN = 0x80;
}


void Voltage_Reference_Init(void)
{
    REF0CN = 0x0A;
}


void Init_Device(void)
{
    PCA_Init();
    Timer_Init();
    Port_IO_Init();
    Oscillator_Init();
    Interrupts_Init();
    ADC_Init();
    Voltage_Reference_Init();
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


void segment_write(unsigned char disp, unsigned char pos, unsigned char point)
{
    unsigned char write_value = segment_code[disp];
     
    if(point)
    {
        write_value &= segment_code[10];
    }
    
    LED_LATCH = 0;
    write_74HC595(write_value);
    write_74HC595(display_pos[pos]);
    LED_LATCH = 1;
    
}


unsigned int adc_read(void)
{
   unsigned int ad_value = 0;

   ad_value = ADC0H;
   ad_value <<= 8;
   ad_value |= ADC0L;
   
   return ad_value;
}


unsigned int adc_avg(unsigned char channel)
{
    unsigned int avg_value = 0;
    signed char samples = 16;
    
    AMX0P = (channel & 0x1F);
    delay_ms(1);
    
    while(samples > 0)
    {
        AD0INT_bit = 0;
        AD0BUSY_bit = 1;
        
        while(AD0INT_bit == 0);
        avg_value += adc_read();
        
        samples--;
    };
    
    avg_value >>= 4;
    
    return avg_value;
}