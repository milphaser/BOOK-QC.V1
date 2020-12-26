/*
 * qc-T000.xc
 *
 *  Създаден на: 19.06.2013
 *       Автори: University of Illinois
 *       NCSA Open Source License
 *       posted in LICENSE.txt and at <http://github.xcore.com/>
 *
 *       Корекции: Милен Луканчевски
 *
 *	Multicore flashing LED program for the XC-2 board
 *
 *	Цел:
 *	Осн. идея:
 *
 */

#include <platform.h>

#define FLASH_PERIOD 20000000	// 200 ms = 0.2 sec = 20E6 x 10E-9 = 200E-3

on stdcore[0]: out port x0ledA = PORT_LED_0_0;
on stdcore[0]: out port x0ledB = PORT_LED_0_1;
on stdcore[1]: out port x1ledA = PORT_LED_1_0;
on stdcore[1]: out port x1ledB = PORT_LED_1_1;

void flashLED (out port led, int delay);

int main(void)
{
	par
	{
		on stdcore[0]: flashLED(x0ledA, FLASH_PERIOD);
		on stdcore[0]: flashLED(x0ledB, FLASH_PERIOD);
		on stdcore[1]: flashLED(x1ledA, FLASH_PERIOD);
		on stdcore[1]: flashLED(x1ledB, FLASH_PERIOD);
	}

	return 0;
}

void flashLED(out port led, int delay)
{
	timer tmr;
	unsigned ledOn = 1;
	unsigned t;

	tmr :> t;

	while (1)
	{
		led <: ledOn;
		t += delay;
		tmr when timerafter(t) :> void;
		ledOn = !ledOn;
	}
}
