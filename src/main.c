
/**
* author : tianyx
* email  : zzztyx55@sina.com
* qq     : 609421258
* github : https://github.com/zzztyx55
*/
/* Includes ------------------------------------------------------------------*/
#include "stm8s_conf.h"
#include "main.h"
#include <string.h>
#include <stdio.h>

uint32_t uart1RecvCnt;
uint8_t uart_0_5ms_upate_cnt;
uint8_t uart1RecvBuff[UART_RSIZE];


/* Private defines -----------------------------------------------------------*/
#define MAX_CLIENT_NUM           5
#define TO_CLIENT_BUF_SIZE      20

static uint8_t uart1RecvFrame[UART_RSIZE];
//static uint32_t uart1RecvFrameCnt;
static int8_t client_cnt;
static uint8_t client_id[MAX_CLIENT_NUM];  
static uint8_t data_to_client_id;
static uint8_t hava_data_to_client;
static uint8_t to_client_buffer[TO_CLIENT_BUF_SIZE];
static uint16_t wifi_async_record_bits;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

void delay(u32 dly)
{
	u32 i;
	for(i = 0; i < dly; i++)
		; //空指令
}

/**
* 函数功能: 初始化串口uart1，BaudRate, 8, N, 1, TX/RX mode,使能中断
* 输入参数: BaudRate，串口波特率
* 函数返回值: void
*/
void uart1_init(uint32_t BaudRate)
{
	// 将uart1 设置成复位后的缺省状态
	UART1_DeInit();
	// 设置uart1的参数: 波特率BaudRate, 8位宽度, 1位停止位, 
	//   无校验，无流控，TX&RX mode 
	UART1_Init(BaudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, 
		UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
	// 配置uart1中断模式为接收中断使能
	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
	// 使能 uart1
	UART1_Cmd(ENABLE);
}


/**
* 函数功能: 使用串口uart1发送8位数据
* 输入参数: c, 8位有效数据
* 函数返回值: 成功发送的数据
*/
uint8_t uart1_sendChar(uint8_t c)
{
	// 等待串口发送寄存器为空
	while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
	// 发送数据c
	UART1_SendData8(c);

	return c;
}

// 重写c库中的字符输出函数，相当于将输出重定向到uart1的意思
char putchar(char c)
{
	if(c == '\n')  // 如果是换行符，加一个回车符
		uart1_sendChar('\r');

	uart1_sendChar((uint8_t)c);

	return c;
}

/**
* 函数功能: 使用串口uart1发送传入的任意字符串
* 输入参数: pStr, 字符串数据首地址
* 函数返回值: 成功发送的数据
*/
uint8_t * uart1_sendString(uint8_t *pStr)
{
	uint8_t *p = pStr;

	// 判断字符串是否为空
	//if(pStr == NULL)
	//	return NULL;

	// 取出的字符是否是 '\0'
	// 因为p是一个uint8_t *类型指针，所以*p就是取出p指向地址处的8bit(一个字节)数据，即一个字符
	while(*p != '\0')
	{
		uart1_sendChar(*p); // 发送字符
		p++;  // 指针指向下一个字符
		// 因为p是一个uint8_t *类型指针，所以p++就是偏移一个字节的地址
	}

	return pStr;
}


void var_init(void)
{
	uart1RecvCnt = 0;  
	memset(uart1RecvBuff, 0, UART_RSIZE); // clear buffer
	memset(uart1RecvFrame, 0, UART_RSIZE); // clear buffer
	//uart1RecvFrameCnt = 0;
	uart_0_5ms_upate_cnt = 0;
	client_cnt = 0;
	memset(client_id, 0, MAX_CLIENT_NUM);
	memset(to_client_buffer, 0, TO_CLIENT_BUF_SIZE);
	hava_data_to_client = 0;
	wifi_async_record_bits = 0;
	data_to_client_id = 0;
}

/*
* stm8s103f3p6 的定时器4使用的是 系统时钟
* 本程序中将系统时钟配置为HSI = 16MHz
*/
void Init_Timer4(void)
{
	// 配置定时器4的预分频值16分频和计数值100
	// 定时器计数到100后就会产生溢出中断，中断完之后又重新从0开始计数
	// time4 定时中断周期T = 100*(16/16MHz) = 0.1ms
	// 所以中断服务函数就会每0.1ms被调用一次
	TIM4_TimeBaseInit(TIM4_PRESCALER_16, 100);
 	 /* Clear TIM4 update flag */
  	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	 /* Enable update interrupt */
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // 使能time4溢出更新中断
	TIM4_Cmd(ENABLE);  // 使能timer4
}

void clk_config(void)
{
	// HSI 时钟 16MHz
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // HSI时钟预分频, 分频系数1
	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);  // 系统时钟配置, HSI, 分频系数1
	CLK_HSICmd(ENABLE);   // 使能HSI
	while(RESET == CLK_GetFlagStatus(CLK_FLAG_HSIRDY));  // 等待HSI ready
}

void gpio_init(void)
{
	// PA1 - led
	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_WriteHigh(GPIOA, GPIO_PIN_1);
}

void cp_uart_frame(void)
{
		memcpy(uart1RecvFrame, uart1RecvBuff, uart1RecvCnt);
		//uart1RecvFrameCnt = uart1RecvCnt;
		uart1RecvFrame[uart1RecvCnt] = '\0';

		//memset(uart1RecvBuff, 0, uart1RecvCnt);
		uart1RecvCnt = 0;
}

uint8_t is_frame_cmd_from_uart(void)
{
	uint8_t yes = 0;

	if(uart1RecvCnt == UART_RSIZE)
		yes = 1;
	else if((uart1RecvCnt > 0) && (uart_0_5ms_upate_cnt > 3)) // 串口接帐菔欠褚汛颱ART_RSIZE=32字节
		yes = 1;

	if(yes)
		cp_uart_frame();

	return yes;
}


uint8_t send_cmd_and_wait_resp_timeout(char *cmd, char *rsp1, char *rsp2, uint32_t timeout)
{
	static uint32_t uart_cmd_in_cnt = 0;
	static uint8_t uart_cmd_out_allow = 1;

	if(uart_cmd_out_allow)
	{
		uart_cmd_out_allow = 0;
		uart_cmd_in_cnt = 0; // clear
		uart1RecvCnt = 0; // clear uart recv buffer, add after debug
		uart1_sendString(cmd);  // send out cmd
	}

	if(is_frame_cmd_from_uart())
	{
		char *p;
		if(p = strstr(&uart1RecvFrame[0], rsp1))
		{
			if(strstr(p, rsp2))
			{
				uart_cmd_out_allow = 1;
				return 1;
			}
		}
	}
	else  // check recv timeout
	{
		uart_cmd_in_cnt += 1;
		if(uart_cmd_in_cnt > timeout)
			uart_cmd_out_allow = 1; // send cmd again
	}

	return 0;
}



uint8_t wifi_init_as_server(void)
{
	static uint8_t process_init = 0;

	switch(process_init)
	{
		case 0:
			// reset esp8266
			if(send_cmd_and_wait_resp_timeout("AT+RST\r\n", "AT+RST", "OK", 200))
			{
				process_init += 1;  // next
				uart_0_5ms_upate_cnt = 0;
			}
			break;
		case 1:
			// check reset ready or not
			if(is_frame_cmd_from_uart())
			{
				if(strstr(&uart1RecvFrame[0], "ready")) // reset success
					process_init += 1;  // next
				else
					uart_0_5ms_upate_cnt = 0;
			}
			else
			{
				if(uart_0_5ms_upate_cnt > 200) // after 100ms, maybe reset fail
				{
					process_init = 0;  // back to rst
				}
			}
			break;
		case 2:
			// ("AT+CWMODE=2\n");  // set AP mode
			if(send_cmd_and_wait_resp_timeout("AT+CWMODE=2\r\n", "AT+CWMODE=2", "OK", 200))
			{
				process_init += 1;  // next
			}
			break;
		case 3:
			// set AP：AT+CWSAP="SSID的信号名","密码", 通道号，加密方式
			if(send_cmd_and_wait_resp_timeout("AT+CWSAP=\"免费WIFI\",\"\",1,0\r\n", "AT+CWSAP", "OK", 200))
			{
				process_init += 1;  // next
			}

			break;
		case 4:
			// AT+CIPMUX=1  启动多连接  
			if(send_cmd_and_wait_resp_timeout("AT+CIPMUX=1\r\n", "AT+CIPMUX=1", "OK", 200))
			{
				process_init += 1;  // next
			}
			break;
		case 5:
			// 发送AT+CIPSERVER=1,8080开启服务器模式，端口号8080
			if(send_cmd_and_wait_resp_timeout("AT+CIPSERVER=1,8080\r\n", "AT+CIPSERVER=1,8080", "OK", 200))
			{
				process_init += 1;  // next
				delay(100);
			}
			break;
		case 6:
			// check wifi ip
			//if(send_cmd_and_wait_resp_timeout("AT+CIFSR\n", "AT+CIFSR", "OK", 200))  // rsp1 rsp2 may not be in same frame
			if(send_cmd_and_wait_resp_timeout("AT+CIFSR\r\n", "AT+CIFSR", "+CIFSR:APIP", 200))
			{
				process_init += 1;  // next
			}
			break;

		case 7:
			// read AP para
			if(send_cmd_and_wait_resp_timeout("AT+CWSAP?\r\n", "AT+CWSAP?", "+CWSAP", 200))
			{
				process_init += 1;  // next
			}
			break;
		default:
			return 1;
			break;
	}

	return 0;
}


void wifi_send_data_task(void)
{
	static uint8_t process_send = 0;
	static uint16_t timeout_cnt = 0;

	if(!hava_data_to_client)
		return;

	switch(process_send)
	{
		case 0:
			if(client_cnt > 0)
			{
				uint16_t len = strlen(to_client_buffer);
				char buff[18];

				sprintf(buff, "AT+CIPSEND=%d,%d\r\n", (uint16_t)data_to_client_id, len);
				uart1_sendString(buff);

				process_send = 1;
				timeout_cnt = 0;
			}
			break;
		case 1:
			if(wifi_async_record_bits & WIFI_PRE_SEND_ACK)
			{
				process_send = 2;
				wifi_async_record_bits &= ~((uint16_t)WIFI_PRE_SEND_ACK);
			}
			else
			{
				timeout_cnt += 1;
				if(timeout_cnt > 65500)
					process_send = 4; 
			}
			break;	
		case 2:
			uart1_sendString(to_client_buffer);
			process_send = 3;
			timeout_cnt = 0;
			break;
		case 3:
			if(wifi_async_record_bits & WIFI_SEND_FINISH_ACK)
			{
				process_send = 4;			
				wifi_async_record_bits &= ~((uint16_t)WIFI_SEND_FINISH_ACK);
			}
			else
			{
				timeout_cnt += 1;
				if(timeout_cnt > 65500)
					process_send = 4; 
			}
			break;
		case 4:  // state clear
			timeout_cnt = 0;
			process_send = 0;
			hava_data_to_client = 0;
			break;
	}
}

uint8_t check_is_connect_status_frame(void)
{
	char *p, *p1 = &uart1RecvFrame[0];
	uint8_t offset;
	char id;

	if((p = strstr(p1, "CLOSE")) != NULL                // remote socket close
		|| (p = strstr(p1, "CONNECT FAIL")) != NULL)      // communication fail ==> remote wifi disconnect
	{
		offset = p - p1; 
		if(offset >= 2)
		{
			id = (*(p-2)) - '0';  // get client id
			{
				uint8_t i;
				// del client record
				for(i = 0; i < client_cnt; ++i)
				{
					if(client_id[i] == id)
						client_id[i] = client_id[client_cnt-1];  // use end one cover this one
				}
				client_cnt -= 1;
			}
		}

		return 1;
	}
	else if(p = strstr(p1, "CONNECT"))    // new connect
	{
		offset = p - p1; 
		if(offset >= 2)
		{
			// add in record 
			id = (*(p-2)) - '0';  // get client id
			client_id[client_cnt] = id; 
			client_cnt += 1;
			//if(client_cnt > MAX_CLIENT_NUM) while(1);
		}

		return 1;
	}

	return 0;
}

void handle_remote_cmd(char *pCmd)
{
	if(strstr(pCmd, "led_on"))  // "\r\n+IPD,0,6:led_on"
	{
		GPIO_WriteLow(GPIOA, GPIO_PIN_1);
	}
	else if(strstr(pCmd, "led_off"))
	{
		GPIO_WriteHigh(GPIOA, GPIO_PIN_1);
	}
}

void wifi_recv_parse_task(void)
{
	static uint8_t process_recv = 0;
	char *p;

	switch(process_recv)
	{
		case 0:
			if(is_frame_cmd_from_uart())
				process_recv = 1;
			break;
		case 1:  // check 1 : connect status ?
			if(check_is_connect_status_frame())
				process_recv = 0;  // check ok, back to "case 0" wait next frame.
			else
				process_recv = 2;
			break;
		case 2:  // check 2 : recv data ?
			if(p = strstr(&uart1RecvFrame[0], "+IPD"))  // yes
			{
				handle_remote_cmd(p);
				process_recv = 0;
				break;  // end
			}
			process_recv = 3;
			break;
		case 3:  // check 3 : send cmd ack ?
			if(p = strstr(&uart1RecvFrame[0], "AT+CIPSEND="))
			{
				if(strstr(p, "OK"))
				{
					wifi_async_record_bits |= WIFI_PRE_SEND_ACK;  // record flag
				}
			
				process_recv = 0;
				break;
			}
			process_recv = 4;
			break;
		case 4:  // check 4 : send data end ?
			if(p = strstr(&uart1RecvFrame[0], "SEND"))
			{
				if(strstr(p, "OK"))
				{
					wifi_async_record_bits |= WIFI_SEND_FINISH_ACK;
				}
				else if(strstr(p, "FAIL")) // send fail
				{
					// to do
				}
			
				process_recv = 0;
				break;				
			}
			process_recv = 5;
			break;
		case 5: // check 5: reserve
			process_recv = 0;  // back to "case 0" wait next frame.
			break;
		default:
			process_recv = 0;  // back to "case 0" wait next frame.
			break;
	}
}


void heartbeat_to_clients_task(void)
{
	static uint16_t dly_cnt = 5000;
	static uint8_t curr_id = 0;

	if(client_cnt == 0)
		return ;

	if(hava_data_to_client)
		return ;

	dly_cnt += 1;
	if(dly_cnt < 60000)  // is not the time
		return ;

	dly_cnt = 0;

	//memcpy(to_client_buffer, "heartbeat", sizeof("heartbeat") > TO_CLIENT_BUF_SIZE ? TO_CLIENT_BUF_SIZE - 1 : sizeof("heartbeat"));
	memcpy(to_client_buffer, "heartbeat", sizeof("heartbeat"));

	hava_data_to_client = 1;
	
	curr_id += 1;
	if(curr_id >= client_cnt)
		curr_id = 0;
	data_to_client_id = client_id[curr_id];
}

/**
* author : tianyx
* email  : zzztyx55@sina.com
* qq     : 609421258
* github : https://github.com/zzztyx55
*/
void main(void)
{
	disableInterrupts();

	// 系统时钟配置
	clk_config();

	GPIO_DeInit(GPIOA);
	GPIO_DeInit(GPIOB);
	GPIO_DeInit(GPIOC);
	GPIO_DeInit(GPIOD);
	// 将uart1 设置成复位后的缺省状态
	UART1_DeInit();
	gpio_init();

	// 变量初始化
	var_init();

	Init_Timer4();
	// 将串口 uart1 波特率设置为 115200
	uart1_init(115200);

	delay(10000);
	
	// 使能总中断
	enableInterrupts();
	
	//printf("initial success\n"); // uart connect to esp8266, cannot print log

	// esp8266恢复出厂设置
	//uart1_sendString("AT+RESTORE\r\n");  while(1);

	
	while(1)
	{
		if(wifi_init_as_server())
			break;

		delay(8000); //delay period can be adjust. // must delay, due to wifi_init_as server() cmd response delay is not enough.
		GPIO_WriteReverse(GPIOA, GPIO_PIN_1);  // flashing led
	}

	while (1)
	{
		wifi_recv_parse_task();

		wifi_send_data_task();

		heartbeat_to_clients_task();
	}

}



#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
