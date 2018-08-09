   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  43                     ; 43 void TIM4_DeInit(void)
  43                     ; 44 {
  45                     	switch	.text
  46  0000               _TIM4_DeInit:
  50                     ; 45     TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  52  0000 725f5340      	clr	21312
  53                     ; 46     TIM4->IER = TIM4_IER_RESET_VALUE;
  55  0004 725f5343      	clr	21315
  56                     ; 47     TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  58  0008 725f5346      	clr	21318
  59                     ; 48     TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  61  000c 725f5347      	clr	21319
  62                     ; 49     TIM4->ARR = TIM4_ARR_RESET_VALUE;
  64  0010 35ff5348      	mov	21320,#255
  65                     ; 50     TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  67  0014 725f5344      	clr	21316
  68                     ; 51 }
  71  0018 81            	ret
 177                     ; 59 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 177                     ; 60 {
 178                     	switch	.text
 179  0019               _TIM4_TimeBaseInit:
 183                     ; 62     assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 185                     ; 64     TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 187  0019 9e            	ld	a,xh
 188  001a c75347        	ld	21319,a
 189                     ; 66     TIM4->ARR = (uint8_t)(TIM4_Period);
 191  001d 9f            	ld	a,xl
 192  001e c75348        	ld	21320,a
 193                     ; 67 }
 196  0021 81            	ret
 251                     ; 77 void TIM4_Cmd(FunctionalState NewState)
 251                     ; 78 {
 252                     	switch	.text
 253  0022               _TIM4_Cmd:
 257                     ; 80     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 259                     ; 83     if (NewState != DISABLE)
 261  0022 4d            	tnz	a
 262  0023 2706          	jreq	L511
 263                     ; 85         TIM4->CR1 |= TIM4_CR1_CEN;
 265  0025 72105340      	bset	21312,#0
 267  0029 2004          	jra	L711
 268  002b               L511:
 269                     ; 89         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 271  002b 72115340      	bres	21312,#0
 272  002f               L711:
 273                     ; 91 }
 276  002f 81            	ret
 334                     ; 103 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 334                     ; 104 {
 335                     	switch	.text
 336  0030               _TIM4_ITConfig:
 338  0030 89            	pushw	x
 339       00000000      OFST:	set	0
 342                     ; 106     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 344                     ; 107     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 346                     ; 109     if (NewState != DISABLE)
 348  0031 9f            	ld	a,xl
 349  0032 4d            	tnz	a
 350  0033 2709          	jreq	L151
 351                     ; 112         TIM4->IER |= (uint8_t)TIM4_IT;
 353  0035 9e            	ld	a,xh
 354  0036 ca5343        	or	a,21315
 355  0039 c75343        	ld	21315,a
 357  003c 2009          	jra	L351
 358  003e               L151:
 359                     ; 117         TIM4->IER &= (uint8_t)(~TIM4_IT);
 361  003e 7b01          	ld	a,(OFST+1,sp)
 362  0040 43            	cpl	a
 363  0041 c45343        	and	a,21315
 364  0044 c75343        	ld	21315,a
 365  0047               L351:
 366                     ; 119 }
 369  0047 85            	popw	x
 370  0048 81            	ret
 406                     ; 127 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 406                     ; 128 {
 407                     	switch	.text
 408  0049               _TIM4_UpdateDisableConfig:
 412                     ; 130     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 414                     ; 133     if (NewState != DISABLE)
 416  0049 4d            	tnz	a
 417  004a 2706          	jreq	L371
 418                     ; 135         TIM4->CR1 |= TIM4_CR1_UDIS;
 420  004c 72125340      	bset	21312,#1
 422  0050 2004          	jra	L571
 423  0052               L371:
 424                     ; 139         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 426  0052 72135340      	bres	21312,#1
 427  0056               L571:
 428                     ; 141 }
 431  0056 81            	ret
 489                     ; 151 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 489                     ; 152 {
 490                     	switch	.text
 491  0057               _TIM4_UpdateRequestConfig:
 495                     ; 154     assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 497                     ; 157     if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 499  0057 4d            	tnz	a
 500  0058 2706          	jreq	L522
 501                     ; 159         TIM4->CR1 |= TIM4_CR1_URS;
 503  005a 72145340      	bset	21312,#2
 505  005e 2004          	jra	L722
 506  0060               L522:
 507                     ; 163         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 509  0060 72155340      	bres	21312,#2
 510  0064               L722:
 511                     ; 165 }
 514  0064 81            	ret
 571                     ; 175 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 571                     ; 176 {
 572                     	switch	.text
 573  0065               _TIM4_SelectOnePulseMode:
 577                     ; 178     assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 579                     ; 181     if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 581  0065 4d            	tnz	a
 582  0066 2706          	jreq	L752
 583                     ; 183         TIM4->CR1 |= TIM4_CR1_OPM;
 585  0068 72165340      	bset	21312,#3
 587  006c 2004          	jra	L162
 588  006e               L752:
 589                     ; 187         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_OPM);
 591  006e 72175340      	bres	21312,#3
 592  0072               L162:
 593                     ; 190 }
 596  0072 81            	ret
 664                     ; 212 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 664                     ; 213 {
 665                     	switch	.text
 666  0073               _TIM4_PrescalerConfig:
 670                     ; 215     assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 672                     ; 216     assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 674                     ; 219     TIM4->PSCR = (uint8_t)Prescaler;
 676  0073 9e            	ld	a,xh
 677  0074 c75347        	ld	21319,a
 678                     ; 222     TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 680  0077 9f            	ld	a,xl
 681  0078 c75345        	ld	21317,a
 682                     ; 223 }
 685  007b 81            	ret
 721                     ; 231 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 721                     ; 232 {
 722                     	switch	.text
 723  007c               _TIM4_ARRPreloadConfig:
 727                     ; 234     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 729                     ; 237     if (NewState != DISABLE)
 731  007c 4d            	tnz	a
 732  007d 2706          	jreq	L333
 733                     ; 239         TIM4->CR1 |= TIM4_CR1_ARPE;
 735  007f 721e5340      	bset	21312,#7
 737  0083 2004          	jra	L533
 738  0085               L333:
 739                     ; 243         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 741  0085 721f5340      	bres	21312,#7
 742  0089               L533:
 743                     ; 245 }
 746  0089 81            	ret
 795                     ; 254 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
 795                     ; 255 {
 796                     	switch	.text
 797  008a               _TIM4_GenerateEvent:
 801                     ; 257     assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
 803                     ; 260     TIM4->EGR = (uint8_t)(TIM4_EventSource);
 805  008a c75345        	ld	21317,a
 806                     ; 261 }
 809  008d 81            	ret
 843                     ; 270 void TIM4_SetCounter(uint8_t Counter)
 843                     ; 271 {
 844                     	switch	.text
 845  008e               _TIM4_SetCounter:
 849                     ; 273     TIM4->CNTR = (uint8_t)(Counter);
 851  008e c75346        	ld	21318,a
 852                     ; 274 }
 855  0091 81            	ret
 889                     ; 283 void TIM4_SetAutoreload(uint8_t Autoreload)
 889                     ; 284 {
 890                     	switch	.text
 891  0092               _TIM4_SetAutoreload:
 895                     ; 286     TIM4->ARR = (uint8_t)(Autoreload);
 897  0092 c75348        	ld	21320,a
 898                     ; 287 }
 901  0095 81            	ret
 924                     ; 294 uint8_t TIM4_GetCounter(void)
 924                     ; 295 {
 925                     	switch	.text
 926  0096               _TIM4_GetCounter:
 930                     ; 297     return (uint8_t)(TIM4->CNTR);
 932  0096 c65346        	ld	a,21318
 935  0099 81            	ret
 959                     ; 305 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
 959                     ; 306 {
 960                     	switch	.text
 961  009a               _TIM4_GetPrescaler:
 965                     ; 308     return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
 967  009a c65347        	ld	a,21319
 970  009d 81            	ret
1049                     ; 318 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1049                     ; 319 {
1050                     	switch	.text
1051  009e               _TIM4_GetFlagStatus:
1053  009e 88            	push	a
1054       00000001      OFST:	set	1
1057                     ; 320     FlagStatus bitstatus = RESET;
1059                     ; 323     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1061                     ; 325   if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
1063  009f c45344        	and	a,21316
1064  00a2 2706          	jreq	L774
1065                     ; 327     bitstatus = SET;
1067  00a4 a601          	ld	a,#1
1068  00a6 6b01          	ld	(OFST+0,sp),a
1070  00a8 2002          	jra	L105
1071  00aa               L774:
1072                     ; 331     bitstatus = RESET;
1074  00aa 0f01          	clr	(OFST+0,sp)
1075  00ac               L105:
1076                     ; 333   return ((FlagStatus)bitstatus);
1078  00ac 7b01          	ld	a,(OFST+0,sp)
1081  00ae 5b01          	addw	sp,#1
1082  00b0 81            	ret
1117                     ; 343 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1117                     ; 344 {
1118                     	switch	.text
1119  00b1               _TIM4_ClearFlag:
1123                     ; 346     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1125                     ; 349     TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
1127  00b1 43            	cpl	a
1128  00b2 c75344        	ld	21316,a
1129                     ; 351 }
1132  00b5 81            	ret
1196                     ; 360 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1196                     ; 361 {
1197                     	switch	.text
1198  00b6               _TIM4_GetITStatus:
1200  00b6 88            	push	a
1201  00b7 89            	pushw	x
1202       00000002      OFST:	set	2
1205                     ; 362     ITStatus bitstatus = RESET;
1207                     ; 364   uint8_t itstatus = 0x0, itenable = 0x0;
1211                     ; 367   assert_param(IS_TIM4_IT_OK(TIM4_IT));
1213                     ; 369   itstatus = (uint8_t)(TIM4->SR1 & (uint8_t)TIM4_IT);
1215  00b8 c45344        	and	a,21316
1216  00bb 6b01          	ld	(OFST-1,sp),a
1217                     ; 371   itenable = (uint8_t)(TIM4->IER & (uint8_t)TIM4_IT);
1219  00bd c65343        	ld	a,21315
1220  00c0 1403          	and	a,(OFST+1,sp)
1221  00c2 6b02          	ld	(OFST+0,sp),a
1222                     ; 373   if ((itstatus != (uint8_t)RESET ) && (itenable != (uint8_t)RESET ))
1224  00c4 0d01          	tnz	(OFST-1,sp)
1225  00c6 270a          	jreq	L355
1227  00c8 0d02          	tnz	(OFST+0,sp)
1228  00ca 2706          	jreq	L355
1229                     ; 375     bitstatus = (ITStatus)SET;
1231  00cc a601          	ld	a,#1
1232  00ce 6b02          	ld	(OFST+0,sp),a
1234  00d0 2002          	jra	L555
1235  00d2               L355:
1236                     ; 379     bitstatus = (ITStatus)RESET;
1238  00d2 0f02          	clr	(OFST+0,sp)
1239  00d4               L555:
1240                     ; 381   return ((ITStatus)bitstatus);
1242  00d4 7b02          	ld	a,(OFST+0,sp)
1245  00d6 5b03          	addw	sp,#3
1246  00d8 81            	ret
1282                     ; 391 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1282                     ; 392 {
1283                     	switch	.text
1284  00d9               _TIM4_ClearITPendingBit:
1288                     ; 394     assert_param(IS_TIM4_IT_OK(TIM4_IT));
1290                     ; 397     TIM4->SR1 = (uint8_t)(~TIM4_IT);
1292  00d9 43            	cpl	a
1293  00da c75344        	ld	21316,a
1294                     ; 398 }
1297  00dd 81            	ret
1310                     	xdef	_TIM4_ClearITPendingBit
1311                     	xdef	_TIM4_GetITStatus
1312                     	xdef	_TIM4_ClearFlag
1313                     	xdef	_TIM4_GetFlagStatus
1314                     	xdef	_TIM4_GetPrescaler
1315                     	xdef	_TIM4_GetCounter
1316                     	xdef	_TIM4_SetAutoreload
1317                     	xdef	_TIM4_SetCounter
1318                     	xdef	_TIM4_GenerateEvent
1319                     	xdef	_TIM4_ARRPreloadConfig
1320                     	xdef	_TIM4_PrescalerConfig
1321                     	xdef	_TIM4_SelectOnePulseMode
1322                     	xdef	_TIM4_UpdateRequestConfig
1323                     	xdef	_TIM4_UpdateDisableConfig
1324                     	xdef	_TIM4_ITConfig
1325                     	xdef	_TIM4_Cmd
1326                     	xdef	_TIM4_TimeBaseInit
1327                     	xdef	_TIM4_DeInit
1346                     	end
