                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module delay
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _delay_ms
                                     12 	.globl _delay_us
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	inc/delay.h: 14: static inline void _delay_cycl( unsigned short __ticks )
                                     51 ; genLabel
                                     52 ;	-----------------------------------------
                                     53 ;	 function _delay_cycl
                                     54 ;	-----------------------------------------
                                     55 ;	Register assignment is optimal.
                                     56 ;	Stack space usage: 0 bytes.
      0080C2                         57 __delay_cycl:
                                     58 ; genReceive
                                     59 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                     60 ;	genInline
      0080C2 9D               [ 1]   61 	nop
      0080C3 9D               [ 1]   62 	nop
                                     63 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                     64 ; genAssign
                                     65 ; genLabel
      0080C4                         66 00101$:
                                     67 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                     68 ; genMinus
      0080C4 5A               [ 2]   69 	decw	x
                                     70 ;	inc/delay.h: 26: } while ( __ticks );
                                     71 ; genIfx
      0080C5 5D               [ 2]   72 	tnzw	x
      0080C6 27 03            [ 1]   73 	jreq	00121$
      0080C8 CC 80 C4         [ 2]   74 	jp	00101$
      0080CB                         75 00121$:
                                     76 ;	inc/delay.h: 27: __asm__("nop\n");
                                     77 ;	genInline
      0080CB 9D               [ 1]   78 	nop
                                     79 ; genLabel
      0080CC                         80 00104$:
                                     81 ;	inc/delay.h: 37: }
                                     82 ; genEndFunction
      0080CC 81               [ 4]   83 	ret
                                     84 ;	inc/delay.h: 39: static inline void _delay_us( const unsigned short __us )
                                     85 ; genLabel
                                     86 ;	-----------------------------------------
                                     87 ;	 function _delay_us
                                     88 ;	-----------------------------------------
                                     89 ;	Register assignment might be sub-optimal.
                                     90 ;	Stack space usage: 0 bytes.
      0080CD                         91 __delay_us:
                                     92 ; genReceive
                                     93 ;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
                                     94 ; genCast
                                     95 ; genAssign
      0080CD 90 5F            [ 1]   96 	clrw	y
                                     97 ; genIPush
      0080CF 89               [ 2]   98 	pushw	x
      0080D0 90 89            [ 2]   99 	pushw	y
                                    100 ; genIPush
      0080D2 4B 00            [ 1]  101 	push	#0x00
      0080D4 4B 24            [ 1]  102 	push	#0x24
      0080D6 4B F4            [ 1]  103 	push	#0xf4
      0080D8 4B 00            [ 1]  104 	push	#0x00
                                    105 ; genCall
      0080DA CD 8C D0         [ 4]  106 	call	__mullong
      0080DD 5B 08            [ 2]  107 	addw	sp, #8
                                    108 ; genCast
                                    109 ; genAssign
                                    110 ; genIPush
      0080DF 4B 40            [ 1]  111 	push	#0x40
      0080E1 4B 42            [ 1]  112 	push	#0x42
      0080E3 4B 0F            [ 1]  113 	push	#0x0f
      0080E5 4B 00            [ 1]  114 	push	#0x00
                                    115 ; genIPush
      0080E7 89               [ 2]  116 	pushw	x
      0080E8 90 89            [ 2]  117 	pushw	y
                                    118 ; genCall
      0080EA CD 8B 36         [ 4]  119 	call	__divulong
      0080ED 5B 08            [ 2]  120 	addw	sp, #8
                                    121 ; genMinus
      0080EF 1D 00 05         [ 2]  122 	subw	x, #0x0005
      0080F2 24 02            [ 1]  123 	jrnc	00122$
      0080F4 90 5A            [ 2]  124 	decw	y
      0080F6                        125 00122$:
                                    126 ; genIPush
      0080F6 4B 05            [ 1]  127 	push	#0x05
      0080F8 4B 00            [ 1]  128 	push	#0x00
      0080FA 4B 00            [ 1]  129 	push	#0x00
      0080FC 4B 00            [ 1]  130 	push	#0x00
                                    131 ; genIPush
      0080FE 89               [ 2]  132 	pushw	x
      0080FF 90 89            [ 2]  133 	pushw	y
                                    134 ; genCall
      008101 CD 8B 36         [ 4]  135 	call	__divulong
      008104 5B 08            [ 2]  136 	addw	sp, #8
                                    137 ; genCast
                                    138 ; genAssign
                                    139 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    140 ;	genInline
      008106 9D               [ 1]  141 	nop
      008107 9D               [ 1]  142 	nop
                                    143 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    144 ; genAssign
                                    145 ; genLabel
      008108                        146 00101$:
                                    147 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    148 ; genMinus
      008108 5A               [ 2]  149 	decw	x
                                    150 ;	inc/delay.h: 26: } while ( __ticks );
                                    151 ; genIfx
      008109 5D               [ 2]  152 	tnzw	x
      00810A 27 03            [ 1]  153 	jreq	00123$
      00810C CC 81 08         [ 2]  154 	jp	00101$
      00810F                        155 00123$:
                                    156 ;	inc/delay.h: 27: __asm__("nop\n");
                                    157 ;	genInline
      00810F 9D               [ 1]  158 	nop
                                    159 ;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
                                    160 ; genLabel
      008110                        161 00105$:
                                    162 ;	inc/delay.h: 42: }
                                    163 ; genEndFunction
      008110 81               [ 4]  164 	ret
                                    165 ;	./src/delay.c: 4: void delay_us(uint8_t us)
                                    166 ; genLabel
                                    167 ;	-----------------------------------------
                                    168 ;	 function delay_us
                                    169 ;	-----------------------------------------
                                    170 ;	Register assignment might be sub-optimal.
                                    171 ;	Stack space usage: 4 bytes.
      008111                        172 _delay_us:
      008111 52 04            [ 2]  173 	sub	sp, #4
                                    174 ; genReceive
                                    175 ;	./src/delay.c: 6: _delay_us(us);
                                    176 ; genCast
                                    177 ; genAssign
                                    178 ;	inc/delay.h: 41: _delay_cycl( (unsigned short)( T_COUNT(__us) );
                                    179 ; genCast
                                    180 ; genAssign
      008113 5F               [ 1]  181 	clrw	x
      008114 0F 01            [ 1]  182 	clr	(0x01, sp)
                                    183 ; genIPush
      008116 88               [ 1]  184 	push	a
      008117 89               [ 2]  185 	pushw	x
      008118 4F               [ 1]  186 	clr	a
      008119 88               [ 1]  187 	push	a
                                    188 ; genIPush
      00811A 4B 00            [ 1]  189 	push	#0x00
      00811C 4B 24            [ 1]  190 	push	#0x24
      00811E 4B F4            [ 1]  191 	push	#0xf4
      008120 4B 00            [ 1]  192 	push	#0x00
                                    193 ; genCall
      008122 CD 8C D0         [ 4]  194 	call	__mullong
      008125 5B 08            [ 2]  195 	addw	sp, #8
                                    196 ; genCast
                                    197 ; genAssign
                                    198 ; genIPush
      008127 4B 40            [ 1]  199 	push	#0x40
      008129 4B 42            [ 1]  200 	push	#0x42
      00812B 4B 0F            [ 1]  201 	push	#0x0f
      00812D 4B 00            [ 1]  202 	push	#0x00
                                    203 ; genIPush
      00812F 89               [ 2]  204 	pushw	x
      008130 90 89            [ 2]  205 	pushw	y
                                    206 ; genCall
      008132 CD 8B 36         [ 4]  207 	call	__divulong
      008135 5B 08            [ 2]  208 	addw	sp, #8
                                    209 ; genMinus
      008137 1D 00 05         [ 2]  210 	subw	x, #0x0005
      00813A 24 02            [ 1]  211 	jrnc	00123$
      00813C 90 5A            [ 2]  212 	decw	y
      00813E                        213 00123$:
                                    214 ; genIPush
      00813E 4B 05            [ 1]  215 	push	#0x05
      008140 4B 00            [ 1]  216 	push	#0x00
      008142 4B 00            [ 1]  217 	push	#0x00
      008144 4B 00            [ 1]  218 	push	#0x00
                                    219 ; genIPush
      008146 89               [ 2]  220 	pushw	x
      008147 90 89            [ 2]  221 	pushw	y
                                    222 ; genCall
      008149 CD 8B 36         [ 4]  223 	call	__divulong
      00814C 5B 08            [ 2]  224 	addw	sp, #8
                                    225 ; genCast
                                    226 ; genAssign
                                    227 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    228 ;	genInline
      00814E 9D               [ 1]  229 	nop
      00814F 9D               [ 1]  230 	nop
                                    231 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    232 ; genAssign
                                    233 ; genLabel
      008150                        234 00101$:
                                    235 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    236 ; genMinus
      008150 5A               [ 2]  237 	decw	x
                                    238 ;	inc/delay.h: 26: } while ( __ticks );
                                    239 ; genIfx
      008151 5D               [ 2]  240 	tnzw	x
      008152 27 03            [ 1]  241 	jreq	00124$
      008154 CC 81 50         [ 2]  242 	jp	00101$
      008157                        243 00124$:
                                    244 ;	inc/delay.h: 27: __asm__("nop\n");
                                    245 ;	genInline
      008157 9D               [ 1]  246 	nop
                                    247 ;	./src/delay.c: 6: _delay_us(us);
                                    248 ; genLabel
      008158                        249 00106$:
                                    250 ;	./src/delay.c: 7: }
                                    251 ; genEndFunction
      008158 5B 04            [ 2]  252 	addw	sp, #4
      00815A 81               [ 4]  253 	ret
                                    254 ;	./src/delay.c: 9: void delay_ms(uint16_t ms)
                                    255 ; genLabel
                                    256 ;	-----------------------------------------
                                    257 ;	 function delay_ms
                                    258 ;	-----------------------------------------
                                    259 ;	Register assignment might be sub-optimal.
                                    260 ;	Stack space usage: 2 bytes.
      00815B                        261 _delay_ms:
      00815B 89               [ 2]  262 	pushw	x
                                    263 ; genReceive
      00815C 1F 01            [ 2]  264 	ldw	(0x01, sp), x
                                    265 ;	./src/delay.c: 11: for (int16_t i = 0; i < ms; i++) {
                                    266 ; genAssign
      00815E 90 5F            [ 1]  267 	clrw	y
                                    268 ; genLabel
      008160                        269 00123$:
                                    270 ; genCast
                                    271 ; genAssign
      008160 93               [ 1]  272 	ldw	x, y
                                    273 ; genCmp
                                    274 ; genCmpTnz
      008161 13 01            [ 2]  275 	cpw	x, (0x01, sp)
      008163 25 03            [ 1]  276 	jrc	00202$
      008165 CC 81 A1         [ 2]  277 	jp	00125$
      008168                        278 00202$:
                                    279 ; skipping generated iCode
                                    280 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    281 ;	genInline
      008168 9D               [ 1]  282 	nop
      008169 9D               [ 1]  283 	nop
                                    284 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    285 ; genAssign
      00816A AE 03 1F         [ 2]  286 	ldw	x, #0x031f
                                    287 ; genLabel
      00816D                        288 00102$:
                                    289 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    290 ; genMinus
      00816D 5A               [ 2]  291 	decw	x
                                    292 ;	inc/delay.h: 26: } while ( __ticks );
                                    293 ; genIfx
      00816E 5D               [ 2]  294 	tnzw	x
      00816F 27 03            [ 1]  295 	jreq	00203$
      008171 CC 81 6D         [ 2]  296 	jp	00102$
      008174                        297 00203$:
                                    298 ;	inc/delay.h: 27: __asm__("nop\n");
                                    299 ;	genInline
      008174 9D               [ 1]  300 	nop
                                    301 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    302 ;	genInline
      008175 9D               [ 1]  303 	nop
      008176 9D               [ 1]  304 	nop
                                    305 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    306 ; genAssign
      008177 AE 03 1F         [ 2]  307 	ldw	x, #0x031f
                                    308 ; genLabel
      00817A                        309 00107$:
                                    310 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    311 ; genMinus
      00817A 5A               [ 2]  312 	decw	x
                                    313 ;	inc/delay.h: 26: } while ( __ticks );
                                    314 ; genIfx
      00817B 5D               [ 2]  315 	tnzw	x
      00817C 27 03            [ 1]  316 	jreq	00204$
      00817E CC 81 7A         [ 2]  317 	jp	00107$
      008181                        318 00204$:
                                    319 ;	inc/delay.h: 27: __asm__("nop\n");
                                    320 ;	genInline
      008181 9D               [ 1]  321 	nop
                                    322 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    323 ;	genInline
      008182 9D               [ 1]  324 	nop
      008183 9D               [ 1]  325 	nop
                                    326 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    327 ; genAssign
      008184 AE 03 1F         [ 2]  328 	ldw	x, #0x031f
                                    329 ; genLabel
      008187                        330 00112$:
                                    331 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    332 ; genMinus
      008187 5A               [ 2]  333 	decw	x
                                    334 ;	inc/delay.h: 26: } while ( __ticks );
                                    335 ; genIfx
      008188 5D               [ 2]  336 	tnzw	x
      008189 27 03            [ 1]  337 	jreq	00205$
      00818B CC 81 87         [ 2]  338 	jp	00112$
      00818E                        339 00205$:
                                    340 ;	inc/delay.h: 27: __asm__("nop\n");
                                    341 ;	genInline
      00818E 9D               [ 1]  342 	nop
                                    343 ;	inc/delay.h: 23: __asm__("nop\n nop\n"); 
                                    344 ;	genInline
      00818F 9D               [ 1]  345 	nop
      008190 9D               [ 1]  346 	nop
                                    347 ;	inc/delay.h: 24: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                                    348 ; genAssign
      008191 AE 03 08         [ 2]  349 	ldw	x, #0x0308
                                    350 ; genLabel
      008194                        351 00117$:
                                    352 ;	inc/delay.h: 25: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
                                    353 ; genMinus
      008194 5A               [ 2]  354 	decw	x
                                    355 ;	inc/delay.h: 26: } while ( __ticks );
                                    356 ; genIfx
      008195 5D               [ 2]  357 	tnzw	x
      008196 27 03            [ 1]  358 	jreq	00206$
      008198 CC 81 94         [ 2]  359 	jp	00117$
      00819B                        360 00206$:
                                    361 ;	inc/delay.h: 27: __asm__("nop\n");
                                    362 ;	genInline
      00819B 9D               [ 1]  363 	nop
                                    364 ;	./src/delay.c: 11: for (int16_t i = 0; i < ms; i++) {
                                    365 ; genPlus
      00819C 90 5C            [ 1]  366 	incw	y
                                    367 ; genGoto
      00819E CC 81 60         [ 2]  368 	jp	00123$
                                    369 ; genLabel
      0081A1                        370 00125$:
                                    371 ;	./src/delay.c: 17: }
                                    372 ; genEndFunction
      0081A1 85               [ 2]  373 	popw	x
      0081A2 81               [ 4]  374 	ret
                                    375 	.area CODE
                                    376 	.area CONST
                                    377 	.area INITIALIZER
                                    378 	.area CABS (ABS)
