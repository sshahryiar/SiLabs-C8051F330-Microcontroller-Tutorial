#define ToF200_TX_data_packet_size                    8
#define ToF200_RX_data_packet_size                    16

#define ToF200_slave_default_ID                       0x01

//registers
#define ToF200_special_register                       0x0001
#define ToF200_slave_ID_register                      0x0002
#define ToF200_baud_rate_register                     0x0003
#define ToF200_range_precision_register               0x0004
#define ToF200_output_control_register                0x0005
#define ToF200_load_calibration_register              0x0006
#define ToF200_offset_correction_register             0x0007
#define ToF200_xtalk_correction_register              0x0008
#define ToF200_i2c_enable_register                    0x0009
#define ToF200_measurement_register                   0x0010
#define ToF200_offset_calibration_register            0x0020
#define ToF200_xtalk_calibration_register             0x0021

//parameters
#define ToF200_restore_default                        0xAA55
#define ToF200_reboot                                 0x1000
#define ToF200_comm_test                              0x0000

#define ToF200_baud_rate_115200                       0x0000
#define ToF200_baud_rate_38400                        0x0001
#define ToF200_baud_rate_9600                         0x0002

#define ToF200_high_precision_1200mm                  0x0001
#define ToF200_medium_precision_2000mm                0x0002
#define ToF200_low_precision_1200mm                   0x0003

#define ToF200_do_not_load_calibration                0x0000
#define ToF200_load_calibration                       0x0001

#define ToF200_i2c_not_prohibited                     0x0000
#define ToF200_i2c_prohibited                         0x0001

//other constant parameters
#define ToF200_default_max_distance                   2000

#define MODBUS_read_holding_registers_function_code   0x03
#define MODBUS_write_single_register_function_code    0x06


unsigned char cnt;
unsigned char rx_buffer[ToF200_RX_data_packet_size];


unsigned int make_word(unsigned char HB, unsigned char LB);
void get_HB_LB(unsigned int value, unsigned char *HB, unsigned char *LB);
unsigned int MODBUS_RTU_CRC16(unsigned char *data_input, unsigned char data_length);
void flush_RX_buffer(void);
void MODBUS_TX(unsigned char slave_ID, unsigned char function_code, unsigned char reg, unsigned char value);
unsigned int ToF_get_range(void);