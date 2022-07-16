#include "ToF200.h"


unsigned int make_word(unsigned char HB, unsigned char LB)
{
    unsigned int tmp = 0;

    tmp = HB;
    tmp <<= 8;
    tmp |= LB;

    return tmp;
}


void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB)
{
    *LB = (unsigned char)(value & 0x00FF);
    *HB = (unsigned char)((value & 0xFF00) >> 8);
}


unsigned int MODBUS_RTU_CRC16(unsigned char *data_input, unsigned char data_length)
{
    unsigned char n = 8;
    unsigned char s = 0;
    unsigned int CRC_word = 0xFFFF;

    for(s = 0; s < data_length; s++)
    {
      CRC_word ^= ((unsigned int)data_input[s]);

      n = 8;
      while(n > 0)
      {
        if((CRC_word & 0x0001) == 0)
        {
          CRC_word >>= 1;
        }

        else
        {
          CRC_word >>= 1;
          CRC_word ^= 0xA001;
        }

        n--;
      }
    }

    return CRC_word;
}


void flush_RX_buffer(void)
{
    signed char s = (ToF200_TX_data_packet_size - 1);

    while(s > -1)
    {
        rx_buffer[s] = 0x00;
        s--;
    };
}


void MODBUS_TX(unsigned char slave_ID, unsigned char function_code, unsigned char reg, unsigned char value)
{
    unsigned char i  = 0x00;
    unsigned char lb = 0x00;
    unsigned char hb = 0x00;
    unsigned int temp = 0x0000;

    unsigned char tx_buffer[ToF200_TX_data_packet_size];

    tx_buffer[0x00] = slave_ID;
    tx_buffer[0x01] = function_code;
    
    get_HB_LB(reg, &hb, &lb);
    
    tx_buffer[0x02] = hb;
    tx_buffer[0x03] = lb;
    
    get_HB_LB(value, &hb, &lb);
    
    tx_buffer[0x04] = hb;
    tx_buffer[0x05] = lb;
    
    temp = MODBUS_RTU_CRC16(tx_buffer, 6);
    get_HB_LB(temp, &hb, &lb);
    
    tx_buffer[0x06] = lb;
    tx_buffer[0x07] = hb;

    flush_RX_buffer();

    for(i = 0; i < ToF200_TX_data_packet_size; i++)
    {
        UART_Write(tx_buffer[i]);
    }

    cnt = 0x00;
    delay_ms(40);
}


unsigned int ToF_get_range(void)
{
    unsigned int CRC_1 = 0x0000;
    unsigned int CRC_2 = 0x0000;
    
    unsigned int distance = 5000;
    
    MODBUS_TX(ToF200_slave_default_ID, 
              MODBUS_read_holding_registers_function_code, 
              ToF200_measurement_register,
              0x0001);
              
    if(rx_buffer[0x00] == ToF200_slave_default_ID)
    {
        if(rx_buffer[0x01] == MODBUS_read_holding_registers_function_code)
        {
            if(rx_buffer[0x02] == 0x02)
            {
                CRC_1 = MODBUS_RTU_CRC16(rx_buffer, 5);
                CRC_2 = make_word(rx_buffer[0x06], rx_buffer[0x05]);

                if(CRC_1 == CRC_2)
                {
                    distance = make_word(rx_buffer[0x03], rx_buffer[0x04]);
                    if(distance > ToF200_default_max_distance)
                    {
                        distance = 40000;
                    }
                }

                else
                {
                    distance = 40000;
                }
            }
        }
    }
    
    return distance;
}