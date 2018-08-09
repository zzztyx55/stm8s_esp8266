#ifndef __MAIN_H__
#define __MAIN_H__

#define UART_RSIZE  64

#define WIFI_PRE_SEND_ACK       (1<<0)
#define WIFI_SEND_FINISH_ACK    (1<<1)




extern uint32_t uart1RecvCnt;
extern uint8_t uart1RecvBuff[UART_RSIZE];

extern uint8_t uart_0_5ms_upate_cnt;
extern uint8_t * uart1_sendString(uint8_t *pStr);


#endif

