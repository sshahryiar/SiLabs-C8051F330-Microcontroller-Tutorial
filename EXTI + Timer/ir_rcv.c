#include "LCD_2_Wire.c"
#include "lcd_print.c"


#define sync_high          16000
#define sync_low           10800
#define one_high            2700
#define one_low             1800
#define zero_high           1400
#define zero_low             900


bit received;
unsigned char bits = 0;
unsigned int frames[33];


void PCA_Init(void);
void Timer_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Interrupts_Init(void);
void Init_Device(void);
void erase_frames(void);
unsigned int get_timer(void);
void set_timer(void);
unsigned char decode(unsigned char start_pos, unsigned char end_pos);
void decode_NEC(unsigned char *addr, unsigned char *cmd);


void IR_receive(void)
iv IVT_ADDR_EX0
ilevel 0
ics ICS_AUTO
{
    frames[bits] = get_timer();
    bits++;
    TR0_bit = 1;

    if(bits >= 33)
    {
       received = 1;
       TR0_bit = 0;
    }
    set_timer();
}


void main(void)
{
    unsigned char i = 0;
    
    unsigned char address = 0;
    unsigned char command = 0;

    Init_Device();
    LCD_init();
    LCD_clear_home();
    
    LCD_goto(0, 0);
    LCD_putstr("ADR:");
    LCD_goto(0, 1);
    LCD_putstr("CMD:");
    
    while(1)
    {
       if(received)
       {
           decode_NEC(&address, &command);
           print_I(12, 0, address);
           print_I(12, 1, command);
           erase_frames();
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
    TCON = 0x01;
    TMOD = 0x01;
}


void Port_IO_Init(void)
{
    // P0.0  -  Skipped,     Open-Drain, Digital
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
    // P1.5  -  Unassigned,  Open-Drain, Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Push-Pull,  Digital

    P1MDOUT = 0xC0;
    P0SKIP = 0x01;
    P1SKIP = 0xC0;
    XBR1 = 0x40;
}


void Oscillator_Init(void)
{
    OSCICN = 0x82;
}


void Interrupts_Init(void)
{
    IE = 0x81;
    IT01CF = 0x00;
}


void Init_Device(void)
{
    PCA_Init();
    Timer_Init();
    Port_IO_Init();
    Oscillator_Init();
    Interrupts_Init();
}


void erase_frames(void)
{
     delay_ms(90);

     for(bits = 0; bits < 33; bits++)
     {
         frames[bits] = 0x0000;
     }

     set_timer();
     received = 0;
     bits = 0;
}


unsigned int get_timer(void)
{
    unsigned int time = 0;

    time = TH0;
    time <<= 8;
    time |= TL0;

    return time;
}


void set_timer(void)
{
     TH0 = 0;
     TL0 = 0;
}


unsigned char decode(unsigned char start_pos, unsigned char end_pos)
{
     unsigned char value = 0;

     for(bits = start_pos; bits <= end_pos; bits++)
     {
           value <<= 1;
           if((frames[bits] >= one_low) && (frames[bits] <= one_high))
           {
               value |= 1;
           }
           else if((frames[bits] >= zero_low) && (frames[bits] <= zero_high))
           {
               value |= 0;
           }
           else if((frames[bits] >= sync_low) && (frames[bits] <= sync_high))
           {
               return 0xFF;
           }
     }

     return value;
}


void decode_NEC(unsigned char *addr, unsigned char *cmd)
{
     *addr = decode(2, 9);
     *cmd = decode(18, 25);
}