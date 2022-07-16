#include "LCD_2_Wire.c"
#include "lcd_print.c"

#define measure_button     P1_4_bit

#define sampling_R         10000.0
#define div_factor         (sampling_R * 0.693147)

#define us_per_tick        0.9795918
#define scale_factor       50


unsigned char ovf = 0;
unsigned char measurement_done = 0;


void PCA_Init(void);
void Timer_Init(void);
void Comparator_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void reset_timer_1(void);
unsigned int get_timer_1(void);


void Timer_1_ISR(void)
iv IVT_ADDR_ET1 
ilevel 0 
ics ICS_AUTO 
{
    ovf++;
    TF1_bit = 0;
}


void Analog_Comparator_ISR(void) 
iv IVT_ADDR_ECP0 
ilevel 0 
ics ICS_AUTO 
{
    if(CP0FIF_bit)
    {
        measurement_done = 1;
        TCON = 0x00;
        P0_2_bit = 0;
        CP0FIF_bit = 0;
    }
}


void main(void)
{
    float c = 0.0;
    unsigned long cnt = 0;
    
    Init_Device();
    LCD_init();
    LCD_clear_home();

    LCD_goto(0, 0);
    LCD_putstr("Capacitance/ F:");

    while(1)
    {
        if((measure_button == 0) && (measurement_done == 0))
        {
            reset_timer_1();
            LCD_goto(0, 1);
            LCD_putstr("Discharging!  ");
            P0MDIN = 0xFE;
            P0MDOUT = 0x06;
            P0_1_bit = 0;
            P0_2_bit = 0;
            delay_ms(4000);
            P0MDIN = 0xFC;
            P0MDOUT = 0x04;
            TCON = 0x40;
            P0_2_bit = 1;
            LCD_goto(0, 1);
            LCD_putstr("Measuring!    ");
            delay_ms(4000);
        }
        
        if(measurement_done)
        {
           cnt = ovf;
           cnt <<= 16;
           cnt += get_timer_1();
           c = ((cnt * us_per_tick) / div_factor);
           c *= scale_factor;
           
           LCD_goto(0, 1);
           LCD_putstr("             ");

           if((c > 0.0) && (c < 10000000.0))
           {
               if((c > 0) && (c < 1000))
               {
                   LCD_goto(12, 0);
                   LCD_putstr("n");
               }
               else if((c >= 1000.0) && (c < 10000000.0))
               {
                   c /= 1000.0;
                   LCD_goto(12, 0);
                   LCD_putstr("u");
               }
               
               print_F(0, 1, c, 1);
           }
           
           else
           {
               LCD_goto(0, 1);
               LCD_putstr("O.L");
           }
           
           measurement_done = 0;
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
    TMOD = 0x10;
}


void Comparator_Init(void)
{
    CPT0CN = 0x8A;
    delay_us(20);
    CPT0CN &= ~0x30;
    CPT0MX = 0x00;
    CPT0MD = 0x11;
}

void Port_IO_Init(void)
{
    // P0.0  -  Skipped,     Open-Drain, Analog
    // P0.1  -  Skipped,     Open-Drain, Analog
    // P0.2  -  Skipped,     Push-Pull,  Digital
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
    // P1.5  -  Unassigned,  Open-Drain, Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P0MDIN = 0xFC;
    P0MDOUT = 0x04;
    P1MDOUT = 0xC0;
    P0SKIP = 0x07;
    P1SKIP = 0xD0;
    XBR1 = 0xC0;
}


void Oscillator_Init(void)
{
    OSCICN = 0x82;
}


void Interrupts_Init(void)
{
    IE = 0x88;
    EIE1 = 0x20;
}


void Init_Device(void)
{
    PCA_Init();
    Comparator_Init();
    Port_IO_Init();
    Oscillator_Init();
    Interrupts_Init();
}


void reset_timer_1(void)
{
    ovf = 0;
    TH1 = 0x00;
    TL1 = 0x00;
}


unsigned int get_timer_1(void)
{
    unsigned int counts = 0;
    
    counts = TH1;
    counts <<= 8;
    counts |= TL1;
    
    return counts;
}