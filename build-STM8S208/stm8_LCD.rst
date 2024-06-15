                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_LCD
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _GPIO_ReadInputPin
                                     12 	.globl _GPIO_WriteLow
                                     13 	.globl _GPIO_WriteHigh
                                     14 	.globl _GPIO_Init
                                     15 	.globl _lcd_store_symbol
                                     16 	.globl _lcd_puts
                                     17 	.globl _lcd_init
                                     18 	.globl _lcd_gotoxy
                                     19 	.globl _lcd_init_hw
                                     20 	.globl _lcd_bus_outputs
                                     21 	.globl _lcd_bus_inputs
                                     22 	.globl _lcd_deinit_hw
                                     23 	.globl _lcd_bus_set
                                     24 	.globl _lcd_bus_read
                                     25 	.globl _lcd_e_tick
                                     26 	.globl _lcd_command
                                     27 	.globl _lcd_data
                                     28 	.globl _lcd_read
                                     29 	.globl _lcd_bus_sleep
                                     30 	.globl _lcd_bus_wakeup
                                     31 	.globl _lcd_busy_wait
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DATA
                                     36 ;--------------------------------------------------------
                                     37 ; ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area INITIALIZED
                                     40 ;--------------------------------------------------------
                                     41 ; absolute external ram data
                                     42 ;--------------------------------------------------------
                                     43 	.area DABS (ABS)
                                     44 
                                     45 ; default segment ordering for linker
                                     46 	.area HOME
                                     47 	.area GSINIT
                                     48 	.area GSFINAL
                                     49 	.area CONST
                                     50 	.area INITIALIZER
                                     51 	.area CODE
                                     52 
                                     53 ;--------------------------------------------------------
                                     54 ; global & static initialisations
                                     55 ;--------------------------------------------------------
                                     56 	.area HOME
                                     57 	.area GSINIT
                                     58 	.area GSFINAL
                                     59 	.area GSINIT
                                     60 ;--------------------------------------------------------
                                     61 ; Home
                                     62 ;--------------------------------------------------------
                                     63 	.area HOME
                                     64 	.area HOME
                                     65 ;--------------------------------------------------------
                                     66 ; code
                                     67 ;--------------------------------------------------------
                                     68 	.area CODE
                                     69 ;	inc/delay.h: 14: static inline void _delay_cycl( unsigned short __ticks )
                                     70 ; genLabel
                                     71 ;	-----------------------------------------
                                     72 ;	 function _delay_cycl
                                     73 ;	-----------------------------------------
                                     74 ;	Register assignment is optimal.
                                     75 ;	Stack space usage: 0 bytes.
      0085A3                         76 __delay_cycl:
                                     77 ; genReceive
                                     78 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                     79 ;	genInline
      0085A3 9D               [ 1]   80 	nop
      0085A4 9D               [ 1]   81 	nop
                                     82 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                     83 ; genAssign
                                     84 ; genLabel
      0085A5                         85 00101$:
                                     86 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                     87 ; genMinus
      0085A5 5A               [ 2]   88 	decw	x
                                     89 ;	inc/delay.h: 26: } while ( __ticks );
                                     90 ; genIfx
      0085A6 5D               [ 2]   91 	tnzw	x
      0085A7 27 03            [ 1]   92 	jreq	00121$
      0085A9 CC 85 A5         [ 2]   93 	jp	00101$
      0085AC                         94 00121$:
                                     95 ;	inc/delay.h: 27: __asm__("nop\n");
                                     96 ;	genInline
      0085AC 9D               [ 1]   97 	nop
                                     98 ; genLabel
      0085AD                         99 00104$:
                                    100 ;	inc/delay.h: 37: }
                                    101 ; genEndFunction
      0085AD 81               [ 4]  102 	ret
                                    103 ;	inc/delay.h: 39: static inline void _delay_us( const unsigned short __us )
                                    104 ; genLabel
                                    105 ;	-----------------------------------------
                                    106 ;	 function _delay_us
                                    107 ;	-----------------------------------------
                                    108 ;	Register assignment might be sub-optimal.
                                    109 ;	Stack space usage: 0 bytes.
      0085AE                        110 __delay_us:
                                    111 ; genReceive
                                    112 ;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
                                    113 ; genCast
                                    114 ; genAssign
      0085AE 90 5F            [ 1]  115 	clrw	y
                                    116 ; genIPush
      0085B0 89               [ 2]  117 	pushw	x
      0085B1 90 89            [ 2]  118 	pushw	y
                                    119 ; genIPush
      0085B3 4B 00            [ 1]  120 	push	#0x00
      0085B5 4B 24            [ 1]  121 	push	#0x24
      0085B7 4B F4            [ 1]  122 	push	#0xf4
      0085B9 4B 00            [ 1]  123 	push	#0x00
                                    124 ; genCall
      0085BB CD 8C D0         [ 4]  125 	call	__mullong
      0085BE 5B 08            [ 2]  126 	addw	sp, #8
                                    127 ; genCast
                                    128 ; genAssign
                                    129 ; genIPush
      0085C0 4B 40            [ 1]  130 	push	#0x40
      0085C2 4B 42            [ 1]  131 	push	#0x42
      0085C4 4B 0F            [ 1]  132 	push	#0x0f
      0085C6 4B 00            [ 1]  133 	push	#0x00
                                    134 ; genIPush
      0085C8 89               [ 2]  135 	pushw	x
      0085C9 90 89            [ 2]  136 	pushw	y
                                    137 ; genCall
      0085CB CD 8B 36         [ 4]  138 	call	__divulong
      0085CE 5B 08            [ 2]  139 	addw	sp, #8
                                    140 ; genMinus
      0085D0 1D 00 05         [ 2]  141 	subw	x, #0x0005
      0085D3 24 02            [ 1]  142 	jrnc	00122$
      0085D5 90 5A            [ 2]  143 	decw	y
      0085D7                        144 00122$:
                                    145 ; genIPush
      0085D7 4B 05            [ 1]  146 	push	#0x05
      0085D9 4B 00            [ 1]  147 	push	#0x00
      0085DB 4B 00            [ 1]  148 	push	#0x00
      0085DD 4B 00            [ 1]  149 	push	#0x00
                                    150 ; genIPush
      0085DF 89               [ 2]  151 	pushw	x
      0085E0 90 89            [ 2]  152 	pushw	y
                                    153 ; genCall
      0085E2 CD 8B 36         [ 4]  154 	call	__divulong
      0085E5 5B 08            [ 2]  155 	addw	sp, #8
                                    156 ; genCast
                                    157 ; genAssign
                                    158 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    159 ;	genInline
      0085E7 9D               [ 1]  160 	nop
      0085E8 9D               [ 1]  161 	nop
                                    162 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    163 ; genAssign
                                    164 ; genLabel
      0085E9                        165 00101$:
                                    166 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    167 ; genMinus
      0085E9 5A               [ 2]  168 	decw	x
                                    169 ;	inc/delay.h: 26: } while ( __ticks );
                                    170 ; genIfx
      0085EA 5D               [ 2]  171 	tnzw	x
      0085EB 27 03            [ 1]  172 	jreq	00123$
      0085ED CC 85 E9         [ 2]  173 	jp	00101$
      0085F0                        174 00123$:
                                    175 ;	inc/delay.h: 27: __asm__("nop\n");
                                    176 ;	genInline
      0085F0 9D               [ 1]  177 	nop
                                    178 ;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
                                    179 ; genLabel
      0085F1                        180 00105$:
                                    181 ;	inc/delay.h: 42: }
                                    182 ; genEndFunction
      0085F1 81               [ 4]  183 	ret
                                    184 ;	./src/stm8_LCD.c: 11: void lcd_store_symbol(uint8_t pos, uint8_t* charmap){
                                    185 ; genLabel
                                    186 ;	-----------------------------------------
                                    187 ;	 function lcd_store_symbol
                                    188 ;	-----------------------------------------
                                    189 ;	Register assignment might be sub-optimal.
                                    190 ;	Stack space usage: 3 bytes.
      0085F2                        191 _lcd_store_symbol:
      0085F2 52 03            [ 2]  192 	sub	sp, #3
                                    193 ; genReceive
                                    194 ; genReceive
      0085F4 1F 01            [ 2]  195 	ldw	(0x01, sp), x
                                    196 ;	./src/stm8_LCD.c: 13: if(pos>7) return;
                                    197 ; genCmp
                                    198 ; genCmpTnz
      0085F6 A1 07            [ 1]  199 	cp	a, #0x07
      0085F8 22 03            [ 1]  200 	jrugt	00130$
      0085FA CC 86 00         [ 2]  201 	jp	00102$
      0085FD                        202 00130$:
                                    203 ; skipping generated iCode
                                    204 ; genReturn
      0085FD CC 86 24         [ 2]  205 	jp	00106$
                                    206 ; genLabel
      008600                        207 00102$:
                                    208 ;	./src/stm8_LCD.c: 14: lcd_command(LCD_SET_CGRAM | pos);
                                    209 ; genOr
      008600 AA 40            [ 1]  210 	or	a, #0x40
                                    211 ; genSend
                                    212 ; genCall
      008602 CD 88 97         [ 4]  213 	call	_lcd_command
                                    214 ;	./src/stm8_LCD.c: 15: for(i=0;i<8;i++){
                                    215 ; genAssign
      008605 0F 03            [ 1]  216 	clr	(0x03, sp)
                                    217 ; genLabel
      008607                        218 00104$:
                                    219 ;	./src/stm8_LCD.c: 16: lcd_data(charmap[i]);
                                    220 ; genPlus
      008607 5F               [ 1]  221 	clrw	x
      008608 7B 03            [ 1]  222 	ld	a, (0x03, sp)
      00860A 97               [ 1]  223 	ld	xl, a
      00860B 72 FB 01         [ 2]  224 	addw	x, (0x01, sp)
                                    225 ; genPointerGet
      00860E F6               [ 1]  226 	ld	a, (x)
                                    227 ; genSend
                                    228 ; genCall
      00860F CD 88 CC         [ 4]  229 	call	_lcd_data
                                    230 ;	./src/stm8_LCD.c: 15: for(i=0;i<8;i++){
                                    231 ; genPlus
      008612 0C 03            [ 1]  232 	inc	(0x03, sp)
                                    233 ; genCmp
                                    234 ; genCmpTnz
      008614 7B 03            [ 1]  235 	ld	a, (0x03, sp)
      008616 A1 08            [ 1]  236 	cp	a, #0x08
      008618 24 03            [ 1]  237 	jrnc	00131$
      00861A CC 86 07         [ 2]  238 	jp	00104$
      00861D                        239 00131$:
                                    240 ; skipping generated iCode
                                    241 ;	./src/stm8_LCD.c: 18: lcd_command(LCD_SET_DDRAM | 0); // other funtions (like lcd_puts) relies that address counter points into DDRAM
                                    242 ; genSend
      00861D A6 80            [ 1]  243 	ld	a, #0x80
                                    244 ; genCall
      00861F 5B 03            [ 2]  245 	addw	sp, #3
      008621 CC 88 97         [ 2]  246 	jp	_lcd_command
                                    247 ; genLabel
      008624                        248 00106$:
                                    249 ;	./src/stm8_LCD.c: 19: }
                                    250 ; genEndFunction
      008624 5B 03            [ 2]  251 	addw	sp, #3
      008626 81               [ 4]  252 	ret
                                    253 ;	./src/stm8_LCD.c: 23: void lcd_puts(char* text){
                                    254 ; genLabel
                                    255 ;	-----------------------------------------
                                    256 ;	 function lcd_puts
                                    257 ;	-----------------------------------------
                                    258 ;	Register assignment is optimal.
                                    259 ;	Stack space usage: 0 bytes.
      008627                        260 _lcd_puts:
                                    261 ; genReceive
                                    262 ;	./src/stm8_LCD.c: 24: while(*text){
                                    263 ; genLabel
      008627                        264 00101$:
                                    265 ; genPointerGet
      008627 F6               [ 1]  266 	ld	a, (x)
                                    267 ; genIfx
      008628 4D               [ 1]  268 	tnz	a
      008629 26 03            [ 1]  269 	jrne	00121$
      00862B CC 86 37         [ 2]  270 	jp	00104$
      00862E                        271 00121$:
                                    272 ;	./src/stm8_LCD.c: 25: lcd_data(*text);
                                    273 ; genSend
      00862E 89               [ 2]  274 	pushw	x
                                    275 ; genCall
      00862F CD 88 CC         [ 4]  276 	call	_lcd_data
      008632 85               [ 2]  277 	popw	x
                                    278 ;	./src/stm8_LCD.c: 26: text++;
                                    279 ; genPlus
      008633 5C               [ 1]  280 	incw	x
                                    281 ; genGoto
      008634 CC 86 27         [ 2]  282 	jp	00101$
                                    283 ; genLabel
      008637                        284 00104$:
                                    285 ;	./src/stm8_LCD.c: 28: }
                                    286 ; genEndFunction
      008637 81               [ 4]  287 	ret
                                    288 ;	./src/stm8_LCD.c: 30: void lcd_init(void){
                                    289 ; genLabel
                                    290 ;	-----------------------------------------
                                    291 ;	 function lcd_init
                                    292 ;	-----------------------------------------
                                    293 ;	Register assignment is optimal.
                                    294 ;	Stack space usage: 0 bytes.
      008638                        295 _lcd_init:
                                    296 ;	./src/stm8_LCD.c: 31: lcd_init_hw();
                                    297 ; genCall
      008638 CD 86 E3         [ 4]  298 	call	_lcd_init_hw
                                    299 ;	./src/stm8_LCD.c: 33: lcd_bus_outputs();
                                    300 ; genCall
      00863B CD 87 05         [ 4]  301 	call	_lcd_bus_outputs
                                    302 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    303 ;	genInline
      00863E 9D               [ 1]  304 	nop
      00863F 9D               [ 1]  305 	nop
                                    306 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    307 ; genAssign
      008640 AE 02 F2         [ 2]  308 	ldw	x, #0x02f2
                                    309 ; genLabel
      008643                        310 00101$:
                                    311 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    312 ; genMinus
      008643 5A               [ 2]  313 	decw	x
                                    314 ;	inc/delay.h: 26: } while ( __ticks );
                                    315 ; genIfx
      008644 5D               [ 2]  316 	tnzw	x
      008645 27 03            [ 1]  317 	jreq	00183$
      008647 CC 86 43         [ 2]  318 	jp	00101$
      00864A                        319 00183$:
                                    320 ;	inc/delay.h: 27: __asm__("nop\n");
                                    321 ;	genInline
      00864A 9D               [ 1]  322 	nop
                                    323 ;	./src/stm8_LCD.c: 36: lcd_bus_set(0b0011);
                                    324 ; genSend
      00864B A6 03            [ 1]  325 	ld	a, #0x03
                                    326 ; genCall
      00864D CD 87 9E         [ 4]  327 	call	_lcd_bus_set
                                    328 ;	./src/stm8_LCD.c: 37: lcd_e_tick();
                                    329 ; genCall
      008650 CD 88 6C         [ 4]  330 	call	_lcd_e_tick
                                    331 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    332 ;	genInline
      008653 9D               [ 1]  333 	nop
      008654 9D               [ 1]  334 	nop
                                    335 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    336 ; genAssign
      008655 AE 00 EA         [ 2]  337 	ldw	x, #0x00ea
                                    338 ; genLabel
      008658                        339 00106$:
                                    340 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    341 ; genMinus
      008658 5A               [ 2]  342 	decw	x
                                    343 ;	inc/delay.h: 26: } while ( __ticks );
                                    344 ; genIfx
      008659 5D               [ 2]  345 	tnzw	x
      00865A 27 03            [ 1]  346 	jreq	00184$
      00865C CC 86 58         [ 2]  347 	jp	00106$
      00865F                        348 00184$:
                                    349 ;	inc/delay.h: 27: __asm__("nop\n");
                                    350 ;	genInline
      00865F 9D               [ 1]  351 	nop
                                    352 ;	./src/stm8_LCD.c: 40: lcd_bus_set(0b0011);
                                    353 ; genSend
      008660 A6 03            [ 1]  354 	ld	a, #0x03
                                    355 ; genCall
      008662 CD 87 9E         [ 4]  356 	call	_lcd_bus_set
                                    357 ;	./src/stm8_LCD.c: 41: lcd_e_tick();
                                    358 ; genCall
      008665 CD 88 6C         [ 4]  359 	call	_lcd_e_tick
                                    360 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    361 ;	genInline
      008668 9D               [ 1]  362 	nop
      008669 9D               [ 1]  363 	nop
                                    364 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    365 ; genAssign
      00866A AE 01 3F         [ 2]  366 	ldw	x, #0x013f
                                    367 ; genLabel
      00866D                        368 00111$:
                                    369 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    370 ; genMinus
      00866D 5A               [ 2]  371 	decw	x
                                    372 ;	inc/delay.h: 26: } while ( __ticks );
                                    373 ; genIfx
      00866E 5D               [ 2]  374 	tnzw	x
      00866F 27 03            [ 1]  375 	jreq	00185$
      008671 CC 86 6D         [ 2]  376 	jp	00111$
      008674                        377 00185$:
                                    378 ;	inc/delay.h: 27: __asm__("nop\n");
                                    379 ;	genInline
      008674 9D               [ 1]  380 	nop
                                    381 ;	./src/stm8_LCD.c: 44: lcd_bus_set(0b0011);
                                    382 ; genSend
      008675 A6 03            [ 1]  383 	ld	a, #0x03
                                    384 ; genCall
      008677 CD 87 9E         [ 4]  385 	call	_lcd_bus_set
                                    386 ;	./src/stm8_LCD.c: 45: lcd_e_tick();
                                    387 ; genCall
      00867A CD 88 6C         [ 4]  388 	call	_lcd_e_tick
                                    389 ;	./src/stm8_LCD.c: 46: lcd_bus_set(0b0010);
                                    390 ; genSend
      00867D A6 02            [ 1]  391 	ld	a, #0x02
                                    392 ; genCall
      00867F CD 87 9E         [ 4]  393 	call	_lcd_bus_set
                                    394 ;	./src/stm8_LCD.c: 47: lcd_e_tick();
                                    395 ; genCall
      008682 CD 88 6C         [ 4]  396 	call	_lcd_e_tick
                                    397 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    398 ;	genInline
      008685 9D               [ 1]  399 	nop
      008686 9D               [ 1]  400 	nop
                                    401 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    402 ; genAssign
      008687 AE 00 7F         [ 2]  403 	ldw	x, #0x007f
                                    404 ; genLabel
      00868A                        405 00116$:
                                    406 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    407 ; genMinus
      00868A 5A               [ 2]  408 	decw	x
                                    409 ;	inc/delay.h: 26: } while ( __ticks );
                                    410 ; genIfx
      00868B 5D               [ 2]  411 	tnzw	x
      00868C 27 03            [ 1]  412 	jreq	00186$
      00868E CC 86 8A         [ 2]  413 	jp	00116$
      008691                        414 00186$:
                                    415 ;	inc/delay.h: 27: __asm__("nop\n");
                                    416 ;	genInline
      008691 9D               [ 1]  417 	nop
                                    418 ;	./src/stm8_LCD.c: 53: lcd_command(LCD_FUNCTION_SET | LCD_4BITS | LCD_2LINES | USED_FONT);
                                    419 ; genSend
      008692 A6 28            [ 1]  420 	ld	a, #0x28
                                    421 ; genCall
      008694 CD 88 97         [ 4]  422 	call	_lcd_command
                                    423 ;	./src/stm8_LCD.c: 55: lcd_command(LCD_ENTRY_MODE_SET | LCD_INCREMENT | LCD_DISPLAY_NOSHIFT);
                                    424 ; genSend
      008697 A6 06            [ 1]  425 	ld	a, #0x06
                                    426 ; genCall
      008699 CD 88 97         [ 4]  427 	call	_lcd_command
                                    428 ;	./src/stm8_LCD.c: 56: lcd_command(LCD_DISPLAY_ONOFF | LCD_ON | LCD_CURSOR_OFF | LCD_BLINK_OFF);
                                    429 ; genSend
      00869C A6 0C            [ 1]  430 	ld	a, #0x0c
                                    431 ; genCall
      00869E CD 88 97         [ 4]  432 	call	_lcd_command
                                    433 ;	./src/stm8_LCD.c: 57: lcd_command(LCD_CURSOR_OR_DISPLAY_SHIFT | LCD_CURSOR_SHIFT | LCD_SHIFT_RIGHT);
                                    434 ; genSend
      0086A1 A6 14            [ 1]  435 	ld	a, #0x14
                                    436 ; genCall
      0086A3 CD 88 97         [ 4]  437 	call	_lcd_command
                                    438 ;	./src/stm8_LCD.c: 58: lcd_command(LCD_DISPLAY_CLEAR);
                                    439 ; genSend
      0086A6 A6 01            [ 1]  440 	ld	a, #0x01
                                    441 ; genCall
      0086A8 CD 88 97         [ 4]  442 	call	_lcd_command
                                    443 ;	./src/stm8_LCD.c: 59: lcd_command(LCD_RETURN_HOME);
                                    444 ; genSend
      0086AB A6 02            [ 1]  445 	ld	a, #0x02
                                    446 ; genCall
      0086AD CC 88 97         [ 2]  447 	jp	_lcd_command
                                    448 ; genLabel
      0086B0                        449 00121$:
                                    450 ;	./src/stm8_LCD.c: 60: }
                                    451 ; genEndFunction
      0086B0 81               [ 4]  452 	ret
                                    453 ;	./src/stm8_LCD.c: 62: void lcd_gotoxy(uint8_t column, uint8_t line){
                                    454 ; genLabel
                                    455 ;	-----------------------------------------
                                    456 ;	 function lcd_gotoxy
                                    457 ;	-----------------------------------------
                                    458 ;	Register assignment is optimal.
                                    459 ;	Stack space usage: 0 bytes.
      0086B1                        460 _lcd_gotoxy:
                                    461 ; genReceive
                                    462 ;	./src/stm8_LCD.c: 63: uint8_t tmp=0;
                                    463 ; genAssign
      0086B1 5F               [ 1]  464 	clrw	x
                                    465 ;	./src/stm8_LCD.c: 75: if(column > (LCD_COLUMNS-1)){column=LCD_COLUMNS-1;}
                                    466 ; genCmp
                                    467 ; genCmpTnz
      0086B2 A1 0F            [ 1]  468 	cp	a, #0x0f
      0086B4 22 03            [ 1]  469 	jrugt	00131$
      0086B6 CC 86 BB         [ 2]  470 	jp	00102$
      0086B9                        471 00131$:
                                    472 ; skipping generated iCode
                                    473 ; genAssign
      0086B9 A6 0F            [ 1]  474 	ld	a, #0x0f
                                    475 ; genLabel
      0086BB                        476 00102$:
                                    477 ;	./src/stm8_LCD.c: 76: if(line == 0){tmp=0x00;}
                                    478 ; genIfx
      0086BB 0D 03            [ 1]  479 	tnz	(0x03, sp)
      0086BD 27 03            [ 1]  480 	jreq	00132$
      0086BF CC 86 C6         [ 2]  481 	jp	00106$
      0086C2                        482 00132$:
                                    483 ; genAssign
      0086C2 5F               [ 1]  484 	clrw	x
                                    485 ; genGoto
      0086C3 CC 86 D7         [ 2]  486 	jp	00107$
                                    487 ; genLabel
      0086C6                        488 00106$:
                                    489 ;	./src/stm8_LCD.c: 77: else if(line==1){tmp = 0x40;}
                                    490 ; genCmpEQorNE
      0086C6 88               [ 1]  491 	push	a
      0086C7 7B 04            [ 1]  492 	ld	a, (0x04, sp)
      0086C9 4A               [ 1]  493 	dec	a
      0086CA 84               [ 1]  494 	pop	a
      0086CB 26 03            [ 1]  495 	jrne	00134$
      0086CD CC 86 D3         [ 2]  496 	jp	00135$
      0086D0                        497 00134$:
      0086D0 CC 86 D7         [ 2]  498 	jp	00107$
      0086D3                        499 00135$:
                                    500 ; skipping generated iCode
                                    501 ; genAssign
      0086D3 41               [ 1]  502 	exg	a, xl
      0086D4 A6 40            [ 1]  503 	ld	a, #0x40
      0086D6 41               [ 1]  504 	exg	a, xl
                                    505 ; genLabel
      0086D7                        506 00107$:
                                    507 ;	./src/stm8_LCD.c: 78: tmp = tmp + column;
                                    508 ; genPlus
      0086D7 89               [ 2]  509 	pushw	x
      0086D8 1B 02            [ 1]  510 	add	a, (2, sp)
      0086DA 85               [ 2]  511 	popw	x
                                    512 ;	./src/stm8_LCD.c: 85: lcd_command(LCD_SET_DDRAM | tmp);
                                    513 ; genOr
      0086DB AA 80            [ 1]  514 	or	a, #0x80
                                    515 ; genSend
                                    516 ; genCall
      0086DD CD 88 97         [ 4]  517 	call	_lcd_command
                                    518 ; genLabel
      0086E0                        519 00108$:
                                    520 ;	./src/stm8_LCD.c: 86: }
                                    521 ; genEndFunction
      0086E0 85               [ 2]  522 	popw	x
      0086E1 84               [ 1]  523 	pop	a
      0086E2 FC               [ 2]  524 	jp	(x)
                                    525 ;	./src/stm8_LCD.c: 89: void lcd_init_hw(void){
                                    526 ; genLabel
                                    527 ;	-----------------------------------------
                                    528 ;	 function lcd_init_hw
                                    529 ;	-----------------------------------------
                                    530 ;	Register assignment is optimal.
                                    531 ;	Stack space usage: 0 bytes.
      0086E3                        532 _lcd_init_hw:
                                    533 ;	./src/stm8_LCD.c: 105: GPIO_Init(LCD_RS_PORT,LCD_RS_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
                                    534 ; genIPush
      0086E3 4B C0            [ 1]  535 	push	#0xc0
                                    536 ; genSend
      0086E5 A6 80            [ 1]  537 	ld	a, #0x80
                                    538 ; genSend
      0086E7 AE 50 19         [ 2]  539 	ldw	x, #0x5019
                                    540 ; genCall
      0086EA CD 8A 2D         [ 4]  541 	call	_GPIO_Init
                                    542 ;	./src/stm8_LCD.c: 106: GPIO_Init(LCD_RW_PORT,LCD_RW_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
                                    543 ; genIPush
      0086ED 4B C0            [ 1]  544 	push	#0xc0
                                    545 ; genSend
      0086EF A6 40            [ 1]  546 	ld	a, #0x40
                                    547 ; genSend
      0086F1 AE 50 19         [ 2]  548 	ldw	x, #0x5019
                                    549 ; genCall
      0086F4 CD 8A 2D         [ 4]  550 	call	_GPIO_Init
                                    551 ;	./src/stm8_LCD.c: 107: GPIO_Init(LCD_E_PORT,LCD_E_PIN,GPIO_MODE_OUT_PP_HIGH_SLOW);
                                    552 ; genIPush
      0086F7 4B D0            [ 1]  553 	push	#0xd0
                                    554 ; genSend
      0086F9 A6 20            [ 1]  555 	ld	a, #0x20
                                    556 ; genSend
      0086FB AE 50 19         [ 2]  557 	ldw	x, #0x5019
                                    558 ; genCall
      0086FE CD 8A 2D         [ 4]  559 	call	_GPIO_Init
                                    560 ;	./src/stm8_LCD.c: 110: lcd_bus_outputs();
                                    561 ; genCall
      008701 CC 87 05         [ 2]  562 	jp	_lcd_bus_outputs
                                    563 ; genLabel
      008704                        564 00101$:
                                    565 ;	./src/stm8_LCD.c: 111: }
                                    566 ; genEndFunction
      008704 81               [ 4]  567 	ret
                                    568 ;	./src/stm8_LCD.c: 114: void lcd_bus_outputs(void){
                                    569 ; genLabel
                                    570 ;	-----------------------------------------
                                    571 ;	 function lcd_bus_outputs
                                    572 ;	-----------------------------------------
                                    573 ;	Register assignment is optimal.
                                    574 ;	Stack space usage: 0 bytes.
      008705                        575 _lcd_bus_outputs:
                                    576 ;	./src/stm8_LCD.c: 118: GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
                                    577 ; genIPush
      008705 4B C0            [ 1]  578 	push	#0xc0
                                    579 ; genSend
      008707 A6 01            [ 1]  580 	ld	a, #0x01
                                    581 ; genSend
      008709 AE 50 1E         [ 2]  582 	ldw	x, #0x501e
                                    583 ; genCall
      00870C CD 8A 2D         [ 4]  584 	call	_GPIO_Init
                                    585 ;	./src/stm8_LCD.c: 119: GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
                                    586 ; genIPush
      00870F 4B C0            [ 1]  587 	push	#0xc0
                                    588 ; genSend
      008711 A6 02            [ 1]  589 	ld	a, #0x02
                                    590 ; genSend
      008713 AE 50 1E         [ 2]  591 	ldw	x, #0x501e
                                    592 ; genCall
      008716 CD 8A 2D         [ 4]  593 	call	_GPIO_Init
                                    594 ;	./src/stm8_LCD.c: 120: GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
                                    595 ; genIPush
      008719 4B C0            [ 1]  596 	push	#0xc0
                                    597 ; genSend
      00871B A6 04            [ 1]  598 	ld	a, #0x04
                                    599 ; genSend
      00871D AE 50 1E         [ 2]  600 	ldw	x, #0x501e
                                    601 ; genCall
      008720 CD 8A 2D         [ 4]  602 	call	_GPIO_Init
                                    603 ;	./src/stm8_LCD.c: 121: GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
                                    604 ; genIPush
      008723 4B C0            [ 1]  605 	push	#0xc0
                                    606 ; genSend
      008725 A6 08            [ 1]  607 	ld	a, #0x08
                                    608 ; genSend
      008727 AE 50 1E         [ 2]  609 	ldw	x, #0x501e
                                    610 ; genCall
      00872A CD 8A 2D         [ 4]  611 	call	_GPIO_Init
                                    612 ; genLabel
      00872D                        613 00101$:
                                    614 ;	./src/stm8_LCD.c: 123: }
                                    615 ; genEndFunction
      00872D 81               [ 4]  616 	ret
                                    617 ;	./src/stm8_LCD.c: 126: void lcd_bus_inputs(void){
                                    618 ; genLabel
                                    619 ;	-----------------------------------------
                                    620 ;	 function lcd_bus_inputs
                                    621 ;	-----------------------------------------
                                    622 ;	Register assignment is optimal.
                                    623 ;	Stack space usage: 0 bytes.
      00872E                        624 _lcd_bus_inputs:
                                    625 ;	./src/stm8_LCD.c: 134: GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    626 ; genIPush
      00872E 4B 00            [ 1]  627 	push	#0x00
                                    628 ; genSend
      008730 A6 01            [ 1]  629 	ld	a, #0x01
                                    630 ; genSend
      008732 AE 50 1E         [ 2]  631 	ldw	x, #0x501e
                                    632 ; genCall
      008735 CD 8A 2D         [ 4]  633 	call	_GPIO_Init
                                    634 ;	./src/stm8_LCD.c: 135: GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    635 ; genIPush
      008738 4B 00            [ 1]  636 	push	#0x00
                                    637 ; genSend
      00873A A6 02            [ 1]  638 	ld	a, #0x02
                                    639 ; genSend
      00873C AE 50 1E         [ 2]  640 	ldw	x, #0x501e
                                    641 ; genCall
      00873F CD 8A 2D         [ 4]  642 	call	_GPIO_Init
                                    643 ;	./src/stm8_LCD.c: 136: GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    644 ; genIPush
      008742 4B 00            [ 1]  645 	push	#0x00
                                    646 ; genSend
      008744 A6 04            [ 1]  647 	ld	a, #0x04
                                    648 ; genSend
      008746 AE 50 1E         [ 2]  649 	ldw	x, #0x501e
                                    650 ; genCall
      008749 CD 8A 2D         [ 4]  651 	call	_GPIO_Init
                                    652 ;	./src/stm8_LCD.c: 137: GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_IN_FL_NO_IT); 
                                    653 ; genIPush
      00874C 4B 00            [ 1]  654 	push	#0x00
                                    655 ; genSend
      00874E A6 08            [ 1]  656 	ld	a, #0x08
                                    657 ; genSend
      008750 AE 50 1E         [ 2]  658 	ldw	x, #0x501e
                                    659 ; genCall
      008753 CD 8A 2D         [ 4]  660 	call	_GPIO_Init
                                    661 ; genLabel
      008756                        662 00101$:
                                    663 ;	./src/stm8_LCD.c: 139: }
                                    664 ; genEndFunction
      008756 81               [ 4]  665 	ret
                                    666 ;	./src/stm8_LCD.c: 142: void lcd_deinit_hw(void){
                                    667 ; genLabel
                                    668 ;	-----------------------------------------
                                    669 ;	 function lcd_deinit_hw
                                    670 ;	-----------------------------------------
                                    671 ;	Register assignment is optimal.
                                    672 ;	Stack space usage: 0 bytes.
      008757                        673 _lcd_deinit_hw:
                                    674 ;	./src/stm8_LCD.c: 143: GPIO_Init(LCD_RS_PORT,LCD_RS_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    675 ; genIPush
      008757 4B 00            [ 1]  676 	push	#0x00
                                    677 ; genSend
      008759 A6 80            [ 1]  678 	ld	a, #0x80
                                    679 ; genSend
      00875B AE 50 19         [ 2]  680 	ldw	x, #0x5019
                                    681 ; genCall
      00875E CD 8A 2D         [ 4]  682 	call	_GPIO_Init
                                    683 ;	./src/stm8_LCD.c: 144: GPIO_Init(LCD_RW_PORT,LCD_RW_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    684 ; genIPush
      008761 4B 00            [ 1]  685 	push	#0x00
                                    686 ; genSend
      008763 A6 40            [ 1]  687 	ld	a, #0x40
                                    688 ; genSend
      008765 AE 50 19         [ 2]  689 	ldw	x, #0x5019
                                    690 ; genCall
      008768 CD 8A 2D         [ 4]  691 	call	_GPIO_Init
                                    692 ;	./src/stm8_LCD.c: 145: GPIO_Init(LCD_E_PORT,LCD_E_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    693 ; genIPush
      00876B 4B 00            [ 1]  694 	push	#0x00
                                    695 ; genSend
      00876D A6 20            [ 1]  696 	ld	a, #0x20
                                    697 ; genSend
      00876F AE 50 19         [ 2]  698 	ldw	x, #0x5019
                                    699 ; genCall
      008772 CD 8A 2D         [ 4]  700 	call	_GPIO_Init
                                    701 ;	./src/stm8_LCD.c: 146: GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    702 ; genIPush
      008775 4B 00            [ 1]  703 	push	#0x00
                                    704 ; genSend
      008777 A6 01            [ 1]  705 	ld	a, #0x01
                                    706 ; genSend
      008779 AE 50 1E         [ 2]  707 	ldw	x, #0x501e
                                    708 ; genCall
      00877C CD 8A 2D         [ 4]  709 	call	_GPIO_Init
                                    710 ;	./src/stm8_LCD.c: 147: GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    711 ; genIPush
      00877F 4B 00            [ 1]  712 	push	#0x00
                                    713 ; genSend
      008781 A6 02            [ 1]  714 	ld	a, #0x02
                                    715 ; genSend
      008783 AE 50 1E         [ 2]  716 	ldw	x, #0x501e
                                    717 ; genCall
      008786 CD 8A 2D         [ 4]  718 	call	_GPIO_Init
                                    719 ;	./src/stm8_LCD.c: 148: GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_IN_FL_NO_IT);
                                    720 ; genIPush
      008789 4B 00            [ 1]  721 	push	#0x00
                                    722 ; genSend
      00878B A6 04            [ 1]  723 	ld	a, #0x04
                                    724 ; genSend
      00878D AE 50 1E         [ 2]  725 	ldw	x, #0x501e
                                    726 ; genCall
      008790 CD 8A 2D         [ 4]  727 	call	_GPIO_Init
                                    728 ;	./src/stm8_LCD.c: 149: GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_IN_FL_NO_IT); 
                                    729 ; genIPush
      008793 4B 00            [ 1]  730 	push	#0x00
                                    731 ; genSend
      008795 A6 08            [ 1]  732 	ld	a, #0x08
                                    733 ; genSend
      008797 AE 50 1E         [ 2]  734 	ldw	x, #0x501e
                                    735 ; genCall
      00879A CD 8A 2D         [ 4]  736 	call	_GPIO_Init
                                    737 ; genLabel
      00879D                        738 00101$:
                                    739 ;	./src/stm8_LCD.c: 150: }
                                    740 ; genEndFunction
      00879D 81               [ 4]  741 	ret
                                    742 ;	./src/stm8_LCD.c: 153: void lcd_bus_set(uint8_t data){
                                    743 ; genLabel
                                    744 ;	-----------------------------------------
                                    745 ;	 function lcd_bus_set
                                    746 ;	-----------------------------------------
                                    747 ;	Register assignment is optimal.
                                    748 ;	Stack space usage: 1 bytes.
      00879E                        749 _lcd_bus_set:
      00879E 88               [ 1]  750 	push	a
                                    751 ; genReceive
      00879F 6B 01            [ 1]  752 	ld	(0x01, sp), a
                                    753 ;	./src/stm8_LCD.c: 154: if(data & (1<<0)){LCD_D4_H;}else{LCD_D4_L;}
                                    754 ; genAnd
      0087A1 7B 01            [ 1]  755 	ld	a, (0x01, sp)
      0087A3 44               [ 1]  756 	srl	a
      0087A4 25 03            [ 1]  757 	jrc	00143$
      0087A6 CC 87 B4         [ 2]  758 	jp	00102$
      0087A9                        759 00143$:
                                    760 ; skipping generated iCode
                                    761 ; genSend
      0087A9 A6 01            [ 1]  762 	ld	a, #0x01
                                    763 ; genSend
      0087AB AE 50 1E         [ 2]  764 	ldw	x, #0x501e
                                    765 ; genCall
      0087AE CD 8C BB         [ 4]  766 	call	_GPIO_WriteHigh
                                    767 ; genGoto
      0087B1 CC 87 BC         [ 2]  768 	jp	00103$
                                    769 ; genLabel
      0087B4                        770 00102$:
                                    771 ; genSend
      0087B4 A6 01            [ 1]  772 	ld	a, #0x01
                                    773 ; genSend
      0087B6 AE 50 1E         [ 2]  774 	ldw	x, #0x501e
                                    775 ; genCall
      0087B9 CD 8B 8F         [ 4]  776 	call	_GPIO_WriteLow
                                    777 ; genLabel
      0087BC                        778 00103$:
                                    779 ;	./src/stm8_LCD.c: 155: if(data & (1<<1)){LCD_D5_H;}else{LCD_D5_L;}
                                    780 ; genAnd
      0087BC 7B 01            [ 1]  781 	ld	a, (0x01, sp)
      0087BE A5 02            [ 1]  782 	bcp	a, #0x02
      0087C0 26 03            [ 1]  783 	jrne	00144$
      0087C2 CC 87 D0         [ 2]  784 	jp	00105$
      0087C5                        785 00144$:
                                    786 ; skipping generated iCode
                                    787 ; genSend
      0087C5 A6 02            [ 1]  788 	ld	a, #0x02
                                    789 ; genSend
      0087C7 AE 50 1E         [ 2]  790 	ldw	x, #0x501e
                                    791 ; genCall
      0087CA CD 8C BB         [ 4]  792 	call	_GPIO_WriteHigh
                                    793 ; genGoto
      0087CD CC 87 D8         [ 2]  794 	jp	00106$
                                    795 ; genLabel
      0087D0                        796 00105$:
                                    797 ; genSend
      0087D0 A6 02            [ 1]  798 	ld	a, #0x02
                                    799 ; genSend
      0087D2 AE 50 1E         [ 2]  800 	ldw	x, #0x501e
                                    801 ; genCall
      0087D5 CD 8B 8F         [ 4]  802 	call	_GPIO_WriteLow
                                    803 ; genLabel
      0087D8                        804 00106$:
                                    805 ;	./src/stm8_LCD.c: 156: if(data & (1<<2)){LCD_D6_H;}else{LCD_D6_L;}
                                    806 ; genAnd
      0087D8 7B 01            [ 1]  807 	ld	a, (0x01, sp)
      0087DA A5 04            [ 1]  808 	bcp	a, #0x04
      0087DC 26 03            [ 1]  809 	jrne	00145$
      0087DE CC 87 EC         [ 2]  810 	jp	00108$
      0087E1                        811 00145$:
                                    812 ; skipping generated iCode
                                    813 ; genSend
      0087E1 A6 04            [ 1]  814 	ld	a, #0x04
                                    815 ; genSend
      0087E3 AE 50 1E         [ 2]  816 	ldw	x, #0x501e
                                    817 ; genCall
      0087E6 CD 8C BB         [ 4]  818 	call	_GPIO_WriteHigh
                                    819 ; genGoto
      0087E9 CC 87 F4         [ 2]  820 	jp	00109$
                                    821 ; genLabel
      0087EC                        822 00108$:
                                    823 ; genSend
      0087EC A6 04            [ 1]  824 	ld	a, #0x04
                                    825 ; genSend
      0087EE AE 50 1E         [ 2]  826 	ldw	x, #0x501e
                                    827 ; genCall
      0087F1 CD 8B 8F         [ 4]  828 	call	_GPIO_WriteLow
                                    829 ; genLabel
      0087F4                        830 00109$:
                                    831 ;	./src/stm8_LCD.c: 157: if(data & (1<<3)){LCD_D7_H;}else{LCD_D7_L;}
                                    832 ; genAnd
      0087F4 7B 01            [ 1]  833 	ld	a, (0x01, sp)
      0087F6 A5 08            [ 1]  834 	bcp	a, #0x08
      0087F8 26 03            [ 1]  835 	jrne	00146$
      0087FA CC 88 0A         [ 2]  836 	jp	00111$
      0087FD                        837 00146$:
                                    838 ; skipping generated iCode
                                    839 ; genSend
      0087FD A6 08            [ 1]  840 	ld	a, #0x08
                                    841 ; genSend
      0087FF AE 50 1E         [ 2]  842 	ldw	x, #0x501e
                                    843 ; genCall
      008802 5B 01            [ 2]  844 	addw	sp, #1
      008804 CC 8C BB         [ 2]  845 	jp	_GPIO_WriteHigh
                                    846 ; genGoto
      008807 CC 88 14         [ 2]  847 	jp	00113$
                                    848 ; genLabel
      00880A                        849 00111$:
                                    850 ; genSend
      00880A A6 08            [ 1]  851 	ld	a, #0x08
                                    852 ; genSend
      00880C AE 50 1E         [ 2]  853 	ldw	x, #0x501e
                                    854 ; genCall
      00880F 5B 01            [ 2]  855 	addw	sp, #1
      008811 CC 8B 8F         [ 2]  856 	jp	_GPIO_WriteLow
                                    857 ; genLabel
      008814                        858 00113$:
                                    859 ;	./src/stm8_LCD.c: 158: }
                                    860 ; genEndFunction
      008814 84               [ 1]  861 	pop	a
      008815 81               [ 4]  862 	ret
                                    863 ;	./src/stm8_LCD.c: 161: uint8_t lcd_bus_read(void){
                                    864 ; genLabel
                                    865 ;	-----------------------------------------
                                    866 ;	 function lcd_bus_read
                                    867 ;	-----------------------------------------
                                    868 ;	Register assignment is optimal.
                                    869 ;	Stack space usage: 1 bytes.
      008816                        870 _lcd_bus_read:
      008816 88               [ 1]  871 	push	a
                                    872 ;	./src/stm8_LCD.c: 162: uint8_t tmp=0;
                                    873 ; genAssign
      008817 0F 01            [ 1]  874 	clr	(0x01, sp)
                                    875 ;	./src/stm8_LCD.c: 163: if(GPIO_ReadInputPin(LCD_D4_PORT,LCD_D4_PIN)){tmp |= 1<<0;}
                                    876 ; genSend
      008819 A6 01            [ 1]  877 	ld	a, #0x01
                                    878 ; genSend
      00881B AE 50 1E         [ 2]  879 	ldw	x, #0x501e
                                    880 ; genCall
      00881E CD 8A E2         [ 4]  881 	call	_GPIO_ReadInputPin
                                    882 ; genIfx
      008821 4D               [ 1]  883 	tnz	a
      008822 26 03            [ 1]  884 	jrne	00139$
      008824 CC 88 2B         [ 2]  885 	jp	00102$
      008827                        886 00139$:
                                    887 ; genAssign
      008827 A6 01            [ 1]  888 	ld	a, #0x01
      008829 6B 01            [ 1]  889 	ld	(0x01, sp), a
                                    890 ; genLabel
      00882B                        891 00102$:
                                    892 ;	./src/stm8_LCD.c: 164: if(GPIO_ReadInputPin(LCD_D5_PORT,LCD_D5_PIN)){tmp |= 1<<1;}
                                    893 ; genSend
      00882B A6 02            [ 1]  894 	ld	a, #0x02
                                    895 ; genSend
      00882D AE 50 1E         [ 2]  896 	ldw	x, #0x501e
                                    897 ; genCall
      008830 CD 8A E2         [ 4]  898 	call	_GPIO_ReadInputPin
                                    899 ; genIfx
      008833 4D               [ 1]  900 	tnz	a
      008834 26 03            [ 1]  901 	jrne	00140$
      008836 CC 88 3F         [ 2]  902 	jp	00104$
      008839                        903 00140$:
                                    904 ; genOr
      008839 7B 01            [ 1]  905 	ld	a, (0x01, sp)
      00883B AA 02            [ 1]  906 	or	a, #0x02
      00883D 6B 01            [ 1]  907 	ld	(0x01, sp), a
                                    908 ; genLabel
      00883F                        909 00104$:
                                    910 ;	./src/stm8_LCD.c: 165: if(GPIO_ReadInputPin(LCD_D6_PORT,LCD_D6_PIN)){tmp |= 1<<2;}
                                    911 ; genSend
      00883F A6 04            [ 1]  912 	ld	a, #0x04
                                    913 ; genSend
      008841 AE 50 1E         [ 2]  914 	ldw	x, #0x501e
                                    915 ; genCall
      008844 CD 8A E2         [ 4]  916 	call	_GPIO_ReadInputPin
                                    917 ; genIfx
      008847 4D               [ 1]  918 	tnz	a
      008848 26 03            [ 1]  919 	jrne	00141$
      00884A CC 88 53         [ 2]  920 	jp	00106$
      00884D                        921 00141$:
                                    922 ; genOr
      00884D 7B 01            [ 1]  923 	ld	a, (0x01, sp)
      00884F AA 04            [ 1]  924 	or	a, #0x04
      008851 6B 01            [ 1]  925 	ld	(0x01, sp), a
                                    926 ; genLabel
      008853                        927 00106$:
                                    928 ;	./src/stm8_LCD.c: 166: if(GPIO_ReadInputPin(LCD_D7_PORT,LCD_D7_PIN)){tmp |= 1<<3;}
                                    929 ; genSend
      008853 A6 08            [ 1]  930 	ld	a, #0x08
                                    931 ; genSend
      008855 AE 50 1E         [ 2]  932 	ldw	x, #0x501e
                                    933 ; genCall
      008858 CD 8A E2         [ 4]  934 	call	_GPIO_ReadInputPin
                                    935 ; genIfx
      00885B 4D               [ 1]  936 	tnz	a
      00885C 26 03            [ 1]  937 	jrne	00142$
      00885E CC 88 67         [ 2]  938 	jp	00108$
      008861                        939 00142$:
                                    940 ; genOr
      008861 7B 01            [ 1]  941 	ld	a, (0x01, sp)
      008863 AA 08            [ 1]  942 	or	a, #0x08
      008865 6B 01            [ 1]  943 	ld	(0x01, sp), a
                                    944 ; genLabel
      008867                        945 00108$:
                                    946 ;	./src/stm8_LCD.c: 167: return tmp;
                                    947 ; genReturn
      008867 7B 01            [ 1]  948 	ld	a, (0x01, sp)
                                    949 ; genLabel
      008869                        950 00109$:
                                    951 ;	./src/stm8_LCD.c: 168: }
                                    952 ; genEndFunction
      008869 5B 01            [ 2]  953 	addw	sp, #1
      00886B 81               [ 4]  954 	ret
                                    955 ;	./src/stm8_LCD.c: 171: void lcd_e_tick(void){
                                    956 ; genLabel
                                    957 ;	-----------------------------------------
                                    958 ;	 function lcd_e_tick
                                    959 ;	-----------------------------------------
                                    960 ;	Register assignment is optimal.
                                    961 ;	Stack space usage: 0 bytes.
      00886C                        962 _lcd_e_tick:
                                    963 ;	./src/stm8_LCD.c: 172: LCD_E_H;
                                    964 ; genSend
      00886C A6 20            [ 1]  965 	ld	a, #0x20
                                    966 ; genSend
      00886E AE 50 19         [ 2]  967 	ldw	x, #0x5019
                                    968 ; genCall
      008871 CD 8C BB         [ 4]  969 	call	_GPIO_WriteHigh
                                    970 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    971 ;	genInline
      008874 9D               [ 1]  972 	nop
      008875 9D               [ 1]  973 	nop
                                    974 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    975 ; genAssign
      008876 AE 00 02         [ 2]  976 	ldw	x, #0x0002
                                    977 ; genLabel
      008879                        978 00101$:
                                    979 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    980 ; genMinus
      008879 5A               [ 2]  981 	decw	x
                                    982 ;	inc/delay.h: 26: } while ( __ticks );
                                    983 ; genIfx
      00887A 5D               [ 2]  984 	tnzw	x
      00887B 27 03            [ 1]  985 	jreq	00143$
      00887D CC 88 79         [ 2]  986 	jp	00101$
      008880                        987 00143$:
                                    988 ;	inc/delay.h: 27: __asm__("nop\n");
                                    989 ;	genInline
      008880 9D               [ 1]  990 	nop
                                    991 ;	./src/stm8_LCD.c: 174: LCD_E_L;
                                    992 ; genSend
      008881 A6 20            [ 1]  993 	ld	a, #0x20
                                    994 ; genSend
      008883 AE 50 19         [ 2]  995 	ldw	x, #0x5019
                                    996 ; genCall
      008886 CD 8B 8F         [ 4]  997 	call	_GPIO_WriteLow
                                    998 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    999 ;	genInline
      008889 9D               [ 1] 1000 	nop
      00888A 9D               [ 1] 1001 	nop
                                   1002 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1003 ; genAssign
      00888B AE 00 02         [ 2] 1004 	ldw	x, #0x0002
                                   1005 ; genLabel
      00888E                       1006 00106$:
                                   1007 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1008 ; genMinus
      00888E 5A               [ 2] 1009 	decw	x
                                   1010 ;	inc/delay.h: 26: } while ( __ticks );
                                   1011 ; genIfx
      00888F 5D               [ 2] 1012 	tnzw	x
      008890 27 03            [ 1] 1013 	jreq	00144$
      008892 CC 88 8E         [ 2] 1014 	jp	00106$
      008895                       1015 00144$:
                                   1016 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1017 ;	genInline
      008895 9D               [ 1] 1018 	nop
                                   1019 ;	./src/stm8_LCD.c: 175: _delay_us(LCD_E_DELAY);
                                   1020 ; genLabel
      008896                       1021 00111$:
                                   1022 ;	./src/stm8_LCD.c: 176: }
                                   1023 ; genEndFunction
      008896 81               [ 4] 1024 	ret
                                   1025 ;	./src/stm8_LCD.c: 179: void lcd_command(uint8_t command){
                                   1026 ; genLabel
                                   1027 ;	-----------------------------------------
                                   1028 ;	 function lcd_command
                                   1029 ;	-----------------------------------------
                                   1030 ;	Register assignment is optimal.
                                   1031 ;	Stack space usage: 1 bytes.
      008897                       1032 _lcd_command:
      008897 88               [ 1] 1033 	push	a
                                   1034 ; genReceive
      008898 6B 01            [ 1] 1035 	ld	(0x01, sp), a
                                   1036 ;	./src/stm8_LCD.c: 180: LCD_RS_L;
                                   1037 ; genSend
      00889A A6 80            [ 1] 1038 	ld	a, #0x80
                                   1039 ; genSend
      00889C AE 50 19         [ 2] 1040 	ldw	x, #0x5019
                                   1041 ; genCall
      00889F CD 8B 8F         [ 4] 1042 	call	_GPIO_WriteLow
                                   1043 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1044 ;	genInline
      0088A2 9D               [ 1] 1045 	nop
      0088A3 9D               [ 1] 1046 	nop
                                   1047 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1048 ; genAssign
      0088A4 AE 00 02         [ 2] 1049 	ldw	x, #0x0002
                                   1050 ; genLabel
      0088A7                       1051 00101$:
                                   1052 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1053 ; genMinus
      0088A7 5A               [ 2] 1054 	decw	x
                                   1055 ;	inc/delay.h: 26: } while ( __ticks );
                                   1056 ; genIfx
      0088A8 5D               [ 2] 1057 	tnzw	x
      0088A9 27 03            [ 1] 1058 	jreq	00123$
      0088AB CC 88 A7         [ 2] 1059 	jp	00101$
      0088AE                       1060 00123$:
                                   1061 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1062 ;	genInline
      0088AE 9D               [ 1] 1063 	nop
                                   1064 ;	./src/stm8_LCD.c: 182: lcd_bus_set((command >> 4) & 0b1111);
                                   1065 ; genRightShiftLiteral
      0088AF 7B 01            [ 1] 1066 	ld	a, (0x01, sp)
      0088B1 4E               [ 1] 1067 	swap	a
      0088B2 A4 0F            [ 1] 1068 	and	a, #0x0f
                                   1069 ; genAnd
      0088B4 A4 0F            [ 1] 1070 	and	a, #0x0f
                                   1071 ; genSend
                                   1072 ; genCall
      0088B6 CD 87 9E         [ 4] 1073 	call	_lcd_bus_set
                                   1074 ;	./src/stm8_LCD.c: 183: lcd_e_tick();
                                   1075 ; genCall
      0088B9 CD 88 6C         [ 4] 1076 	call	_lcd_e_tick
                                   1077 ;	./src/stm8_LCD.c: 184: lcd_bus_set(command & 0b1111);
                                   1078 ; genAnd
      0088BC 7B 01            [ 1] 1079 	ld	a, (0x01, sp)
      0088BE A4 0F            [ 1] 1080 	and	a, #0x0f
                                   1081 ; genSend
                                   1082 ; genCall
      0088C0 CD 87 9E         [ 4] 1083 	call	_lcd_bus_set
                                   1084 ;	./src/stm8_LCD.c: 185: lcd_e_tick();
                                   1085 ; genCall
      0088C3 CD 88 6C         [ 4] 1086 	call	_lcd_e_tick
                                   1087 ;	./src/stm8_LCD.c: 186: lcd_busy_wait();
                                   1088 ; genCall
      0088C6 84               [ 1] 1089 	pop	a
      0088C7 CC 89 D5         [ 2] 1090 	jp	_lcd_busy_wait
                                   1091 ; genLabel
      0088CA                       1092 00106$:
                                   1093 ;	./src/stm8_LCD.c: 187: }
                                   1094 ; genEndFunction
      0088CA 84               [ 1] 1095 	pop	a
      0088CB 81               [ 4] 1096 	ret
                                   1097 ;	./src/stm8_LCD.c: 190: void lcd_data(uint8_t data){
                                   1098 ; genLabel
                                   1099 ;	-----------------------------------------
                                   1100 ;	 function lcd_data
                                   1101 ;	-----------------------------------------
                                   1102 ;	Register assignment is optimal.
                                   1103 ;	Stack space usage: 1 bytes.
      0088CC                       1104 _lcd_data:
      0088CC 88               [ 1] 1105 	push	a
                                   1106 ; genReceive
      0088CD 6B 01            [ 1] 1107 	ld	(0x01, sp), a
                                   1108 ;	./src/stm8_LCD.c: 191: LCD_RS_H;
                                   1109 ; genSend
      0088CF A6 80            [ 1] 1110 	ld	a, #0x80
                                   1111 ; genSend
      0088D1 AE 50 19         [ 2] 1112 	ldw	x, #0x5019
                                   1113 ; genCall
      0088D4 CD 8C BB         [ 4] 1114 	call	_GPIO_WriteHigh
                                   1115 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1116 ;	genInline
      0088D7 9D               [ 1] 1117 	nop
      0088D8 9D               [ 1] 1118 	nop
                                   1119 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1120 ; genAssign
      0088D9 AE 00 02         [ 2] 1121 	ldw	x, #0x0002
                                   1122 ; genLabel
      0088DC                       1123 00101$:
                                   1124 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1125 ; genMinus
      0088DC 5A               [ 2] 1126 	decw	x
                                   1127 ;	inc/delay.h: 26: } while ( __ticks );
                                   1128 ; genIfx
      0088DD 5D               [ 2] 1129 	tnzw	x
      0088DE 27 03            [ 1] 1130 	jreq	00123$
      0088E0 CC 88 DC         [ 2] 1131 	jp	00101$
      0088E3                       1132 00123$:
                                   1133 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1134 ;	genInline
      0088E3 9D               [ 1] 1135 	nop
                                   1136 ;	./src/stm8_LCD.c: 193: lcd_bus_set((data >> 4) & 0b1111);
                                   1137 ; genRightShiftLiteral
      0088E4 7B 01            [ 1] 1138 	ld	a, (0x01, sp)
      0088E6 4E               [ 1] 1139 	swap	a
      0088E7 A4 0F            [ 1] 1140 	and	a, #0x0f
                                   1141 ; genAnd
      0088E9 A4 0F            [ 1] 1142 	and	a, #0x0f
                                   1143 ; genSend
                                   1144 ; genCall
      0088EB CD 87 9E         [ 4] 1145 	call	_lcd_bus_set
                                   1146 ;	./src/stm8_LCD.c: 194: lcd_e_tick();
                                   1147 ; genCall
      0088EE CD 88 6C         [ 4] 1148 	call	_lcd_e_tick
                                   1149 ;	./src/stm8_LCD.c: 195: lcd_bus_set(data & 0b1111);
                                   1150 ; genAnd
      0088F1 7B 01            [ 1] 1151 	ld	a, (0x01, sp)
      0088F3 A4 0F            [ 1] 1152 	and	a, #0x0f
                                   1153 ; genSend
                                   1154 ; genCall
      0088F5 CD 87 9E         [ 4] 1155 	call	_lcd_bus_set
                                   1156 ;	./src/stm8_LCD.c: 196: lcd_e_tick();
                                   1157 ; genCall
      0088F8 CD 88 6C         [ 4] 1158 	call	_lcd_e_tick
                                   1159 ;	./src/stm8_LCD.c: 197: lcd_busy_wait();
                                   1160 ; genCall
      0088FB 84               [ 1] 1161 	pop	a
      0088FC CC 89 D5         [ 2] 1162 	jp	_lcd_busy_wait
                                   1163 ; genLabel
      0088FF                       1164 00106$:
                                   1165 ;	./src/stm8_LCD.c: 198: }
                                   1166 ; genEndFunction
      0088FF 84               [ 1] 1167 	pop	a
      008900 81               [ 4] 1168 	ret
                                   1169 ;	./src/stm8_LCD.c: 201: uint8_t lcd_read(void){
                                   1170 ; genLabel
                                   1171 ;	-----------------------------------------
                                   1172 ;	 function lcd_read
                                   1173 ;	-----------------------------------------
                                   1174 ;	Register assignment is optimal.
                                   1175 ;	Stack space usage: 1 bytes.
      008901                       1176 _lcd_read:
      008901 88               [ 1] 1177 	push	a
                                   1178 ;	./src/stm8_LCD.c: 203: LCD_RS_L;
                                   1179 ; genSend
      008902 A6 80            [ 1] 1180 	ld	a, #0x80
                                   1181 ; genSend
      008904 AE 50 19         [ 2] 1182 	ldw	x, #0x5019
                                   1183 ; genCall
      008907 CD 8B 8F         [ 4] 1184 	call	_GPIO_WriteLow
                                   1185 ;	./src/stm8_LCD.c: 204: lcd_bus_inputs();
                                   1186 ; genCall
      00890A CD 87 2E         [ 4] 1187 	call	_lcd_bus_inputs
                                   1188 ;	./src/stm8_LCD.c: 205: LCD_RW_H;
                                   1189 ; genSend
      00890D A6 40            [ 1] 1190 	ld	a, #0x40
                                   1191 ; genSend
      00890F AE 50 19         [ 2] 1192 	ldw	x, #0x5019
                                   1193 ; genCall
      008912 CD 8C BB         [ 4] 1194 	call	_GPIO_WriteHigh
                                   1195 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1196 ;	genInline
      008915 9D               [ 1] 1197 	nop
      008916 9D               [ 1] 1198 	nop
                                   1199 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1200 ; genAssign
      008917 AE 00 02         [ 2] 1201 	ldw	x, #0x0002
                                   1202 ; genLabel
      00891A                       1203 00101$:
                                   1204 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1205 ; genMinus
      00891A 5A               [ 2] 1206 	decw	x
                                   1207 ;	inc/delay.h: 26: } while ( __ticks );
                                   1208 ; genIfx
      00891B 5D               [ 2] 1209 	tnzw	x
      00891C 27 03            [ 1] 1210 	jreq	00203$
      00891E CC 89 1A         [ 2] 1211 	jp	00101$
      008921                       1212 00203$:
                                   1213 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1214 ;	genInline
      008921 9D               [ 1] 1215 	nop
                                   1216 ;	./src/stm8_LCD.c: 207: LCD_E_H;
                                   1217 ; genSend
      008922 A6 20            [ 1] 1218 	ld	a, #0x20
                                   1219 ; genSend
      008924 AE 50 19         [ 2] 1220 	ldw	x, #0x5019
                                   1221 ; genCall
      008927 CD 8C BB         [ 4] 1222 	call	_GPIO_WriteHigh
                                   1223 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1224 ;	genInline
      00892A 9D               [ 1] 1225 	nop
      00892B 9D               [ 1] 1226 	nop
                                   1227 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1228 ; genAssign
      00892C AE 00 02         [ 2] 1229 	ldw	x, #0x0002
                                   1230 ; genLabel
      00892F                       1231 00106$:
                                   1232 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1233 ; genMinus
      00892F 5A               [ 2] 1234 	decw	x
                                   1235 ;	inc/delay.h: 26: } while ( __ticks );
                                   1236 ; genIfx
      008930 5D               [ 2] 1237 	tnzw	x
      008931 27 03            [ 1] 1238 	jreq	00204$
      008933 CC 89 2F         [ 2] 1239 	jp	00106$
      008936                       1240 00204$:
                                   1241 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1242 ;	genInline
      008936 9D               [ 1] 1243 	nop
                                   1244 ;	./src/stm8_LCD.c: 209: tmp = lcd_bus_read()<<4;
                                   1245 ; genCall
      008937 CD 88 16         [ 4] 1246 	call	_lcd_bus_read
                                   1247 ; genCast
                                   1248 ; genAssign
                                   1249 ; genLeftShiftLiteral
      00893A 4E               [ 1] 1250 	swap	a
      00893B A4 F0            [ 1] 1251 	and	a, #0xf0
      00893D 6B 01            [ 1] 1252 	ld	(0x01, sp), a
                                   1253 ;	./src/stm8_LCD.c: 210: LCD_E_L;
                                   1254 ; genSend
      00893F A6 20            [ 1] 1255 	ld	a, #0x20
                                   1256 ; genSend
      008941 AE 50 19         [ 2] 1257 	ldw	x, #0x5019
                                   1258 ; genCall
      008944 CD 8B 8F         [ 4] 1259 	call	_GPIO_WriteLow
                                   1260 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1261 ;	genInline
      008947 9D               [ 1] 1262 	nop
      008948 9D               [ 1] 1263 	nop
                                   1264 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1265 ; genAssign
      008949 AE 00 02         [ 2] 1266 	ldw	x, #0x0002
                                   1267 ; genLabel
      00894C                       1268 00111$:
                                   1269 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1270 ; genMinus
      00894C 5A               [ 2] 1271 	decw	x
                                   1272 ;	inc/delay.h: 26: } while ( __ticks );
                                   1273 ; genIfx
      00894D 5D               [ 2] 1274 	tnzw	x
      00894E 27 03            [ 1] 1275 	jreq	00205$
      008950 CC 89 4C         [ 2] 1276 	jp	00111$
      008953                       1277 00205$:
                                   1278 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1279 ;	genInline
      008953 9D               [ 1] 1280 	nop
                                   1281 ;	./src/stm8_LCD.c: 212: LCD_E_H;
                                   1282 ; genSend
      008954 A6 20            [ 1] 1283 	ld	a, #0x20
                                   1284 ; genSend
      008956 AE 50 19         [ 2] 1285 	ldw	x, #0x5019
                                   1286 ; genCall
      008959 CD 8C BB         [ 4] 1287 	call	_GPIO_WriteHigh
                                   1288 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1289 ;	genInline
      00895C 9D               [ 1] 1290 	nop
      00895D 9D               [ 1] 1291 	nop
                                   1292 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1293 ; genAssign
      00895E AE 00 02         [ 2] 1294 	ldw	x, #0x0002
                                   1295 ; genLabel
      008961                       1296 00116$:
                                   1297 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1298 ; genMinus
      008961 5A               [ 2] 1299 	decw	x
                                   1300 ;	inc/delay.h: 26: } while ( __ticks );
                                   1301 ; genIfx
      008962 5D               [ 2] 1302 	tnzw	x
      008963 27 03            [ 1] 1303 	jreq	00206$
      008965 CC 89 61         [ 2] 1304 	jp	00116$
      008968                       1305 00206$:
                                   1306 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1307 ;	genInline
      008968 9D               [ 1] 1308 	nop
                                   1309 ;	./src/stm8_LCD.c: 214: tmp |= lcd_bus_read();
                                   1310 ; genCall
      008969 CD 88 16         [ 4] 1311 	call	_lcd_bus_read
                                   1312 ; genOr
      00896C 1A 01            [ 1] 1313 	or	a, (0x01, sp)
      00896E 6B 01            [ 1] 1314 	ld	(0x01, sp), a
                                   1315 ;	./src/stm8_LCD.c: 215: LCD_E_L;
                                   1316 ; genSend
      008970 A6 20            [ 1] 1317 	ld	a, #0x20
                                   1318 ; genSend
      008972 AE 50 19         [ 2] 1319 	ldw	x, #0x5019
                                   1320 ; genCall
      008975 CD 8B 8F         [ 4] 1321 	call	_GPIO_WriteLow
                                   1322 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                   1323 ;	genInline
      008978 9D               [ 1] 1324 	nop
      008979 9D               [ 1] 1325 	nop
                                   1326 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                   1327 ; genAssign
      00897A AE 00 02         [ 2] 1328 	ldw	x, #0x0002
                                   1329 ; genLabel
      00897D                       1330 00121$:
                                   1331 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                   1332 ; genMinus
      00897D 5A               [ 2] 1333 	decw	x
                                   1334 ;	inc/delay.h: 26: } while ( __ticks );
                                   1335 ; genIfx
      00897E 5D               [ 2] 1336 	tnzw	x
      00897F 27 03            [ 1] 1337 	jreq	00207$
      008981 CC 89 7D         [ 2] 1338 	jp	00121$
      008984                       1339 00207$:
                                   1340 ;	inc/delay.h: 27: __asm__("nop\n");
                                   1341 ;	genInline
      008984 9D               [ 1] 1342 	nop
                                   1343 ;	./src/stm8_LCD.c: 217: LCD_RW_L;
                                   1344 ; genSend
      008985 A6 40            [ 1] 1345 	ld	a, #0x40
                                   1346 ; genSend
      008987 AE 50 19         [ 2] 1347 	ldw	x, #0x5019
                                   1348 ; genCall
      00898A CD 8B 8F         [ 4] 1349 	call	_GPIO_WriteLow
                                   1350 ;	./src/stm8_LCD.c: 218: lcd_bus_outputs();
                                   1351 ; genCall
      00898D CD 87 05         [ 4] 1352 	call	_lcd_bus_outputs
                                   1353 ;	./src/stm8_LCD.c: 219: return tmp;
                                   1354 ; genReturn
      008990 7B 01            [ 1] 1355 	ld	a, (0x01, sp)
                                   1356 ; genLabel
      008992                       1357 00126$:
                                   1358 ;	./src/stm8_LCD.c: 220: }
                                   1359 ; genEndFunction
      008992 5B 01            [ 2] 1360 	addw	sp, #1
      008994 81               [ 4] 1361 	ret
                                   1362 ;	./src/stm8_LCD.c: 224: void lcd_bus_sleep(void){
                                   1363 ; genLabel
                                   1364 ;	-----------------------------------------
                                   1365 ;	 function lcd_bus_sleep
                                   1366 ;	-----------------------------------------
                                   1367 ;	Register assignment is optimal.
                                   1368 ;	Stack space usage: 0 bytes.
      008995                       1369 _lcd_bus_sleep:
                                   1370 ;	./src/stm8_LCD.c: 225: LCD_RS_H;
                                   1371 ; genSend
      008995 A6 80            [ 1] 1372 	ld	a, #0x80
                                   1373 ; genSend
      008997 AE 50 19         [ 2] 1374 	ldw	x, #0x5019
                                   1375 ; genCall
      00899A CD 8C BB         [ 4] 1376 	call	_GPIO_WriteHigh
                                   1377 ;	./src/stm8_LCD.c: 226: LCD_RW_H;
                                   1378 ; genSend
      00899D A6 40            [ 1] 1379 	ld	a, #0x40
                                   1380 ; genSend
      00899F AE 50 19         [ 2] 1381 	ldw	x, #0x5019
                                   1382 ; genCall
      0089A2 CD 8C BB         [ 4] 1383 	call	_GPIO_WriteHigh
                                   1384 ;	./src/stm8_LCD.c: 227: lcd_bus_inputs();
                                   1385 ; genCall
      0089A5 CC 87 2E         [ 2] 1386 	jp	_lcd_bus_inputs
                                   1387 ; genLabel
      0089A8                       1388 00101$:
                                   1389 ;	./src/stm8_LCD.c: 228: }
                                   1390 ; genEndFunction
      0089A8 81               [ 4] 1391 	ret
                                   1392 ;	./src/stm8_LCD.c: 231: void lcd_bus_wakeup(void){
                                   1393 ; genLabel
                                   1394 ;	-----------------------------------------
                                   1395 ;	 function lcd_bus_wakeup
                                   1396 ;	-----------------------------------------
                                   1397 ;	Register assignment is optimal.
                                   1398 ;	Stack space usage: 0 bytes.
      0089A9                       1399 _lcd_bus_wakeup:
                                   1400 ;	./src/stm8_LCD.c: 232: LCD_RW_L;
                                   1401 ; genSend
      0089A9 A6 40            [ 1] 1402 	ld	a, #0x40
                                   1403 ; genSend
      0089AB AE 50 19         [ 2] 1404 	ldw	x, #0x5019
                                   1405 ; genCall
      0089AE CD 8B 8F         [ 4] 1406 	call	_GPIO_WriteLow
                                   1407 ;	./src/stm8_LCD.c: 233: LCD_D4_H;
                                   1408 ; genSend
      0089B1 A6 01            [ 1] 1409 	ld	a, #0x01
                                   1410 ; genSend
      0089B3 AE 50 1E         [ 2] 1411 	ldw	x, #0x501e
                                   1412 ; genCall
      0089B6 CD 8C BB         [ 4] 1413 	call	_GPIO_WriteHigh
                                   1414 ;	./src/stm8_LCD.c: 234: LCD_D5_H;
                                   1415 ; genSend
      0089B9 A6 02            [ 1] 1416 	ld	a, #0x02
                                   1417 ; genSend
      0089BB AE 50 1E         [ 2] 1418 	ldw	x, #0x501e
                                   1419 ; genCall
      0089BE CD 8C BB         [ 4] 1420 	call	_GPIO_WriteHigh
                                   1421 ;	./src/stm8_LCD.c: 235: LCD_D6_H;
                                   1422 ; genSend
      0089C1 A6 04            [ 1] 1423 	ld	a, #0x04
                                   1424 ; genSend
      0089C3 AE 50 1E         [ 2] 1425 	ldw	x, #0x501e
                                   1426 ; genCall
      0089C6 CD 8C BB         [ 4] 1427 	call	_GPIO_WriteHigh
                                   1428 ;	./src/stm8_LCD.c: 236: LCD_D7_H;
                                   1429 ; genSend
      0089C9 A6 08            [ 1] 1430 	ld	a, #0x08
                                   1431 ; genSend
      0089CB AE 50 1E         [ 2] 1432 	ldw	x, #0x501e
                                   1433 ; genCall
      0089CE CD 8C BB         [ 4] 1434 	call	_GPIO_WriteHigh
                                   1435 ;	./src/stm8_LCD.c: 237: lcd_bus_outputs();
                                   1436 ; genCall
      0089D1 CC 87 05         [ 2] 1437 	jp	_lcd_bus_outputs
                                   1438 ; genLabel
      0089D4                       1439 00101$:
                                   1440 ;	./src/stm8_LCD.c: 238: }	
                                   1441 ; genEndFunction
      0089D4 81               [ 4] 1442 	ret
                                   1443 ;	./src/stm8_LCD.c: 241: uint8_t lcd_busy_wait(void){
                                   1444 ; genLabel
                                   1445 ;	-----------------------------------------
                                   1446 ;	 function lcd_busy_wait
                                   1447 ;	-----------------------------------------
                                   1448 ;	Register assignment is optimal.
                                   1449 ;	Stack space usage: 0 bytes.
      0089D5                       1450 _lcd_busy_wait:
                                   1451 ;	./src/stm8_LCD.c: 243: while(timeout && lcd_busy()){
                                   1452 ; genAssign
      0089D5 AE 01 F4         [ 2] 1453 	ldw	x, #0x01f4
                                   1454 ; genLabel
      0089D8                       1455 00102$:
                                   1456 ; genIfx
      0089D8 5D               [ 2] 1457 	tnzw	x
      0089D9 26 03            [ 1] 1458 	jrne	00139$
      0089DB CC 89 ED         [ 2] 1459 	jp	00114$
      0089DE                       1460 00139$:
                                   1461 ; genCall
      0089DE 89               [ 2] 1462 	pushw	x
      0089DF CD 89 01         [ 4] 1463 	call	_lcd_read
      0089E2 85               [ 2] 1464 	popw	x
                                   1465 ; genAnd
      0089E3 4D               [ 1] 1466 	tnz	a
      0089E4 2B 03            [ 1] 1467 	jrmi	00140$
      0089E6 CC 89 ED         [ 2] 1468 	jp	00114$
      0089E9                       1469 00140$:
                                   1470 ; skipping generated iCode
                                   1471 ;	./src/stm8_LCD.c: 244: timeout--;
                                   1472 ; genMinus
      0089E9 5A               [ 2] 1473 	decw	x
                                   1474 ; genGoto
      0089EA CC 89 D8         [ 2] 1475 	jp	00102$
                                   1476 ; genLabel
      0089ED                       1477 00114$:
                                   1478 ; genAssign
                                   1479 ;	./src/stm8_LCD.c: 246: if(timeout==0){return 1;} // error, busy still ==1
                                   1480 ; genIfx
      0089ED 5D               [ 2] 1481 	tnzw	x
      0089EE 27 03            [ 1] 1482 	jreq	00141$
      0089F0 CC 89 F8         [ 2] 1483 	jp	00106$
      0089F3                       1484 00141$:
                                   1485 ; genReturn
      0089F3 A6 01            [ 1] 1486 	ld	a, #0x01
      0089F5 CC 89 F9         [ 2] 1487 	jp	00108$
                                   1488 ; genLabel
      0089F8                       1489 00106$:
                                   1490 ;	./src/stm8_LCD.c: 247: else{return 0;}
                                   1491 ; genReturn
      0089F8 4F               [ 1] 1492 	clr	a
                                   1493 ; genLabel
      0089F9                       1494 00108$:
                                   1495 ;	./src/stm8_LCD.c: 248: }
                                   1496 ; genEndFunction
      0089F9 81               [ 4] 1497 	ret
                                   1498 	.area CODE
                                   1499 	.area CONST
                                   1500 	.area INITIALIZER
                                   1501 	.area CABS (ABS)
