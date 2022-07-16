const code unsigned int LUT_1[32] = 
{
      0, 
      6423, 
      12785, 
      19023, 
      25079, 
      30892, 
      36409, 
      41574, 
      46340, 
      50659, 
      54490, 
      57796, 
      60546, 
      62713, 
      64275, 
      65219,
      65532,
      65219,
      64275, 
      62713,
      60546,
      57796,
      54490,
      50659,
      46340,
      41574,
      36409,
      30892,
      25079,
      19023,
      12785,
      6423,
};


const code unsigned int LUT_2[32] =
{
      54490,
      57796,
      60546,
      62713,
      64275,
      65219,
      65532,
      65219,
      64275,
      62713,
      60546,
      57796,
      54490,
      50659,
      46340,
      41574,
      36409,
      30892,
      25079,
      19023,
      12785,
      6423,
      0,
      6423,
      12785,
      19023,
      25079,
      30892,
      36409,
      41574,
      46340,
      50659
};


const code unsigned int LUT_3[32] =
{
      60546,
      57796,
      54490,
      50659,
      46340,
      41574,
      36409,
      30892,
      25079,
      19023,
      12785,
      6423,
      0,
      6423,
      12785,
      19023,
      25079,
      30892,
      36409,
      41574,
      46340,
      50659,
      54490,
      57796,
      60546,
      62713,
      64275,
      65219,
      65532,
      65219,
      64275,
      62713
};


void PCA_Init(void);
void Port_IO_Init(void);
void Oscillator_Init(void);
void Init_Device(void);
void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB);
void PWM_0_duty_cycle(unsigned int value);
void PWM_1_duty_cycle(unsigned int value);
void PWM_2_duty_cycle(unsigned int value);


void main(void)
{
    unsigned int i = 0;
    unsigned char j = 0;
    unsigned char mode = 1;
    
    Init_Device();
    
    while(1)
    {
        switch(mode)
        {
            case 1:
            {
                PWM_1_duty_cycle(0);
                PWM_2_duty_cycle(0);
                
                for(j = 0; j < 6; j++)
                {
                    for(i = 0; i < 32; i++)
                    {
                        PWM_0_duty_cycle(LUT_1[i]);
                        delay_ms(45);
                    }
                }
                break;
            }
            
            case 2:
            {
                PWM_0_duty_cycle(0);
                PWM_2_duty_cycle(0);
                
                for(j = 0; j < 6; j++)
                {
                    for(i = 0; i < 32; i++)
                    {
                        PWM_1_duty_cycle(LUT_1[i]);
                        delay_ms(45);
                    }
                }
                break;
            }
            
            case 3:
            {
                PWM_0_duty_cycle(0);
                PWM_1_duty_cycle(0);
                
                for(j = 0; j < 6; j++)
                {
                    for(i = 0; i < 32; i++)
                    {
                        PWM_2_duty_cycle(LUT_1[i]);
                        delay_ms(45);
                    }
                }
                break;
            }
            
            default:
            {
                for(j = 0; j < 10; j++)
                {
                    for(i = 0; i < 32; i++)
                    {
                        PWM_0_duty_cycle(LUT_1[i]);
                        PWM_1_duty_cycle(LUT_2[i]);
                        PWM_2_duty_cycle(LUT_3[i]);
                        delay_ms(200);
                    }
                }
                break;
            }
        }
        
        mode++;
        if(mode > 3)
        {
            mode  = 0;
        }
    };
}


void PCA_Init(void)
{
    PCA0CN = 0x40;
    PCA0MD &= ~0x40;
    PCA0MD = 0x02;
    PCA0CPM0 = 0xC2;
    PCA0CPM1 = 0xC2;
    PCA0CPM2 = 0xC2;
    PCA0L = 0xC0;
    PCA0H = 0x4F;
    PCA0CPL0 = 0xFF;
    PCA0CPL1 = 0xFF;
    PCA0CPL2 = 0xFF;
    PCA0CPH0 = 0xFF;
    PCA0CPH1 = 0xFF;
    PCA0CPH2 = 0xFF;
}


void Port_IO_Init(void)
{
    // P0.0  -  CEX0 (PCA),  Push-Pull,  Digital
    // P0.1  -  CEX1 (PCA),  Push-Pull,  Digital
    // P0.2  -  CEX2 (PCA),  Push-Pull,  Digital
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
    // P1.6  -  Unassigned,  Open-Drain, Digital
    // P1.7  -  Unassigned,  Open-Drain, Digital

    P0MDOUT = 0x07;
    XBR1 = 0x43;
}


void Oscillator_Init(void)
{
    OSCICN = 0x82;
}


void Init_Device(void)
{
    PCA_Init();
    Port_IO_Init();
    Oscillator_Init();
}


void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB)
{
    *LB = (unsigned char)(value & 0x00FF);
    *HB = (unsigned char)((value & 0xFF00) >> 0x08);
}



void PWM_0_duty_cycle(unsigned int value)
{
    unsigned char hb = 0x00;
    unsigned char lb = 0x00;

    get_HB_LB(value, &hb, &lb);
    
    PCA0CPL0 = lb;
    PCA0CPH0 = hb;
    CCF0_bit = 0;
}


void PWM_1_duty_cycle(unsigned int value)
{
    unsigned char hb = 0x00;
    unsigned char lb = 0x00;

    get_HB_LB(value, &hb, &lb);

    PCA0CPL1 = lb;
    PCA0CPH1 = hb;
    CCF1_bit = 0;
}


void PWM_2_duty_cycle(unsigned int value)
{
    unsigned char hb = 0x00;
    unsigned char lb = 0x00;

    get_HB_LB(value, &hb, &lb);

    PCA0CPL2 = lb;
    PCA0CPH2 = hb;
    CCF2_bit = 0;
}