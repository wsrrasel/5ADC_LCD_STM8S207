   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
 135                     ; 10 void ADC_Init(ADC_ts *adc, uint8_t channel){
 137                     	switch	.text
 138  0000               _ADC_Init:
 140  0000 89            	pushw	x
 141       00000000      OFST:	set	0
 144                     ; 11     adc->channel = channel;
 146  0001 7b05          	ld	a,(OFST+5,sp)
 147  0003 1e01          	ldw	x,(OFST+1,sp)
 148  0005 f7            	ld	(x),a
 149                     ; 12     adc->value = 0;
 151  0006 1e01          	ldw	x,(OFST+1,sp)
 152  0008 905f          	clrw	y
 153  000a ef01          	ldw	(1,x),y
 154                     ; 14     MovAvgFilter_Init(&adc->movAvgFltr);
 156  000c 1e01          	ldw	x,(OFST+1,sp)
 157  000e 1c0003        	addw	x,#3
 158  0011 cd0000        	call	_MovAvgFilter_Init
 160                     ; 15 }
 163  0014 85            	popw	x
 164  0015 81            	ret
 214                     ; 27 uint16_t ADC_ReadChannel(uint8_t channel){
 215                     	switch	.text
 216  0016               _ADC_ReadChannel:
 218  0016 89            	pushw	x
 219       00000002      OFST:	set	2
 222                     ; 28 	uint16_t adcValue = 0;
 224                     ; 30     ADC2_Init(
 224                     ; 31         ADC2_CONVERSIONMODE_SINGLE,
 224                     ; 32         channel,
 224                     ; 33         ADC2_PRESSEL_FCPU_D2,
 224                     ; 34         ADC2_EXTTRIG_TIM,
 224                     ; 35         DISABLE,
 224                     ; 36         ADC2_ALIGN_RIGHT,
 224                     ; 37         channel,
 224                     ; 38         DISABLE
 224                     ; 39     );
 226  0017 4b00          	push	#0
 227  0019 88            	push	a
 228  001a 4b08          	push	#8
 229  001c 4b00          	push	#0
 230  001e 4b00          	push	#0
 231  0020 4b00          	push	#0
 232  0022 5f            	clrw	x
 233  0023 97            	ld	xl,a
 234  0024 cd0000        	call	_ADC2_Init
 236  0027 5b06          	addw	sp,#6
 237                     ; 42     ADC2_Cmd(ENABLE);
 239  0029 a601          	ld	a,#1
 240  002b cd0000        	call	_ADC2_Cmd
 242                     ; 45     ADC2_StartConversion();
 244  002e cd0000        	call	_ADC2_StartConversion
 247  0031               L311:
 248                     ; 48     while (ADC2_GetFlagStatus() == RESET)  {;}
 250  0031 cd0000        	call	_ADC2_GetFlagStatus
 252  0034 4d            	tnz	a
 253  0035 27fa          	jreq	L311
 254                     ; 51     ADC2_ClearFlag();
 256  0037 cd0000        	call	_ADC2_ClearFlag
 258                     ; 54     adcValue = ADC2_GetConversionValue();
 260  003a cd0000        	call	_ADC2_GetConversionValue
 262  003d 1f01          	ldw	(OFST-1,sp),x
 264                     ; 57     ADC2_DeInit();
 266  003f cd0000        	call	_ADC2_DeInit
 268                     ; 60     return adcValue;
 270  0042 1e01          	ldw	x,(OFST-1,sp)
 273  0044 5b02          	addw	sp,#2
 274  0046 81            	ret
 313                     ; 72 uint16_t ADC_Read(ADC_ts *adc){
 314                     	switch	.text
 315  0047               _ADC_Read:
 317  0047 89            	pushw	x
 318       00000000      OFST:	set	0
 321                     ; 73     adc->value = ADC_ReadChannel(adc->channel);
 323  0048 f6            	ld	a,(x)
 324  0049 adcb          	call	_ADC_ReadChannel
 326  004b 1601          	ldw	y,(OFST+1,sp)
 327  004d 90ef01        	ldw	(1,y),x
 328                     ; 74     adc->value = MovAvgFilter_Update(&adc->movAvgFltr, adc->value);
 330  0050 1e01          	ldw	x,(OFST+1,sp)
 331  0052 ee01          	ldw	x,(1,x)
 332  0054 89            	pushw	x
 333  0055 1e03          	ldw	x,(OFST+3,sp)
 334  0057 1c0003        	addw	x,#3
 335  005a cd0000        	call	_MovAvgFilter_Update
 337  005d 5b02          	addw	sp,#2
 338  005f 1601          	ldw	y,(OFST+1,sp)
 339  0061 90ef01        	ldw	(1,y),x
 340                     ; 75     return adc->value;
 342  0064 1e01          	ldw	x,(OFST+1,sp)
 343  0066 ee01          	ldw	x,(1,x)
 346  0068 5b02          	addw	sp,#2
 347  006a 81            	ret
 360                     	xdef	_ADC_ReadChannel
 361                     	xdef	_ADC_Read
 362                     	xdef	_ADC_Init
 363                     	xref	_MovAvgFilter_Update
 364                     	xref	_MovAvgFilter_Init
 365                     	xref	_ADC2_ClearFlag
 366                     	xref	_ADC2_GetFlagStatus
 367                     	xref	_ADC2_GetConversionValue
 368                     	xref	_ADC2_StartConversion
 369                     	xref	_ADC2_Cmd
 370                     	xref	_ADC2_Init
 371                     	xref	_ADC2_DeInit
 390                     	end
