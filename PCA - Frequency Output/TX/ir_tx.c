#define LED_DOUT P1_6_bit
#define  LED_CLK P1_5_bit
#define  LED_LATCH P1_7_bit

#define ADC_res    1023.0
#define VDD_mv     3200.0

#define freq      (6125000 / 2 /38000)


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
void UART_Init(void);
void ADC_Init(void);
void Voltage_Reference_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void write_74HC595(unsigned char send_data);
void segment_write(unsigned char disp, unsigned char pos);


void Timer_ISR(void)
iv IVT_ADDR_ET3
ilevel 0
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
    unsigned int t = 0;
    char tmp = 0;
    Init_Device();
    UART1_Init(1200);
    ADC1_Init_Advanced(_INTERNAL_REF | _RIGHT_ADJUSTMENT);
    
    while(1)
    {
        t = (ADC1_Get_Sample(16) * VDD_mv);
        t /= 1023.0;
        t = (((float)t - 776.0) / 2.86);
        value = t;
        tmp = t;
        UART1_Write(0xAA);
        UART1_Write((tmp / 10) + 0x30);
        UART1_Write((tmp % 10) + 0x30);
        delay_ms(400);
    };
}


void PCA_Init(void)
{
    PCA0CN = 0x40;
    PCA0MD &= ~0x40;
    PCA0MD = 0x02;
    PCA0CPM1 = 0x46;
    PCA0CPH1 = 0x14;
}


void Timer_Init(void)
{
    TMR3CN = 0x04;
    TMR3RLL = 0x01;
    TMR3RLH = 0xFE;
}


void UART_Init(void)
{
    SCON0 = 0x10;
}


void ADC_Init(void)
{
    AMX0P = 0x10;
    AMX0N = 0x11;
    ADC0CF = 0xF0;
    ADC0CN = 0x80;
}


void Voltage_Reference_Init(void)
{
    REF0CN = 0x0F;
}


void Port_IO_Init(void)
{
    // P0.0  -  CEX0 (PCA),  Open-Drain, Digital
    // P0.1  -  CEX1 (PCA),  Push-Pull,  Digital
    // P0.2  -  Unassigned,  Open-Drain, Digital
    // P0.3  -  Unassigned,  Open-Drain, Digital
    // P0.4  -  TX0 (UART0), Push-Pull,  Digital
    // P0.5  -  RX0 (UART0), Open-Drain, Digital
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

    P0MDOUT = 0x12;
    P1MDOUT = 0xE0;
    P1SKIP = 0xE0;
    XBR0 = 0x01;
    XBR1 = 0x42;
}


void Oscillator_Init(void)
{
    OSCICN = 0x81;
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
    UART_Init();
    ADC_Init();
    Voltage_Reference_Init();
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