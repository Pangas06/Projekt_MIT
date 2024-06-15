#ifndef _MAIN_H_
#define _MAIN_H_ 1

#define LOW(BAGR) GPIO_WriteLow(BAGR##_PORT, BAGR##_PIN)
#define HIGH(BAGR) GPIO_WriteHigh(BAGR##_PORT, BAGR##_PIN)
#define REVERSE(BAGR) GPIO_WriteReverse(BAGR##_PORT, BAGR##_PIN)

#define READ(BAGR) (GPIO_ReadInputPin(BAGR##_PORT, BAGR##_PIN)!=RESET) 
#define PUSH(BAGR) (GPIO_ReadInputPin(BAGR##_PORT, BAGR##_PIN)==RESET) 

// Discovery Board
#ifdef STM8S003
#define LED_PORT GPIOD
#define LED_PIN  GPIO_PIN_0
#define BTN_PORT GPIOB
#define BTN_PIN  GPIO_PIN_7
#endif

// Dero Board
#ifdef STM8S103
#define LED_PORT GPIOD
#define LED_PIN  GPIO_PIN_4
#endif

// Discovery Board
#ifdef STM8S105
#define LED_PORT GPIOD
#define LED_PIN  GPIO_PIN_0
#endif

// Nucleo Kit
#ifdef STM8S208
#define LED_PORT GPIOC
#define LED_PIN  GPIO_PIN_5

#define SENZOR1_PORT GPIOC
#define SENZOR1_PIN GPIO_PIN_7

#define SENZOR2_PORT GPIOC
#define SENZOR2_PIN GPIO_PIN_6

#define BTN_PORT GPIOE
#define BTN_PIN  GPIO_PIN_4

#define PZ_PORT GPIOD

#define PZ_PIN  GPIO_PIN_4

#define PZ_DOWN   GPIO_WriteHigh(PZ_PORT, PZ_PIN)
#define PZ_UP  GPIO_WriteLow(PZ_PORT, PZ_PIN)
#define PZ_REVERSE GPIO_WriteReverse(PZ_PORT, PZ_PIN)

#endif

// functions
void init(void);

#endif // !_MAIN_H_
