#include <stdbool.h>
#include <stm8s.h>
#include <stdio.h>
#include "main.h"
#include "milis.h"
#include <stm8_LCD.h>
#include "__assert__.h"

void init(void)
{
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);      // taktovani MCU na 16MHz
    GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
#if defined (BTN_PORT) || defined (BTN_PIN)
    GPIO_Init(BTN_PORT, BTN_PIN, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(SENZOR1_PORT, SENZOR1_PIN, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(SENZOR2_PORT, SENZOR2_PIN, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(PZ_PORT, PZ_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
#endif
    init_milis();
}

void zvuk_vstup(void){
	
	uint32_t lastTime = 0;
    uint16_t UP=1;
    uint16_t DOWN=0;
    uint16_t zvuk_stav = 1;
    uint32_t time = 0;

    time = milis();
    lastTime = milis();
    while(1){

        if (UP == zvuk_stav){
            PZ_UP;
            if (milis() - lastTime > 1) {
                    lastTime = milis();
                    zvuk_stav = 0;
                }
        }else if (DOWN == zvuk_stav){
            PZ_DOWN;
            if (milis() - lastTime > 1) {
                    lastTime = milis();
                    zvuk_stav = 1;
                }
        }
        if(milis() - time > 50){
            PZ_UP;
            break;
        }
    }

    time = milis();
    while(1){
        PZ_REVERSE;
        if(milis() - time > 100){
            PZ_UP;
            break;
        }
    }
}

void zvuk_vystup(void){
	
	uint32_t lastTime = 0;
    uint16_t UP=1;
    uint16_t DOWN=0;
    uint16_t zvuk_stav = 1;
    uint32_t time = 0;

    time = milis();
    while(1){
        PZ_REVERSE;
        if(milis() - time > 50){
            PZ_UP;
            break;
        }
    }

    time = milis();
    lastTime = milis();

    while(1){
        if (UP == zvuk_stav){
            PZ_UP;
            if (milis() - lastTime > 1) {
                    lastTime = milis();
                    zvuk_stav = 0;
                }
        }else if (DOWN == zvuk_stav){
            PZ_DOWN;
            if (milis() - lastTime > 1) {
                    lastTime = milis();
                    zvuk_stav = 1;
                }
        }
        if(milis() - time > 100){
            PZ_UP;
            break;
        }
    }
}

int main(void){
    init();
	uint16_t mezivstup  = 0;
    uint16_t mezivystup  = 0;
    uint16_t senzorstav1 = 0;
    uint16_t senzorposledni1 = 0;
    uint16_t senzorstav2 = 0;
    uint16_t senzorposledni2 = 0;
    
    uint16_t vstup_ted = 0;
    uint16_t vstup_pred = 0;
    uint16_t vystup_ted = 0;
    uint16_t vystup_pred = 0;

	char text[20];
	char text2[20];

	lcd_init();
    lcd_gotoxy(0,0);
    sprintf(text,"vstupy  =   %u",(uint16_t)vstup_ted);
    lcd_puts(text);

    lcd_gotoxy(0,1);
    sprintf(text2,"vystupy =   %u",(uint16_t)vystup_ted);
    lcd_puts(text2);
    
    while(1){
        senzorstav1 = GPIO_ReadInputPin(SENZOR1_PORT, SENZOR1_PIN);
        senzorstav2 = GPIO_ReadInputPin(SENZOR2_PORT, SENZOR2_PIN);

        if(senzorstav1 == 0 && senzorposledni1 == 1){
            mezivstup += 1;
        }
        if(senzorstav2 == 0 && senzorposledni2 == 1 && mezivstup == 1){
            vstup_ted += 1;
        }

        if(senzorstav2 == 0 && senzorposledni2 == 1){
            mezivystup += 1;
        }
        if(senzorstav1 == 0 && senzorposledni1 == 1 && mezivystup == 1){
            vystup_ted += 1;
        }

        senzorposledni1 = senzorstav1;
        senzorposledni2 = senzorstav2;
        
        if(mezivstup==2){
            mezivstup = 0;
        }else if(mezivystup==2){
            mezivystup = 0;
        }
        
        if(vstup_ted > vstup_pred){
            mezivstup = 0;
            mezivystup = 0;
            vstup_pred = vstup_ted;
            lcd_gotoxy(0,0);
		    sprintf(text,"vstupy  =   %u",(uint16_t)vstup_ted);
		    lcd_puts(text);
			zvuk_vstup();
        }else if(vystup_ted > vystup_pred){
            mezivystup = 0;
            mezivstup = 0;
            vystup_pred = vystup_ted;
            lcd_gotoxy(0,1);
		    sprintf(text2,"vystupy =   %u",(uint16_t)vystup_ted);
    	    lcd_puts(text2);
            zvuk_vystup();
        }
	}
}
#include "__assert__.h"