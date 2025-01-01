   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
 103                     ; 20 void MovAvgFilter_Init(MovAvgFilter_ts* filter) {
 105                     	switch	.text
 106  0000               _MovAvgFilter_Init:
 108  0000 89            	pushw	x
 109  0001 88            	push	a
 110       00000001      OFST:	set	1
 113                     ; 21     uint8_t i = 0;
 115                     ; 22     filter->index = 0;
 117  0002 6f0a          	clr	(10,x)
 118                     ; 23     filter->count = 0;
 120  0004 6f0b          	clr	(11,x)
 121                     ; 24     filter->sum = 0;
 123  0006 a600          	ld	a,#0
 124  0008 e70f          	ld	(15,x),a
 125  000a a600          	ld	a,#0
 126  000c e70e          	ld	(14,x),a
 127  000e a600          	ld	a,#0
 128  0010 e70d          	ld	(13,x),a
 129  0012 a600          	ld	a,#0
 130  0014 e70c          	ld	(12,x),a
 131                     ; 26     for (i = 0; i < FILTER_SIZE; i++) {
 133  0016 0f01          	clr	(OFST+0,sp)
 135  0018               L35:
 136                     ; 27         filter->buffer[i] = 0;
 138  0018 7b01          	ld	a,(OFST+0,sp)
 139  001a 5f            	clrw	x
 140  001b 97            	ld	xl,a
 141  001c 58            	sllw	x
 142  001d 72fb02        	addw	x,(OFST+1,sp)
 143  0020 905f          	clrw	y
 144  0022 ff            	ldw	(x),y
 145                     ; 26     for (i = 0; i < FILTER_SIZE; i++) {
 147  0023 0c01          	inc	(OFST+0,sp)
 151  0025 7b01          	ld	a,(OFST+0,sp)
 152  0027 a105          	cp	a,#5
 153  0029 25ed          	jrult	L35
 154                     ; 29 }
 157  002b 5b03          	addw	sp,#3
 158  002d 81            	ret
 205                     ; 41 uint16_t MovAvgFilter_Update(MovAvgFilter_ts* filter, uint16_t newValue) {
 206                     	switch	.text
 207  002e               _MovAvgFilter_Update:
 209  002e 89            	pushw	x
 210  002f 5204          	subw	sp,#4
 211       00000004      OFST:	set	4
 214                     ; 43     filter->sum -= filter->buffer[filter->index];
 216  0031 9093          	ldw	y,x
 217  0033 1703          	ldw	(OFST-1,sp),y
 219  0035 9093          	ldw	y,x
 220  0037 90e60a        	ld	a,(10,y)
 221  003a 905f          	clrw	y
 222  003c 9097          	ld	yl,a
 223  003e 9058          	sllw	y
 224  0040 72f903        	addw	y,(OFST-1,sp)
 225  0043 90fe          	ldw	y,(y)
 226  0045 cd0000        	call	c_uitoly
 228  0048 1c000c        	addw	x,#12
 229  004b cd0000        	call	c_lgsub
 231                     ; 46     filter->buffer[filter->index] = newValue;
 233  004e 1e05          	ldw	x,(OFST+1,sp)
 234  0050 e60a          	ld	a,(10,x)
 235  0052 5f            	clrw	x
 236  0053 97            	ld	xl,a
 237  0054 58            	sllw	x
 238  0055 72fb05        	addw	x,(OFST+1,sp)
 239  0058 1609          	ldw	y,(OFST+5,sp)
 240  005a ff            	ldw	(x),y
 241                     ; 47     filter->sum += newValue;
 243  005b 1e05          	ldw	x,(OFST+1,sp)
 244  005d 1609          	ldw	y,(OFST+5,sp)
 245  005f cd0000        	call	c_uitoly
 247  0062 1c000c        	addw	x,#12
 248  0065 cd0000        	call	c_lgadd
 250                     ; 50     filter->index = (filter->index + 1) % FILTER_SIZE;
 252  0068 1e05          	ldw	x,(OFST+1,sp)
 253  006a e60a          	ld	a,(10,x)
 254  006c 5f            	clrw	x
 255  006d 97            	ld	xl,a
 256  006e 5c            	incw	x
 257  006f a605          	ld	a,#5
 258  0071 cd0000        	call	c_smodx
 260  0074 1605          	ldw	y,(OFST+1,sp)
 261  0076 01            	rrwa	x,a
 262  0077 90e70a        	ld	(10,y),a
 263  007a 02            	rlwa	x,a
 264                     ; 53     if (filter->count < FILTER_SIZE) {
 266  007b 1e05          	ldw	x,(OFST+1,sp)
 267  007d e60b          	ld	a,(11,x)
 268  007f a105          	cp	a,#5
 269  0081 2404          	jruge	L501
 270                     ; 54         filter->count++;
 272  0083 1e05          	ldw	x,(OFST+1,sp)
 273  0085 6c0b          	inc	(11,x)
 274  0087               L501:
 275                     ; 58     return filter->sum / filter->count;
 277  0087 1e05          	ldw	x,(OFST+1,sp)
 278  0089 e60b          	ld	a,(11,x)
 279  008b b703          	ld	c_lreg+3,a
 280  008d 3f02          	clr	c_lreg+2
 281  008f 3f01          	clr	c_lreg+1
 282  0091 3f00          	clr	c_lreg
 283  0093 96            	ldw	x,sp
 284  0094 1c0001        	addw	x,#OFST-3
 285  0097 cd0000        	call	c_rtol
 288  009a 1e05          	ldw	x,(OFST+1,sp)
 289  009c 1c000c        	addw	x,#12
 290  009f cd0000        	call	c_ltor
 292  00a2 96            	ldw	x,sp
 293  00a3 1c0001        	addw	x,#OFST-3
 294  00a6 cd0000        	call	c_ludv
 296  00a9 be02          	ldw	x,c_lreg+2
 299  00ab 5b06          	addw	sp,#6
 300  00ad 81            	ret
 313                     	xdef	_MovAvgFilter_Update
 314                     	xdef	_MovAvgFilter_Init
 315                     	xref.b	c_lreg
 316                     	xref.b	c_x
 335                     	xref	c_ludv
 336                     	xref	c_rtol
 337                     	xref	c_ltor
 338                     	xref	c_smodx
 339                     	xref	c_lgadd
 340                     	xref	c_lgsub
 341                     	xref	c_uitoly
 342                     	end
