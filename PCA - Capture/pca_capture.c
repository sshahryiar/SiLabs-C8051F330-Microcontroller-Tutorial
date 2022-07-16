#include "Waveshare_RGB_LCD.c"
#include "lcd_print_rgb.c"


#define RED_filter      0x00
#define BLUE_filter     0x01
#define CLEAR_filter    0x02
#define GREEN_filter    0x03


#define S2            P1_4_bit
#define S3            P1_5_bit


unsigned long count = 0;
unsigned int overflow = 0;
unsigned int past_capture = 0;
unsigned int current_capture = 0;


void PCA_Init(void);
void Voltage_Reference_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
unsigned int get_capture_count(void);


void PCA0_ISR(void) 
iv IVT_ADDR_EPCA0
ilevel 0
ics ICS_AUTO
{
    if(CF_bit)
    {
        overflow++;
        CF_bit = 0;
    }
    
    if(CCF0_bit)
    {
        current_capture = get_capture_count();
        count = ((overflow << 16) + (current_capture - past_capture));
        past_capture = current_capture;
        overflow = 0x00000;
        current_capture = 0;
        CCF0_bit = 0;
    }
}


void main(void)
{
    unsigned long f = 0;
    unsigned long fr = 0;
    unsigned long fg = 0;
    unsigned long fb = 0;
    unsigned long fc = 0;
    unsigned char mode = 0;

    Init_Device();
    RGB_LCD_init();
    LCD_clear_home();
    
    LCD_goto(0, 0);
    LCD_putstr(" R%  G%  B%  fC");
    
    while(1)
    {
        switch(mode)
        {
            case RED_filter:
            {
                S2 = 0;
                S3 = 0;
                break;
            }
            case BLUE_filter:
            {
                S2 = 0;
                S3 = 1;
                break;
            }
            case CLEAR_filter:
            {
                S2 = 1;
                S3 = 0;
                break;
            }
            case GREEN_filter:
            {
                S2 = 1;
                S3 = 1;
                break;
            }
        }
        delay_ms(100);
        
        f = (1020833 / ((float)count));
        
        switch(mode)
        {
            case RED_filter:
            {
                fr = f;
                break;
            }
            case BLUE_filter:
            {
                fb = f;
                break;
            }
            case CLEAR_filter:
            {
                fc = f;
                break;
            }
            case GREEN_filter:
            {
                fg = f;
                break;
            }
        }
        
        mode++;
        
        if(mode > 3)
        {
            fr = (((float)fr / (float)fc) * 100);
            fg = (((float)fg / (float)fc) * 100);
            fb = (((float)fb / (float)fc) * 100);
            
            print_C(0, 1, fr);
            print_C(4, 1, fg);
            print_C(8, 1, fb);
            print_I(12, 1, fc); 
            
            fr <<= 1;
            fg <<= 1;
            fb <<= 1;
            set_RGB(fr, fg, fb);
            
            mode = 0;
            delay_ms(400);
        }
    };
}


void PCA_Init(void)
{
    PCA0CN = 0x40;
    PCA0MD &= ~0x40;
    PCA0MD = 0x01;
    PCA0CPM0 = 0x11;
}


void Voltage_Reference_Init(void)
{
    REF0CN = 0x08;
}


void Port_IO_Init(void)
{
    // P0.0  -  CEX0 (PCA),  Open-Drain, Digital
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
    // P1.4  -  Skipped,     Push-Pull,  Digital
    // P1.5  -  Skipped,     Push-Pull,  Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P1MDOUT = 0xF0;
    P1SKIP = 0xF0;
    XBR1 = 0x41;
}


void Oscillator_Init(void)
{
    OSCICN = 0x82;
}


void Interrupts_Init(void)
{
    IE = 0x80;
    EIE1 = 0x10;
}


void Init_Device(void)
{
    PCA_Init();
    Voltage_Reference_Init();
    Port_IO_Init();
    Oscillator_Init();
    Interrupts_Init();
}


unsigned int get_capture_count(void)
{
    unsigned char lb = 0x00;
    unsigned char hb = 0x00;
    unsigned int cnt = 0x0000;

    hb = PCA0CPH0;
    lb = PCA0CPL0;

    cnt = hb;
    cnt <<= 8;
    cnt |= lb;
    
    return cnt;
}