   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  63                     ; 35 void delay(u32 dly)
  63                     ; 36 {
  65                     	switch	.text
  66  0000               _delay:
  68  0000 5204          	subw	sp,#4
  69       00000004      OFST:	set	4
  72                     ; 38 	for(i = 0; i < dly; i++)
  74  0002 ae0000        	ldw	x,#0
  75  0005 1f03          	ldw	(OFST-1,sp),x
  76  0007 ae0000        	ldw	x,#0
  77  000a 1f01          	ldw	(OFST-3,sp),x
  79  000c 2009          	jra	L55
  80  000e               L15:
  84  000e 96            	ldw	x,sp
  85  000f 1c0001        	addw	x,#OFST-3
  86  0012 a601          	ld	a,#1
  87  0014 cd0000        	call	c_lgadc
  89  0017               L55:
  92  0017 96            	ldw	x,sp
  93  0018 1c0001        	addw	x,#OFST-3
  94  001b cd0000        	call	c_ltor
  96  001e 96            	ldw	x,sp
  97  001f 1c0007        	addw	x,#OFST+3
  98  0022 cd0000        	call	c_lcmp
 100  0025 25e7          	jrult	L15
 101                     ; 40 }
 104  0027 5b04          	addw	sp,#4
 105  0029 81            	ret
 143                     ; 47 void uart1_init(uint32_t BaudRate)
 143                     ; 48 {
 144                     	switch	.text
 145  002a               _uart1_init:
 147       00000000      OFST:	set	0
 150                     ; 50 	UART1_DeInit();
 152  002a cd0000        	call	_UART1_DeInit
 154                     ; 53 	UART1_Init(BaudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, 
 154                     ; 54 		UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 156  002d 4b0c          	push	#12
 157  002f 4b80          	push	#128
 158  0031 4b00          	push	#0
 159  0033 4b00          	push	#0
 160  0035 4b00          	push	#0
 161  0037 1e0a          	ldw	x,(OFST+10,sp)
 162  0039 89            	pushw	x
 163  003a 1e0a          	ldw	x,(OFST+10,sp)
 164  003c 89            	pushw	x
 165  003d cd0000        	call	_UART1_Init
 167  0040 5b09          	addw	sp,#9
 168                     ; 56 	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
 170  0042 4b01          	push	#1
 171  0044 ae0205        	ldw	x,#517
 172  0047 cd0000        	call	_UART1_ITConfig
 174  004a 84            	pop	a
 175                     ; 58 	UART1_Cmd(ENABLE);
 177  004b a601          	ld	a,#1
 178  004d cd0000        	call	_UART1_Cmd
 180                     ; 59 }
 183  0050 81            	ret
 219                     ; 67 uint8_t uart1_sendChar(uint8_t c)
 219                     ; 68 {
 220                     	switch	.text
 221  0051               _uart1_sendChar:
 223  0051 88            	push	a
 224       00000000      OFST:	set	0
 227  0052               L711:
 228                     ; 70 	while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 230  0052 ae0080        	ldw	x,#128
 231  0055 cd0000        	call	_UART1_GetFlagStatus
 233  0058 4d            	tnz	a
 234  0059 27f7          	jreq	L711
 235                     ; 72 	UART1_SendData8(c);
 237  005b 7b01          	ld	a,(OFST+1,sp)
 238  005d cd0000        	call	_UART1_SendData8
 240                     ; 74 	return c;
 242  0060 7b01          	ld	a,(OFST+1,sp)
 245  0062 5b01          	addw	sp,#1
 246  0064 81            	ret
 281                     ; 78 char putchar(char c)
 281                     ; 79 {
 282                     	switch	.text
 283  0065               _putchar:
 285  0065 88            	push	a
 286       00000000      OFST:	set	0
 289                     ; 80 	if(c == '\n')  // 如果是换行符，加一个回车符
 291  0066 a10a          	cp	a,#10
 292  0068 2604          	jrne	L141
 293                     ; 81 		uart1_sendChar('\r');
 295  006a a60d          	ld	a,#13
 296  006c ade3          	call	_uart1_sendChar
 298  006e               L141:
 299                     ; 83 	uart1_sendChar((uint8_t)c);
 301  006e 7b01          	ld	a,(OFST+1,sp)
 302  0070 addf          	call	_uart1_sendChar
 304                     ; 85 	return c;
 306  0072 7b01          	ld	a,(OFST+1,sp)
 309  0074 5b01          	addw	sp,#1
 310  0076 81            	ret
 357                     ; 93 uint8_t * uart1_sendString(uint8_t *pStr)
 357                     ; 94 {
 358                     	switch	.text
 359  0077               _uart1_sendString:
 361  0077 89            	pushw	x
 362  0078 89            	pushw	x
 363       00000002      OFST:	set	2
 366                     ; 95 	uint8_t *p = pStr;
 368  0079 1f01          	ldw	(OFST-1,sp),x
 370  007b 200c          	jra	L171
 371  007d               L561:
 372                     ; 105 		uart1_sendChar(*p); // 发送字符
 374  007d 1e01          	ldw	x,(OFST-1,sp)
 375  007f f6            	ld	a,(x)
 376  0080 adcf          	call	_uart1_sendChar
 378                     ; 106 		p++;  // 指针指向下一个字符
 380  0082 1e01          	ldw	x,(OFST-1,sp)
 381  0084 1c0001        	addw	x,#1
 382  0087 1f01          	ldw	(OFST-1,sp),x
 383  0089               L171:
 384                     ; 103 	while(*p != '\0')
 386  0089 1e01          	ldw	x,(OFST-1,sp)
 387  008b 7d            	tnz	(x)
 388  008c 26ef          	jrne	L561
 389                     ; 110 	return pStr;
 391  008e 1e03          	ldw	x,(OFST+1,sp)
 394  0090 5b04          	addw	sp,#4
 395  0092 81            	ret
 429                     ; 114 void var_init(void)
 429                     ; 115 {
 430                     	switch	.text
 431  0093               _var_init:
 435                     ; 116 	uart1RecvCnt = 0;  
 437  0093 ae0000        	ldw	x,#0
 438  0096 bfa1          	ldw	_uart1RecvCnt+2,x
 439  0098 ae0000        	ldw	x,#0
 440  009b bf9f          	ldw	_uart1RecvCnt,x
 441                     ; 117 	memset(uart1RecvBuff, 0, UART_RSIZE); // clear buffer
 443  009d ae0040        	ldw	x,#64
 444  00a0               L02:
 445  00a0 6f5e          	clr	(_uart1RecvBuff-1,x)
 446  00a2 5a            	decw	x
 447  00a3 26fb          	jrne	L02
 448                     ; 118 	memset(uart1RecvFrame, 0, UART_RSIZE); // clear buffer
 450  00a5 ae0040        	ldw	x,#64
 451  00a8               L22:
 452  00a8 6f1d          	clr	(L3_uart1RecvFrame-1,x)
 453  00aa 5a            	decw	x
 454  00ab 26fb          	jrne	L22
 455                     ; 120 	uart_0_5ms_upate_cnt = 0;
 457  00ad 3f5e          	clr	_uart_0_5ms_upate_cnt
 458                     ; 121 	client_cnt = 0;
 460  00af 3f1d          	clr	L5_client_cnt
 461                     ; 122 	memset(client_id, 0, MAX_CLIENT_NUM);
 463  00b1 ae0005        	ldw	x,#5
 464  00b4               L42:
 465  00b4 6f17          	clr	(L7_client_id-1,x)
 466  00b6 5a            	decw	x
 467  00b7 26fb          	jrne	L42
 468                     ; 123 	memset(to_client_buffer, 0, TO_CLIENT_BUF_SIZE);
 470  00b9 ae0014        	ldw	x,#20
 471  00bc               L62:
 472  00bc 6f01          	clr	(L51_to_client_buffer-1,x)
 473  00be 5a            	decw	x
 474  00bf 26fb          	jrne	L62
 475                     ; 124 	hava_data_to_client = 0;
 477  00c1 3f16          	clr	L31_hava_data_to_client
 478                     ; 125 	wifi_async_record_bits = 0;
 480  00c3 5f            	clrw	x
 481  00c4 bf00          	ldw	L71_wifi_async_record_bits,x
 482                     ; 126 	data_to_client_id = 0;
 484  00c6 3f17          	clr	L11_data_to_client_id
 485                     ; 127 }
 488  00c8 81            	ret
 515                     ; 133 void Init_Timer4(void)
 515                     ; 134 {
 516                     	switch	.text
 517  00c9               _Init_Timer4:
 521                     ; 139 	TIM4_TimeBaseInit(TIM4_PRESCALER_16, 100);
 523  00c9 ae0064        	ldw	x,#100
 524  00cc a604          	ld	a,#4
 525  00ce 95            	ld	xh,a
 526  00cf cd0000        	call	_TIM4_TimeBaseInit
 528                     ; 141   	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 530  00d2 a601          	ld	a,#1
 531  00d4 cd0000        	call	_TIM4_ClearFlag
 533                     ; 143 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // 使能time4溢出更新中断
 535  00d7 ae0001        	ldw	x,#1
 536  00da a601          	ld	a,#1
 537  00dc 95            	ld	xh,a
 538  00dd cd0000        	call	_TIM4_ITConfig
 540                     ; 144 	TIM4_Cmd(ENABLE);  // 使能timer4
 542  00e0 a601          	ld	a,#1
 543  00e2 cd0000        	call	_TIM4_Cmd
 545                     ; 145 }
 548  00e5 81            	ret
 575                     ; 147 void clk_config(void)
 575                     ; 148 {
 576                     	switch	.text
 577  00e6               _clk_config:
 581                     ; 150 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // HSI时钟预分频, 分频系数1
 583  00e6 4f            	clr	a
 584  00e7 cd0000        	call	_CLK_HSIPrescalerConfig
 586                     ; 151 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);  // 系统时钟配置, HSI, 分频系数1
 588  00ea 4f            	clr	a
 589  00eb cd0000        	call	_CLK_SYSCLKConfig
 591                     ; 152 	CLK_HSICmd(ENABLE);   // 使能HSI
 593  00ee a601          	ld	a,#1
 594  00f0 cd0000        	call	_CLK_HSICmd
 597  00f3               L722:
 598                     ; 153 	while(RESET == CLK_GetFlagStatus(CLK_FLAG_HSIRDY));  // 等待HSI ready
 600  00f3 ae0102        	ldw	x,#258
 601  00f6 cd0000        	call	_CLK_GetFlagStatus
 603  00f9 4d            	tnz	a
 604  00fa 27f7          	jreq	L722
 605                     ; 154 }
 608  00fc 81            	ret
 633                     ; 156 void gpio_init(void)
 633                     ; 157 {
 634                     	switch	.text
 635  00fd               _gpio_init:
 639                     ; 159 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_HIGH_FAST);
 641  00fd 4bf0          	push	#240
 642  00ff 4b02          	push	#2
 643  0101 ae5000        	ldw	x,#20480
 644  0104 cd0000        	call	_GPIO_Init
 646  0107 85            	popw	x
 647                     ; 160 	GPIO_WriteHigh(GPIOA, GPIO_PIN_1);
 649  0108 4b02          	push	#2
 650  010a ae5000        	ldw	x,#20480
 651  010d cd0000        	call	_GPIO_WriteHigh
 653  0110 84            	pop	a
 654                     ; 161 }
 657  0111 81            	ret
 684                     ; 163 void cp_uart_frame(void)
 684                     ; 164 {
 685                     	switch	.text
 686  0112               _cp_uart_frame:
 690                     ; 165 		memcpy(uart1RecvFrame, uart1RecvBuff, uart1RecvCnt);
 692  0112 bea1          	ldw	x,_uart1RecvCnt+2
 693  0114 5d            	tnzw	x
 694  0115 2707          	jreq	L04
 695  0117               L24:
 696  0117 e65e          	ld	a,(_uart1RecvBuff-1,x)
 697  0119 e71d          	ld	(L3_uart1RecvFrame-1,x),a
 698  011b 5a            	decw	x
 699  011c 26f9          	jrne	L24
 700  011e               L04:
 701                     ; 167 		uart1RecvFrame[uart1RecvCnt] = '\0';
 703  011e bea1          	ldw	x,_uart1RecvCnt+2
 704  0120 6f1e          	clr	(L3_uart1RecvFrame,x)
 705                     ; 170 		uart1RecvCnt = 0;
 707  0122 ae0000        	ldw	x,#0
 708  0125 bfa1          	ldw	_uart1RecvCnt+2,x
 709  0127 ae0000        	ldw	x,#0
 710  012a bf9f          	ldw	_uart1RecvCnt,x
 711                     ; 171 }
 714  012c 81            	ret
 752                     .const:	section	.text
 753  0000               L64:
 754  0000 00000040      	dc.l	64
 755                     ; 173 uint8_t is_frame_cmd_from_uart(void)
 755                     ; 174 {
 756                     	switch	.text
 757  012d               _is_frame_cmd_from_uart:
 759  012d 88            	push	a
 760       00000001      OFST:	set	1
 763                     ; 175 	uint8_t yes = 0;
 765  012e 0f01          	clr	(OFST+0,sp)
 766                     ; 177 	if(uart1RecvCnt == UART_RSIZE)
 768  0130 ae009f        	ldw	x,#_uart1RecvCnt
 769  0133 cd0000        	call	c_ltor
 771  0136 ae0000        	ldw	x,#L64
 772  0139 cd0000        	call	c_lcmp
 774  013c 2606          	jrne	L172
 775                     ; 178 		yes = 1;
 777  013e a601          	ld	a,#1
 778  0140 6b01          	ld	(OFST+0,sp),a
 780  0142 2012          	jra	L372
 781  0144               L172:
 782                     ; 179 	else if((uart1RecvCnt > 0) && (uart_0_5ms_upate_cnt > 3)) // 串口接帐菔欠褚汛颱ART_RSIZE=32字节
 784  0144 ae009f        	ldw	x,#_uart1RecvCnt
 785  0147 cd0000        	call	c_lzmp
 787  014a 270a          	jreq	L372
 789  014c b65e          	ld	a,_uart_0_5ms_upate_cnt
 790  014e a104          	cp	a,#4
 791  0150 2504          	jrult	L372
 792                     ; 180 		yes = 1;
 794  0152 a601          	ld	a,#1
 795  0154 6b01          	ld	(OFST+0,sp),a
 796  0156               L372:
 797                     ; 182 	if(yes)
 799  0156 0d01          	tnz	(OFST+0,sp)
 800  0158 2702          	jreq	L772
 801                     ; 183 		cp_uart_frame();
 803  015a adb6          	call	_cp_uart_frame
 805  015c               L772:
 806                     ; 185 	return yes;
 808  015c 7b01          	ld	a,(OFST+0,sp)
 811  015e 5b01          	addw	sp,#1
 812  0160 81            	ret
 815                     	bsct
 816  0000               L103_uart_cmd_in_cnt:
 817  0000 00000000      	dc.l	0
 818  0004               L303_uart_cmd_out_allow:
 819  0004 01            	dc.b	1
 915                     ; 189 uint8_t send_cmd_and_wait_resp_timeout(char *cmd, char *rsp1, char *rsp2, uint32_t timeout)
 915                     ; 190 {
 916                     	switch	.text
 917  0161               _send_cmd_and_wait_resp_timeout:
 919  0161 89            	pushw	x
 920  0162 89            	pushw	x
 921       00000002      OFST:	set	2
 924                     ; 194 	if(uart_cmd_out_allow)
 926  0163 3d04          	tnz	L303_uart_cmd_out_allow
 927  0165 271b          	jreq	L353
 928                     ; 196 		uart_cmd_out_allow = 0;
 930  0167 3f04          	clr	L303_uart_cmd_out_allow
 931                     ; 197 		uart_cmd_in_cnt = 0; // clear
 933  0169 ae0000        	ldw	x,#0
 934  016c bf02          	ldw	L103_uart_cmd_in_cnt+2,x
 935  016e ae0000        	ldw	x,#0
 936  0171 bf00          	ldw	L103_uart_cmd_in_cnt,x
 937                     ; 198 		uart1RecvCnt = 0; // clear uart recv buffer, add after debug
 939  0173 ae0000        	ldw	x,#0
 940  0176 bfa1          	ldw	_uart1RecvCnt+2,x
 941  0178 ae0000        	ldw	x,#0
 942  017b bf9f          	ldw	_uart1RecvCnt,x
 943                     ; 199 		uart1_sendString(cmd);  // send out cmd
 945  017d 1e03          	ldw	x,(OFST+1,sp)
 946  017f cd0077        	call	_uart1_sendString
 948  0182               L353:
 949                     ; 202 	if(is_frame_cmd_from_uart())
 951  0182 ada9          	call	_is_frame_cmd_from_uart
 953  0184 4d            	tnz	a
 954  0185 2728          	jreq	L553
 955                     ; 205 		if(p = strstr(&uart1RecvFrame[0], rsp1))
 957  0187 1e07          	ldw	x,(OFST+5,sp)
 958  0189 89            	pushw	x
 959  018a ae001e        	ldw	x,#L3_uart1RecvFrame
 960  018d cd0000        	call	_strstr
 962  0190 5b02          	addw	sp,#2
 963  0192 1f01          	ldw	(OFST-1,sp),x
 964  0194 1e01          	ldw	x,(OFST-1,sp)
 965  0196 2732          	jreq	L363
 966                     ; 207 			if(strstr(p, rsp2))
 968  0198 1e09          	ldw	x,(OFST+7,sp)
 969  019a 89            	pushw	x
 970  019b 1e03          	ldw	x,(OFST+1,sp)
 971  019d cd0000        	call	_strstr
 973  01a0 5b02          	addw	sp,#2
 974  01a2 a30000        	cpw	x,#0
 975  01a5 2723          	jreq	L363
 976                     ; 209 				uart_cmd_out_allow = 1;
 978  01a7 35010004      	mov	L303_uart_cmd_out_allow,#1
 979                     ; 210 				return 1;
 981  01ab a601          	ld	a,#1
 983  01ad 201c          	jra	L25
 984  01af               L553:
 985                     ; 216 		uart_cmd_in_cnt += 1;
 987  01af ae0000        	ldw	x,#L103_uart_cmd_in_cnt
 988  01b2 a601          	ld	a,#1
 989  01b4 cd0000        	call	c_lgadc
 991                     ; 217 		if(uart_cmd_in_cnt > timeout)
 993  01b7 ae0000        	ldw	x,#L103_uart_cmd_in_cnt
 994  01ba cd0000        	call	c_ltor
 996  01bd 96            	ldw	x,sp
 997  01be 1c000b        	addw	x,#OFST+9
 998  01c1 cd0000        	call	c_lcmp
1000  01c4 2304          	jrule	L363
1001                     ; 218 			uart_cmd_out_allow = 1; // send cmd again
1003  01c6 35010004      	mov	L303_uart_cmd_out_allow,#1
1004  01ca               L363:
1005                     ; 221 	return 0;
1007  01ca 4f            	clr	a
1009  01cb               L25:
1011  01cb 5b04          	addw	sp,#4
1012  01cd 81            	ret
1015                     	bsct
1016  0005               L763_process_init:
1017  0005 00            	dc.b	0
1056                     ; 226 uint8_t wifi_init_as_server(void)
1056                     ; 227 {
1057                     	switch	.text
1058  01ce               _wifi_init_as_server:
1062                     ; 230 	switch(process_init)
1064  01ce b605          	ld	a,L763_process_init
1066                     ; 305 			break;
1068  01d0 4d            	tnz	a
1069  01d1 2727          	jreq	L173
1070  01d3 4a            	dec	a
1071  01d4 274a          	jreq	L373
1072  01d6 4a            	dec	a
1073  01d7 2779          	jreq	L573
1074  01d9 4a            	dec	a
1075  01da 2603          	jrne	L65
1076  01dc cc0276        	jp	L773
1077  01df               L65:
1078  01df 4a            	dec	a
1079  01e0 2603          	jrne	L06
1080  01e2 cc0296        	jp	L104
1081  01e5               L06:
1082  01e5 4a            	dec	a
1083  01e6 2603          	jrne	L26
1084  01e8 cc02b5        	jp	L304
1085  01eb               L26:
1086  01eb 4a            	dec	a
1087  01ec 2603          	jrne	L46
1088  01ee cc02e1        	jp	L504
1089  01f1               L46:
1090  01f1 4a            	dec	a
1091  01f2 2603          	jrne	L66
1092  01f4 cc0300        	jp	L704
1093  01f7               L66:
1094  01f7               L114:
1095                     ; 303 		default:
1095                     ; 304 			return 1;
1097  01f7 a601          	ld	a,#1
1100  01f9 81            	ret
1101  01fa               L173:
1102                     ; 232 		case 0:
1102                     ; 233 			// reset esp8266
1102                     ; 234 			if(send_cmd_and_wait_resp_timeout("AT+RST\r\n", "AT+RST", "OK", 200))
1104  01fa ae00c8        	ldw	x,#200
1105  01fd 89            	pushw	x
1106  01fe ae0000        	ldw	x,#0
1107  0201 89            	pushw	x
1108  0202 ae0137        	ldw	x,#L344
1109  0205 89            	pushw	x
1110  0206 ae013a        	ldw	x,#L144
1111  0209 89            	pushw	x
1112  020a ae0141        	ldw	x,#L734
1113  020d cd0161        	call	_send_cmd_and_wait_resp_timeout
1115  0210 5b08          	addw	sp,#8
1116  0212 4d            	tnz	a
1117  0213 2603          	jrne	L07
1118  0215 cc031d        	jp	L334
1119  0218               L07:
1120                     ; 236 				process_init += 1;  // next
1122  0218 3c05          	inc	L763_process_init
1123                     ; 237 				uart_0_5ms_upate_cnt = 0;
1125  021a 3f5e          	clr	_uart_0_5ms_upate_cnt
1126  021c ac1d031d      	jpf	L334
1127  0220               L373:
1128                     ; 240 		case 1:
1128                     ; 241 			// check reset ready or not
1128                     ; 242 			if(is_frame_cmd_from_uart())
1130  0220 cd012d        	call	_is_frame_cmd_from_uart
1132  0223 4d            	tnz	a
1133  0224 271d          	jreq	L544
1134                     ; 244 				if(strstr(&uart1RecvFrame[0], "ready")) // reset success
1136  0226 ae0131        	ldw	x,#L154
1137  0229 89            	pushw	x
1138  022a ae001e        	ldw	x,#L3_uart1RecvFrame
1139  022d cd0000        	call	_strstr
1141  0230 5b02          	addw	sp,#2
1142  0232 a30000        	cpw	x,#0
1143  0235 2706          	jreq	L744
1144                     ; 245 					process_init += 1;  // next
1146  0237 3c05          	inc	L763_process_init
1148  0239 ac1d031d      	jpf	L334
1149  023d               L744:
1150                     ; 247 					uart_0_5ms_upate_cnt = 0;
1152  023d 3f5e          	clr	_uart_0_5ms_upate_cnt
1153  023f ac1d031d      	jpf	L334
1154  0243               L544:
1155                     ; 251 				if(uart_0_5ms_upate_cnt > 200) // after 100ms, maybe reset fail
1157  0243 b65e          	ld	a,_uart_0_5ms_upate_cnt
1158  0245 a1c9          	cp	a,#201
1159  0247 2403          	jruge	L27
1160  0249 cc031d        	jp	L334
1161  024c               L27:
1162                     ; 253 					process_init = 0;  // back to rst
1164  024c 3f05          	clr	L763_process_init
1165  024e ac1d031d      	jpf	L334
1166  0252               L573:
1167                     ; 257 		case 2:
1167                     ; 258 			// ("AT+CWMODE=2\n");  // set AP mode
1167                     ; 259 			if(send_cmd_and_wait_resp_timeout("AT+CWMODE=2\r\n", "AT+CWMODE=2", "OK", 200))
1169  0252 ae00c8        	ldw	x,#200
1170  0255 89            	pushw	x
1171  0256 ae0000        	ldw	x,#0
1172  0259 89            	pushw	x
1173  025a ae0137        	ldw	x,#L344
1174  025d 89            	pushw	x
1175  025e ae0117        	ldw	x,#L564
1176  0261 89            	pushw	x
1177  0262 ae0123        	ldw	x,#L364
1178  0265 cd0161        	call	_send_cmd_and_wait_resp_timeout
1180  0268 5b08          	addw	sp,#8
1181  026a 4d            	tnz	a
1182  026b 2603          	jrne	L47
1183  026d cc031d        	jp	L334
1184  0270               L47:
1185                     ; 261 				process_init += 1;  // next
1187  0270 3c05          	inc	L763_process_init
1188  0272 ac1d031d      	jpf	L334
1189  0276               L773:
1190                     ; 264 		case 3:
1190                     ; 265 			// set AP：AT+CWSAP="SSID的信号名","密码", 通道号，加密方式
1190                     ; 266 			if(send_cmd_and_wait_resp_timeout("AT+CWSAP=\"免费WIFI\",\"\",1,0\r\n", "AT+CWSAP", "OK", 200))
1192  0276 ae00c8        	ldw	x,#200
1193  0279 89            	pushw	x
1194  027a ae0000        	ldw	x,#0
1195  027d 89            	pushw	x
1196  027e ae0137        	ldw	x,#L344
1197  0281 89            	pushw	x
1198  0282 ae00ef        	ldw	x,#L374
1199  0285 89            	pushw	x
1200  0286 ae00f8        	ldw	x,#L174
1201  0289 cd0161        	call	_send_cmd_and_wait_resp_timeout
1203  028c 5b08          	addw	sp,#8
1204  028e 4d            	tnz	a
1205  028f 27dc          	jreq	L334
1206                     ; 268 				process_init += 1;  // next
1208  0291 3c05          	inc	L763_process_init
1209  0293 cc031d        	jra	L334
1210  0296               L104:
1211                     ; 272 		case 4:
1211                     ; 273 			// AT+CIPMUX=1  启动多连接  
1211                     ; 274 			if(send_cmd_and_wait_resp_timeout("AT+CIPMUX=1\r\n", "AT+CIPMUX=1", "OK", 200))
1213  0296 ae00c8        	ldw	x,#200
1214  0299 89            	pushw	x
1215  029a ae0000        	ldw	x,#0
1216  029d 89            	pushw	x
1217  029e ae0137        	ldw	x,#L344
1218  02a1 89            	pushw	x
1219  02a2 ae00d5        	ldw	x,#L105
1220  02a5 89            	pushw	x
1221  02a6 ae00e1        	ldw	x,#L774
1222  02a9 cd0161        	call	_send_cmd_and_wait_resp_timeout
1224  02ac 5b08          	addw	sp,#8
1225  02ae 4d            	tnz	a
1226  02af 276c          	jreq	L334
1227                     ; 276 				process_init += 1;  // next
1229  02b1 3c05          	inc	L763_process_init
1230  02b3 2068          	jra	L334
1231  02b5               L304:
1232                     ; 279 		case 5:
1232                     ; 280 			// 发送AT+CIPSERVER=1,8080开启服务器模式，端口号8080
1232                     ; 281 			if(send_cmd_and_wait_resp_timeout("AT+CIPSERVER=1,8080\r\n", "AT+CIPSERVER=1,8080", "OK", 200))
1234  02b5 ae00c8        	ldw	x,#200
1235  02b8 89            	pushw	x
1236  02b9 ae0000        	ldw	x,#0
1237  02bc 89            	pushw	x
1238  02bd ae0137        	ldw	x,#L344
1239  02c0 89            	pushw	x
1240  02c1 ae00ab        	ldw	x,#L705
1241  02c4 89            	pushw	x
1242  02c5 ae00bf        	ldw	x,#L505
1243  02c8 cd0161        	call	_send_cmd_and_wait_resp_timeout
1245  02cb 5b08          	addw	sp,#8
1246  02cd 4d            	tnz	a
1247  02ce 274d          	jreq	L334
1248                     ; 283 				process_init += 1;  // next
1250  02d0 3c05          	inc	L763_process_init
1251                     ; 284 				delay(100);
1253  02d2 ae0064        	ldw	x,#100
1254  02d5 89            	pushw	x
1255  02d6 ae0000        	ldw	x,#0
1256  02d9 89            	pushw	x
1257  02da cd0000        	call	_delay
1259  02dd 5b04          	addw	sp,#4
1260  02df 203c          	jra	L334
1261  02e1               L504:
1262                     ; 287 		case 6:
1262                     ; 288 			// check wifi ip
1262                     ; 289 			//if(send_cmd_and_wait_resp_timeout("AT+CIFSR\n", "AT+CIFSR", "OK", 200))  // rsp1 rsp2 may not be in same frame
1262                     ; 290 			if(send_cmd_and_wait_resp_timeout("AT+CIFSR\r\n", "AT+CIFSR", "+CIFSR:APIP", 200))
1264  02e1 ae00c8        	ldw	x,#200
1265  02e4 89            	pushw	x
1266  02e5 ae0000        	ldw	x,#0
1267  02e8 89            	pushw	x
1268  02e9 ae008b        	ldw	x,#L715
1269  02ec 89            	pushw	x
1270  02ed ae0097        	ldw	x,#L515
1271  02f0 89            	pushw	x
1272  02f1 ae00a0        	ldw	x,#L315
1273  02f4 cd0161        	call	_send_cmd_and_wait_resp_timeout
1275  02f7 5b08          	addw	sp,#8
1276  02f9 4d            	tnz	a
1277  02fa 2721          	jreq	L334
1278                     ; 292 				process_init += 1;  // next
1280  02fc 3c05          	inc	L763_process_init
1281  02fe 201d          	jra	L334
1282  0300               L704:
1283                     ; 296 		case 7:
1283                     ; 297 			// read AP para
1283                     ; 298 			if(send_cmd_and_wait_resp_timeout("AT+CWSAP?\r\n", "AT+CWSAP?", "+CWSAP", 200))
1285  0300 ae00c8        	ldw	x,#200
1286  0303 89            	pushw	x
1287  0304 ae0000        	ldw	x,#0
1288  0307 89            	pushw	x
1289  0308 ae006e        	ldw	x,#L725
1290  030b 89            	pushw	x
1291  030c ae0075        	ldw	x,#L525
1292  030f 89            	pushw	x
1293  0310 ae007f        	ldw	x,#L325
1294  0313 cd0161        	call	_send_cmd_and_wait_resp_timeout
1296  0316 5b08          	addw	sp,#8
1297  0318 4d            	tnz	a
1298  0319 2702          	jreq	L334
1299                     ; 300 				process_init += 1;  // next
1301  031b 3c05          	inc	L763_process_init
1302  031d               L334:
1303                     ; 308 	return 0;
1305  031d 4f            	clr	a
1308  031e 81            	ret
1311                     	bsct
1312  0006               L135_process_send:
1313  0006 00            	dc.b	0
1314  0007               L335_timeout_cnt:
1315  0007 0000          	dc.w	0
1384                     	switch	.const
1385  0004               L001:
1386  0004 0000ffdd      	dc.l	65501
1387                     ; 312 void wifi_send_data_task(void)
1387                     ; 313 {
1388                     	switch	.text
1389  031f               _wifi_send_data_task:
1391  031f 5214          	subw	sp,#20
1392       00000014      OFST:	set	20
1395                     ; 317 	if(!hava_data_to_client)
1397  0321 3d16          	tnz	L31_hava_data_to_client
1398  0323 2603          	jrne	L401
1399  0325 cc03e3        	jp	L201
1400  0328               L401:
1401                     ; 318 		return;
1403                     ; 320 	switch(process_send)
1405  0328 b606          	ld	a,L135_process_send
1407                     ; 370 			break;
1408  032a 4d            	tnz	a
1409  032b 2713          	jreq	L535
1410  032d 4a            	dec	a
1411  032e 2747          	jreq	L735
1412  0330 4a            	dec	a
1413  0331 276f          	jreq	L145
1414  0333 4a            	dec	a
1415  0334 277b          	jreq	L345
1416  0336 4a            	dec	a
1417  0337 2603          	jrne	L601
1418  0339 cc03dc        	jp	L545
1419  033c               L601:
1420  033c ace303e3      	jpf	L506
1421  0340               L535:
1422                     ; 322 		case 0:
1422                     ; 323 			if(client_cnt > 0)
1424  0340 9c            	rvf
1425  0341 b61d          	ld	a,L5_client_cnt
1426  0343 a100          	cp	a,#0
1427  0345 2c03          	jrsgt	L011
1428  0347 cc03e3        	jp	L506
1429  034a               L011:
1430                     ; 325 				uint16_t len = strlen(to_client_buffer);
1432  034a ae0002        	ldw	x,#L51_to_client_buffer
1433  034d cd0000        	call	_strlen
1435  0350 1f01          	ldw	(OFST-19,sp),x
1436                     ; 328 				sprintf(buff, "AT+CIPSEND=%d,%d\r\n", (uint16_t)data_to_client_id, len);
1438  0352 1e01          	ldw	x,(OFST-19,sp)
1439  0354 89            	pushw	x
1440  0355 b617          	ld	a,L11_data_to_client_id
1441  0357 5f            	clrw	x
1442  0358 97            	ld	xl,a
1443  0359 89            	pushw	x
1444  035a ae005b        	ldw	x,#L116
1445  035d 89            	pushw	x
1446  035e 96            	ldw	x,sp
1447  035f 1c0009        	addw	x,#OFST-11
1448  0362 cd0000        	call	_sprintf
1450  0365 5b06          	addw	sp,#6
1451                     ; 329 				uart1_sendString(buff);
1453  0367 96            	ldw	x,sp
1454  0368 1c0003        	addw	x,#OFST-17
1455  036b cd0077        	call	_uart1_sendString
1457                     ; 331 				process_send = 1;
1459  036e 35010006      	mov	L135_process_send,#1
1460                     ; 332 				timeout_cnt = 0;
1462  0372 5f            	clrw	x
1463  0373 bf07          	ldw	L335_timeout_cnt,x
1464  0375 206c          	jra	L506
1465  0377               L735:
1466                     ; 335 		case 1:
1466                     ; 336 			if(wifi_async_record_bits & WIFI_PRE_SEND_ACK)
1468  0377 b601          	ld	a,L71_wifi_async_record_bits+1
1469  0379 a501          	bcp	a,#1
1470  037b 270a          	jreq	L316
1471                     ; 338 				process_send = 2;
1473  037d 35020006      	mov	L135_process_send,#2
1474                     ; 339 				wifi_async_record_bits &= ~((uint16_t)WIFI_PRE_SEND_ACK);
1476  0381 72110001      	bres	L71_wifi_async_record_bits+1,#0
1478  0385 205c          	jra	L506
1479  0387               L316:
1480                     ; 343 				timeout_cnt += 1;
1482  0387 be07          	ldw	x,L335_timeout_cnt
1483  0389 1c0001        	addw	x,#1
1484  038c bf07          	ldw	L335_timeout_cnt,x
1485                     ; 344 				if(timeout_cnt > 65500)
1487  038e 9c            	rvf
1488  038f be07          	ldw	x,L335_timeout_cnt
1489  0391 cd0000        	call	c_uitolx
1491  0394 ae0004        	ldw	x,#L001
1492  0397 cd0000        	call	c_lcmp
1494  039a 2f47          	jrslt	L506
1495                     ; 345 					process_send = 4; 
1497  039c 35040006      	mov	L135_process_send,#4
1498  03a0 2041          	jra	L506
1499  03a2               L145:
1500                     ; 348 		case 2:
1500                     ; 349 			uart1_sendString(to_client_buffer);
1502  03a2 ae0002        	ldw	x,#L51_to_client_buffer
1503  03a5 cd0077        	call	_uart1_sendString
1505                     ; 350 			process_send = 3;
1507  03a8 35030006      	mov	L135_process_send,#3
1508                     ; 351 			timeout_cnt = 0;
1510  03ac 5f            	clrw	x
1511  03ad bf07          	ldw	L335_timeout_cnt,x
1512                     ; 352 			break;
1514  03af 2032          	jra	L506
1515  03b1               L345:
1516                     ; 353 		case 3:
1516                     ; 354 			if(wifi_async_record_bits & WIFI_SEND_FINISH_ACK)
1518  03b1 b601          	ld	a,L71_wifi_async_record_bits+1
1519  03b3 a502          	bcp	a,#2
1520  03b5 270a          	jreq	L126
1521                     ; 356 				process_send = 4;			
1523  03b7 35040006      	mov	L135_process_send,#4
1524                     ; 357 				wifi_async_record_bits &= ~((uint16_t)WIFI_SEND_FINISH_ACK);
1526  03bb 72130001      	bres	L71_wifi_async_record_bits+1,#1
1528  03bf 2022          	jra	L506
1529  03c1               L126:
1530                     ; 361 				timeout_cnt += 1;
1532  03c1 be07          	ldw	x,L335_timeout_cnt
1533  03c3 1c0001        	addw	x,#1
1534  03c6 bf07          	ldw	L335_timeout_cnt,x
1535                     ; 362 				if(timeout_cnt > 65500)
1537  03c8 9c            	rvf
1538  03c9 be07          	ldw	x,L335_timeout_cnt
1539  03cb cd0000        	call	c_uitolx
1541  03ce ae0004        	ldw	x,#L001
1542  03d1 cd0000        	call	c_lcmp
1544  03d4 2f0d          	jrslt	L506
1545                     ; 363 					process_send = 4; 
1547  03d6 35040006      	mov	L135_process_send,#4
1548  03da 2007          	jra	L506
1549  03dc               L545:
1550                     ; 366 		case 4:  // state clear
1550                     ; 367 			timeout_cnt = 0;
1552  03dc 5f            	clrw	x
1553  03dd bf07          	ldw	L335_timeout_cnt,x
1554                     ; 368 			process_send = 0;
1556  03df 3f06          	clr	L135_process_send
1557                     ; 369 			hava_data_to_client = 0;
1559  03e1 3f16          	clr	L31_hava_data_to_client
1560                     ; 370 			break;
1562  03e3               L506:
1563                     ; 372 }
1564  03e3               L201:
1567  03e3 5b14          	addw	sp,#20
1568  03e5 81            	ret
1645                     ; 374 uint8_t check_is_connect_status_frame(void)
1645                     ; 375 {
1646                     	switch	.text
1647  03e6               _check_is_connect_status_frame:
1649  03e6 5206          	subw	sp,#6
1650       00000006      OFST:	set	6
1653                     ; 376 	char *p, *p1 = &uart1RecvFrame[0];
1655  03e8 ae001e        	ldw	x,#L3_uart1RecvFrame
1656  03eb 1f02          	ldw	(OFST-4,sp),x
1657                     ; 380 	if((p = strstr(p1, "CLOSE")) != NULL                // remote socket close
1657                     ; 381 		|| (p = strstr(p1, "CONNECT FAIL")) != NULL)      // communication fail ==> remote wifi disconnect
1659  03ed ae0055        	ldw	x,#L176
1660  03f0 89            	pushw	x
1661  03f1 ae001e        	ldw	x,#L3_uart1RecvFrame
1662  03f4 cd0000        	call	_strstr
1664  03f7 5b02          	addw	sp,#2
1665  03f9 1f04          	ldw	(OFST-2,sp),x
1666  03fb 1e04          	ldw	x,(OFST-2,sp)
1667  03fd 2611          	jrne	L766
1669  03ff ae0048        	ldw	x,#L376
1670  0402 89            	pushw	x
1671  0403 1e04          	ldw	x,(OFST-2,sp)
1672  0405 cd0000        	call	_strstr
1674  0408 5b02          	addw	sp,#2
1675  040a 1f04          	ldw	(OFST-2,sp),x
1676  040c 1e04          	ldw	x,(OFST-2,sp)
1677  040e 2759          	jreq	L566
1678  0410               L766:
1679                     ; 383 		offset = p - p1; 
1681  0410 1e04          	ldw	x,(OFST-2,sp)
1682  0412 72f002        	subw	x,(OFST-4,sp)
1683  0415 01            	rrwa	x,a
1684  0416 6b06          	ld	(OFST+0,sp),a
1685  0418 02            	rlwa	x,a
1686                     ; 384 		if(offset >= 2)
1688  0419 7b06          	ld	a,(OFST+0,sp)
1689  041b a102          	cp	a,#2
1690  041d 2546          	jrult	L576
1691                     ; 386 			id = (*(p-2)) - '0';  // get client id
1693  041f 1e04          	ldw	x,(OFST-2,sp)
1694  0421 5a            	decw	x
1695  0422 5a            	decw	x
1696  0423 f6            	ld	a,(x)
1697  0424 a030          	sub	a,#48
1698  0426 6b06          	ld	(OFST+0,sp),a
1699                     ; 390 				for(i = 0; i < client_cnt; ++i)
1701  0428 0f01          	clr	(OFST-5,sp)
1703  042a 2021          	jra	L307
1704  042c               L776:
1705                     ; 392 					if(client_id[i] == id)
1707  042c 7b01          	ld	a,(OFST-5,sp)
1708  042e 5f            	clrw	x
1709  042f 97            	ld	xl,a
1710  0430 e618          	ld	a,(L7_client_id,x)
1711  0432 1106          	cp	a,(OFST+0,sp)
1712  0434 2615          	jrne	L707
1713                     ; 393 						client_id[i] = client_id[client_cnt-1];  // use end one cover this one
1715  0436 7b01          	ld	a,(OFST-5,sp)
1716  0438 5f            	clrw	x
1717  0439 97            	ld	xl,a
1718  043a 905f          	clrw	y
1719  043c b61d          	ld	a,L5_client_cnt
1720  043e 2a02          	jrpl	L411
1721  0440 9053          	cplw	y
1722  0442               L411:
1723  0442 9097          	ld	yl,a
1724  0444 905a          	decw	y
1725  0446 90e618        	ld	a,(L7_client_id,y)
1726  0449 e718          	ld	(L7_client_id,x),a
1727  044b               L707:
1728                     ; 390 				for(i = 0; i < client_cnt; ++i)
1730  044b 0c01          	inc	(OFST-5,sp)
1731  044d               L307:
1734  044d 9c            	rvf
1735  044e 7b01          	ld	a,(OFST-5,sp)
1736  0450 5f            	clrw	x
1737  0451 97            	ld	xl,a
1738  0452 905f          	clrw	y
1739  0454 b61d          	ld	a,L5_client_cnt
1740  0456 2a02          	jrpl	L611
1741  0458 9053          	cplw	y
1742  045a               L611:
1743  045a 9097          	ld	yl,a
1744  045c 90bf00        	ldw	c_y,y
1745  045f b300          	cpw	x,c_y
1746  0461 2fc9          	jrslt	L776
1747                     ; 395 				client_cnt -= 1;
1749  0463 3a1d          	dec	L5_client_cnt
1750  0465               L576:
1751                     ; 399 		return 1;
1753  0465 a601          	ld	a,#1
1755  0467 2039          	jra	L221
1756  0469               L566:
1757                     ; 401 	else if(p = strstr(p1, "CONNECT"))    // new connect
1759  0469 ae0040        	ldw	x,#L517
1760  046c 89            	pushw	x
1761  046d ae001e        	ldw	x,#L3_uart1RecvFrame
1762  0470 cd0000        	call	_strstr
1764  0473 5b02          	addw	sp,#2
1765  0475 1f04          	ldw	(OFST-2,sp),x
1766  0477 1e04          	ldw	x,(OFST-2,sp)
1767  0479 272a          	jreq	L117
1768                     ; 403 		offset = p - p1; 
1770  047b 1e04          	ldw	x,(OFST-2,sp)
1771  047d 72f002        	subw	x,(OFST-4,sp)
1772  0480 01            	rrwa	x,a
1773  0481 6b06          	ld	(OFST+0,sp),a
1774  0483 02            	rlwa	x,a
1775                     ; 404 		if(offset >= 2)
1777  0484 7b06          	ld	a,(OFST+0,sp)
1778  0486 a102          	cp	a,#2
1779  0488 2516          	jrult	L717
1780                     ; 407 			id = (*(p-2)) - '0';  // get client id
1782  048a 1e04          	ldw	x,(OFST-2,sp)
1783  048c 5a            	decw	x
1784  048d 5a            	decw	x
1785  048e f6            	ld	a,(x)
1786  048f a030          	sub	a,#48
1787  0491 6b06          	ld	(OFST+0,sp),a
1788                     ; 408 			client_id[client_cnt] = id; 
1790  0493 5f            	clrw	x
1791  0494 b61d          	ld	a,L5_client_cnt
1792  0496 2a01          	jrpl	L021
1793  0498 53            	cplw	x
1794  0499               L021:
1795  0499 97            	ld	xl,a
1796  049a 7b06          	ld	a,(OFST+0,sp)
1797  049c e718          	ld	(L7_client_id,x),a
1798                     ; 409 			client_cnt += 1;
1800  049e 3c1d          	inc	L5_client_cnt
1801  04a0               L717:
1802                     ; 413 		return 1;
1804  04a0 a601          	ld	a,#1
1806  04a2               L221:
1808  04a2 5b06          	addw	sp,#6
1809  04a4 81            	ret
1810  04a5               L117:
1811                     ; 416 	return 0;
1813  04a5 4f            	clr	a
1815  04a6 20fa          	jra	L221
1853                     ; 419 void handle_remote_cmd(char *pCmd)
1853                     ; 420 {
1854                     	switch	.text
1855  04a8               _handle_remote_cmd:
1857  04a8 89            	pushw	x
1858       00000000      OFST:	set	0
1861                     ; 421 	if(strstr(pCmd, "led_on"))  // "\r\n+IPD,0,6:led_on"
1863  04a9 ae0039        	ldw	x,#L147
1864  04ac 89            	pushw	x
1865  04ad 1e03          	ldw	x,(OFST+3,sp)
1866  04af cd0000        	call	_strstr
1868  04b2 5b02          	addw	sp,#2
1869  04b4 a30000        	cpw	x,#0
1870  04b7 270b          	jreq	L737
1871                     ; 423 		GPIO_WriteLow(GPIOA, GPIO_PIN_1);
1873  04b9 4b02          	push	#2
1874  04bb ae5000        	ldw	x,#20480
1875  04be cd0000        	call	_GPIO_WriteLow
1877  04c1 84            	pop	a
1879  04c2 2019          	jra	L347
1880  04c4               L737:
1881                     ; 425 	else if(strstr(pCmd, "led_off"))
1883  04c4 ae0031        	ldw	x,#L747
1884  04c7 89            	pushw	x
1885  04c8 1e03          	ldw	x,(OFST+3,sp)
1886  04ca cd0000        	call	_strstr
1888  04cd 5b02          	addw	sp,#2
1889  04cf a30000        	cpw	x,#0
1890  04d2 2709          	jreq	L347
1891                     ; 427 		GPIO_WriteHigh(GPIOA, GPIO_PIN_1);
1893  04d4 4b02          	push	#2
1894  04d6 ae5000        	ldw	x,#20480
1895  04d9 cd0000        	call	_GPIO_WriteHigh
1897  04dc 84            	pop	a
1898  04dd               L347:
1899                     ; 429 }
1902  04dd 85            	popw	x
1903  04de 81            	ret
1906                     	bsct
1907  0009               L157_process_recv:
1908  0009 00            	dc.b	0
1957                     ; 431 void wifi_recv_parse_task(void)
1957                     ; 432 {
1958                     	switch	.text
1959  04df               _wifi_recv_parse_task:
1961  04df 89            	pushw	x
1962       00000002      OFST:	set	2
1965                     ; 436 	switch(process_recv)
1967  04e0 b609          	ld	a,L157_process_recv
1969                     ; 492 			break;
1970  04e2 4d            	tnz	a
1971  04e3 271b          	jreq	L357
1972  04e5 4a            	dec	a
1973  04e6 2729          	jreq	L557
1974  04e8 4a            	dec	a
1975  04e9 2739          	jreq	L757
1976  04eb 4a            	dec	a
1977  04ec 2757          	jreq	L167
1978  04ee 4a            	dec	a
1979  04ef 2603cc0575    	jreq	L367
1980  04f4 4a            	dec	a
1981  04f5 2603          	jrne	L031
1982  04f7 cc05b5        	jp	L567
1983  04fa               L031:
1984  04fa               L767:
1985                     ; 490 		default:
1985                     ; 491 			process_recv = 0;  // back to "case 0" wait next frame.
1987  04fa 3f09          	clr	L157_process_recv
1988                     ; 492 			break;
1990  04fc acb705b7      	jpf	L5101
1991  0500               L357:
1992                     ; 438 		case 0:
1992                     ; 439 			if(is_frame_cmd_from_uart())
1994  0500 cd012d        	call	_is_frame_cmd_from_uart
1996  0503 4d            	tnz	a
1997  0504 2603          	jrne	L231
1998  0506 cc05b7        	jp	L5101
1999  0509               L231:
2000                     ; 440 				process_recv = 1;
2002  0509 35010009      	mov	L157_process_recv,#1
2003  050d acb705b7      	jpf	L5101
2004  0511               L557:
2005                     ; 442 		case 1:  // check 1 : connect status ?
2005                     ; 443 			if(check_is_connect_status_frame())
2007  0511 cd03e6        	call	_check_is_connect_status_frame
2009  0514 4d            	tnz	a
2010  0515 2706          	jreq	L1201
2011                     ; 444 				process_recv = 0;  // check ok, back to "case 0" wait next frame.
2013  0517 3f09          	clr	L157_process_recv
2015  0519 acb705b7      	jpf	L5101
2016  051d               L1201:
2017                     ; 446 				process_recv = 2;
2019  051d 35020009      	mov	L157_process_recv,#2
2020  0521 cc05b7        	jra	L5101
2021  0524               L757:
2022                     ; 448 		case 2:  // check 2 : recv data ?
2022                     ; 449 			if(p = strstr(&uart1RecvFrame[0], "+IPD"))  // yes
2024  0524 ae002c        	ldw	x,#L7201
2025  0527 89            	pushw	x
2026  0528 ae001e        	ldw	x,#L3_uart1RecvFrame
2027  052b cd0000        	call	_strstr
2029  052e 5b02          	addw	sp,#2
2030  0530 1f01          	ldw	(OFST-1,sp),x
2031  0532 1e01          	ldw	x,(OFST-1,sp)
2032  0534 2709          	jreq	L5201
2033                     ; 451 				handle_remote_cmd(p);
2035  0536 1e01          	ldw	x,(OFST-1,sp)
2036  0538 cd04a8        	call	_handle_remote_cmd
2038                     ; 452 				process_recv = 0;
2040  053b 3f09          	clr	L157_process_recv
2041                     ; 453 				break;  // end
2043  053d 2078          	jra	L5101
2044  053f               L5201:
2045                     ; 455 			process_recv = 3;
2047  053f 35030009      	mov	L157_process_recv,#3
2048                     ; 456 			break;
2050  0543 2072          	jra	L5101
2051  0545               L167:
2052                     ; 457 		case 3:  // check 3 : send cmd ack ?
2052                     ; 458 			if(p = strstr(&uart1RecvFrame[0], "AT+CIPSEND="))
2054  0545 ae0020        	ldw	x,#L3301
2055  0548 89            	pushw	x
2056  0549 ae001e        	ldw	x,#L3_uart1RecvFrame
2057  054c cd0000        	call	_strstr
2059  054f 5b02          	addw	sp,#2
2060  0551 1f01          	ldw	(OFST-1,sp),x
2061  0553 1e01          	ldw	x,(OFST-1,sp)
2062  0555 2718          	jreq	L1301
2063                     ; 460 				if(strstr(p, "OK"))
2065  0557 ae0137        	ldw	x,#L344
2066  055a 89            	pushw	x
2067  055b 1e03          	ldw	x,(OFST+1,sp)
2068  055d cd0000        	call	_strstr
2070  0560 5b02          	addw	sp,#2
2071  0562 a30000        	cpw	x,#0
2072  0565 2704          	jreq	L5301
2073                     ; 462 					wifi_async_record_bits |= WIFI_PRE_SEND_ACK;  // record flag
2075  0567 72100001      	bset	L71_wifi_async_record_bits+1,#0
2076  056b               L5301:
2077                     ; 465 				process_recv = 0;
2079  056b 3f09          	clr	L157_process_recv
2080                     ; 466 				break;
2082  056d 2048          	jra	L5101
2083  056f               L1301:
2084                     ; 468 			process_recv = 4;
2086  056f 35040009      	mov	L157_process_recv,#4
2087                     ; 469 			break;
2089  0573 2042          	jra	L5101
2090  0575               L367:
2091                     ; 470 		case 4:  // check 4 : send data end ?
2091                     ; 471 			if(p = strstr(&uart1RecvFrame[0], "SEND"))
2093  0575 ae001b        	ldw	x,#L1401
2094  0578 89            	pushw	x
2095  0579 ae001e        	ldw	x,#L3_uart1RecvFrame
2096  057c cd0000        	call	_strstr
2098  057f 5b02          	addw	sp,#2
2099  0581 1f01          	ldw	(OFST-1,sp),x
2100  0583 1e01          	ldw	x,(OFST-1,sp)
2101  0585 2728          	jreq	L7301
2102                     ; 473 				if(strstr(p, "OK"))
2104  0587 ae0137        	ldw	x,#L344
2105  058a 89            	pushw	x
2106  058b 1e03          	ldw	x,(OFST+1,sp)
2107  058d cd0000        	call	_strstr
2109  0590 5b02          	addw	sp,#2
2110  0592 a30000        	cpw	x,#0
2111  0595 2706          	jreq	L3401
2112                     ; 475 					wifi_async_record_bits |= WIFI_SEND_FINISH_ACK;
2114  0597 72120001      	bset	L71_wifi_async_record_bits+1,#1
2116  059b 200e          	jra	L5401
2117  059d               L3401:
2118                     ; 477 				else if(strstr(p, "FAIL")) // send fail
2120  059d ae0016        	ldw	x,#L1501
2121  05a0 89            	pushw	x
2122  05a1 1e03          	ldw	x,(OFST+1,sp)
2123  05a3 cd0000        	call	_strstr
2125  05a6 5b02          	addw	sp,#2
2126  05a8 a30000        	cpw	x,#0
2127  05ab               L5401:
2128                     ; 482 				process_recv = 0;
2130  05ab 3f09          	clr	L157_process_recv
2131                     ; 483 				break;				
2133  05ad 2008          	jra	L5101
2134  05af               L7301:
2135                     ; 485 			process_recv = 5;
2137  05af 35050009      	mov	L157_process_recv,#5
2138                     ; 486 			break;
2140  05b3 2002          	jra	L5101
2141  05b5               L567:
2142                     ; 487 		case 5: // check 5: reserve
2142                     ; 488 			process_recv = 0;  // back to "case 0" wait next frame.
2144  05b5 3f09          	clr	L157_process_recv
2145                     ; 489 			break;
2147  05b7               L5101:
2148                     ; 494 }
2151  05b7 85            	popw	x
2152  05b8 81            	ret
2155                     	bsct
2156  000a               L3501_dly_cnt:
2157  000a 1388          	dc.w	5000
2158  000c               L5501_curr_id:
2159  000c 00            	dc.b	0
2207                     	switch	.const
2208  0008               L631:
2209  0008 0000ea60      	dc.l	60000
2210                     ; 497 void heartbeat_to_clients_task(void)
2210                     ; 498 {
2211                     	switch	.text
2212  05b9               _heartbeat_to_clients_task:
2216                     ; 502 	if(client_cnt == 0)
2218  05b9 3d1d          	tnz	L5_client_cnt
2219  05bb 2601          	jrne	L1011
2220                     ; 503 		return ;
2223  05bd 81            	ret
2224  05be               L1011:
2225                     ; 505 	if(hava_data_to_client)
2227  05be 3d16          	tnz	L31_hava_data_to_client
2228  05c0 2701          	jreq	L3011
2229                     ; 506 		return ;
2232  05c2 81            	ret
2233  05c3               L3011:
2234                     ; 508 	dly_cnt += 1;
2236  05c3 be0a          	ldw	x,L3501_dly_cnt
2237  05c5 1c0001        	addw	x,#1
2238  05c8 bf0a          	ldw	L3501_dly_cnt,x
2239                     ; 509 	if(dly_cnt < 60000)  // is not the time
2241  05ca 9c            	rvf
2242  05cb be0a          	ldw	x,L3501_dly_cnt
2243  05cd cd0000        	call	c_uitolx
2245  05d0 ae0008        	ldw	x,#L631
2246  05d3 cd0000        	call	c_lcmp
2248  05d6 2e01          	jrsge	L5011
2249                     ; 510 		return ;
2252  05d8 81            	ret
2253  05d9               L5011:
2254                     ; 512 	dly_cnt = 0;
2256  05d9 5f            	clrw	x
2257  05da bf0a          	ldw	L3501_dly_cnt,x
2258                     ; 515 	memcpy(to_client_buffer, "heartbeat", sizeof("heartbeat"));
2260  05dc ae000a        	ldw	x,#10
2261  05df               L041:
2262  05df d6000b        	ld	a,(L7011-1,x)
2263  05e2 e701          	ld	(L51_to_client_buffer-1,x),a
2264  05e4 5a            	decw	x
2265  05e5 26f8          	jrne	L041
2266                     ; 517 	hava_data_to_client = 1;
2268  05e7 35010016      	mov	L31_hava_data_to_client,#1
2269                     ; 519 	curr_id += 1;
2271  05eb 3c0c          	inc	L5501_curr_id
2272                     ; 520 	if(curr_id >= client_cnt)
2274  05ed 9c            	rvf
2275  05ee b60c          	ld	a,L5501_curr_id
2276  05f0 5f            	clrw	x
2277  05f1 97            	ld	xl,a
2278  05f2 905f          	clrw	y
2279  05f4 b61d          	ld	a,L5_client_cnt
2280  05f6 2a02          	jrpl	L241
2281  05f8 9053          	cplw	y
2282  05fa               L241:
2283  05fa 9097          	ld	yl,a
2284  05fc 90bf00        	ldw	c_y,y
2285  05ff b300          	cpw	x,c_y
2286  0601 2f02          	jrslt	L1111
2287                     ; 521 		curr_id = 0;
2289  0603 3f0c          	clr	L5501_curr_id
2290  0605               L1111:
2291                     ; 522 	data_to_client_id = client_id[curr_id];
2293  0605 b60c          	ld	a,L5501_curr_id
2294  0607 5f            	clrw	x
2295  0608 97            	ld	xl,a
2296  0609 e618          	ld	a,(L7_client_id,x)
2297  060b b717          	ld	L11_data_to_client_id,a
2298                     ; 523 }
2301  060d 81            	ret
2339                     ; 531 void main(void)
2339                     ; 532 {
2340                     	switch	.text
2341  060e               _main:
2345                     ; 533 	disableInterrupts();
2348  060e 9b            sim
2350                     ; 536 	clk_config();
2353  060f cd00e6        	call	_clk_config
2355                     ; 538 	GPIO_DeInit(GPIOA);
2357  0612 ae5000        	ldw	x,#20480
2358  0615 cd0000        	call	_GPIO_DeInit
2360                     ; 539 	GPIO_DeInit(GPIOB);
2362  0618 ae5005        	ldw	x,#20485
2363  061b cd0000        	call	_GPIO_DeInit
2365                     ; 540 	GPIO_DeInit(GPIOC);
2367  061e ae500a        	ldw	x,#20490
2368  0621 cd0000        	call	_GPIO_DeInit
2370                     ; 541 	GPIO_DeInit(GPIOD);
2372  0624 ae500f        	ldw	x,#20495
2373  0627 cd0000        	call	_GPIO_DeInit
2375                     ; 543 	UART1_DeInit();
2377  062a cd0000        	call	_UART1_DeInit
2379                     ; 544 	gpio_init();
2381  062d cd00fd        	call	_gpio_init
2383                     ; 547 	var_init();
2385  0630 cd0093        	call	_var_init
2387                     ; 549 	Init_Timer4();
2389  0633 cd00c9        	call	_Init_Timer4
2391                     ; 551 	uart1_init(115200);
2393  0636 aec200        	ldw	x,#49664
2394  0639 89            	pushw	x
2395  063a ae0001        	ldw	x,#1
2396  063d 89            	pushw	x
2397  063e cd002a        	call	_uart1_init
2399  0641 5b04          	addw	sp,#4
2400                     ; 553 	delay(10000);
2402  0643 ae2710        	ldw	x,#10000
2403  0646 89            	pushw	x
2404  0647 ae0000        	ldw	x,#0
2405  064a 89            	pushw	x
2406  064b cd0000        	call	_delay
2408  064e 5b04          	addw	sp,#4
2409                     ; 556 	enableInterrupts();
2412  0650 9a            rim
2414  0651               L3211:
2415                     ; 566 		if(wifi_init_as_server())
2417  0651 cd01ce        	call	_wifi_init_as_server
2419  0654 4d            	tnz	a
2420  0655 270b          	jreq	L7211
2421                     ; 567 			break;
2422  0657               L1311:
2423                     ; 575 		wifi_recv_parse_task();
2425  0657 cd04df        	call	_wifi_recv_parse_task
2427                     ; 577 		wifi_send_data_task();
2429  065a cd031f        	call	_wifi_send_data_task
2431                     ; 579 		heartbeat_to_clients_task();
2433  065d cd05b9        	call	_heartbeat_to_clients_task
2436  0660 20f5          	jra	L1311
2437  0662               L7211:
2438                     ; 569 		delay(8000); //delay period can be adjust. // must delay, due to wifi_init_as server() cmd response delay is not enough.
2440  0662 ae1f40        	ldw	x,#8000
2441  0665 89            	pushw	x
2442  0666 ae0000        	ldw	x,#0
2443  0669 89            	pushw	x
2444  066a cd0000        	call	_delay
2446  066d 5b04          	addw	sp,#4
2447                     ; 570 		GPIO_WriteReverse(GPIOA, GPIO_PIN_1);  // flashing led
2449  066f 4b02          	push	#2
2450  0671 ae5000        	ldw	x,#20480
2451  0674 cd0000        	call	_GPIO_WriteReverse
2453  0677 84            	pop	a
2455  0678 20d7          	jra	L3211
2567                     	xdef	_main
2568                     	xdef	_heartbeat_to_clients_task
2569                     	xdef	_wifi_recv_parse_task
2570                     	xdef	_handle_remote_cmd
2571                     	xdef	_check_is_connect_status_frame
2572                     	xdef	_wifi_send_data_task
2573                     	xdef	_wifi_init_as_server
2574                     	xdef	_send_cmd_and_wait_resp_timeout
2575                     	xdef	_is_frame_cmd_from_uart
2576                     	xdef	_cp_uart_frame
2577                     	xdef	_gpio_init
2578                     	xdef	_clk_config
2579                     	xdef	_Init_Timer4
2580                     	xdef	_var_init
2581                     	xdef	_uart1_sendChar
2582                     	xdef	_uart1_init
2583                     	xdef	_delay
2584                     	switch	.ubsct
2585  0000               L71_wifi_async_record_bits:
2586  0000 0000          	ds.b	2
2587  0002               L51_to_client_buffer:
2588  0002 000000000000  	ds.b	20
2589  0016               L31_hava_data_to_client:
2590  0016 00            	ds.b	1
2591  0017               L11_data_to_client_id:
2592  0017 00            	ds.b	1
2593  0018               L7_client_id:
2594  0018 0000000000    	ds.b	5
2595  001d               L5_client_cnt:
2596  001d 00            	ds.b	1
2597  001e               L3_uart1RecvFrame:
2598  001e 000000000000  	ds.b	64
2599                     	xref	_sprintf
2600                     	xdef	_putchar
2601                     	xref	_strlen
2602                     	xref	_strstr
2603                     	xdef	_uart1_sendString
2604  005e               _uart_0_5ms_upate_cnt:
2605  005e 00            	ds.b	1
2606                     	xdef	_uart_0_5ms_upate_cnt
2607  005f               _uart1RecvBuff:
2608  005f 000000000000  	ds.b	64
2609                     	xdef	_uart1RecvBuff
2610  009f               _uart1RecvCnt:
2611  009f 00000000      	ds.b	4
2612                     	xdef	_uart1RecvCnt
2613                     	xref	_UART1_GetFlagStatus
2614                     	xref	_UART1_SendData8
2615                     	xref	_UART1_ITConfig
2616                     	xref	_UART1_Cmd
2617                     	xref	_UART1_Init
2618                     	xref	_UART1_DeInit
2619                     	xref	_TIM4_ClearFlag
2620                     	xref	_TIM4_ITConfig
2621                     	xref	_TIM4_Cmd
2622                     	xref	_TIM4_TimeBaseInit
2623                     	xref	_GPIO_WriteReverse
2624                     	xref	_GPIO_WriteLow
2625                     	xref	_GPIO_WriteHigh
2626                     	xref	_GPIO_Init
2627                     	xref	_GPIO_DeInit
2628                     	xref	_CLK_GetFlagStatus
2629                     	xref	_CLK_SYSCLKConfig
2630                     	xref	_CLK_HSIPrescalerConfig
2631                     	xref	_CLK_HSICmd
2632                     	switch	.const
2633  000c               L7011:
2634  000c 686561727462  	dc.b	"heartbeat",0
2635  0016               L1501:
2636  0016 4641494c00    	dc.b	"FAIL",0
2637  001b               L1401:
2638  001b 53454e4400    	dc.b	"SEND",0
2639  0020               L3301:
2640  0020 41542b434950  	dc.b	"AT+CIPSEND=",0
2641  002c               L7201:
2642  002c 2b49504400    	dc.b	"+IPD",0
2643  0031               L747:
2644  0031 6c65645f6f66  	dc.b	"led_off",0
2645  0039               L147:
2646  0039 6c65645f6f6e  	dc.b	"led_on",0
2647  0040               L517:
2648  0040 434f4e4e4543  	dc.b	"CONNECT",0
2649  0048               L376:
2650  0048 434f4e4e4543  	dc.b	"CONNECT FAIL",0
2651  0055               L176:
2652  0055 434c4f534500  	dc.b	"CLOSE",0
2653  005b               L116:
2654  005b 41542b434950  	dc.b	"AT+CIPSEND=%d,%d",13
2655  006c 0a00          	dc.b	10,0
2656  006e               L725:
2657  006e 2b4357534150  	dc.b	"+CWSAP",0
2658  0075               L525:
2659  0075 41542b435753  	dc.b	"AT+CWSAP?",0
2660  007f               L325:
2661  007f 41542b435753  	dc.b	"AT+CWSAP?",13
2662  0089 0a00          	dc.b	10,0
2663  008b               L715:
2664  008b 2b4349465352  	dc.b	"+CIFSR:APIP",0
2665  0097               L515:
2666  0097 41542b434946  	dc.b	"AT+CIFSR",0
2667  00a0               L315:
2668  00a0 41542b434946  	dc.b	"AT+CIFSR",13
2669  00a9 0a00          	dc.b	10,0
2670  00ab               L705:
2671  00ab 41542b434950  	dc.b	"AT+CIPSERVER=1,808"
2672  00bd 3000          	dc.b	"0",0
2673  00bf               L505:
2674  00bf 41542b434950  	dc.b	"AT+CIPSERVER=1,808"
2675  00d1 300d          	dc.b	"0",13
2676  00d3 0a00          	dc.b	10,0
2677  00d5               L105:
2678  00d5 41542b434950  	dc.b	"AT+CIPMUX=1",0
2679  00e1               L774:
2680  00e1 41542b434950  	dc.b	"AT+CIPMUX=1",13
2681  00ed 0a00          	dc.b	10,0
2682  00ef               L374:
2683  00ef 41542b435753  	dc.b	"AT+CWSAP",0
2684  00f8               L174:
2685  00f8 41542b435753  	dc.b	"AT+CWSAP=",34
2686  0102 e5858de8b4b9  	dc.b	229,133,141,232,180,185
2687  0108 5749464922    	dc.b	"WIFI",34
2688  010d 2c22          	dc.b	",",34
2689  010f 222c312c300d  	dc.b	34,44,49,44,48,13
2690  0115 0a00          	dc.b	10,0
2691  0117               L564:
2692  0117 41542b43574d  	dc.b	"AT+CWMODE=2",0
2693  0123               L364:
2694  0123 41542b43574d  	dc.b	"AT+CWMODE=2",13
2695  012f 0a00          	dc.b	10,0
2696  0131               L154:
2697  0131 726561647900  	dc.b	"ready",0
2698  0137               L344:
2699  0137 4f4b00        	dc.b	"OK",0
2700  013a               L144:
2701  013a 41542b525354  	dc.b	"AT+RST",0
2702  0141               L734:
2703  0141 41542b525354  	dc.b	"AT+RST",13
2704  0148 0a00          	dc.b	10,0
2705                     	xref.b	c_y
2725                     	xref	c_uitolx
2726                     	xref	c_lzmp
2727                     	xref	c_lcmp
2728                     	xref	c_ltor
2729                     	xref	c_lgadc
2730                     	end
