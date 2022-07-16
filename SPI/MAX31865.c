#include "MAX31865.h"


void MAX31865_init(void)
{
    SPI1_Init_Advanced(1000000, _SPI_CLK_IDLE_LO | _SPI_CLK_ACTIVE_2_IDLE | _SPI_MASTER);
    delay_ms(10);

    MAX31865_CS = 1;
    
    MAX31865_write_byte(MAX31865_CONFIG_REG, \
                        MAX31865_CONFIG_BIAS | \
                        MAX31865_CONFIG_MODE_AUTO | \
                        MAX31865_CONFIG_3_WIRE | \
                        MAX31865_CONFIG_FAULT_STATUS | \
                        MAX31865_CONFIG_FILTER_50Hz);
}


unsigned char MAX31865_read_byte(unsigned char address)
{
    unsigned char retval = 0x00;
    
    MAX31865_CS = 0;
    SPI_Write(address & 0x7F);
    retval = SPI_Read(0x00);
    MAX31865_CS = 1;
    
    return retval;
}


unsigned int MAX31865_read_word(unsigned char address)
{
    unsigned char lb = 0x00;
    unsigned char hb = 0x00;
    unsigned int retval = 0x0000;

    hb = MAX31865_read_byte(address);
    lb = MAX31865_read_byte(address + 1);
    
    retval = hb;
    retval <<= 0x08;
    retval |= lb;
    
    return retval;
}


void MAX31865_write_byte(unsigned char address, unsigned char value)
{
    MAX31865_CS = 0;
    SPI_Write(address | 0x80);
    SPI_Write(value);
    MAX31865_CS = 1;
}


void MAX31865_write_word(unsigned char address, unsigned char lb, unsigned char hb)
{
    MAX31865_write_byte(address, hb);
    MAX31865_write_byte((address + 1), lb);
}


unsigned int MAX31865_get_RTD(void)
{
  unsigned int rtd_value = 0x00;
  
  rtd_value = MAX31865_read_word(MAX31865_RTD_MSB_REG);
  rtd_value >>= 1;
  
  return rtd_value;
}


signed int MAX31865_get_temperature(void)
{
    float rt = 0.0;
    signed int t_value = 0;
    
    t_value = MAX31865_get_RTD();
    rt = (MAX31865_Reference_Resistance * t_value);
    rt /= 32768.0;
    
    rt /= MAX31865_RTD_Nominal_Value;
    rt = (rt - 1.0);
    t_value = (rt / MAX31865_RTD_A);
    
    return t_value;
}