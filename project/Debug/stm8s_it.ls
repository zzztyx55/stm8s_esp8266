   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 48 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  44                     ; 49 {
  45                     	switch	.text
  46  0000               f_NonHandledInterrupt:
  50                     ; 53 }
  53  0000 80            	iret
  75                     ; 61 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  75                     ; 62 {
  76                     	switch	.text
  77  0001               f_TRAP_IRQHandler:
  81                     ; 66 }
  84  0001 80            	iret
 106                     ; 73 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 106                     ; 74 
 106                     ; 75 {
 107                     	switch	.text
 108  0002               f_TLI_IRQHandler:
 112                     ; 79 }
 115  0002 80            	iret
 137                     ; 86 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 137                     ; 87 {
 138                     	switch	.text
 139  0003               f_AWU_IRQHandler:
 143                     ; 91 }
 146  0003 80            	iret
 168                     ; 98 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 168                     ; 99 {
 169                     	switch	.text
 170  0004               f_CLK_IRQHandler:
 174                     ; 103 }
 177  0004 80            	iret
 200                     ; 110 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 200                     ; 111 {
 201                     	switch	.text
 202  0005               f_EXTI_PORTA_IRQHandler:
 206                     ; 115 }
 209  0005 80            	iret
 232                     ; 122 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 232                     ; 123 {
 233                     	switch	.text
 234  0006               f_EXTI_PORTB_IRQHandler:
 238                     ; 127 }
 241  0006 80            	iret
 264                     ; 134 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 264                     ; 135 {
 265                     	switch	.text
 266  0007               f_EXTI_PORTC_IRQHandler:
 270                     ; 139 }
 273  0007 80            	iret
 296                     ; 146 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 296                     ; 147 {
 297                     	switch	.text
 298  0008               f_EXTI_PORTD_IRQHandler:
 302                     ; 151 }
 305  0008 80            	iret
 328                     ; 158 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 328                     ; 159 {
 329                     	switch	.text
 330  0009               f_EXTI_PORTE_IRQHandler:
 334                     ; 163 }
 337  0009 80            	iret
 359                     ; 210 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 359                     ; 211 {
 360                     	switch	.text
 361  000a               f_SPI_IRQHandler:
 365                     ; 215 }
 368  000a 80            	iret
 391                     ; 222 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 391                     ; 223 {
 392                     	switch	.text
 393  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 397                     ; 227 }
 400  000b 80            	iret
 423                     ; 234 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 423                     ; 235 {
 424                     	switch	.text
 425  000c               f_TIM1_CAP_COM_IRQHandler:
 429                     ; 239 }
 432  000c 80            	iret
 455                     ; 272  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 455                     ; 273  {
 456                     	switch	.text
 457  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 461                     ; 277  }
 464  000d 80            	iret
 487                     ; 284  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 487                     ; 285  {
 488                     	switch	.text
 489  000e               f_TIM2_CAP_COM_IRQHandler:
 493                     ; 289  }
 496  000e 80            	iret
 519                     ; 326  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 519                     ; 327  {
 520                     	switch	.text
 521  000f               f_UART1_TX_IRQHandler:
 525                     ; 331  }
 528  000f 80            	iret
 568                     .const:	section	.text
 569  0000               L64:
 570  0000 00000040      	dc.l	64
 571                     ; 338  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 571                     ; 339  {
 572                     	switch	.text
 573  0010               f_UART1_RX_IRQHandler:
 575       00000001      OFST:	set	1
 576  0010 3b0002        	push	c_x+2
 577  0013 be00          	ldw	x,c_x
 578  0015 89            	pushw	x
 579  0016 3b0002        	push	c_y+2
 580  0019 be00          	ldw	x,c_y
 581  001b 89            	pushw	x
 582  001c be02          	ldw	x,c_lreg+2
 583  001e 89            	pushw	x
 584  001f be00          	ldw	x,c_lreg
 585  0021 89            	pushw	x
 586  0022 88            	push	a
 589                     ; 344 	if(RESET != UART1_GetITStatus(UART1_IT_RXNE))
 591  0023 ae0255        	ldw	x,#597
 592  0026 cd0000        	call	_UART1_GetITStatus
 594  0029 4d            	tnz	a
 595  002a 2736          	jreq	L722
 596                     ; 346 		if(uart1RecvCnt < UART_RSIZE)  // 数组大小是 UART_RSIZE
 598  002c ae0000        	ldw	x,#_uart1RecvCnt
 599  002f cd0000        	call	c_ltor
 601  0032 ae0000        	ldw	x,#L64
 602  0035 cd0000        	call	c_lcmp
 604  0038 241d          	jruge	L132
 605                     ; 349 			uart1RecvBuff[uart1RecvCnt++] = UART1_ReceiveData8();
 607  003a ae0000        	ldw	x,#_uart1RecvCnt
 608  003d cd0000        	call	c_ltor
 610  0040 ae0000        	ldw	x,#_uart1RecvCnt
 611  0043 a601          	ld	a,#1
 612  0045 cd0000        	call	c_lgadc
 614  0048 a600          	ld	a,#_uart1RecvBuff
 615  004a cd0000        	call	c_ladc
 617  004d be02          	ldw	x,c_lreg+2
 618  004f 89            	pushw	x
 619  0050 cd0000        	call	_UART1_ReceiveData8
 621  0053 85            	popw	x
 622  0054 f7            	ld	(x),a
 624  0055 2003          	jra	L332
 625  0057               L132:
 626                     ; 354 			c = UART1_ReceiveData8();  
 628  0057 cd0000        	call	_UART1_ReceiveData8
 630  005a               L332:
 631                     ; 357 		uart_0_5ms_upate_cnt = 0;
 633  005a 3f00          	clr	_uart_0_5ms_upate_cnt
 634                     ; 359 		UART1_ClearITPendingBit(UART1_IT_RXNE);
 636  005c ae0255        	ldw	x,#597
 637  005f cd0000        	call	_UART1_ClearITPendingBit
 639  0062               L722:
 640                     ; 361 }
 643  0062 84            	pop	a
 644  0063 85            	popw	x
 645  0064 bf00          	ldw	c_lreg,x
 646  0066 85            	popw	x
 647  0067 bf02          	ldw	c_lreg+2,x
 648  0069 85            	popw	x
 649  006a bf00          	ldw	c_y,x
 650  006c 320002        	pop	c_y+2
 651  006f 85            	popw	x
 652  0070 bf00          	ldw	c_x,x
 653  0072 320002        	pop	c_x+2
 654  0075 80            	iret
 676                     ; 369 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 676                     ; 370 {
 677                     	switch	.text
 678  0076               f_I2C_IRQHandler:
 682                     ; 374 }
 685  0076 80            	iret
 707                     ; 448  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 707                     ; 449  {
 708                     	switch	.text
 709  0077               f_ADC1_IRQHandler:
 713                     ; 453  }
 716  0077 80            	iret
 718                     	bsct
 719  0000               L552_cnt:
 720  0000 0000          	dc.w	0
 755                     ; 474  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 755                     ; 475  {
 756                     	switch	.text
 757  0078               f_TIM4_UPD_OVF_IRQHandler:
 759  0078 3b0002        	push	c_x+2
 760  007b be00          	ldw	x,c_x
 761  007d 89            	pushw	x
 762  007e 3b0002        	push	c_y+2
 763  0081 be00          	ldw	x,c_y
 764  0083 89            	pushw	x
 767                     ; 481 	cnt++;
 769  0084 be00          	ldw	x,L552_cnt
 770  0086 1c0001        	addw	x,#1
 771  0089 bf00          	ldw	L552_cnt,x
 772                     ; 482 	if(cnt >= 10) // 0.1ms * 10 = 1ms
 774  008b be00          	ldw	x,L552_cnt
 775  008d a3000a        	cpw	x,#10
 776  0090 2505          	jrult	L572
 777                     ; 484 		cnt = 0;
 779  0092 5f            	clrw	x
 780  0093 bf00          	ldw	L552_cnt,x
 781                     ; 485 		uart_0_5ms_upate_cnt += 1;
 783  0095 3c00          	inc	_uart_0_5ms_upate_cnt
 784  0097               L572:
 785                     ; 488 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);   //  清除中断标志位
 787  0097 a601          	ld	a,#1
 788  0099 cd0000        	call	_TIM4_ClearITPendingBit
 790                     ; 489  }
 793  009c 85            	popw	x
 794  009d bf00          	ldw	c_y,x
 795  009f 320002        	pop	c_y+2
 796  00a2 85            	popw	x
 797  00a3 bf00          	ldw	c_x,x
 798  00a5 320002        	pop	c_x+2
 799  00a8 80            	iret
 822                     ; 497 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 822                     ; 498 {
 823                     	switch	.text
 824  00a9               f_EEPROM_EEC_IRQHandler:
 828                     ; 502 }
 831  00a9 80            	iret
 843                     	xref.b	_uart_0_5ms_upate_cnt
 844                     	xref.b	_uart1RecvBuff
 845                     	xref.b	_uart1RecvCnt
 846                     	xdef	f_EEPROM_EEC_IRQHandler
 847                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 848                     	xdef	f_ADC1_IRQHandler
 849                     	xdef	f_I2C_IRQHandler
 850                     	xdef	f_UART1_RX_IRQHandler
 851                     	xdef	f_UART1_TX_IRQHandler
 852                     	xdef	f_TIM2_CAP_COM_IRQHandler
 853                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 854                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 855                     	xdef	f_TIM1_CAP_COM_IRQHandler
 856                     	xdef	f_SPI_IRQHandler
 857                     	xdef	f_EXTI_PORTE_IRQHandler
 858                     	xdef	f_EXTI_PORTD_IRQHandler
 859                     	xdef	f_EXTI_PORTC_IRQHandler
 860                     	xdef	f_EXTI_PORTB_IRQHandler
 861                     	xdef	f_EXTI_PORTA_IRQHandler
 862                     	xdef	f_CLK_IRQHandler
 863                     	xdef	f_AWU_IRQHandler
 864                     	xdef	f_TLI_IRQHandler
 865                     	xdef	f_TRAP_IRQHandler
 866                     	xdef	f_NonHandledInterrupt
 867                     	xref	_UART1_ClearITPendingBit
 868                     	xref	_UART1_GetITStatus
 869                     	xref	_UART1_ReceiveData8
 870                     	xref	_TIM4_ClearITPendingBit
 871                     	xref.b	c_lreg
 872                     	xref.b	c_x
 873                     	xref.b	c_y
 892                     	xref	c_rtol
 893                     	xref	c_ladc
 894                     	xref	c_lgadc
 895                     	xref	c_lcmp
 896                     	xref	c_ltor
 897                     	end
