#define MAX31865_CONFIG_REG                  0x00
#define MAX31865_RTD_MSB_REG                 0x01
#define MAX31865_RTD_LSB_REG                 0x02
#define MAX31865_HFAULT_MSB_REG              0x03
#define MAX31865_HFAULT_LSB_REG              0x04
#define MAX31865_LFAULT_MSB_REG              0x05
#define MAX31865_LFAULT_LSB_REG              0x06
#define MAX31865_FAULT_STATUS_REG            0x07


/* Configuration Definitions */
#define MAX31865_CONFIG_BIAS                 0x80
#define MAX31865_CONFIG_MODE_AUTO            0x40
#define MAX31865_CONFIG_MODE_OFF             0x00
#define MAX31865_CONFIG_1SHOT                0x20
#define MAX31865_CONFIG_3_WIRE               0x10
#define MAX31865_CONFIG_24_WIRE              0x00
#define MAX31865_CONFIG_FAULT_STATUS         0x02
#define MAX31865_CONFIG_FILTER_50Hz          0x01
#define MAX31865_CONFIG_FILTER_60Hz          0x00

/* Fault Definitions */
#define MAX31865_FAULT_HIGH_THRESHOLD        0x80
#define MAX31865_FAULT_LOW_THRESHOLD         0x40
#define MAX31865_FAULT_REF_IN_LOW            0x20
#define MAX31865_FAULT_REF_IN_HIGH           0x10
#define MAX31865_FAULT_RTD_IN_LOW            0x08
#define MAX31865_FAULT_OV_UV                 0x04

#define MAX31865_RTD_A                       0.00390803
#define MAX31865_RTD_B                       -0.000000577
#define MAX31865_Reference_Resistance        430.0
#define MAX31865_RTD_Nominal_Value           100.0 // for PT100

#define MAX31865_CS                          P0_3_bit


void MAX31865_init(void);
unsigned char MAX31865_read_byte(unsigned char address);
unsigned int MAX31865_read_word(unsigned char address);
void MAX31865_write_byte(unsigned char address, unsigned char value);
void MAX31865_write_word(unsigned char address, unsigned char lb, unsigned char hb);
unsigned int MAX31865_get_RTD(void);
signed int MAX31865_get_temperature(void);