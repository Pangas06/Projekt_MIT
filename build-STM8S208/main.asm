;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _zvuk_vystup
	.globl _zvuk_vstup
	.globl _lcd_puts
	.globl _lcd_gotoxy
	.globl _lcd_init
	.globl _milis
	.globl _init_milis
	.globl _sprintf
	.globl _GPIO_ReadInputPin
	.globl _GPIO_WriteReverse
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _CLK_HSIPrescalerConfig
	.globl _init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
	int _TRAP_IRQHandler ; trap
	int _TLI_IRQHandler ; int0
	int _AWU_IRQHandler ; int1
	int _CLK_IRQHandler ; int2
	int _EXTI_PORTA_IRQHandler ; int3
	int _EXTI_PORTB_IRQHandler ; int4
	int _EXTI_PORTC_IRQHandler ; int5
	int _EXTI_PORTD_IRQHandler ; int6
	int _EXTI_PORTE_IRQHandler ; int7
	int _CAN_RX_IRQHandler ; int8
	int _CAN_TX_IRQHandler ; int9
	int _SPI_IRQHandler ; int10
	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ; int11
	int _TIM1_CAP_COM_IRQHandler ; int12
	int _TIM2_UPD_OVF_BRK_IRQHandler ; int13
	int _TIM2_CAP_COM_IRQHandler ; int14
	int _TIM3_UPD_OVF_BRK_IRQHandler ; int15
	int _TIM3_CAP_COM_IRQHandler ; int16
	int _UART1_TX_IRQHandler ; int17
	int _UART1_RX_IRQHandler ; int18
	int _I2C_IRQHandler ; int19
	int _UART3_TX_IRQHandler ; int20
	int _UART3_RX_IRQHandler ; int21
	int _ADC2_IRQHandler ; int22
	int _TIM4_UPD_OVF_IRQHandler ; int23
	int _EEPROM_EEC_IRQHandler ; int24
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./src/main.c: 10: void init(void)
; genLabel
;	-----------------------------------------
;	 function init
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init:
;	./src/main.c: 12: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);      // taktovani MCU na 16MHz
; genSend
	clr	a
; genCall
	call	_CLK_HSIPrescalerConfig
;	./src/main.c: 13: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x500a
; genCall
	call	_GPIO_Init
;	./src/main.c: 15: GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x5014
; genCall
	call	_GPIO_Init
;	./src/main.c: 16: GPIO_Init(SENZOR1_PORT, SENZOR1_PIN, GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x500a
; genCall
	call	_GPIO_Init
;	./src/main.c: 17: GPIO_Init(SENZOR2_PORT, SENZOR2_PIN, GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x500a
; genCall
	call	_GPIO_Init
;	./src/main.c: 18: GPIO_Init(PZ_PORT, PZ_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_Init
;	./src/main.c: 20: init_milis();
; genCall
	jp	_init_milis
; genLabel
00101$:
;	./src/main.c: 21: }
; genEndFunction
	ret
;	./src/main.c: 23: void zvuk_vstup(void){
; genLabel
;	-----------------------------------------
;	 function zvuk_vstup
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 13 bytes.
_zvuk_vstup:
	sub	sp, #13
;	./src/main.c: 28: uint16_t zvuk_stav = 1;
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
;	./src/main.c: 31: time = milis();
; genCall
	call	_milis
	ldw	(0x04, sp), x
	ldw	(0x02, sp), y
;	./src/main.c: 32: lastTime = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 33: while(1){
; genLabel
00113$:
;	./src/main.c: 35: if (UP == zvuk_stav){
; genCmpEQorNE
	ld	a, (0x01, sp)
	dec	a
	jrne	00179$
	jp	00180$
00179$:
	jp	00108$
00180$:
; skipping generated iCode
;	./src/main.c: 36: PZ_UP;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteLow
;	./src/main.c: 37: if (milis() - lastTime > 1) {
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x08, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x07, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x06, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	clrw	x
	incw	x
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00181$
	jp	00109$
00181$:
; skipping generated iCode
;	./src/main.c: 38: lastTime = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 39: zvuk_stav = 0;
; genAssign
	clr	(0x01, sp)
; genGoto
	jp	00109$
; genLabel
00108$:
;	./src/main.c: 41: }else if (DOWN == zvuk_stav){
; genCmpEQorNE
	ld	a, (0x01, sp)
	cp	a, #0x00
	jrne	00183$
	jp	00184$
00183$:
	jp	00109$
00184$:
; skipping generated iCode
;	./src/main.c: 42: PZ_DOWN;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 43: if (milis() - lastTime > 1) {
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x08, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x07, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x06, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	clrw	x
	incw	x
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00185$
	jp	00109$
00185$:
; skipping generated iCode
;	./src/main.c: 44: lastTime = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 45: zvuk_stav = 1;
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
; genLabel
00109$:
;	./src/main.c: 48: if(milis() - time > 50){
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x04, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x03, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x02, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	ldw	x, #0x0032
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00186$
	jp	00113$
00186$:
; skipping generated iCode
;	./src/main.c: 49: PZ_UP;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteLow
;	./src/main.c: 54: time = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 55: while(1){
; genLabel
00118$:
;	./src/main.c: 56: PZ_REVERSE;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteReverse
;	./src/main.c: 57: if(milis() - time > 100){
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x08, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x07, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x06, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	ldw	x, #0x0064
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00187$
	jp	00118$
00187$:
; skipping generated iCode
;	./src/main.c: 58: PZ_UP;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	addw	sp, #13
	jp	_GPIO_WriteLow
;	./src/main.c: 59: break;
; genLabel
00120$:
;	./src/main.c: 62: }
; genEndFunction
	addw	sp, #13
	ret
;	./src/main.c: 64: void zvuk_vystup(void){
; genLabel
;	-----------------------------------------
;	 function zvuk_vystup
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 13 bytes.
_zvuk_vystup:
	sub	sp, #13
;	./src/main.c: 69: uint16_t zvuk_stav = 1;
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
;	./src/main.c: 72: time = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 73: while(1){
; genLabel
00104$:
;	./src/main.c: 74: PZ_REVERSE;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteReverse
;	./src/main.c: 75: if(milis() - time > 50){
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x08, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x07, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x06, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	ldw	x, #0x0032
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00178$
	jp	00104$
00178$:
; skipping generated iCode
;	./src/main.c: 76: PZ_UP;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteLow
;	./src/main.c: 81: time = milis();
; genCall
	call	_milis
	ldw	(0x04, sp), x
	ldw	(0x02, sp), y
;	./src/main.c: 82: lastTime = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 84: while(1){
; genLabel
00118$:
;	./src/main.c: 85: if (UP == zvuk_stav){
; genCmpEQorNE
	ld	a, (0x01, sp)
	dec	a
	jrne	00180$
	jp	00181$
00180$:
	jp	00113$
00181$:
; skipping generated iCode
;	./src/main.c: 86: PZ_UP;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteLow
;	./src/main.c: 87: if (milis() - lastTime > 1) {
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x08, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x07, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x06, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	clrw	x
	incw	x
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00182$
	jp	00114$
00182$:
; skipping generated iCode
;	./src/main.c: 88: lastTime = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 89: zvuk_stav = 0;
; genAssign
	clr	(0x01, sp)
; genGoto
	jp	00114$
; genLabel
00113$:
;	./src/main.c: 91: }else if (DOWN == zvuk_stav){
; genCmpEQorNE
	ld	a, (0x01, sp)
	cp	a, #0x00
	jrne	00184$
	jp	00185$
00184$:
	jp	00114$
00185$:
; skipping generated iCode
;	./src/main.c: 92: PZ_DOWN;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	call	_GPIO_WriteHigh
;	./src/main.c: 93: if (milis() - lastTime > 1) {
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x08, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x07, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x06, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	clrw	x
	incw	x
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00186$
	jp	00114$
00186$:
; skipping generated iCode
;	./src/main.c: 94: lastTime = milis();
; genCall
	call	_milis
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	./src/main.c: 95: zvuk_stav = 1;
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
; genLabel
00114$:
;	./src/main.c: 98: if(milis() - time > 100){
; genCall
	call	_milis
	exgw	x, y
; genMinus
	subw	y, (0x04, sp)
	ldw	(0x0c, sp), y
	ld	a, xl
	sbc	a, (0x03, sp)
	ld	(0x0b, sp), a
	ld	a, xh
	sbc	a, (0x02, sp)
	ld	(0x0a, sp), a
; genCmp
; genCmpTnz
	ldw	x, #0x0064
	cpw	x, (0x0c, sp)
	clr	a
	sbc	a, (0x0b, sp)
	clr	a
	sbc	a, (0x0a, sp)
	jrc	00187$
	jp	00118$
00187$:
; skipping generated iCode
;	./src/main.c: 99: PZ_UP;
; genSend
	ld	a, #0x10
; genSend
	ldw	x, #0x500f
; genCall
	addw	sp, #13
	jp	_GPIO_WriteLow
;	./src/main.c: 100: break;
; genLabel
00120$:
;	./src/main.c: 103: }
; genEndFunction
	addw	sp, #13
	ret
;	./src/main.c: 105: int main(void){
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 60 bytes.
_main:
	sub	sp, #60
;	./src/main.c: 106: init();
; genCall
	call	_init
;	./src/main.c: 107: uint16_t mezivstup  = 0;
; genAssign
	clrw	x
	ldw	(0x29, sp), x
;	./src/main.c: 108: uint16_t mezivystup  = 0;
; genAssign
	clrw	x
	ldw	(0x2b, sp), x
;	./src/main.c: 110: uint16_t senzorposledni1 = 0;
; genAssign
	clr	(0x38, sp)
;	./src/main.c: 112: uint16_t senzorposledni2 = 0;
; genAssign
	clr	(0x2d, sp)
;	./src/main.c: 114: uint16_t vstup_ted = 0;
; genAssign
	clrw	x
	ldw	(0x2e, sp), x
;	./src/main.c: 115: uint16_t vstup_pred = 0;
; genAssign
	clrw	x
	ldw	(0x30, sp), x
;	./src/main.c: 116: uint16_t vystup_ted = 0;
; genAssign
	clrw	x
	ldw	(0x32, sp), x
;	./src/main.c: 117: uint16_t vystup_pred = 0;
; genAssign
	clrw	x
	ldw	(0x34, sp), x
;	./src/main.c: 123: lcd_init();
; genCall
	call	_lcd_init
;	./src/main.c: 124: lcd_gotoxy(0,0);
; genIPush
	push	#0x00
; genSend
	clr	a
; genCall
	call	_lcd_gotoxy
;	./src/main.c: 125: sprintf(text,"vstupy  =   %u",(uint16_t)vstup_ted);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	clrw	x
	pushw	x
; genIPush
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
; genIPush
	ldw	x, sp
	addw	x, #5
	pushw	x
; genCall
	call	_sprintf
	addw	sp, #6
;	./src/main.c: 126: lcd_puts(text);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genSend
	ldw	x, sp
	incw	x
; genCall
	call	_lcd_puts
;	./src/main.c: 128: lcd_gotoxy(0,1);
; genIPush
	push	#0x01
; genSend
	clr	a
; genCall
	call	_lcd_gotoxy
;	./src/main.c: 129: sprintf(text2,"vystupy =   %u",(uint16_t)vystup_ted);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	clrw	x
	pushw	x
; genIPush
	push	#<(___str_1+0)
	push	#((___str_1+0) >> 8)
; genIPush
	ldw	x, sp
	addw	x, #25
	pushw	x
; genCall
	call	_sprintf
	addw	sp, #6
;	./src/main.c: 130: lcd_puts(text2);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genSend
	ldw	x, sp
	addw	x, #21
; genCall
	call	_lcd_puts
;	./src/main.c: 131: while(1){/*
; genLabel
00126$:
;	./src/main.c: 146: senzorstav1 = GPIO_ReadInputPin(SENZOR1_PORT, SENZOR1_PIN);
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x500a
; genCall
	call	_GPIO_ReadInputPin
; genCast
; genAssign
	ld	(0x36, sp), a
;	./src/main.c: 147: senzorstav2 = GPIO_ReadInputPin(SENZOR2_PORT, SENZOR2_PIN);
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x500a
; genCall
	call	_GPIO_ReadInputPin
; genCast
; genAssign
	ld	(0x37, sp), a
;	./src/main.c: 149: if(senzorstav1 == 0 && senzorposledni1 == 1){
; genCast
; genAssign
	ld	a, (0x38, sp)
; genCmpEQorNE
	dec	a
	jrne	00236$
	ld	a, #0x01
	ld	(0x38, sp), a
	jp	00237$
00236$:
	clr	(0x38, sp)
00237$:
; genIfx
	tnz	(0x36, sp)
	jreq	00238$
	jp	00102$
00238$:
; genIfx
	tnz	(0x38, sp)
	jrne	00239$
	jp	00102$
00239$:
;	./src/main.c: 150: mezivstup += 1;
; genCast
; genAssign
	ldw	x, (0x29, sp)
; genPlus
	incw	x
; genCast
; genAssign
	ldw	(0x29, sp), x
; genLabel
00102$:
; genCast
; genAssign
	ldw	y, (0x29, sp)
	ldw	(0x39, sp), y
;	./src/main.c: 152: if(senzorstav2 == 0 && senzorposledni2 == 1 && mezivstup == 1){
; genCast
; genAssign
	ld	a, (0x2d, sp)
; genCmpEQorNE
	dec	a
	jrne	00241$
	ld	a, #0x01
	jp	00242$
00241$:
	clr	a
00242$:
; genIfx
	tnz	(0x37, sp)
	jreq	00243$
	jp	00105$
00243$:
; genIfx
	tnz	a
	jrne	00244$
	jp	00105$
00244$:
; genCmpEQorNE
	ldw	x, (0x39, sp)
	decw	x
	jrne	00246$
	jp	00247$
00246$:
	jp	00105$
00247$:
; skipping generated iCode
;	./src/main.c: 153: vstup_ted += 1;
; genCast
; genAssign
	ldw	x, (0x2e, sp)
; genPlus
	incw	x
; genCast
; genAssign
	ldw	(0x2e, sp), x
; genLabel
00105$:
;	./src/main.c: 156: if(senzorstav2 == 0 && senzorposledni2 == 1){
; genIfx
	tnz	(0x37, sp)
	jreq	00248$
	jp	00109$
00248$:
; genIfx
	tnz	a
	jrne	00249$
	jp	00109$
00249$:
;	./src/main.c: 157: mezivystup += 1;
; genCast
; genAssign
	ldw	x, (0x2b, sp)
; genPlus
	incw	x
; genCast
; genAssign
	ldw	(0x2b, sp), x
; genLabel
00109$:
; genCast
; genAssign
	ldw	y, (0x2b, sp)
	ldw	(0x3b, sp), y
;	./src/main.c: 159: if(senzorstav1 == 0 && senzorposledni1 == 1 && mezivystup == 1){
; genIfx
	tnz	(0x36, sp)
	jreq	00250$
	jp	00112$
00250$:
; genIfx
	tnz	(0x38, sp)
	jrne	00251$
	jp	00112$
00251$:
; genCmpEQorNE
	ldw	x, (0x3b, sp)
	decw	x
	jrne	00253$
	jp	00254$
00253$:
	jp	00112$
00254$:
; skipping generated iCode
;	./src/main.c: 160: vystup_ted += 1;
; genCast
; genAssign
	ldw	x, (0x32, sp)
; genPlus
	incw	x
; genCast
; genAssign
	ldw	(0x32, sp), x
; genLabel
00112$:
;	./src/main.c: 163: senzorposledni1 = senzorstav1;
; genCast
; genAssign
	ld	a, (0x36, sp)
	ld	(0x38, sp), a
;	./src/main.c: 164: senzorposledni2 = senzorstav2;
; genCast
; genAssign
	ld	a, (0x37, sp)
	ld	(0x2d, sp), a
;	./src/main.c: 166: if(mezivstup==2){
; genCmpEQorNE
	ldw	x, (0x39, sp)
	cpw	x, #0x0002
	jrne	00256$
	jp	00257$
00256$:
	jp	00118$
00257$:
; skipping generated iCode
;	./src/main.c: 167: mezivstup = 0;
; genAssign
	clrw	x
	ldw	(0x29, sp), x
; genGoto
	jp	00119$
; genLabel
00118$:
;	./src/main.c: 168: }else if(mezivystup==2){
; genCmpEQorNE
	ldw	x, (0x3b, sp)
	cpw	x, #0x0002
	jrne	00259$
	jp	00260$
00259$:
	jp	00119$
00260$:
; skipping generated iCode
;	./src/main.c: 169: mezivystup = 0;
; genAssign
	clrw	x
	ldw	(0x2b, sp), x
; genLabel
00119$:
;	./src/main.c: 172: if(vstup_ted > vstup_pred){
; genCmp
; genCmpTnz
	ldw	x, (0x2e, sp)
	cpw	x, (0x30, sp)
	jrugt	00261$
	jp	00123$
00261$:
; skipping generated iCode
;	./src/main.c: 173: mezivstup = 0;
; genAssign
	clrw	x
	ldw	(0x29, sp), x
;	./src/main.c: 174: mezivystup = 0;
; genAssign
	clrw	x
	ldw	(0x2b, sp), x
;	./src/main.c: 175: vstup_pred = vstup_ted;
; genAssign
	ldw	y, (0x2e, sp)
	ldw	(0x30, sp), y
;	./src/main.c: 176: lcd_gotoxy(0,0);
; genIPush
	push	#0x00
; genSend
	clr	a
; genCall
	call	_lcd_gotoxy
;	./src/main.c: 177: sprintf(text,"vstupy  =   %u",(uint16_t)vstup_ted);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	ldw	x, (0x2e, sp)
	pushw	x
; genIPush
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
; genIPush
	ldw	x, sp
	addw	x, #5
	pushw	x
; genCall
	call	_sprintf
	addw	sp, #6
;	./src/main.c: 178: lcd_puts(text);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genSend
	ldw	x, sp
	incw	x
; genCall
	call	_lcd_puts
;	./src/main.c: 179: zvuk_vstup();
; genCall
	call	_zvuk_vstup
; genGoto
	jp	00126$
; genLabel
00123$:
;	./src/main.c: 180: }else if(vystup_ted > vystup_pred){
; genCmp
; genCmpTnz
	ldw	x, (0x32, sp)
	cpw	x, (0x34, sp)
	jrugt	00262$
	jp	00126$
00262$:
; skipping generated iCode
;	./src/main.c: 181: mezivystup = 0;
; genAssign
	clrw	x
	ldw	(0x2b, sp), x
;	./src/main.c: 182: mezivstup = 0;
; genAssign
	clrw	x
	ldw	(0x29, sp), x
;	./src/main.c: 183: vystup_pred = vystup_ted;
; genAssign
	ldw	y, (0x32, sp)
	ldw	(0x34, sp), y
;	./src/main.c: 184: lcd_gotoxy(0,1);
; genIPush
	push	#0x01
; genSend
	clr	a
; genCall
	call	_lcd_gotoxy
;	./src/main.c: 185: sprintf(text2,"vystupy =   %u",(uint16_t)vystup_ted);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	ldw	x, (0x32, sp)
	pushw	x
; genIPush
	push	#<(___str_1+0)
	push	#((___str_1+0) >> 8)
; genIPush
	ldw	x, sp
	addw	x, #25
	pushw	x
; genCall
	call	_sprintf
	addw	sp, #6
;	./src/main.c: 186: lcd_puts(text2);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genSend
	ldw	x, sp
	addw	x, #21
; genCall
	call	_lcd_puts
;	./src/main.c: 187: zvuk_vystup();
; genCall
	call	_zvuk_vystup
; genGoto
	jp	00126$
; genLabel
00128$:
;	./src/main.c: 190: }
; genEndFunction
	addw	sp, #60
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "vstupy  =   %u"
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "vystupy =   %u"
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
