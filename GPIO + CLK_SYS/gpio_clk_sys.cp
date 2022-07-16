#line 1 "E:/Current_Works/C8051F3xx Tutorial/Code/GPIO + CLK_SYS/gpio_clk_sys.c"
void PCA_Init(void);
void Port_IO_Init(void);
void Init_Device(void);


void main(void)
{
 unsigned char i = 0;

 Init_Device();

 P1_0_bit = 1;
 P1_1_bit = 0;

 while(1)
 {
 if(P1_4_bit == 0)
 {
 delay_ms(100);
 i++;
 }

 switch(i)
 {
 case 0:
 {
 OSCICN = 0x83;
 break;
 }
 case 1:
 {
 OSCICN = 0x82;
 break;
 }
 case 2:
 {
 OSCICN = 0x81;
 break;
 }
 case 3:
 {
 OSCICN = 0x80;
 break;
 }
 default:
 {
 i = 0;
 break;
 }
 }

 P1_0_bit ^= 1;
 P1_1_bit ^= 1;
 delay_ms(100);
 };
}


void PCA_Init(void)
{
 PCA0MD &= ~0x40;
 PCA0MD = 0x00;
}


void Port_IO_Init(void)
{
#line 86 "E:/Current_Works/C8051F3xx Tutorial/Code/GPIO + CLK_SYS/gpio_clk_sys.c"
 P1MDOUT = 0x03;
 P1SKIP = 0x13;
 XBR1 = 0x40;
}


void Init_Device(void)
{
 PCA_Init();
 Port_IO_Init();
}
