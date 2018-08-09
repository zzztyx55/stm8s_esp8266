   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     .const:	section	.text
  16  0000               _HSIDivFactor:
  17  0000 01            	dc.b	1
  18  0001 02            	dc.b	2
  19  0002 04            	dc.b	4
  20  0003 08            	dc.b	8
  21  0004               _CLKPrescTable:
  22  0004 01            	dc.b	1
  23  0005 02            	dc.b	2
  24  0006 04            	dc.b	4
  25  0007 08            	dc.b	8
  26  0008 0a            	dc.b	10
  27  0009 10            	dc.b	16
  28  000a 14            	dc.b	20
  29  000b 28            	dc.b	40
  58                     ; 66 void CLK_DeInit(void)
  58                     ; 67 {
  60                     	switch	.text
  61  0000               _CLK_DeInit:
  65                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  67  0000 350150c0      	mov	20672,#1
  68                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  70  0004 725f50c1      	clr	20673
  71                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  73  0008 35e150c4      	mov	20676,#225
  74                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  76  000c 725f50c5      	clr	20677
  77                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  79  0010 351850c6      	mov	20678,#24
  80                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  82  0014 35ff50c7      	mov	20679,#255
  83                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  85  0018 35ff50ca      	mov	20682,#255
  86                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  88  001c 725f50c8      	clr	20680
  89                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  91  0020 725f50c9      	clr	20681
  93  0024               L52:
  94                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  96  0024 c650c9        	ld	a,20681
  97  0027 a501          	bcp	a,#1
  98  0029 26f9          	jrne	L52
  99                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 101  002b 725f50c9      	clr	20681
 102                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 104  002f 725f50cc      	clr	20684
 105                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 107  0033 725f50cd      	clr	20685
 108                     ; 84 }
 111  0037 81            	ret
 167                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 167                     ; 96 {
 168                     	switch	.text
 169  0038               _CLK_FastHaltWakeUpCmd:
 173                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 175                     ; 101     if (NewState != DISABLE)
 177  0038 4d            	tnz	a
 178  0039 2706          	jreq	L75
 179                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 181  003b 721450c0      	bset	20672,#2
 183  003f 2004          	jra	L16
 184  0041               L75:
 185                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 187  0041 721550c0      	bres	20672,#2
 188  0045               L16:
 189                     ; 112 }
 192  0045 81            	ret
 227                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 227                     ; 120 {
 228                     	switch	.text
 229  0046               _CLK_HSECmd:
 233                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 235                     ; 125     if (NewState != DISABLE)
 237  0046 4d            	tnz	a
 238  0047 2706          	jreq	L101
 239                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 241  0049 721050c1      	bset	20673,#0
 243  004d 2004          	jra	L301
 244  004f               L101:
 245                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 247  004f 721150c1      	bres	20673,#0
 248  0053               L301:
 249                     ; 136 }
 252  0053 81            	ret
 287                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 287                     ; 144 {
 288                     	switch	.text
 289  0054               _CLK_HSICmd:
 293                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 295                     ; 149     if (NewState != DISABLE)
 297  0054 4d            	tnz	a
 298  0055 2706          	jreq	L321
 299                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 301  0057 721050c0      	bset	20672,#0
 303  005b 2004          	jra	L521
 304  005d               L321:
 305                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 307  005d 721150c0      	bres	20672,#0
 308  0061               L521:
 309                     ; 160 }
 312  0061 81            	ret
 347                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 347                     ; 168 {
 348                     	switch	.text
 349  0062               _CLK_LSICmd:
 353                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 355                     ; 173     if (NewState != DISABLE)
 357  0062 4d            	tnz	a
 358  0063 2706          	jreq	L541
 359                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 361  0065 721650c0      	bset	20672,#3
 363  0069 2004          	jra	L741
 364  006b               L541:
 365                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 367  006b 721750c0      	bres	20672,#3
 368  006f               L741:
 369                     ; 184 }
 372  006f 81            	ret
 407                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 407                     ; 193 {
 408                     	switch	.text
 409  0070               _CLK_CCOCmd:
 413                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 415                     ; 198     if (NewState != DISABLE)
 417  0070 4d            	tnz	a
 418  0071 2706          	jreq	L761
 419                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 421  0073 721050c9      	bset	20681,#0
 423  0077 2004          	jra	L171
 424  0079               L761:
 425                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 427  0079 721150c9      	bres	20681,#0
 428  007d               L171:
 429                     ; 209 }
 432  007d 81            	ret
 467                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 467                     ; 219 {
 468                     	switch	.text
 469  007e               _CLK_ClockSwitchCmd:
 473                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 475                     ; 224     if (NewState != DISABLE )
 477  007e 4d            	tnz	a
 478  007f 2706          	jreq	L112
 479                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 481  0081 721250c5      	bset	20677,#1
 483  0085 2004          	jra	L312
 484  0087               L112:
 485                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 487  0087 721350c5      	bres	20677,#1
 488  008b               L312:
 489                     ; 235 }
 492  008b 81            	ret
 528                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 528                     ; 246 {
 529                     	switch	.text
 530  008c               _CLK_SlowActiveHaltWakeUpCmd:
 534                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 536                     ; 251     if (NewState != DISABLE)
 538  008c 4d            	tnz	a
 539  008d 2706          	jreq	L332
 540                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 542  008f 721a50c0      	bset	20672,#5
 544  0093 2004          	jra	L532
 545  0095               L332:
 546                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 548  0095 721b50c0      	bres	20672,#5
 549  0099               L532:
 550                     ; 262 }
 553  0099 81            	ret
 712                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 712                     ; 273 {
 713                     	switch	.text
 714  009a               _CLK_PeripheralClockConfig:
 716  009a 89            	pushw	x
 717       00000000      OFST:	set	0
 720                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 722                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 724                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 726  009b 9e            	ld	a,xh
 727  009c a510          	bcp	a,#16
 728  009e 2633          	jrne	L123
 729                     ; 281         if (NewState != DISABLE)
 731  00a0 0d02          	tnz	(OFST+2,sp)
 732  00a2 2717          	jreq	L323
 733                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 735  00a4 7b01          	ld	a,(OFST+1,sp)
 736  00a6 a40f          	and	a,#15
 737  00a8 5f            	clrw	x
 738  00a9 97            	ld	xl,a
 739  00aa a601          	ld	a,#1
 740  00ac 5d            	tnzw	x
 741  00ad 2704          	jreq	L62
 742  00af               L03:
 743  00af 48            	sll	a
 744  00b0 5a            	decw	x
 745  00b1 26fc          	jrne	L03
 746  00b3               L62:
 747  00b3 ca50c7        	or	a,20679
 748  00b6 c750c7        	ld	20679,a
 750  00b9 2049          	jra	L723
 751  00bb               L323:
 752                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 754  00bb 7b01          	ld	a,(OFST+1,sp)
 755  00bd a40f          	and	a,#15
 756  00bf 5f            	clrw	x
 757  00c0 97            	ld	xl,a
 758  00c1 a601          	ld	a,#1
 759  00c3 5d            	tnzw	x
 760  00c4 2704          	jreq	L23
 761  00c6               L43:
 762  00c6 48            	sll	a
 763  00c7 5a            	decw	x
 764  00c8 26fc          	jrne	L43
 765  00ca               L23:
 766  00ca 43            	cpl	a
 767  00cb c450c7        	and	a,20679
 768  00ce c750c7        	ld	20679,a
 769  00d1 2031          	jra	L723
 770  00d3               L123:
 771                     ; 294         if (NewState != DISABLE)
 773  00d3 0d02          	tnz	(OFST+2,sp)
 774  00d5 2717          	jreq	L133
 775                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 777  00d7 7b01          	ld	a,(OFST+1,sp)
 778  00d9 a40f          	and	a,#15
 779  00db 5f            	clrw	x
 780  00dc 97            	ld	xl,a
 781  00dd a601          	ld	a,#1
 782  00df 5d            	tnzw	x
 783  00e0 2704          	jreq	L63
 784  00e2               L04:
 785  00e2 48            	sll	a
 786  00e3 5a            	decw	x
 787  00e4 26fc          	jrne	L04
 788  00e6               L63:
 789  00e6 ca50ca        	or	a,20682
 790  00e9 c750ca        	ld	20682,a
 792  00ec 2016          	jra	L723
 793  00ee               L133:
 794                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 796  00ee 7b01          	ld	a,(OFST+1,sp)
 797  00f0 a40f          	and	a,#15
 798  00f2 5f            	clrw	x
 799  00f3 97            	ld	xl,a
 800  00f4 a601          	ld	a,#1
 801  00f6 5d            	tnzw	x
 802  00f7 2704          	jreq	L24
 803  00f9               L44:
 804  00f9 48            	sll	a
 805  00fa 5a            	decw	x
 806  00fb 26fc          	jrne	L44
 807  00fd               L24:
 808  00fd 43            	cpl	a
 809  00fe c450ca        	and	a,20682
 810  0101 c750ca        	ld	20682,a
 811  0104               L723:
 812                     ; 306 }
 815  0104 85            	popw	x
 816  0105 81            	ret
1004                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1004                     ; 320 {
1005                     	switch	.text
1006  0106               _CLK_ClockSwitchConfig:
1008  0106 89            	pushw	x
1009  0107 5204          	subw	sp,#4
1010       00000004      OFST:	set	4
1013                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1015  0109 ae0491        	ldw	x,#1169
1016  010c 1f03          	ldw	(OFST-1,sp),x
1017                     ; 324     ErrorStatus Swif = ERROR;
1019                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1021                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1023                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1025                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1027                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1029  010e c650c3        	ld	a,20675
1030  0111 6b01          	ld	(OFST-3,sp),a
1031                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1033  0113 7b05          	ld	a,(OFST+1,sp)
1034  0115 a101          	cp	a,#1
1035  0117 2639          	jrne	L544
1036                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1038  0119 721250c5      	bset	20677,#1
1039                     ; 343         if (ITState != DISABLE)
1041  011d 0d09          	tnz	(OFST+5,sp)
1042  011f 2706          	jreq	L744
1043                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1045  0121 721450c5      	bset	20677,#2
1047  0125 2004          	jra	L154
1048  0127               L744:
1049                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1051  0127 721550c5      	bres	20677,#2
1052  012b               L154:
1053                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1055  012b 7b06          	ld	a,(OFST+2,sp)
1056  012d c750c4        	ld	20676,a
1058  0130 2007          	jra	L754
1059  0132               L354:
1060                     ; 357             DownCounter--;
1062  0132 1e03          	ldw	x,(OFST-1,sp)
1063  0134 1d0001        	subw	x,#1
1064  0137 1f03          	ldw	(OFST-1,sp),x
1065  0139               L754:
1066                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1068  0139 c650c5        	ld	a,20677
1069  013c a501          	bcp	a,#1
1070  013e 2704          	jreq	L364
1072  0140 1e03          	ldw	x,(OFST-1,sp)
1073  0142 26ee          	jrne	L354
1074  0144               L364:
1075                     ; 360         if (DownCounter != 0)
1077  0144 1e03          	ldw	x,(OFST-1,sp)
1078  0146 2706          	jreq	L564
1079                     ; 362             Swif = SUCCESS;
1081  0148 a601          	ld	a,#1
1082  014a 6b02          	ld	(OFST-2,sp),a
1084  014c 201b          	jra	L174
1085  014e               L564:
1086                     ; 366             Swif = ERROR;
1088  014e 0f02          	clr	(OFST-2,sp)
1089  0150 2017          	jra	L174
1090  0152               L544:
1091                     ; 374         if (ITState != DISABLE)
1093  0152 0d09          	tnz	(OFST+5,sp)
1094  0154 2706          	jreq	L374
1095                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1097  0156 721450c5      	bset	20677,#2
1099  015a 2004          	jra	L574
1100  015c               L374:
1101                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1103  015c 721550c5      	bres	20677,#2
1104  0160               L574:
1105                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1107  0160 7b06          	ld	a,(OFST+2,sp)
1108  0162 c750c4        	ld	20676,a
1109                     ; 388         Swif = SUCCESS;
1111  0165 a601          	ld	a,#1
1112  0167 6b02          	ld	(OFST-2,sp),a
1113  0169               L174:
1114                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1116  0169 0d0a          	tnz	(OFST+6,sp)
1117  016b 260c          	jrne	L774
1119  016d 7b01          	ld	a,(OFST-3,sp)
1120  016f a1e1          	cp	a,#225
1121  0171 2606          	jrne	L774
1122                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1124  0173 721150c0      	bres	20672,#0
1126  0177 201e          	jra	L105
1127  0179               L774:
1128                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1130  0179 0d0a          	tnz	(OFST+6,sp)
1131  017b 260c          	jrne	L305
1133  017d 7b01          	ld	a,(OFST-3,sp)
1134  017f a1d2          	cp	a,#210
1135  0181 2606          	jrne	L305
1136                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1138  0183 721750c0      	bres	20672,#3
1140  0187 200e          	jra	L105
1141  0189               L305:
1142                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1144  0189 0d0a          	tnz	(OFST+6,sp)
1145  018b 260a          	jrne	L105
1147  018d 7b01          	ld	a,(OFST-3,sp)
1148  018f a1b4          	cp	a,#180
1149  0191 2604          	jrne	L105
1150                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1152  0193 721150c1      	bres	20673,#0
1153  0197               L105:
1154                     ; 406     return(Swif);
1156  0197 7b02          	ld	a,(OFST-2,sp)
1159  0199 5b06          	addw	sp,#6
1160  019b 81            	ret
1298                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1298                     ; 417 {
1299                     	switch	.text
1300  019c               _CLK_HSIPrescalerConfig:
1302  019c 88            	push	a
1303       00000000      OFST:	set	0
1306                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1308                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1310  019d c650c6        	ld	a,20678
1311  01a0 a4e7          	and	a,#231
1312  01a2 c750c6        	ld	20678,a
1313                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1315  01a5 c650c6        	ld	a,20678
1316  01a8 1a01          	or	a,(OFST+1,sp)
1317  01aa c750c6        	ld	20678,a
1318                     ; 428 }
1321  01ad 84            	pop	a
1322  01ae 81            	ret
1457                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1457                     ; 440 {
1458                     	switch	.text
1459  01af               _CLK_CCOConfig:
1461  01af 88            	push	a
1462       00000000      OFST:	set	0
1465                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1467                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1469  01b0 c650c9        	ld	a,20681
1470  01b3 a4e1          	and	a,#225
1471  01b5 c750c9        	ld	20681,a
1472                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1474  01b8 c650c9        	ld	a,20681
1475  01bb 1a01          	or	a,(OFST+1,sp)
1476  01bd c750c9        	ld	20681,a
1477                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1479  01c0 721050c9      	bset	20681,#0
1480                     ; 454 }
1483  01c4 84            	pop	a
1484  01c5 81            	ret
1549                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1549                     ; 465 {
1550                     	switch	.text
1551  01c6               _CLK_ITConfig:
1553  01c6 89            	pushw	x
1554       00000000      OFST:	set	0
1557                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1559                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1561                     ; 471     if (NewState != DISABLE)
1563  01c7 9f            	ld	a,xl
1564  01c8 4d            	tnz	a
1565  01c9 2719          	jreq	L507
1566                     ; 473         switch (CLK_IT)
1568  01cb 9e            	ld	a,xh
1570                     ; 481         default:
1570                     ; 482             break;
1571  01cc a00c          	sub	a,#12
1572  01ce 270a          	jreq	L146
1573  01d0 a010          	sub	a,#16
1574  01d2 2624          	jrne	L317
1575                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1575                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1577  01d4 721450c5      	bset	20677,#2
1578                     ; 477             break;
1580  01d8 201e          	jra	L317
1581  01da               L146:
1582                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1582                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1584  01da 721450c8      	bset	20680,#2
1585                     ; 480             break;
1587  01de 2018          	jra	L317
1588  01e0               L346:
1589                     ; 481         default:
1589                     ; 482             break;
1591  01e0 2016          	jra	L317
1592  01e2               L117:
1594  01e2 2014          	jra	L317
1595  01e4               L507:
1596                     ; 487         switch (CLK_IT)
1598  01e4 7b01          	ld	a,(OFST+1,sp)
1600                     ; 495         default:
1600                     ; 496             break;
1601  01e6 a00c          	sub	a,#12
1602  01e8 270a          	jreq	L746
1603  01ea a010          	sub	a,#16
1604  01ec 260a          	jrne	L317
1605                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1605                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1607  01ee 721550c5      	bres	20677,#2
1608                     ; 491             break;
1610  01f2 2004          	jra	L317
1611  01f4               L746:
1612                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1612                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1614  01f4 721550c8      	bres	20680,#2
1615                     ; 494             break;
1616  01f8               L317:
1617                     ; 500 }
1620  01f8 85            	popw	x
1621  01f9 81            	ret
1622  01fa               L156:
1623                     ; 495         default:
1623                     ; 496             break;
1625  01fa 20fc          	jra	L317
1626  01fc               L717:
1627  01fc 20fa          	jra	L317
1662                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1662                     ; 508 {
1663                     	switch	.text
1664  01fe               _CLK_SYSCLKConfig:
1666  01fe 88            	push	a
1667       00000000      OFST:	set	0
1670                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1672                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1674  01ff a580          	bcp	a,#128
1675  0201 2614          	jrne	L737
1676                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1678  0203 c650c6        	ld	a,20678
1679  0206 a4e7          	and	a,#231
1680  0208 c750c6        	ld	20678,a
1681                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1683  020b 7b01          	ld	a,(OFST+1,sp)
1684  020d a418          	and	a,#24
1685  020f ca50c6        	or	a,20678
1686  0212 c750c6        	ld	20678,a
1688  0215 2012          	jra	L147
1689  0217               L737:
1690                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1692  0217 c650c6        	ld	a,20678
1693  021a a4f8          	and	a,#248
1694  021c c750c6        	ld	20678,a
1695                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1697  021f 7b01          	ld	a,(OFST+1,sp)
1698  0221 a407          	and	a,#7
1699  0223 ca50c6        	or	a,20678
1700  0226 c750c6        	ld	20678,a
1701  0229               L147:
1702                     ; 524 }
1705  0229 84            	pop	a
1706  022a 81            	ret
1762                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1762                     ; 532 {
1763                     	switch	.text
1764  022b               _CLK_SWIMConfig:
1768                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1770                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1772  022b 4d            	tnz	a
1773  022c 2706          	jreq	L177
1774                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1776  022e 721050cd      	bset	20685,#0
1778  0232 2004          	jra	L377
1779  0234               L177:
1780                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1782  0234 721150cd      	bres	20685,#0
1783  0238               L377:
1784                     ; 548 }
1787  0238 81            	ret
1811                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1811                     ; 558 {
1812                     	switch	.text
1813  0239               _CLK_ClockSecuritySystemEnable:
1817                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1819  0239 721050c8      	bset	20680,#0
1820                     ; 561 }
1823  023d 81            	ret
1848                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1848                     ; 570 {
1849                     	switch	.text
1850  023e               _CLK_GetSYSCLKSource:
1854                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1856  023e c650c3        	ld	a,20675
1859  0241 81            	ret
1922                     ; 579 uint32_t CLK_GetClockFreq(void)
1922                     ; 580 {
1923                     	switch	.text
1924  0242               _CLK_GetClockFreq:
1926  0242 5209          	subw	sp,#9
1927       00000009      OFST:	set	9
1930                     ; 582     uint32_t clockfrequency = 0;
1932                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1934                     ; 584     uint8_t tmp = 0, presc = 0;
1938                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1940  0244 c650c3        	ld	a,20675
1941  0247 6b09          	ld	(OFST+0,sp),a
1942                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1944  0249 7b09          	ld	a,(OFST+0,sp)
1945  024b a1e1          	cp	a,#225
1946  024d 2641          	jrne	L7401
1947                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1949  024f c650c6        	ld	a,20678
1950  0252 a418          	and	a,#24
1951  0254 6b09          	ld	(OFST+0,sp),a
1952                     ; 592         tmp = (uint8_t)(tmp >> 3);
1954  0256 0409          	srl	(OFST+0,sp)
1955  0258 0409          	srl	(OFST+0,sp)
1956  025a 0409          	srl	(OFST+0,sp)
1957                     ; 593         presc = HSIDivFactor[tmp];
1959  025c 7b09          	ld	a,(OFST+0,sp)
1960  025e 5f            	clrw	x
1961  025f 97            	ld	xl,a
1962  0260 d60000        	ld	a,(_HSIDivFactor,x)
1963  0263 6b09          	ld	(OFST+0,sp),a
1964                     ; 594         clockfrequency = HSI_VALUE / presc;
1966  0265 7b09          	ld	a,(OFST+0,sp)
1967  0267 b703          	ld	c_lreg+3,a
1968  0269 3f02          	clr	c_lreg+2
1969  026b 3f01          	clr	c_lreg+1
1970  026d 3f00          	clr	c_lreg
1971  026f 96            	ldw	x,sp
1972  0270 1c0001        	addw	x,#OFST-8
1973  0273 cd0000        	call	c_rtol
1975  0276 ae2400        	ldw	x,#9216
1976  0279 bf02          	ldw	c_lreg+2,x
1977  027b ae00f4        	ldw	x,#244
1978  027e bf00          	ldw	c_lreg,x
1979  0280 96            	ldw	x,sp
1980  0281 1c0001        	addw	x,#OFST-8
1981  0284 cd0000        	call	c_ludv
1983  0287 96            	ldw	x,sp
1984  0288 1c0005        	addw	x,#OFST-4
1985  028b cd0000        	call	c_rtol
1988  028e 201c          	jra	L1501
1989  0290               L7401:
1990                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1992  0290 7b09          	ld	a,(OFST+0,sp)
1993  0292 a1d2          	cp	a,#210
1994  0294 260c          	jrne	L3501
1995                     ; 598         clockfrequency = LSI_VALUE;
1997  0296 aef400        	ldw	x,#62464
1998  0299 1f07          	ldw	(OFST-2,sp),x
1999  029b ae0001        	ldw	x,#1
2000  029e 1f05          	ldw	(OFST-4,sp),x
2002  02a0 200a          	jra	L1501
2003  02a2               L3501:
2004                     ; 602         clockfrequency = HSE_VALUE;
2006  02a2 ae2400        	ldw	x,#9216
2007  02a5 1f07          	ldw	(OFST-2,sp),x
2008  02a7 ae00f4        	ldw	x,#244
2009  02aa 1f05          	ldw	(OFST-4,sp),x
2010  02ac               L1501:
2011                     ; 605     return((uint32_t)clockfrequency);
2013  02ac 96            	ldw	x,sp
2014  02ad 1c0005        	addw	x,#OFST-4
2015  02b0 cd0000        	call	c_ltor
2019  02b3 5b09          	addw	sp,#9
2020  02b5 81            	ret
2119                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2119                     ; 617 {
2120                     	switch	.text
2121  02b6               _CLK_AdjustHSICalibrationValue:
2123  02b6 88            	push	a
2124       00000000      OFST:	set	0
2127                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2129                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2131  02b7 c650cc        	ld	a,20684
2132  02ba a4f8          	and	a,#248
2133  02bc 1a01          	or	a,(OFST+1,sp)
2134  02be c750cc        	ld	20684,a
2135                     ; 625 }
2138  02c1 84            	pop	a
2139  02c2 81            	ret
2163                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2163                     ; 637 {
2164                     	switch	.text
2165  02c3               _CLK_SYSCLKEmergencyClear:
2169                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2171  02c3 721150c5      	bres	20677,#0
2172                     ; 639 }
2175  02c7 81            	ret
2328                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2328                     ; 649 {
2329                     	switch	.text
2330  02c8               _CLK_GetFlagStatus:
2332  02c8 89            	pushw	x
2333  02c9 5203          	subw	sp,#3
2334       00000003      OFST:	set	3
2337                     ; 651     uint16_t statusreg = 0;
2339                     ; 652     uint8_t tmpreg = 0;
2341                     ; 653     FlagStatus bitstatus = RESET;
2343                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2345                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2347  02cb 01            	rrwa	x,a
2348  02cc 9f            	ld	a,xl
2349  02cd a4ff          	and	a,#255
2350  02cf 97            	ld	xl,a
2351  02d0 4f            	clr	a
2352  02d1 02            	rlwa	x,a
2353  02d2 1f01          	ldw	(OFST-2,sp),x
2354  02d4 01            	rrwa	x,a
2355                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2357  02d5 1e01          	ldw	x,(OFST-2,sp)
2358  02d7 a30100        	cpw	x,#256
2359  02da 2607          	jrne	L1221
2360                     ; 664         tmpreg = CLK->ICKR;
2362  02dc c650c0        	ld	a,20672
2363  02df 6b03          	ld	(OFST+0,sp),a
2365  02e1 202f          	jra	L3221
2366  02e3               L1221:
2367                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2369  02e3 1e01          	ldw	x,(OFST-2,sp)
2370  02e5 a30200        	cpw	x,#512
2371  02e8 2607          	jrne	L5221
2372                     ; 668         tmpreg = CLK->ECKR;
2374  02ea c650c1        	ld	a,20673
2375  02ed 6b03          	ld	(OFST+0,sp),a
2377  02ef 2021          	jra	L3221
2378  02f1               L5221:
2379                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2381  02f1 1e01          	ldw	x,(OFST-2,sp)
2382  02f3 a30300        	cpw	x,#768
2383  02f6 2607          	jrne	L1321
2384                     ; 672         tmpreg = CLK->SWCR;
2386  02f8 c650c5        	ld	a,20677
2387  02fb 6b03          	ld	(OFST+0,sp),a
2389  02fd 2013          	jra	L3221
2390  02ff               L1321:
2391                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2393  02ff 1e01          	ldw	x,(OFST-2,sp)
2394  0301 a30400        	cpw	x,#1024
2395  0304 2607          	jrne	L5321
2396                     ; 676         tmpreg = CLK->CSSR;
2398  0306 c650c8        	ld	a,20680
2399  0309 6b03          	ld	(OFST+0,sp),a
2401  030b 2005          	jra	L3221
2402  030d               L5321:
2403                     ; 680         tmpreg = CLK->CCOR;
2405  030d c650c9        	ld	a,20681
2406  0310 6b03          	ld	(OFST+0,sp),a
2407  0312               L3221:
2408                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2410  0312 7b05          	ld	a,(OFST+2,sp)
2411  0314 1503          	bcp	a,(OFST+0,sp)
2412  0316 2706          	jreq	L1421
2413                     ; 685         bitstatus = SET;
2415  0318 a601          	ld	a,#1
2416  031a 6b03          	ld	(OFST+0,sp),a
2418  031c 2002          	jra	L3421
2419  031e               L1421:
2420                     ; 689         bitstatus = RESET;
2422  031e 0f03          	clr	(OFST+0,sp)
2423  0320               L3421:
2424                     ; 693     return((FlagStatus)bitstatus);
2426  0320 7b03          	ld	a,(OFST+0,sp)
2429  0322 5b05          	addw	sp,#5
2430  0324 81            	ret
2476                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2476                     ; 704 {
2477                     	switch	.text
2478  0325               _CLK_GetITStatus:
2480  0325 88            	push	a
2481  0326 88            	push	a
2482       00000001      OFST:	set	1
2485                     ; 706     ITStatus bitstatus = RESET;
2487                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2489                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2491  0327 a11c          	cp	a,#28
2492  0329 2611          	jrne	L7621
2493                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2495  032b c450c5        	and	a,20677
2496  032e a10c          	cp	a,#12
2497  0330 2606          	jrne	L1721
2498                     ; 716             bitstatus = SET;
2500  0332 a601          	ld	a,#1
2501  0334 6b01          	ld	(OFST+0,sp),a
2503  0336 2015          	jra	L5721
2504  0338               L1721:
2505                     ; 720             bitstatus = RESET;
2507  0338 0f01          	clr	(OFST+0,sp)
2508  033a 2011          	jra	L5721
2509  033c               L7621:
2510                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2512  033c c650c8        	ld	a,20680
2513  033f 1402          	and	a,(OFST+1,sp)
2514  0341 a10c          	cp	a,#12
2515  0343 2606          	jrne	L7721
2516                     ; 728             bitstatus = SET;
2518  0345 a601          	ld	a,#1
2519  0347 6b01          	ld	(OFST+0,sp),a
2521  0349 2002          	jra	L5721
2522  034b               L7721:
2523                     ; 732             bitstatus = RESET;
2525  034b 0f01          	clr	(OFST+0,sp)
2526  034d               L5721:
2527                     ; 737     return bitstatus;
2529  034d 7b01          	ld	a,(OFST+0,sp)
2532  034f 85            	popw	x
2533  0350 81            	ret
2569                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2569                     ; 748 {
2570                     	switch	.text
2571  0351               _CLK_ClearITPendingBit:
2575                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2577                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2579  0351 a10c          	cp	a,#12
2580  0353 2606          	jrne	L1231
2581                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2583  0355 721750c8      	bres	20680,#3
2585  0359 2004          	jra	L3231
2586  035b               L1231:
2587                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2589  035b 721750c5      	bres	20677,#3
2590  035f               L3231:
2591                     ; 764 }
2594  035f 81            	ret
2629                     	xdef	_CLKPrescTable
2630                     	xdef	_HSIDivFactor
2631                     	xdef	_CLK_ClearITPendingBit
2632                     	xdef	_CLK_GetITStatus
2633                     	xdef	_CLK_GetFlagStatus
2634                     	xdef	_CLK_GetSYSCLKSource
2635                     	xdef	_CLK_GetClockFreq
2636                     	xdef	_CLK_AdjustHSICalibrationValue
2637                     	xdef	_CLK_SYSCLKEmergencyClear
2638                     	xdef	_CLK_ClockSecuritySystemEnable
2639                     	xdef	_CLK_SWIMConfig
2640                     	xdef	_CLK_SYSCLKConfig
2641                     	xdef	_CLK_ITConfig
2642                     	xdef	_CLK_CCOConfig
2643                     	xdef	_CLK_HSIPrescalerConfig
2644                     	xdef	_CLK_ClockSwitchConfig
2645                     	xdef	_CLK_PeripheralClockConfig
2646                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2647                     	xdef	_CLK_FastHaltWakeUpCmd
2648                     	xdef	_CLK_ClockSwitchCmd
2649                     	xdef	_CLK_CCOCmd
2650                     	xdef	_CLK_LSICmd
2651                     	xdef	_CLK_HSICmd
2652                     	xdef	_CLK_HSECmd
2653                     	xdef	_CLK_DeInit
2654                     	xref.b	c_lreg
2655                     	xref.b	c_x
2674                     	xref	c_ltor
2675                     	xref	c_ludv
2676                     	xref	c_rtol
2677                     	end
