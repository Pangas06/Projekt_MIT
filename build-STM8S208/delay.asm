;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module delay
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _delay_ms
	.globl _delay_us
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
;	./src/delay.c: 4: void delay_us(uint8_t us)
; genLabel
;	-----------------------------------------
;	 function delay_us
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 4 bytes.
_delay_us:
	sub	sp, #4
; genReceive
;	./src/delay.c: 6: _delay_us(us);
; genCast
; genAssign
;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
; genCast
; genAssign
	clrw	x
	clr	(0x01, sp)
; genIPush
	push	a
	pushw	x
	clr	a
	push	a
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
	jrnc	00123$
	decw	y
00123$:
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
	jreq	00124$
	jp	00101$
00124$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/delay.c: 6: _delay_us(us);
; genLabel
00106$:
;	./src/delay.c: 7: }
; genEndFunction
	addw	sp, #4
	ret
;	./src/delay.c: 9: void delay_ms(uint16_t ms)
; genLabel
;	-----------------------------------------
;	 function delay_ms
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 2 bytes.
_delay_ms:
	pushw	x
; genReceive
	ldw	(0x01, sp), x
;	./src/delay.c: 11: for (int16_t i = 0; i < ms; i++) {
; genAssign
	clrw	y
; genLabel
00123$:
; genCast
; genAssign
	ldw	x, y
; genCmp
; genCmpTnz
	cpw	x, (0x01, sp)
	jrc	00202$
	jp	00125$
00202$:
; skipping generated iCode
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x031f
; genLabel
00102$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00203$
	jp	00102$
00203$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x031f
; genLabel
00107$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00204$
	jp	00107$
00204$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x031f
; genLabel
00112$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00205$
	jp	00112$
00205$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
;	genInline
	nop
	nop
;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
; genAssign
	ldw	x, #0x0308
; genLabel
00117$:
;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
; genMinus
	decw	x
;	inc/delay.h: 26: } while ( __ticks );
; genIfx
	tnzw	x
	jreq	00206$
	jp	00117$
00206$:
;	inc/delay.h: 27: __asm__("nop\n");
;	genInline
	nop
;	./src/delay.c: 11: for (int16_t i = 0; i < ms; i++) {
; genPlus
	incw	y
; genGoto
	jp	00123$
; genLabel
00125$:
;	./src/delay.c: 17: }
; genEndFunction
	popw	x
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
