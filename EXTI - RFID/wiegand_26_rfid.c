#include "Waveshare_RGB_LCD.c"
#include "lcd_print_rgb.c"


unsigned char count = 0;
unsigned long raw_card_data = 0;


void PCA_Init(void);
void Timer_Init(void);
void Port_IO_Init();
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);


void EXTI_0_ISR(void)
iv IVT_ADDR_EX0 
ilevel 0 
ics ICS_AUTO 
{
    raw_card_data <<= 1;
    count++;
}


void EXTI_1_ISR(void)
iv IVT_ADDR_EX1 
ilevel 0 
ics ICS_AUTO 
{
    raw_card_data <<= 1;
    raw_card_data |= 1;
    count++;
}


void main(void)
{
    unsigned char facility_code = 0;
    unsigned int card_number = 0;
    
    Init_Device();
    RGB_LCD_init();
    LCD_clear_home();
    
    LCD_goto(0, 0);
    LCD_putstr("Facility:");

    LCD_goto(0, 1);
    LCD_putstr("Card I.D:");
    
    while(1)
    {
        if(count >= 25)
        {
            card_number = (raw_card_data & 0xFFFF);
            facility_code = (0xFF & (raw_card_data >> 0x10));
            print_C(12, 0, facility_code);
            print_I(10, 1, card_number);
            raw_card_data = 0;
            count = 0;
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
    TCON = 0x05;
}


void Port_IO_Init()
{
    // P0.0  -  Skipped,     Open-Drain, Digital
    // P0.1  -  Skipped,     Open-Drain, Digital
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
    // P1.5  -  Unassigned,  Open-Drain, Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P1MDOUT = 0xC0;
    P0SKIP = 0x03;
    P1SKIP = 0xC0;
    XBR1 = 0x40;
}


void Oscillator_Init(void)
{
    OSCICN = 0x82;
}


void Interrupts_Init(void)
{
    IE = 0x85;
    IP = 0x05;
    IT01CF = 0x10;
}


void Init_Device(void)
{
    PCA_Init();
    Timer_Init();
    Port_IO_Init();
    Oscillator_Init();
    Interrupts_Init();
}