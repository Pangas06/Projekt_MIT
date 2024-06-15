;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module stm8_LCD
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _GPIO_ReadInputPin
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _lcd_store_symbol
	.globl _lcd_puts
	.globl _lcd_init
	.globl _lcd_gotoxy
	.globl _lcd_init_hw
	.globl _lcd_bus_outputs
	.globl _lcd_bus_inputs
	.globl _lcd_deinit_hw
	.globl _lcd_bus_set
	.globl _lcd_bus_read
	.globl _lcd_e_tick
	.globl _lcd_command
	.globl _lcd_data
	.globl _lcd_read
	.globl _lcd_bus_sleep
	.globl _lcd_bus_wakeup
	.globl _lcd_busy_wait
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	inc/delay.h: 14: static inline void _delay_cycl( unsigned short __ticks )
; genLabel
;	-----------------------------------------
;	 function _delay_cycl
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
__delay_cycl:
; genReceive
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00121$
	jp	00101$
00121$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
; genLabel
00104$:
;	inc/delay.h: 37: }
; genEndFunction
	ret
;	inc/delay.h: 39: static inline void _delay_us( const unsigned short __us )
; genLabel
;	-----------------------------------------
;	 function _delay_us
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 0 bytes.
__delay_us:
; genReceive
;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
; genCast
; genAssign
	clrw	y
; genIPush
	pushw	x
	pushw	y
; genIPush
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
; genCall
	call	__mullong
	addw	sp, #8
; genCast
; genAssign
; genIPush
	push	#0x40
	push	#0x42
	push	#0x0f
	push	#0x00
; genIPush
	pushw	x
	pushw	y
; genCall
	call	__divulong
	addw	sp, #8
; genMinus
	subw	x, #0x0005
	jrnc	00122$
	decw	y
00122$:
; genIPush
	push	#0x05
	push	#0x00
	push	#0x00
	push	#0x00
; genIPush
	pushw	x
	pushw	y
; genCall
	call	__divulong
	addw	sp, #8
; genCast
; genAssign
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00123$
	jp	00101$
00123$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
; genLabel
00105$:
;	inc/delay.h: 42: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 11: void lcd_store_symbol(uint8_t pos, uint8_t* charmap){
; genLabel
;	-----------------------------------------
;	 function lcd_store_symbol
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 3 bytes.
_lcd_store_symbol:
	sub	sp, #3
; genReceive
; genReceive
	ldw	(0x01, sp), x
;	./src/stm8_LCD.c: 13: if(pos>7) return;
; genCmp
; genCmpTnz
	cp	a, #0x07
	jrugt	00130$
	jp	00102$
00130$:
; skipping generated iCode
; genReturn
	jp	00106$
; genLabel
00102$:
;	./src/stm8_LCD.c: 14: lcd_command(LCD_SET_CGRAM | pos);
; genOr
	or	a, #0x40
; genSend
; genCall
	call	_lcd_command
;	./src/stm8_LCD.c: 15: for(i=0;i<8;i++){
; genAssign
	clr	(0x03, sp)
; genLabel
00104$:
;	./src/stm8_LCD.c: 16: lcd_data(charmap[i]);
; genPlus
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x01, sp)
; genPointerGet
	ld	a, (x)
; genSend
; genCall
	call	_lcd_data
;	./src/stm8_LCD.c: 15: for(i=0;i<8;i++){
; genPlus
	inc	(0x03, sp)
; genCmp
; genCmpTnz
	ld	a, (0x03, sp)
	cp	a, #0x08
	jrnc	00131$
	jp	00104$
00131$:
; skipping generated iCode
;	./src/stm8_LCD.c: 18: lcd_command(LCD_SET_DDRAM | 0); // other funtions (like lcd_puts) relies that address counter points into DDRAM
; genSend
	ld	a, #0x80
; genCall
	addw	sp, #3
	jp	_lcd_command
; genLabel
00106$:
;	./src/stm8_LCD.c: 19: }
; genEndFunction
	addw	sp, #3
	ret
;	./src/stm8_LCD.c: 23: void lcd_puts(char* text){
; genLabel
;	-----------------------------------------
;	 function lcd_puts
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_puts:
; genReceive
;	./src/stm8_LCD.c: 24: while(*text){
; genLabel
00101$:
; genPointerGet
	ld	a, (x)
; genIfx
	tnz	a
	jrne	00121$
	jp	00104$
00121$:
;	./src/stm8_LCD.c: 25: lcd_data(*text);
; genSend
	pushw	x
; genCall
	call	_lcd_data
	popw	x
;	./src/stm8_LCD.c: 26: text++;
; genPlus
	incw	x
; genGoto
	jp	00101$
; genLabel
00104$:
;	./src/stm8_LCD.c: 28: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 30: void lcd_init(void){
; genLabel
;	-----------------------------------------
;	 function lcd_init
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_init:
;	./src/stm8_LCD.c: 31: lcd_init_hw();
; genCall
	call	_lcd_init_hw
;	./src/stm8_LCD.c: 33: lcd_bus_outputs();
; genCall
	call	_lcd_bus_outputs
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x02f2
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00183$
	jp	00101$
00183$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 36: lcd_bus_set(0b0011);
; genSend
	ld	a, #0x03
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 37: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x00ea
; genLabel
00106$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00184$
	jp	00106$
00184$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 40: lcd_bus_set(0b0011);
; genSend
	ld	a, #0x03
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 41: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x013f
; genLabel
00111$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00185$
	jp	00111$
00185$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 44: lcd_bus_set(0b0011);
; genSend
	ld	a, #0x03
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 45: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	./src/stm8_LCD.c: 46: lcd_bus_set(0b0010);
; genSend
	ld	a, #0x02
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 47: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x007f
; genLabel
00116$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00186$
	jp	00116$
00186$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 53: lcd_command(LCD_FUNCTION_SET | LCD_4BITS | LCD_2LINES | USED_FONT);
; genSend
	ld	a, #0x28
; genCall
	call	_lcd_command
;	./src/stm8_LCD.c: 55: lcd_command(LCD_ENTRY_MODE_SET | LCD_INCREMENT | LCD_DISPLAY_NOSHIFT);
; genSend
	ld	a, #0x06
; genCall
	call	_lcd_command
;	./src/stm8_LCD.c: 56: lcd_command(LCD_DISPLAY_ONOFF | LCD_ON | LCD_CURSOR_OFF | LCD_BLINK_OFF);
; genSend
	ld	a, #0x0c
; genCall
	call	_lcd_command
;	./src/stm8_LCD.c: 57: lcd_command(LCD_CURSOR_OR_DISPLAY_SHIFT | LCD_CURSOR_SHIFT | LCD_SHIFT_RIGHT);
; genSend
	ld	a, #0x14
; genCall
	call	_lcd_command
;	./src/stm8_LCD.c: 58: lcd_command(LCD_DISPLAY_CLEAR);
; genSend
	ld	a, #0x01
; genCall
	call	_lcd_command
;	./src/stm8_LCD.c: 59: lcd_command(LCD_RETURN_HOME);
; genSend
	ld	a, #0x02
; genCall
	jp	_lcd_command
; genLabel
00121$:
;	./src/stm8_LCD.c: 60: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 62: void lcd_gotoxy(uint8_t column, uint8_t line){
; genLabel
;	-----------------------------------------
;	 function lcd_gotoxy
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_gotoxy:
; genReceive
;	./src/stm8_LCD.c: 63: uint8_t tmp=0;
; genAssign
	clrw	x
;	./src/stm8_LCD.c: 75: if(column > (LCD_COLUMNS-1)){column=LCD_COLUMNS-1;}
; genCmp
; genCmpTnz
	cp	a, #0x0f
	jrugt	00131$
	jp	00102$
00131$:
; skipping generated iCode
; genAssign
	ld	a, #0x0f
; genLabel
00102$:
;	./src/stm8_LCD.c: 76: if(line == 0){tmp=0x00;}
; genIfx
	tnz	(0x03, sp)
	jreq	00132$
	jp	00106$
00132$:
; genAssign
	clrw	x
; genGoto
	jp	00107$
; genLabel
00106$:
;	./src/stm8_LCD.c: 77: else if(line==1){tmp = 0x40;}
; genCmpEQorNE
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00134$
	jp	00135$
00134$:
	jp	00107$
00135$:
; skipping generated iCode
; genAssign
	exg	a, xl
	ld	a, #0x40
	exg	a, xl
; genLabel
00107$:
;	./src/stm8_LCD.c: 78: tmp = tmp + column;
; genPlus
	pushw	x
	add	a, (2, sp)
	popw	x
;	./src/stm8_LCD.c: 85: lcd_command(LCD_SET_DDRAM | tmp);
; genOr
	or	a, #0x80
; genSend
; genCall
	call	_lcd_command
; genLabel
00108$:
;	./src/stm8_LCD.c: 86: }
; genEndFunction
	popw	x
	pop	a
	jp	(x)
;	./src/stm8_LCD.c: 89: void lcd_init_hw(void){
; genLabel
;	-----------------------------------------
;	 function lcd_init_hw
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_init_hw:
;	./src/stm8_LCD.c: 105: GPIO_Init(LCD_RS_PORT,LCD_RS_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 106: GPIO_Init(LCD_RW_PORT,LCD_RW_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 107: GPIO_Init(LCD_E_PORT,LCD_E_PIN,GPIO_MODE_OUT_PP_HIGH_SLOW);
; genIPush
	push	#0xd0
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 110: lcd_bus_outputs();
; genCall
	jp	_lcd_bus_outputs
; genLabel
00101$:
;	./src/stm8_LCD.c: 111: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 114: void lcd_bus_outputs(void){
; genLabel
;	-----------------------------------------
;	 function lcd_bus_outputs
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_bus_outputs:
;	./src/stm8_LCD.c: 118: GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 119: GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 120: GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 121: GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
; genIPush
	push	#0xc0
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
; genLabel
00101$:
;	./src/stm8_LCD.c: 123: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 126: void lcd_bus_inputs(void){
; genLabel
;	-----------------------------------------
;	 function lcd_bus_inputs
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_bus_inputs:
;	./src/stm8_LCD.c: 134: GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 135: GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 136: GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 137: GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_IN_FL_NO_IT); 
; genIPush
	push	#0x00
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
; genLabel
00101$:
;	./src/stm8_LCD.c: 139: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 142: void lcd_deinit_hw(void){
; genLabel
;	-----------------------------------------
;	 function lcd_deinit_hw
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_deinit_hw:
;	./src/stm8_LCD.c: 143: GPIO_Init(LCD_RS_PORT,LCD_RS_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 144: GPIO_Init(LCD_RW_PORT,LCD_RW_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 145: GPIO_Init(LCD_E_PORT,LCD_E_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 146: GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 147: GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 148: GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_IN_FL_NO_IT);
; genIPush
	push	#0x00
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
;	./src/stm8_LCD.c: 149: GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_IN_FL_NO_IT); 
; genIPush
	push	#0x00
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_Init
; genLabel
00101$:
;	./src/stm8_LCD.c: 150: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 153: void lcd_bus_set(uint8_t data){
; genLabel
;	-----------------------------------------
;	 function lcd_bus_set
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_lcd_bus_set:
	push	a
; genReceive
	ld	(0x01, sp), a
;	./src/stm8_LCD.c: 154: if(data & (1<<0)){LCD_D4_H;}else{LCD_D4_L;}
; genAnd
	ld	a, (0x01, sp)
	srl	a
	jrc	00143$
	jp	00102$
00143$:
; skipping generated iCode
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
; genGoto
	jp	00103$
; genLabel
00102$:
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteLow
; genLabel
00103$:
;	./src/stm8_LCD.c: 155: if(data & (1<<1)){LCD_D5_H;}else{LCD_D5_L;}
; genAnd
	ld	a, (0x01, sp)
	bcp	a, #0x02
	jrne	00144$
	jp	00105$
00144$:
; skipping generated iCode
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
; genGoto
	jp	00106$
; genLabel
00105$:
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteLow
; genLabel
00106$:
;	./src/stm8_LCD.c: 156: if(data & (1<<2)){LCD_D6_H;}else{LCD_D6_L;}
; genAnd
	ld	a, (0x01, sp)
	bcp	a, #0x04
	jrne	00145$
	jp	00108$
00145$:
; skipping generated iCode
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
; genGoto
	jp	00109$
; genLabel
00108$:
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteLow
; genLabel
00109$:
;	./src/stm8_LCD.c: 157: if(data & (1<<3)){LCD_D7_H;}else{LCD_D7_L;}
; genAnd
	ld	a, (0x01, sp)
	bcp	a, #0x08
	jrne	00146$
	jp	00111$
00146$:
; skipping generated iCode
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	addw	sp, #1
	jp	_GPIO_WriteHigh
; genGoto
	jp	00113$
; genLabel
00111$:
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	addw	sp, #1
	jp	_GPIO_WriteLow
; genLabel
00113$:
;	./src/stm8_LCD.c: 158: }
; genEndFunction
	pop	a
	ret
;	./src/stm8_LCD.c: 161: uint8_t lcd_bus_read(void){
; genLabel
;	-----------------------------------------
;	 function lcd_bus_read
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_lcd_bus_read:
	push	a
;	./src/stm8_LCD.c: 162: uint8_t tmp=0;
; genAssign
	clr	(0x01, sp)
;	./src/stm8_LCD.c: 163: if(GPIO_ReadInputPin(LCD_D4_PORT,LCD_D4_PIN)){tmp |= 1<<0;}
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_ReadInputPin
; genIfx
	tnz	a
	jrne	00139$
	jp	00102$
00139$:
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
; genLabel
00102$:
;	./src/stm8_LCD.c: 164: if(GPIO_ReadInputPin(LCD_D5_PORT,LCD_D5_PIN)){tmp |= 1<<1;}
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_ReadInputPin
; genIfx
	tnz	a
	jrne	00140$
	jp	00104$
00140$:
; genOr
	ld	a, (0x01, sp)
	or	a, #0x02
	ld	(0x01, sp), a
; genLabel
00104$:
;	./src/stm8_LCD.c: 165: if(GPIO_ReadInputPin(LCD_D6_PORT,LCD_D6_PIN)){tmp |= 1<<2;}
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_ReadInputPin
; genIfx
	tnz	a
	jrne	00141$
	jp	00106$
00141$:
; genOr
	ld	a, (0x01, sp)
	or	a, #0x04
	ld	(0x01, sp), a
; genLabel
00106$:
;	./src/stm8_LCD.c: 166: if(GPIO_ReadInputPin(LCD_D7_PORT,LCD_D7_PIN)){tmp |= 1<<3;}
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_ReadInputPin
; genIfx
	tnz	a
	jrne	00142$
	jp	00108$
00142$:
; genOr
	ld	a, (0x01, sp)
	or	a, #0x08
	ld	(0x01, sp), a
; genLabel
00108$:
;	./src/stm8_LCD.c: 167: return tmp;
; genReturn
	ld	a, (0x01, sp)
; genLabel
00109$:
;	./src/stm8_LCD.c: 168: }
; genEndFunction
	addw	sp, #1
	ret
;	./src/stm8_LCD.c: 171: void lcd_e_tick(void){
; genLabel
;	-----------------------------------------
;	 function lcd_e_tick
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_e_tick:
;	./src/stm8_LCD.c: 172: LCD_E_H;
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00143$
	jp	00101$
00143$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 174: LCD_E_L;
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00106$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00144$
	jp	00106$
00144$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 175: _delay_us(LCD_E_DELAY);
; genLabel
00111$:
;	./src/stm8_LCD.c: 176: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 179: void lcd_command(uint8_t command){
; genLabel
;	-----------------------------------------
;	 function lcd_command
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_lcd_command:
	push	a
; genReceive
	ld	(0x01, sp), a
;	./src/stm8_LCD.c: 180: LCD_RS_L;
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00123$
	jp	00101$
00123$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 182: lcd_bus_set((command >> 4) & 0b1111);
; genRightShiftLiteral
	ld	a, (0x01, sp)
	swap	a
	and	a, #0x0f
; genAnd
	and	a, #0x0f
; genSend
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 183: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	./src/stm8_LCD.c: 184: lcd_bus_set(command & 0b1111);
; genAnd
	ld	a, (0x01, sp)
	and	a, #0x0f
; genSend
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 185: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	./src/stm8_LCD.c: 186: lcd_busy_wait();
; genCall
	pop	a
	jp	_lcd_busy_wait
; genLabel
00106$:
;	./src/stm8_LCD.c: 187: }
; genEndFunction
	pop	a
	ret
;	./src/stm8_LCD.c: 190: void lcd_data(uint8_t data){
; genLabel
;	-----------------------------------------
;	 function lcd_data
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_lcd_data:
	push	a
; genReceive
	ld	(0x01, sp), a
;	./src/stm8_LCD.c: 191: LCD_RS_H;
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00123$
	jp	00101$
00123$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 193: lcd_bus_set((data >> 4) & 0b1111);
; genRightShiftLiteral
	ld	a, (0x01, sp)
	swap	a
	and	a, #0x0f
; genAnd
	and	a, #0x0f
; genSend
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 194: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	./src/stm8_LCD.c: 195: lcd_bus_set(data & 0b1111);
; genAnd
	ld	a, (0x01, sp)
	and	a, #0x0f
; genSend
; genCall
	call	_lcd_bus_set
;	./src/stm8_LCD.c: 196: lcd_e_tick();
; genCall
	call	_lcd_e_tick
;	./src/stm8_LCD.c: 197: lcd_busy_wait();
; genCall
	pop	a
	jp	_lcd_busy_wait
; genLabel
00106$:
;	./src/stm8_LCD.c: 198: }
; genEndFunction
	pop	a
	ret
;	./src/stm8_LCD.c: 201: uint8_t lcd_read(void){
; genLabel
;	-----------------------------------------
;	 function lcd_read
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_lcd_read:
	push	a
;	./src/stm8_LCD.c: 203: LCD_RS_L;
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	./src/stm8_LCD.c: 204: lcd_bus_inputs();
; genCall
	call	_lcd_bus_inputs
;	./src/stm8_LCD.c: 205: LCD_RW_H;
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00101$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00203$
	jp	00101$
00203$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 207: LCD_E_H;
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00106$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00204$
	jp	00106$
00204$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 209: tmp = lcd_bus_read()<<4;
; genCall
	call	_lcd_bus_read
; genCast
; genAssign
; genLeftShiftLiteral
	swap	a
	and	a, #0xf0
	ld	(0x01, sp), a
;	./src/stm8_LCD.c: 210: LCD_E_L;
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00111$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00205$
	jp	00111$
00205$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 212: LCD_E_H;
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00116$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00206$
	jp	00116$
00206$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 214: tmp |= lcd_bus_read();
; genCall
	call	_lcd_bus_read
; genOr
	or	a, (0x01, sp)
	ld	(0x01, sp), a
;	./src/stm8_LCD.c: 215: LCD_E_L;
; genSend
	ld	a, #0x20
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0002
; genLabel
00121$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00207$
	jp	00121$
00207$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/stm8_LCD.c: 217: LCD_RW_L;
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	./src/stm8_LCD.c: 218: lcd_bus_outputs();
; genCall
	call	_lcd_bus_outputs
;	./src/stm8_LCD.c: 219: return tmp;
; genReturn
	ld	a, (0x01, sp)
; genLabel
00126$:
;	./src/stm8_LCD.c: 220: }
; genEndFunction
	addw	sp, #1
	ret
;	./src/stm8_LCD.c: 224: void lcd_bus_sleep(void){
; genLabel
;	-----------------------------------------
;	 function lcd_bus_sleep
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_bus_sleep:
;	./src/stm8_LCD.c: 225: LCD_RS_H;
; genSend
	ld	a, #0x80
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	./src/stm8_LCD.c: 226: LCD_RW_H;
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteHigh
;	./src/stm8_LCD.c: 227: lcd_bus_inputs();
; genCall
	jp	_lcd_bus_inputs
; genLabel
00101$:
;	./src/stm8_LCD.c: 228: }
; genEndFunction
	ret
;	./src/stm8_LCD.c: 231: void lcd_bus_wakeup(void){
; genLabel
;	-----------------------------------------
;	 function lcd_bus_wakeup
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_bus_wakeup:
;	./src/stm8_LCD.c: 232: LCD_RW_L;
; genSend
	ld	a, #0x40
; genSend
	ldw	x, #0x5019
; genCall
	call	_GPIO_WriteLow
;	./src/stm8_LCD.c: 233: LCD_D4_H;
; genSend
	ld	a, #0x01
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
;	./src/stm8_LCD.c: 234: LCD_D5_H;
; genSend
	ld	a, #0x02
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
;	./src/stm8_LCD.c: 235: LCD_D6_H;
; genSend
	ld	a, #0x04
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
;	./src/stm8_LCD.c: 236: LCD_D7_H;
; genSend
	ld	a, #0x08
; genSend
	ldw	x, #0x501e
; genCall
	call	_GPIO_WriteHigh
;	./src/stm8_LCD.c: 237: lcd_bus_outputs();
; genCall
	jp	_lcd_bus_outputs
; genLabel
00101$:
;	./src/stm8_LCD.c: 238: }	
; genEndFunction
	ret
;	./src/stm8_LCD.c: 241: uint8_t lcd_busy_wait(void){
; genLabel
;	-----------------------------------------
;	 function lcd_busy_wait
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_lcd_busy_wait:
;	./src/stm8_LCD.c: 243: while(timeout && lcd_busy()){
; genAssign
	ldw	x, #0x01f4
; genLabel
00102$:
; genIfx
	tnzw	x
	jrne	00139$
	jp	00114$
00139$:
; genCall
	pushw	x
	call	_lcd_read
	popw	x
; genAnd
	tnz	a
	jrmi	00140$
	jp	00114$
00140$:
; skipping generated iCode
;	./src/stm8_LCD.c: 244: timeout--;
; genMinus
	decw	x
; genGoto
	jp	00102$
; genLabel
00114$:
; genAssign
;	./src/stm8_LCD.c: 246: if(timeout==0){return 1;} // error, busy still ==1
; genIfx
	tnzw	x
	jreq	00141$
	jp	00106$
00141$:
; genReturn
	ld	a, #0x01
	jp	00108$
; genLabel
00106$:
;	./src/stm8_LCD.c: 247: else{return 0;}
; genReturn
	clr	a
; genLabel
00108$:
;	./src/stm8_LCD.c: 248: }
; genEndFunction
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
