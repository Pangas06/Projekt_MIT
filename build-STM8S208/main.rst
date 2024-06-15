                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _zvuk_vystup
                                     13 	.globl _zvuk_vstup
                                     14 	.globl _lcd_puts
                                     15 	.globl _lcd_gotoxy
                                     16 	.globl _lcd_init
                                     17 	.globl _milis
                                     18 	.globl _init_milis
                                     19 	.globl _sprintf
                                     20 	.globl _GPIO_ReadInputPin
                                     21 	.globl _GPIO_WriteReverse
                                     22 	.globl _GPIO_WriteLow
                                     23 	.globl _GPIO_WriteHigh
                                     24 	.globl _GPIO_Init
                                     25 	.globl _CLK_HSIPrescalerConfig
                                     26 	.globl _init
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DATA
                                     31 ;--------------------------------------------------------
                                     32 ; ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area INITIALIZED
                                     35 ;--------------------------------------------------------
                                     36 ; Stack segment in internal ram
                                     37 ;--------------------------------------------------------
                                     38 	.area SSEG
      009367                         39 __start__stack:
      009367                         40 	.ds	1
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; absolute external ram data
                                     44 ;--------------------------------------------------------
                                     45 	.area DABS (ABS)
                                     46 
                                     47 ; default segment ordering for linker
                                     48 	.area HOME
                                     49 	.area GSINIT
                                     50 	.area GSFINAL
                                     51 	.area CONST
                                     52 	.area INITIALIZER
                                     53 	.area CODE
                                     54 
                                     55 ;--------------------------------------------------------
                                     56 ; interrupt vector
                                     57 ;--------------------------------------------------------
                                     58 	.area HOME
      008000                         59 __interrupt_vect:
      008000 82 00 80 6F             60 	int s_GSINIT ; reset
      008004 82 00 89 FA             61 	int _TRAP_IRQHandler ; trap
      008008 82 00 89 FB             62 	int _TLI_IRQHandler ; int0
      00800C 82 00 89 FC             63 	int _AWU_IRQHandler ; int1
      008010 82 00 89 FD             64 	int _CLK_IRQHandler ; int2
      008014 82 00 89 FE             65 	int _EXTI_PORTA_IRQHandler ; int3
      008018 82 00 89 FF             66 	int _EXTI_PORTB_IRQHandler ; int4
      00801C 82 00 8A 00             67 	int _EXTI_PORTC_IRQHandler ; int5
      008020 82 00 8A 01             68 	int _EXTI_PORTD_IRQHandler ; int6
      008024 82 00 8A 02             69 	int _EXTI_PORTE_IRQHandler ; int7
      008028 82 00 8A 03             70 	int _CAN_RX_IRQHandler ; int8
      00802C 82 00 8A 04             71 	int _CAN_TX_IRQHandler ; int9
      008030 82 00 8A 05             72 	int _SPI_IRQHandler ; int10
      008034 82 00 8A 06             73 	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ; int11
      008038 82 00 8A 07             74 	int _TIM1_CAP_COM_IRQHandler ; int12
      00803C 82 00 8A 08             75 	int _TIM2_UPD_OVF_BRK_IRQHandler ; int13
      008040 82 00 8A 09             76 	int _TIM2_CAP_COM_IRQHandler ; int14
      008044 82 00 8A 0A             77 	int _TIM3_UPD_OVF_BRK_IRQHandler ; int15
      008048 82 00 8A 0B             78 	int _TIM3_CAP_COM_IRQHandler ; int16
      00804C 82 00 8A 0C             79 	int _UART1_TX_IRQHandler ; int17
      008050 82 00 8A 0D             80 	int _UART1_RX_IRQHandler ; int18
      008054 82 00 8A 0E             81 	int _I2C_IRQHandler ; int19
      008058 82 00 8A 0F             82 	int _UART3_TX_IRQHandler ; int20
      00805C 82 00 8A 10             83 	int _UART3_RX_IRQHandler ; int21
      008060 82 00 8A 11             84 	int _ADC2_IRQHandler ; int22
      008064 82 00 8A 12             85 	int _TIM4_UPD_OVF_IRQHandler ; int23
      008068 82 00 8A 2C             86 	int _EEPROM_EEC_IRQHandler ; int24
                                     87 ;--------------------------------------------------------
                                     88 ; global & static initialisations
                                     89 ;--------------------------------------------------------
                                     90 	.area HOME
                                     91 	.area GSINIT
                                     92 	.area GSFINAL
                                     93 	.area GSINIT
      00806F CD 8B 9B         [ 4]   94 	call	___sdcc_external_startup
      008072 4D               [ 1]   95 	tnz	a
      008073 27 03            [ 1]   96 	jreq	__sdcc_init_data
      008075 CC 80 6C         [ 2]   97 	jp	__sdcc_program_startup
      008078                         98 __sdcc_init_data:
                                     99 ; stm8_genXINIT() start
      008078 AE 00 00         [ 2]  100 	ldw x, #l_DATA
      00807B 27 07            [ 1]  101 	jreq	00002$
      00807D                        102 00001$:
      00807D 72 4F 00 00      [ 1]  103 	clr (s_DATA - 1, x)
      008081 5A               [ 2]  104 	decw x
      008082 26 F9            [ 1]  105 	jrne	00001$
      008084                        106 00002$:
      008084 AE 00 04         [ 2]  107 	ldw	x, #l_INITIALIZER
      008087 27 09            [ 1]  108 	jreq	00004$
      008089                        109 00003$:
      008089 D6 80 BD         [ 1]  110 	ld	a, (s_INITIALIZER - 1, x)
      00808C D7 00 00         [ 1]  111 	ld	(s_INITIALIZED - 1, x), a
      00808F 5A               [ 2]  112 	decw	x
      008090 26 F7            [ 1]  113 	jrne	00003$
      008092                        114 00004$:
                                    115 ; stm8_genXINIT() end
                                    116 	.area GSFINAL
      008092 CC 80 6C         [ 2]  117 	jp	__sdcc_program_startup
                                    118 ;--------------------------------------------------------
                                    119 ; Home
                                    120 ;--------------------------------------------------------
                                    121 	.area HOME
                                    122 	.area HOME
      00806C                        123 __sdcc_program_startup:
      00806C CC 83 DD         [ 2]  124 	jp	_main
                                    125 ;	return from main will return to caller
                                    126 ;--------------------------------------------------------
                                    127 ; code
                                    128 ;--------------------------------------------------------
                                    129 	.area CODE
                                    130 ;	./src/main.c: 10: void init(void)
                                    131 ; genLabel
                                    132 ;	-----------------------------------------
                                    133 ;	 function init
                                    134 ;	-----------------------------------------
                                    135 ;	Register assignment is optimal.
                                    136 ;	Stack space usage: 0 bytes.
      0081A3                        137 _init:
                                    138 ;	./src/main.c: 12: CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);      // taktovani MCU na 16MHz
                                    139 ; genSend
      0081A3 4F               [ 1]  140 	clr	a
                                    141 ; genCall
      0081A4 CD 8B B9         [ 4]  142 	call	_CLK_HSIPrescalerConfig
                                    143 ;	./src/main.c: 13: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
                                    144 ; genIPush
      0081A7 4B C0            [ 1]  145 	push	#0xc0
                                    146 ; genSend
      0081A9 A6 20            [ 1]  147 	ld	a, #0x20
                                    148 ; genSend
      0081AB AE 50 0A         [ 2]  149 	ldw	x, #0x500a
                                    150 ; genCall
      0081AE CD 8A 2D         [ 4]  151 	call	_GPIO_Init
                                    152 ;	./src/main.c: 15: GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_FL_NO_IT);
                                    153 ; genIPush
      0081B1 4B 00            [ 1]  154 	push	#0x00
                                    155 ; genSend
      0081B3 A6 10            [ 1]  156 	ld	a, #0x10
                                    157 ; genSend
      0081B5 AE 50 14         [ 2]  158 	ldw	x, #0x5014
                                    159 ; genCall
      0081B8 CD 8A 2D         [ 4]  160 	call	_GPIO_Init
                                    161 ;	./src/main.c: 16: GPIO_Init(SENZOR1_PORT, SENZOR1_PIN, GPIO_MODE_IN_FL_NO_IT);
                                    162 ; genIPush
      0081BB 4B 00            [ 1]  163 	push	#0x00
                                    164 ; genSend
      0081BD A6 80            [ 1]  165 	ld	a, #0x80
                                    166 ; genSend
      0081BF AE 50 0A         [ 2]  167 	ldw	x, #0x500a
                                    168 ; genCall
      0081C2 CD 8A 2D         [ 4]  169 	call	_GPIO_Init
                                    170 ;	./src/main.c: 17: GPIO_Init(SENZOR2_PORT, SENZOR2_PIN, GPIO_MODE_IN_FL_NO_IT);
                                    171 ; genIPush
      0081C5 4B 00            [ 1]  172 	push	#0x00
                                    173 ; genSend
      0081C7 A6 40            [ 1]  174 	ld	a, #0x40
                                    175 ; genSend
      0081C9 AE 50 0A         [ 2]  176 	ldw	x, #0x500a
                                    177 ; genCall
      0081CC CD 8A 2D         [ 4]  178 	call	_GPIO_Init
                                    179 ;	./src/main.c: 18: GPIO_Init(PZ_PORT, PZ_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
                                    180 ; genIPush
      0081CF 4B C0            [ 1]  181 	push	#0xc0
                                    182 ; genSend
      0081D1 A6 10            [ 1]  183 	ld	a, #0x10
                                    184 ; genSend
      0081D3 AE 50 0F         [ 2]  185 	ldw	x, #0x500f
                                    186 ; genCall
      0081D6 CD 8A 2D         [ 4]  187 	call	_GPIO_Init
                                    188 ;	./src/main.c: 20: init_milis();
                                    189 ; genCall
      0081D9 CC 85 82         [ 2]  190 	jp	_init_milis
                                    191 ; genLabel
      0081DC                        192 00101$:
                                    193 ;	./src/main.c: 21: }
                                    194 ; genEndFunction
      0081DC 81               [ 4]  195 	ret
                                    196 ;	./src/main.c: 23: void zvuk_vstup(void){
                                    197 ; genLabel
                                    198 ;	-----------------------------------------
                                    199 ;	 function zvuk_vstup
                                    200 ;	-----------------------------------------
                                    201 ;	Register assignment might be sub-optimal.
                                    202 ;	Stack space usage: 13 bytes.
      0081DD                        203 _zvuk_vstup:
      0081DD 52 0D            [ 2]  204 	sub	sp, #13
                                    205 ;	./src/main.c: 28: uint16_t zvuk_stav = 1;
                                    206 ; genAssign
      0081DF A6 01            [ 1]  207 	ld	a, #0x01
      0081E1 6B 01            [ 1]  208 	ld	(0x01, sp), a
                                    209 ;	./src/main.c: 31: time = milis();
                                    210 ; genCall
      0081E3 CD 85 62         [ 4]  211 	call	_milis
      0081E6 1F 04            [ 2]  212 	ldw	(0x04, sp), x
      0081E8 17 02            [ 2]  213 	ldw	(0x02, sp), y
                                    214 ;	./src/main.c: 32: lastTime = milis();
                                    215 ; genCall
      0081EA CD 85 62         [ 4]  216 	call	_milis
      0081ED 1F 08            [ 2]  217 	ldw	(0x08, sp), x
      0081EF 17 06            [ 2]  218 	ldw	(0x06, sp), y
                                    219 ;	./src/main.c: 33: while(1){
                                    220 ; genLabel
      0081F1                        221 00113$:
                                    222 ;	./src/main.c: 35: if (UP == zvuk_stav){
                                    223 ; genCmpEQorNE
      0081F1 7B 01            [ 1]  224 	ld	a, (0x01, sp)
      0081F3 4A               [ 1]  225 	dec	a
      0081F4 26 03            [ 1]  226 	jrne	00179$
      0081F6 CC 81 FC         [ 2]  227 	jp	00180$
      0081F9                        228 00179$:
      0081F9 CC 82 32         [ 2]  229 	jp	00108$
      0081FC                        230 00180$:
                                    231 ; skipping generated iCode
                                    232 ;	./src/main.c: 36: PZ_UP;
                                    233 ; genSend
      0081FC A6 10            [ 1]  234 	ld	a, #0x10
                                    235 ; genSend
      0081FE AE 50 0F         [ 2]  236 	ldw	x, #0x500f
                                    237 ; genCall
      008201 CD 8B 8F         [ 4]  238 	call	_GPIO_WriteLow
                                    239 ;	./src/main.c: 37: if (milis() - lastTime > 1) {
                                    240 ; genCall
      008204 CD 85 62         [ 4]  241 	call	_milis
      008207 51               [ 1]  242 	exgw	x, y
                                    243 ; genMinus
      008208 72 F2 08         [ 2]  244 	subw	y, (0x08, sp)
      00820B 17 0C            [ 2]  245 	ldw	(0x0c, sp), y
      00820D 9F               [ 1]  246 	ld	a, xl
      00820E 12 07            [ 1]  247 	sbc	a, (0x07, sp)
      008210 6B 0B            [ 1]  248 	ld	(0x0b, sp), a
      008212 9E               [ 1]  249 	ld	a, xh
      008213 12 06            [ 1]  250 	sbc	a, (0x06, sp)
      008215 6B 0A            [ 1]  251 	ld	(0x0a, sp), a
                                    252 ; genCmp
                                    253 ; genCmpTnz
      008217 5F               [ 1]  254 	clrw	x
      008218 5C               [ 1]  255 	incw	x
      008219 13 0C            [ 2]  256 	cpw	x, (0x0c, sp)
      00821B 4F               [ 1]  257 	clr	a
      00821C 12 0B            [ 1]  258 	sbc	a, (0x0b, sp)
      00821E 4F               [ 1]  259 	clr	a
      00821F 12 0A            [ 1]  260 	sbc	a, (0x0a, sp)
      008221 25 03            [ 1]  261 	jrc	00181$
      008223 CC 82 73         [ 2]  262 	jp	00109$
      008226                        263 00181$:
                                    264 ; skipping generated iCode
                                    265 ;	./src/main.c: 38: lastTime = milis();
                                    266 ; genCall
      008226 CD 85 62         [ 4]  267 	call	_milis
      008229 1F 08            [ 2]  268 	ldw	(0x08, sp), x
      00822B 17 06            [ 2]  269 	ldw	(0x06, sp), y
                                    270 ;	./src/main.c: 39: zvuk_stav = 0;
                                    271 ; genAssign
      00822D 0F 01            [ 1]  272 	clr	(0x01, sp)
                                    273 ; genGoto
      00822F CC 82 73         [ 2]  274 	jp	00109$
                                    275 ; genLabel
      008232                        276 00108$:
                                    277 ;	./src/main.c: 41: }else if (DOWN == zvuk_stav){
                                    278 ; genCmpEQorNE
      008232 7B 01            [ 1]  279 	ld	a, (0x01, sp)
      008234 A1 00            [ 1]  280 	cp	a, #0x00
      008236 26 03            [ 1]  281 	jrne	00183$
      008238 CC 82 3E         [ 2]  282 	jp	00184$
      00823B                        283 00183$:
      00823B CC 82 73         [ 2]  284 	jp	00109$
      00823E                        285 00184$:
                                    286 ; skipping generated iCode
                                    287 ;	./src/main.c: 42: PZ_DOWN;
                                    288 ; genSend
      00823E A6 10            [ 1]  289 	ld	a, #0x10
                                    290 ; genSend
      008240 AE 50 0F         [ 2]  291 	ldw	x, #0x500f
                                    292 ; genCall
      008243 CD 8C BB         [ 4]  293 	call	_GPIO_WriteHigh
                                    294 ;	./src/main.c: 43: if (milis() - lastTime > 1) {
                                    295 ; genCall
      008246 CD 85 62         [ 4]  296 	call	_milis
      008249 51               [ 1]  297 	exgw	x, y
                                    298 ; genMinus
      00824A 72 F2 08         [ 2]  299 	subw	y, (0x08, sp)
      00824D 17 0C            [ 2]  300 	ldw	(0x0c, sp), y
      00824F 9F               [ 1]  301 	ld	a, xl
      008250 12 07            [ 1]  302 	sbc	a, (0x07, sp)
      008252 6B 0B            [ 1]  303 	ld	(0x0b, sp), a
      008254 9E               [ 1]  304 	ld	a, xh
      008255 12 06            [ 1]  305 	sbc	a, (0x06, sp)
      008257 6B 0A            [ 1]  306 	ld	(0x0a, sp), a
                                    307 ; genCmp
                                    308 ; genCmpTnz
      008259 5F               [ 1]  309 	clrw	x
      00825A 5C               [ 1]  310 	incw	x
      00825B 13 0C            [ 2]  311 	cpw	x, (0x0c, sp)
      00825D 4F               [ 1]  312 	clr	a
      00825E 12 0B            [ 1]  313 	sbc	a, (0x0b, sp)
      008260 4F               [ 1]  314 	clr	a
      008261 12 0A            [ 1]  315 	sbc	a, (0x0a, sp)
      008263 25 03            [ 1]  316 	jrc	00185$
      008265 CC 82 73         [ 2]  317 	jp	00109$
      008268                        318 00185$:
                                    319 ; skipping generated iCode
                                    320 ;	./src/main.c: 44: lastTime = milis();
                                    321 ; genCall
      008268 CD 85 62         [ 4]  322 	call	_milis
      00826B 1F 08            [ 2]  323 	ldw	(0x08, sp), x
      00826D 17 06            [ 2]  324 	ldw	(0x06, sp), y
                                    325 ;	./src/main.c: 45: zvuk_stav = 1;
                                    326 ; genAssign
      00826F A6 01            [ 1]  327 	ld	a, #0x01
      008271 6B 01            [ 1]  328 	ld	(0x01, sp), a
                                    329 ; genLabel
      008273                        330 00109$:
                                    331 ;	./src/main.c: 48: if(milis() - time > 50){
                                    332 ; genCall
      008273 CD 85 62         [ 4]  333 	call	_milis
      008276 51               [ 1]  334 	exgw	x, y
                                    335 ; genMinus
      008277 72 F2 04         [ 2]  336 	subw	y, (0x04, sp)
      00827A 17 0C            [ 2]  337 	ldw	(0x0c, sp), y
      00827C 9F               [ 1]  338 	ld	a, xl
      00827D 12 03            [ 1]  339 	sbc	a, (0x03, sp)
      00827F 6B 0B            [ 1]  340 	ld	(0x0b, sp), a
      008281 9E               [ 1]  341 	ld	a, xh
      008282 12 02            [ 1]  342 	sbc	a, (0x02, sp)
      008284 6B 0A            [ 1]  343 	ld	(0x0a, sp), a
                                    344 ; genCmp
                                    345 ; genCmpTnz
      008286 AE 00 32         [ 2]  346 	ldw	x, #0x0032
      008289 13 0C            [ 2]  347 	cpw	x, (0x0c, sp)
      00828B 4F               [ 1]  348 	clr	a
      00828C 12 0B            [ 1]  349 	sbc	a, (0x0b, sp)
      00828E 4F               [ 1]  350 	clr	a
      00828F 12 0A            [ 1]  351 	sbc	a, (0x0a, sp)
      008291 25 03            [ 1]  352 	jrc	00186$
      008293 CC 81 F1         [ 2]  353 	jp	00113$
      008296                        354 00186$:
                                    355 ; skipping generated iCode
                                    356 ;	./src/main.c: 49: PZ_UP;
                                    357 ; genSend
      008296 A6 10            [ 1]  358 	ld	a, #0x10
                                    359 ; genSend
      008298 AE 50 0F         [ 2]  360 	ldw	x, #0x500f
                                    361 ; genCall
      00829B CD 8B 8F         [ 4]  362 	call	_GPIO_WriteLow
                                    363 ;	./src/main.c: 54: time = milis();
                                    364 ; genCall
      00829E CD 85 62         [ 4]  365 	call	_milis
      0082A1 1F 08            [ 2]  366 	ldw	(0x08, sp), x
      0082A3 17 06            [ 2]  367 	ldw	(0x06, sp), y
                                    368 ;	./src/main.c: 55: while(1){
                                    369 ; genLabel
      0082A5                        370 00118$:
                                    371 ;	./src/main.c: 56: PZ_REVERSE;
                                    372 ; genSend
      0082A5 A6 10            [ 1]  373 	ld	a, #0x10
                                    374 ; genSend
      0082A7 AE 50 0F         [ 2]  375 	ldw	x, #0x500f
                                    376 ; genCall
      0082AA CD 8A D9         [ 4]  377 	call	_GPIO_WriteReverse
                                    378 ;	./src/main.c: 57: if(milis() - time > 100){
                                    379 ; genCall
      0082AD CD 85 62         [ 4]  380 	call	_milis
      0082B0 51               [ 1]  381 	exgw	x, y
                                    382 ; genMinus
      0082B1 72 F2 08         [ 2]  383 	subw	y, (0x08, sp)
      0082B4 17 0C            [ 2]  384 	ldw	(0x0c, sp), y
      0082B6 9F               [ 1]  385 	ld	a, xl
      0082B7 12 07            [ 1]  386 	sbc	a, (0x07, sp)
      0082B9 6B 0B            [ 1]  387 	ld	(0x0b, sp), a
      0082BB 9E               [ 1]  388 	ld	a, xh
      0082BC 12 06            [ 1]  389 	sbc	a, (0x06, sp)
      0082BE 6B 0A            [ 1]  390 	ld	(0x0a, sp), a
                                    391 ; genCmp
                                    392 ; genCmpTnz
      0082C0 AE 00 64         [ 2]  393 	ldw	x, #0x0064
      0082C3 13 0C            [ 2]  394 	cpw	x, (0x0c, sp)
      0082C5 4F               [ 1]  395 	clr	a
      0082C6 12 0B            [ 1]  396 	sbc	a, (0x0b, sp)
      0082C8 4F               [ 1]  397 	clr	a
      0082C9 12 0A            [ 1]  398 	sbc	a, (0x0a, sp)
      0082CB 25 03            [ 1]  399 	jrc	00187$
      0082CD CC 82 A5         [ 2]  400 	jp	00118$
      0082D0                        401 00187$:
                                    402 ; skipping generated iCode
                                    403 ;	./src/main.c: 58: PZ_UP;
                                    404 ; genSend
      0082D0 A6 10            [ 1]  405 	ld	a, #0x10
                                    406 ; genSend
      0082D2 AE 50 0F         [ 2]  407 	ldw	x, #0x500f
                                    408 ; genCall
      0082D5 5B 0D            [ 2]  409 	addw	sp, #13
      0082D7 CC 8B 8F         [ 2]  410 	jp	_GPIO_WriteLow
                                    411 ;	./src/main.c: 59: break;
                                    412 ; genLabel
      0082DA                        413 00120$:
                                    414 ;	./src/main.c: 62: }
                                    415 ; genEndFunction
      0082DA 5B 0D            [ 2]  416 	addw	sp, #13
      0082DC 81               [ 4]  417 	ret
                                    418 ;	./src/main.c: 64: void zvuk_vystup(void){
                                    419 ; genLabel
                                    420 ;	-----------------------------------------
                                    421 ;	 function zvuk_vystup
                                    422 ;	-----------------------------------------
                                    423 ;	Register assignment might be sub-optimal.
                                    424 ;	Stack space usage: 13 bytes.
      0082DD                        425 _zvuk_vystup:
      0082DD 52 0D            [ 2]  426 	sub	sp, #13
                                    427 ;	./src/main.c: 69: uint16_t zvuk_stav = 1;
                                    428 ; genAssign
      0082DF A6 01            [ 1]  429 	ld	a, #0x01
      0082E1 6B 01            [ 1]  430 	ld	(0x01, sp), a
                                    431 ;	./src/main.c: 72: time = milis();
                                    432 ; genCall
      0082E3 CD 85 62         [ 4]  433 	call	_milis
      0082E6 1F 08            [ 2]  434 	ldw	(0x08, sp), x
      0082E8 17 06            [ 2]  435 	ldw	(0x06, sp), y
                                    436 ;	./src/main.c: 73: while(1){
                                    437 ; genLabel
      0082EA                        438 00104$:
                                    439 ;	./src/main.c: 74: PZ_REVERSE;
                                    440 ; genSend
      0082EA A6 10            [ 1]  441 	ld	a, #0x10
                                    442 ; genSend
      0082EC AE 50 0F         [ 2]  443 	ldw	x, #0x500f
                                    444 ; genCall
      0082EF CD 8A D9         [ 4]  445 	call	_GPIO_WriteReverse
                                    446 ;	./src/main.c: 75: if(milis() - time > 50){
                                    447 ; genCall
      0082F2 CD 85 62         [ 4]  448 	call	_milis
      0082F5 51               [ 1]  449 	exgw	x, y
                                    450 ; genMinus
      0082F6 72 F2 08         [ 2]  451 	subw	y, (0x08, sp)
      0082F9 17 0C            [ 2]  452 	ldw	(0x0c, sp), y
      0082FB 9F               [ 1]  453 	ld	a, xl
      0082FC 12 07            [ 1]  454 	sbc	a, (0x07, sp)
      0082FE 6B 0B            [ 1]  455 	ld	(0x0b, sp), a
      008300 9E               [ 1]  456 	ld	a, xh
      008301 12 06            [ 1]  457 	sbc	a, (0x06, sp)
      008303 6B 0A            [ 1]  458 	ld	(0x0a, sp), a
                                    459 ; genCmp
                                    460 ; genCmpTnz
      008305 AE 00 32         [ 2]  461 	ldw	x, #0x0032
      008308 13 0C            [ 2]  462 	cpw	x, (0x0c, sp)
      00830A 4F               [ 1]  463 	clr	a
      00830B 12 0B            [ 1]  464 	sbc	a, (0x0b, sp)
      00830D 4F               [ 1]  465 	clr	a
      00830E 12 0A            [ 1]  466 	sbc	a, (0x0a, sp)
      008310 25 03            [ 1]  467 	jrc	00178$
      008312 CC 82 EA         [ 2]  468 	jp	00104$
      008315                        469 00178$:
                                    470 ; skipping generated iCode
                                    471 ;	./src/main.c: 76: PZ_UP;
                                    472 ; genSend
      008315 A6 10            [ 1]  473 	ld	a, #0x10
                                    474 ; genSend
      008317 AE 50 0F         [ 2]  475 	ldw	x, #0x500f
                                    476 ; genCall
      00831A CD 8B 8F         [ 4]  477 	call	_GPIO_WriteLow
                                    478 ;	./src/main.c: 81: time = milis();
                                    479 ; genCall
      00831D CD 85 62         [ 4]  480 	call	_milis
      008320 1F 04            [ 2]  481 	ldw	(0x04, sp), x
      008322 17 02            [ 2]  482 	ldw	(0x02, sp), y
                                    483 ;	./src/main.c: 82: lastTime = milis();
                                    484 ; genCall
      008324 CD 85 62         [ 4]  485 	call	_milis
      008327 1F 08            [ 2]  486 	ldw	(0x08, sp), x
      008329 17 06            [ 2]  487 	ldw	(0x06, sp), y
                                    488 ;	./src/main.c: 84: while(1){
                                    489 ; genLabel
      00832B                        490 00118$:
                                    491 ;	./src/main.c: 85: if (UP == zvuk_stav){
                                    492 ; genCmpEQorNE
      00832B 7B 01            [ 1]  493 	ld	a, (0x01, sp)
      00832D 4A               [ 1]  494 	dec	a
      00832E 26 03            [ 1]  495 	jrne	00180$
      008330 CC 83 36         [ 2]  496 	jp	00181$
      008333                        497 00180$:
      008333 CC 83 6C         [ 2]  498 	jp	00113$
      008336                        499 00181$:
                                    500 ; skipping generated iCode
                                    501 ;	./src/main.c: 86: PZ_UP;
                                    502 ; genSend
      008336 A6 10            [ 1]  503 	ld	a, #0x10
                                    504 ; genSend
      008338 AE 50 0F         [ 2]  505 	ldw	x, #0x500f
                                    506 ; genCall
      00833B CD 8B 8F         [ 4]  507 	call	_GPIO_WriteLow
                                    508 ;	./src/main.c: 87: if (milis() - lastTime > 1) {
                                    509 ; genCall
      00833E CD 85 62         [ 4]  510 	call	_milis
      008341 51               [ 1]  511 	exgw	x, y
                                    512 ; genMinus
      008342 72 F2 08         [ 2]  513 	subw	y, (0x08, sp)
      008345 17 0C            [ 2]  514 	ldw	(0x0c, sp), y
      008347 9F               [ 1]  515 	ld	a, xl
      008348 12 07            [ 1]  516 	sbc	a, (0x07, sp)
      00834A 6B 0B            [ 1]  517 	ld	(0x0b, sp), a
      00834C 9E               [ 1]  518 	ld	a, xh
      00834D 12 06            [ 1]  519 	sbc	a, (0x06, sp)
      00834F 6B 0A            [ 1]  520 	ld	(0x0a, sp), a
                                    521 ; genCmp
                                    522 ; genCmpTnz
      008351 5F               [ 1]  523 	clrw	x
      008352 5C               [ 1]  524 	incw	x
      008353 13 0C            [ 2]  525 	cpw	x, (0x0c, sp)
      008355 4F               [ 1]  526 	clr	a
      008356 12 0B            [ 1]  527 	sbc	a, (0x0b, sp)
      008358 4F               [ 1]  528 	clr	a
      008359 12 0A            [ 1]  529 	sbc	a, (0x0a, sp)
      00835B 25 03            [ 1]  530 	jrc	00182$
      00835D CC 83 AD         [ 2]  531 	jp	00114$
      008360                        532 00182$:
                                    533 ; skipping generated iCode
                                    534 ;	./src/main.c: 88: lastTime = milis();
                                    535 ; genCall
      008360 CD 85 62         [ 4]  536 	call	_milis
      008363 1F 08            [ 2]  537 	ldw	(0x08, sp), x
      008365 17 06            [ 2]  538 	ldw	(0x06, sp), y
                                    539 ;	./src/main.c: 89: zvuk_stav = 0;
                                    540 ; genAssign
      008367 0F 01            [ 1]  541 	clr	(0x01, sp)
                                    542 ; genGoto
      008369 CC 83 AD         [ 2]  543 	jp	00114$
                                    544 ; genLabel
      00836C                        545 00113$:
                                    546 ;	./src/main.c: 91: }else if (DOWN == zvuk_stav){
                                    547 ; genCmpEQorNE
      00836C 7B 01            [ 1]  548 	ld	a, (0x01, sp)
      00836E A1 00            [ 1]  549 	cp	a, #0x00
      008370 26 03            [ 1]  550 	jrne	00184$
      008372 CC 83 78         [ 2]  551 	jp	00185$
      008375                        552 00184$:
      008375 CC 83 AD         [ 2]  553 	jp	00114$
      008378                        554 00185$:
                                    555 ; skipping generated iCode
                                    556 ;	./src/main.c: 92: PZ_DOWN;
                                    557 ; genSend
      008378 A6 10            [ 1]  558 	ld	a, #0x10
                                    559 ; genSend
      00837A AE 50 0F         [ 2]  560 	ldw	x, #0x500f
                                    561 ; genCall
      00837D CD 8C BB         [ 4]  562 	call	_GPIO_WriteHigh
                                    563 ;	./src/main.c: 93: if (milis() - lastTime > 1) {
                                    564 ; genCall
      008380 CD 85 62         [ 4]  565 	call	_milis
      008383 51               [ 1]  566 	exgw	x, y
                                    567 ; genMinus
      008384 72 F2 08         [ 2]  568 	subw	y, (0x08, sp)
      008387 17 0C            [ 2]  569 	ldw	(0x0c, sp), y
      008389 9F               [ 1]  570 	ld	a, xl
      00838A 12 07            [ 1]  571 	sbc	a, (0x07, sp)
      00838C 6B 0B            [ 1]  572 	ld	(0x0b, sp), a
      00838E 9E               [ 1]  573 	ld	a, xh
      00838F 12 06            [ 1]  574 	sbc	a, (0x06, sp)
      008391 6B 0A            [ 1]  575 	ld	(0x0a, sp), a
                                    576 ; genCmp
                                    577 ; genCmpTnz
      008393 5F               [ 1]  578 	clrw	x
      008394 5C               [ 1]  579 	incw	x
      008395 13 0C            [ 2]  580 	cpw	x, (0x0c, sp)
      008397 4F               [ 1]  581 	clr	a
      008398 12 0B            [ 1]  582 	sbc	a, (0x0b, sp)
      00839A 4F               [ 1]  583 	clr	a
      00839B 12 0A            [ 1]  584 	sbc	a, (0x0a, sp)
      00839D 25 03            [ 1]  585 	jrc	00186$
      00839F CC 83 AD         [ 2]  586 	jp	00114$
      0083A2                        587 00186$:
                                    588 ; skipping generated iCode
                                    589 ;	./src/main.c: 94: lastTime = milis();
                                    590 ; genCall
      0083A2 CD 85 62         [ 4]  591 	call	_milis
      0083A5 1F 08            [ 2]  592 	ldw	(0x08, sp), x
      0083A7 17 06            [ 2]  593 	ldw	(0x06, sp), y
                                    594 ;	./src/main.c: 95: zvuk_stav = 1;
                                    595 ; genAssign
      0083A9 A6 01            [ 1]  596 	ld	a, #0x01
      0083AB 6B 01            [ 1]  597 	ld	(0x01, sp), a
                                    598 ; genLabel
      0083AD                        599 00114$:
                                    600 ;	./src/main.c: 98: if(milis() - time > 100){
                                    601 ; genCall
      0083AD CD 85 62         [ 4]  602 	call	_milis
      0083B0 51               [ 1]  603 	exgw	x, y
                                    604 ; genMinus
      0083B1 72 F2 04         [ 2]  605 	subw	y, (0x04, sp)
      0083B4 17 0C            [ 2]  606 	ldw	(0x0c, sp), y
      0083B6 9F               [ 1]  607 	ld	a, xl
      0083B7 12 03            [ 1]  608 	sbc	a, (0x03, sp)
      0083B9 6B 0B            [ 1]  609 	ld	(0x0b, sp), a
      0083BB 9E               [ 1]  610 	ld	a, xh
      0083BC 12 02            [ 1]  611 	sbc	a, (0x02, sp)
      0083BE 6B 0A            [ 1]  612 	ld	(0x0a, sp), a
                                    613 ; genCmp
                                    614 ; genCmpTnz
      0083C0 AE 00 64         [ 2]  615 	ldw	x, #0x0064
      0083C3 13 0C            [ 2]  616 	cpw	x, (0x0c, sp)
      0083C5 4F               [ 1]  617 	clr	a
      0083C6 12 0B            [ 1]  618 	sbc	a, (0x0b, sp)
      0083C8 4F               [ 1]  619 	clr	a
      0083C9 12 0A            [ 1]  620 	sbc	a, (0x0a, sp)
      0083CB 25 03            [ 1]  621 	jrc	00187$
      0083CD CC 83 2B         [ 2]  622 	jp	00118$
      0083D0                        623 00187$:
                                    624 ; skipping generated iCode
                                    625 ;	./src/main.c: 99: PZ_UP;
                                    626 ; genSend
      0083D0 A6 10            [ 1]  627 	ld	a, #0x10
                                    628 ; genSend
      0083D2 AE 50 0F         [ 2]  629 	ldw	x, #0x500f
                                    630 ; genCall
      0083D5 5B 0D            [ 2]  631 	addw	sp, #13
      0083D7 CC 8B 8F         [ 2]  632 	jp	_GPIO_WriteLow
                                    633 ;	./src/main.c: 100: break;
                                    634 ; genLabel
      0083DA                        635 00120$:
                                    636 ;	./src/main.c: 103: }
                                    637 ; genEndFunction
      0083DA 5B 0D            [ 2]  638 	addw	sp, #13
      0083DC 81               [ 4]  639 	ret
                                    640 ;	./src/main.c: 105: int main(void){
                                    641 ; genLabel
                                    642 ;	-----------------------------------------
                                    643 ;	 function main
                                    644 ;	-----------------------------------------
                                    645 ;	Register assignment might be sub-optimal.
                                    646 ;	Stack space usage: 60 bytes.
      0083DD                        647 _main:
      0083DD 52 3C            [ 2]  648 	sub	sp, #60
                                    649 ;	./src/main.c: 106: init();
                                    650 ; genCall
      0083DF CD 81 A3         [ 4]  651 	call	_init
                                    652 ;	./src/main.c: 107: uint16_t mezivstup  = 0;
                                    653 ; genAssign
      0083E2 5F               [ 1]  654 	clrw	x
      0083E3 1F 29            [ 2]  655 	ldw	(0x29, sp), x
                                    656 ;	./src/main.c: 108: uint16_t mezivystup  = 0;
                                    657 ; genAssign
      0083E5 5F               [ 1]  658 	clrw	x
      0083E6 1F 2B            [ 2]  659 	ldw	(0x2b, sp), x
                                    660 ;	./src/main.c: 110: uint16_t senzorposledni1 = 0;
                                    661 ; genAssign
      0083E8 0F 38            [ 1]  662 	clr	(0x38, sp)
                                    663 ;	./src/main.c: 112: uint16_t senzorposledni2 = 0;
                                    664 ; genAssign
      0083EA 0F 2D            [ 1]  665 	clr	(0x2d, sp)
                                    666 ;	./src/main.c: 114: uint16_t vstup_ted = 0;
                                    667 ; genAssign
      0083EC 5F               [ 1]  668 	clrw	x
      0083ED 1F 2E            [ 2]  669 	ldw	(0x2e, sp), x
                                    670 ;	./src/main.c: 115: uint16_t vstup_pred = 0;
                                    671 ; genAssign
      0083EF 5F               [ 1]  672 	clrw	x
      0083F0 1F 30            [ 2]  673 	ldw	(0x30, sp), x
                                    674 ;	./src/main.c: 116: uint16_t vystup_ted = 0;
                                    675 ; genAssign
      0083F2 5F               [ 1]  676 	clrw	x
      0083F3 1F 32            [ 2]  677 	ldw	(0x32, sp), x
                                    678 ;	./src/main.c: 117: uint16_t vystup_pred = 0;
                                    679 ; genAssign
      0083F5 5F               [ 1]  680 	clrw	x
      0083F6 1F 34            [ 2]  681 	ldw	(0x34, sp), x
                                    682 ;	./src/main.c: 123: lcd_init();
                                    683 ; genCall
      0083F8 CD 86 38         [ 4]  684 	call	_lcd_init
                                    685 ;	./src/main.c: 124: lcd_gotoxy(0,0);
                                    686 ; genIPush
      0083FB 4B 00            [ 1]  687 	push	#0x00
                                    688 ; genSend
      0083FD 4F               [ 1]  689 	clr	a
                                    690 ; genCall
      0083FE CD 86 B1         [ 4]  691 	call	_lcd_gotoxy
                                    692 ;	./src/main.c: 125: sprintf(text,"vstupy  =   %u",(uint16_t)vstup_ted);
                                    693 ; skipping iCode since result will be rematerialized
                                    694 ; skipping iCode since result will be rematerialized
                                    695 ; skipping iCode since result will be rematerialized
                                    696 ; skipping iCode since result will be rematerialized
                                    697 ; genIPush
      008401 5F               [ 1]  698 	clrw	x
      008402 89               [ 2]  699 	pushw	x
                                    700 ; genIPush
      008403 4B 95            [ 1]  701 	push	#<(___str_0+0)
      008405 4B 80            [ 1]  702 	push	#((___str_0+0) >> 8)
                                    703 ; genIPush
      008407 96               [ 1]  704 	ldw	x, sp
      008408 1C 00 05         [ 2]  705 	addw	x, #5
      00840B 89               [ 2]  706 	pushw	x
                                    707 ; genCall
      00840C CD 8B 1E         [ 4]  708 	call	_sprintf
      00840F 5B 06            [ 2]  709 	addw	sp, #6
                                    710 ;	./src/main.c: 126: lcd_puts(text);
                                    711 ; skipping iCode since result will be rematerialized
                                    712 ; skipping iCode since result will be rematerialized
                                    713 ; genSend
      008411 96               [ 1]  714 	ldw	x, sp
      008412 5C               [ 1]  715 	incw	x
                                    716 ; genCall
      008413 CD 86 27         [ 4]  717 	call	_lcd_puts
                                    718 ;	./src/main.c: 128: lcd_gotoxy(0,1);
                                    719 ; genIPush
      008416 4B 01            [ 1]  720 	push	#0x01
                                    721 ; genSend
      008418 4F               [ 1]  722 	clr	a
                                    723 ; genCall
      008419 CD 86 B1         [ 4]  724 	call	_lcd_gotoxy
                                    725 ;	./src/main.c: 129: sprintf(text2,"vystupy =   %u",(uint16_t)vystup_ted);
                                    726 ; skipping iCode since result will be rematerialized
                                    727 ; skipping iCode since result will be rematerialized
                                    728 ; skipping iCode since result will be rematerialized
                                    729 ; skipping iCode since result will be rematerialized
                                    730 ; genIPush
      00841C 5F               [ 1]  731 	clrw	x
      00841D 89               [ 2]  732 	pushw	x
                                    733 ; genIPush
      00841E 4B A4            [ 1]  734 	push	#<(___str_1+0)
      008420 4B 80            [ 1]  735 	push	#((___str_1+0) >> 8)
                                    736 ; genIPush
      008422 96               [ 1]  737 	ldw	x, sp
      008423 1C 00 19         [ 2]  738 	addw	x, #25
      008426 89               [ 2]  739 	pushw	x
                                    740 ; genCall
      008427 CD 8B 1E         [ 4]  741 	call	_sprintf
      00842A 5B 06            [ 2]  742 	addw	sp, #6
                                    743 ;	./src/main.c: 130: lcd_puts(text2);
                                    744 ; skipping iCode since result will be rematerialized
                                    745 ; skipping iCode since result will be rematerialized
                                    746 ; genSend
      00842C 96               [ 1]  747 	ldw	x, sp
      00842D 1C 00 15         [ 2]  748 	addw	x, #21
                                    749 ; genCall
      008430 CD 86 27         [ 4]  750 	call	_lcd_puts
                                    751 ;	./src/main.c: 131: while(1){/*
                                    752 ; genLabel
      008433                        753 00126$:
                                    754 ;	./src/main.c: 146: senzorstav1 = GPIO_ReadInputPin(SENZOR1_PORT, SENZOR1_PIN);
                                    755 ; genSend
      008433 A6 80            [ 1]  756 	ld	a, #0x80
                                    757 ; genSend
      008435 AE 50 0A         [ 2]  758 	ldw	x, #0x500a
                                    759 ; genCall
      008438 CD 8A E2         [ 4]  760 	call	_GPIO_ReadInputPin
                                    761 ; genCast
                                    762 ; genAssign
      00843B 6B 36            [ 1]  763 	ld	(0x36, sp), a
                                    764 ;	./src/main.c: 147: senzorstav2 = GPIO_ReadInputPin(SENZOR2_PORT, SENZOR2_PIN);
                                    765 ; genSend
      00843D A6 40            [ 1]  766 	ld	a, #0x40
                                    767 ; genSend
      00843F AE 50 0A         [ 2]  768 	ldw	x, #0x500a
                                    769 ; genCall
      008442 CD 8A E2         [ 4]  770 	call	_GPIO_ReadInputPin
                                    771 ; genCast
                                    772 ; genAssign
      008445 6B 37            [ 1]  773 	ld	(0x37, sp), a
                                    774 ;	./src/main.c: 149: if(senzorstav1 == 0 && senzorposledni1 == 1){
                                    775 ; genCast
                                    776 ; genAssign
      008447 7B 38            [ 1]  777 	ld	a, (0x38, sp)
                                    778 ; genCmpEQorNE
      008449 4A               [ 1]  779 	dec	a
      00844A 26 07            [ 1]  780 	jrne	00236$
      00844C A6 01            [ 1]  781 	ld	a, #0x01
      00844E 6B 38            [ 1]  782 	ld	(0x38, sp), a
      008450 CC 84 55         [ 2]  783 	jp	00237$
      008453                        784 00236$:
      008453 0F 38            [ 1]  785 	clr	(0x38, sp)
      008455                        786 00237$:
                                    787 ; genIfx
      008455 0D 36            [ 1]  788 	tnz	(0x36, sp)
      008457 27 03            [ 1]  789 	jreq	00238$
      008459 CC 84 68         [ 2]  790 	jp	00102$
      00845C                        791 00238$:
                                    792 ; genIfx
      00845C 0D 38            [ 1]  793 	tnz	(0x38, sp)
      00845E 26 03            [ 1]  794 	jrne	00239$
      008460 CC 84 68         [ 2]  795 	jp	00102$
      008463                        796 00239$:
                                    797 ;	./src/main.c: 150: mezivstup += 1;
                                    798 ; genCast
                                    799 ; genAssign
      008463 1E 29            [ 2]  800 	ldw	x, (0x29, sp)
                                    801 ; genPlus
      008465 5C               [ 1]  802 	incw	x
                                    803 ; genCast
                                    804 ; genAssign
      008466 1F 29            [ 2]  805 	ldw	(0x29, sp), x
                                    806 ; genLabel
      008468                        807 00102$:
                                    808 ; genCast
                                    809 ; genAssign
      008468 16 29            [ 2]  810 	ldw	y, (0x29, sp)
      00846A 17 39            [ 2]  811 	ldw	(0x39, sp), y
                                    812 ;	./src/main.c: 152: if(senzorstav2 == 0 && senzorposledni2 == 1 && mezivstup == 1){
                                    813 ; genCast
                                    814 ; genAssign
      00846C 7B 2D            [ 1]  815 	ld	a, (0x2d, sp)
                                    816 ; genCmpEQorNE
      00846E 4A               [ 1]  817 	dec	a
      00846F 26 05            [ 1]  818 	jrne	00241$
      008471 A6 01            [ 1]  819 	ld	a, #0x01
      008473 CC 84 77         [ 2]  820 	jp	00242$
      008476                        821 00241$:
      008476 4F               [ 1]  822 	clr	a
      008477                        823 00242$:
                                    824 ; genIfx
      008477 0D 37            [ 1]  825 	tnz	(0x37, sp)
      008479 27 03            [ 1]  826 	jreq	00243$
      00847B CC 84 94         [ 2]  827 	jp	00105$
      00847E                        828 00243$:
                                    829 ; genIfx
      00847E 4D               [ 1]  830 	tnz	a
      00847F 26 03            [ 1]  831 	jrne	00244$
      008481 CC 84 94         [ 2]  832 	jp	00105$
      008484                        833 00244$:
                                    834 ; genCmpEQorNE
      008484 1E 39            [ 2]  835 	ldw	x, (0x39, sp)
      008486 5A               [ 2]  836 	decw	x
      008487 26 03            [ 1]  837 	jrne	00246$
      008489 CC 84 8F         [ 2]  838 	jp	00247$
      00848C                        839 00246$:
      00848C CC 84 94         [ 2]  840 	jp	00105$
      00848F                        841 00247$:
                                    842 ; skipping generated iCode
                                    843 ;	./src/main.c: 153: vstup_ted += 1;
                                    844 ; genCast
                                    845 ; genAssign
      00848F 1E 2E            [ 2]  846 	ldw	x, (0x2e, sp)
                                    847 ; genPlus
      008491 5C               [ 1]  848 	incw	x
                                    849 ; genCast
                                    850 ; genAssign
      008492 1F 2E            [ 2]  851 	ldw	(0x2e, sp), x
                                    852 ; genLabel
      008494                        853 00105$:
                                    854 ;	./src/main.c: 156: if(senzorstav2 == 0 && senzorposledni2 == 1){
                                    855 ; genIfx
      008494 0D 37            [ 1]  856 	tnz	(0x37, sp)
      008496 27 03            [ 1]  857 	jreq	00248$
      008498 CC 84 A6         [ 2]  858 	jp	00109$
      00849B                        859 00248$:
                                    860 ; genIfx
      00849B 4D               [ 1]  861 	tnz	a
      00849C 26 03            [ 1]  862 	jrne	00249$
      00849E CC 84 A6         [ 2]  863 	jp	00109$
      0084A1                        864 00249$:
                                    865 ;	./src/main.c: 157: mezivystup += 1;
                                    866 ; genCast
                                    867 ; genAssign
      0084A1 1E 2B            [ 2]  868 	ldw	x, (0x2b, sp)
                                    869 ; genPlus
      0084A3 5C               [ 1]  870 	incw	x
                                    871 ; genCast
                                    872 ; genAssign
      0084A4 1F 2B            [ 2]  873 	ldw	(0x2b, sp), x
                                    874 ; genLabel
      0084A6                        875 00109$:
                                    876 ; genCast
                                    877 ; genAssign
      0084A6 16 2B            [ 2]  878 	ldw	y, (0x2b, sp)
      0084A8 17 3B            [ 2]  879 	ldw	(0x3b, sp), y
                                    880 ;	./src/main.c: 159: if(senzorstav1 == 0 && senzorposledni1 == 1 && mezivystup == 1){
                                    881 ; genIfx
      0084AA 0D 36            [ 1]  882 	tnz	(0x36, sp)
      0084AC 27 03            [ 1]  883 	jreq	00250$
      0084AE CC 84 C8         [ 2]  884 	jp	00112$
      0084B1                        885 00250$:
                                    886 ; genIfx
      0084B1 0D 38            [ 1]  887 	tnz	(0x38, sp)
      0084B3 26 03            [ 1]  888 	jrne	00251$
      0084B5 CC 84 C8         [ 2]  889 	jp	00112$
      0084B8                        890 00251$:
                                    891 ; genCmpEQorNE
      0084B8 1E 3B            [ 2]  892 	ldw	x, (0x3b, sp)
      0084BA 5A               [ 2]  893 	decw	x
      0084BB 26 03            [ 1]  894 	jrne	00253$
      0084BD CC 84 C3         [ 2]  895 	jp	00254$
      0084C0                        896 00253$:
      0084C0 CC 84 C8         [ 2]  897 	jp	00112$
      0084C3                        898 00254$:
                                    899 ; skipping generated iCode
                                    900 ;	./src/main.c: 160: vystup_ted += 1;
                                    901 ; genCast
                                    902 ; genAssign
      0084C3 1E 32            [ 2]  903 	ldw	x, (0x32, sp)
                                    904 ; genPlus
      0084C5 5C               [ 1]  905 	incw	x
                                    906 ; genCast
                                    907 ; genAssign
      0084C6 1F 32            [ 2]  908 	ldw	(0x32, sp), x
                                    909 ; genLabel
      0084C8                        910 00112$:
                                    911 ;	./src/main.c: 163: senzorposledni1 = senzorstav1;
                                    912 ; genCast
                                    913 ; genAssign
      0084C8 7B 36            [ 1]  914 	ld	a, (0x36, sp)
      0084CA 6B 38            [ 1]  915 	ld	(0x38, sp), a
                                    916 ;	./src/main.c: 164: senzorposledni2 = senzorstav2;
                                    917 ; genCast
                                    918 ; genAssign
      0084CC 7B 37            [ 1]  919 	ld	a, (0x37, sp)
      0084CE 6B 2D            [ 1]  920 	ld	(0x2d, sp), a
                                    921 ;	./src/main.c: 166: if(mezivstup==2){
                                    922 ; genCmpEQorNE
      0084D0 1E 39            [ 2]  923 	ldw	x, (0x39, sp)
      0084D2 A3 00 02         [ 2]  924 	cpw	x, #0x0002
      0084D5 26 03            [ 1]  925 	jrne	00256$
      0084D7 CC 84 DD         [ 2]  926 	jp	00257$
      0084DA                        927 00256$:
      0084DA CC 84 E3         [ 2]  928 	jp	00118$
      0084DD                        929 00257$:
                                    930 ; skipping generated iCode
                                    931 ;	./src/main.c: 167: mezivstup = 0;
                                    932 ; genAssign
      0084DD 5F               [ 1]  933 	clrw	x
      0084DE 1F 29            [ 2]  934 	ldw	(0x29, sp), x
                                    935 ; genGoto
      0084E0 CC 84 F3         [ 2]  936 	jp	00119$
                                    937 ; genLabel
      0084E3                        938 00118$:
                                    939 ;	./src/main.c: 168: }else if(mezivystup==2){
                                    940 ; genCmpEQorNE
      0084E3 1E 3B            [ 2]  941 	ldw	x, (0x3b, sp)
      0084E5 A3 00 02         [ 2]  942 	cpw	x, #0x0002
      0084E8 26 03            [ 1]  943 	jrne	00259$
      0084EA CC 84 F0         [ 2]  944 	jp	00260$
      0084ED                        945 00259$:
      0084ED CC 84 F3         [ 2]  946 	jp	00119$
      0084F0                        947 00260$:
                                    948 ; skipping generated iCode
                                    949 ;	./src/main.c: 169: mezivystup = 0;
                                    950 ; genAssign
      0084F0 5F               [ 1]  951 	clrw	x
      0084F1 1F 2B            [ 2]  952 	ldw	(0x2b, sp), x
                                    953 ; genLabel
      0084F3                        954 00119$:
                                    955 ;	./src/main.c: 172: if(vstup_ted > vstup_pred){
                                    956 ; genCmp
                                    957 ; genCmpTnz
      0084F3 1E 2E            [ 2]  958 	ldw	x, (0x2e, sp)
      0084F5 13 30            [ 2]  959 	cpw	x, (0x30, sp)
      0084F7 22 03            [ 1]  960 	jrugt	00261$
      0084F9 CC 85 28         [ 2]  961 	jp	00123$
      0084FC                        962 00261$:
                                    963 ; skipping generated iCode
                                    964 ;	./src/main.c: 173: mezivstup = 0;
                                    965 ; genAssign
      0084FC 5F               [ 1]  966 	clrw	x
      0084FD 1F 29            [ 2]  967 	ldw	(0x29, sp), x
                                    968 ;	./src/main.c: 174: mezivystup = 0;
                                    969 ; genAssign
      0084FF 5F               [ 1]  970 	clrw	x
      008500 1F 2B            [ 2]  971 	ldw	(0x2b, sp), x
                                    972 ;	./src/main.c: 175: vstup_pred = vstup_ted;
                                    973 ; genAssign
      008502 16 2E            [ 2]  974 	ldw	y, (0x2e, sp)
      008504 17 30            [ 2]  975 	ldw	(0x30, sp), y
                                    976 ;	./src/main.c: 176: lcd_gotoxy(0,0);
                                    977 ; genIPush
      008506 4B 00            [ 1]  978 	push	#0x00
                                    979 ; genSend
      008508 4F               [ 1]  980 	clr	a
                                    981 ; genCall
      008509 CD 86 B1         [ 4]  982 	call	_lcd_gotoxy
                                    983 ;	./src/main.c: 177: sprintf(text,"vstupy  =   %u",(uint16_t)vstup_ted);
                                    984 ; skipping iCode since result will be rematerialized
                                    985 ; skipping iCode since result will be rematerialized
                                    986 ; skipping iCode since result will be rematerialized
                                    987 ; skipping iCode since result will be rematerialized
                                    988 ; genIPush
      00850C 1E 2E            [ 2]  989 	ldw	x, (0x2e, sp)
      00850E 89               [ 2]  990 	pushw	x
                                    991 ; genIPush
      00850F 4B 95            [ 1]  992 	push	#<(___str_0+0)
      008511 4B 80            [ 1]  993 	push	#((___str_0+0) >> 8)
                                    994 ; genIPush
      008513 96               [ 1]  995 	ldw	x, sp
      008514 1C 00 05         [ 2]  996 	addw	x, #5
      008517 89               [ 2]  997 	pushw	x
                                    998 ; genCall
      008518 CD 8B 1E         [ 4]  999 	call	_sprintf
      00851B 5B 06            [ 2] 1000 	addw	sp, #6
                                   1001 ;	./src/main.c: 178: lcd_puts(text);
                                   1002 ; skipping iCode since result will be rematerialized
                                   1003 ; skipping iCode since result will be rematerialized
                                   1004 ; genSend
      00851D 96               [ 1] 1005 	ldw	x, sp
      00851E 5C               [ 1] 1006 	incw	x
                                   1007 ; genCall
      00851F CD 86 27         [ 4] 1008 	call	_lcd_puts
                                   1009 ;	./src/main.c: 179: zvuk_vstup();
                                   1010 ; genCall
      008522 CD 81 DD         [ 4] 1011 	call	_zvuk_vstup
                                   1012 ; genGoto
      008525 CC 84 33         [ 2] 1013 	jp	00126$
                                   1014 ; genLabel
      008528                       1015 00123$:
                                   1016 ;	./src/main.c: 180: }else if(vystup_ted > vystup_pred){
                                   1017 ; genCmp
                                   1018 ; genCmpTnz
      008528 1E 32            [ 2] 1019 	ldw	x, (0x32, sp)
      00852A 13 34            [ 2] 1020 	cpw	x, (0x34, sp)
      00852C 22 03            [ 1] 1021 	jrugt	00262$
      00852E CC 84 33         [ 2] 1022 	jp	00126$
      008531                       1023 00262$:
                                   1024 ; skipping generated iCode
                                   1025 ;	./src/main.c: 181: mezivystup = 0;
                                   1026 ; genAssign
      008531 5F               [ 1] 1027 	clrw	x
      008532 1F 2B            [ 2] 1028 	ldw	(0x2b, sp), x
                                   1029 ;	./src/main.c: 182: mezivstup = 0;
                                   1030 ; genAssign
      008534 5F               [ 1] 1031 	clrw	x
      008535 1F 29            [ 2] 1032 	ldw	(0x29, sp), x
                                   1033 ;	./src/main.c: 183: vystup_pred = vystup_ted;
                                   1034 ; genAssign
      008537 16 32            [ 2] 1035 	ldw	y, (0x32, sp)
      008539 17 34            [ 2] 1036 	ldw	(0x34, sp), y
                                   1037 ;	./src/main.c: 184: lcd_gotoxy(0,1);
                                   1038 ; genIPush
      00853B 4B 01            [ 1] 1039 	push	#0x01
                                   1040 ; genSend
      00853D 4F               [ 1] 1041 	clr	a
                                   1042 ; genCall
      00853E CD 86 B1         [ 4] 1043 	call	_lcd_gotoxy
                                   1044 ;	./src/main.c: 185: sprintf(text2,"vystupy =   %u",(uint16_t)vystup_ted);
                                   1045 ; skipping iCode since result will be rematerialized
                                   1046 ; skipping iCode since result will be rematerialized
                                   1047 ; skipping iCode since result will be rematerialized
                                   1048 ; skipping iCode since result will be rematerialized
                                   1049 ; genIPush
      008541 1E 32            [ 2] 1050 	ldw	x, (0x32, sp)
      008543 89               [ 2] 1051 	pushw	x
                                   1052 ; genIPush
      008544 4B A4            [ 1] 1053 	push	#<(___str_1+0)
      008546 4B 80            [ 1] 1054 	push	#((___str_1+0) >> 8)
                                   1055 ; genIPush
      008548 96               [ 1] 1056 	ldw	x, sp
      008549 1C 00 19         [ 2] 1057 	addw	x, #25
      00854C 89               [ 2] 1058 	pushw	x
                                   1059 ; genCall
      00854D CD 8B 1E         [ 4] 1060 	call	_sprintf
      008550 5B 06            [ 2] 1061 	addw	sp, #6
                                   1062 ;	./src/main.c: 186: lcd_puts(text2);
                                   1063 ; skipping iCode since result will be rematerialized
                                   1064 ; skipping iCode since result will be rematerialized
                                   1065 ; genSend
      008552 96               [ 1] 1066 	ldw	x, sp
      008553 1C 00 15         [ 2] 1067 	addw	x, #21
                                   1068 ; genCall
      008556 CD 86 27         [ 4] 1069 	call	_lcd_puts
                                   1070 ;	./src/main.c: 187: zvuk_vystup();
                                   1071 ; genCall
      008559 CD 82 DD         [ 4] 1072 	call	_zvuk_vystup
                                   1073 ; genGoto
      00855C CC 84 33         [ 2] 1074 	jp	00126$
                                   1075 ; genLabel
      00855F                       1076 00128$:
                                   1077 ;	./src/main.c: 190: }
                                   1078 ; genEndFunction
      00855F 5B 3C            [ 2] 1079 	addw	sp, #60
      008561 81               [ 4] 1080 	ret
                                   1081 	.area CODE
                                   1082 	.area CONST
                                   1083 	.area CONST
      008095                       1084 ___str_0:
      008095 76 73 74 75 70 79 20  1085 	.ascii "vstupy  =   %u"
             20 3D 20 20 20 25 75
      0080A3 00                    1086 	.db 0x00
                                   1087 	.area CODE
                                   1088 	.area CONST
      0080A4                       1089 ___str_1:
      0080A4 76 79 73 74 75 70 79  1090 	.ascii "vystupy =   %u"
             20 3D 20 20 20 25 75
      0080B2 00                    1091 	.db 0x00
                                   1092 	.area CODE
                                   1093 	.area INITIALIZER
                                   1094 	.area CABS (ABS)
