#define bit_shift_right(val, shift_size)     (val >> shift_size)
#define bit_shift_left(val, shift_size)      (val << shift_size)
#define bit_mask(bit_pos)                    bit_shift_left(1, bit_pos)

#define bit_set(val, bit_val)               (val |= bit_mask(bit_val))
#define bit_clr(val, bit_val)               (val &= (~bit_mask(bit_val)))
#define bit_tgl(val, bit_val)               (val ^= bit_mask(bit_val))
#define get_bit(val, bit_val)               (val & bit_mask(bit_val))
#define get_reg(val, msk)                   (val & msk)

#define test_if_bit_set(val, bit_val)       (get_bit(val, bit_val) != FALSE)
#define test_if_bit_cleared(val, bit_val)   (get_bit(val, bit_val) == FALSE)

#define test_if_all_bits_set(val, msk)     (get_reg(val, msk) == msk)
#define test_if_any_bit_set(val, msk)      (get_reg(val, msk) != FALSE)


#define SDA_DIR_OUT()                      do{bit_set(P1MDOUT, 6); bit_set(P0SKIP, 6);}while(0)
#define SDA_DIR_IN()                       do{bit_clr(P1MDOUT, 6); bit_set(P0SKIP, 6);}while(0)

#define SCL_DIR_OUT()                      do{bit_set(P1MDOUT, 7); bit_set(P0SKIP, 7);}while(0)
#define SCL_DIR_IN()                       do{bit_clr(P1MDOUT, 7); bit_set(P0SKIP, 7);}while(0)

#define SDA_HIGH()                         bit_set(P1, 6)
#define SDA_LOW()                          bit_clr(P1, 6)

#define SCL_HIGH()                         bit_set(P1, 7)
#define SCL_LOW()                          bit_clr(P1, 7)

#define SDA_IN()                           get_bit(P1, 6)

#define I2C_ACK                            0xFF
#define I2C_NACK                           0x00

#define I2C_timeout                        1000


void SW_I2C_init(void);
void SW_I2C_start(void);
void SW_I2C_stop(void);
unsigned char SW_I2C_read(unsigned char ack);
void SW_I2C_write(unsigned char value);
void SW_I2C_ACK_NACK(unsigned char mode);
unsigned char SW_I2C_wait_ACK(void);