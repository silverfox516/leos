#include <navilnux.h>

void swiHandler(unsigned int syscallnum)
{
	printf("system call %d\n", syscallnum);
}

void irqHandler(void)
{
	if ((ICIP & (1 << 27)) != 0) {
		OSMR1 = OSCR + 3686400;
		printf("Timer Interrupt!!!\n");
		OSSR = OSSR_M1;
	}
}

void irqEnable(void)
{
	__asm__("msr	cpsr_c,#0x40|0x13");
}

void irqDisable(void)
{
	__asm__("msr	cpsr_c,#0xc0|0x13");
}

void osTimerInit(void)
{
	ICCR = 0x01;
	ICMR |= (1 << 27);
	ICLR &= ~(1 << 27);
	
	OSCR = 0;
	OSMR1 = OSCR + 3686400;

	OSSR = OSSR_M1;
}

void osTimerStart(void)
{
	OIER |= (1 << 1);
	OSSR = OSSR_M1;
}

int main(void)
{
	printf("chapter 7\n");

	int a = 1;
	int b = 2;
	int c = 0;

	c = a + b;

	osTimerInit();
	osTimerStart();

	irqEnable();

	while (1) {
		printf("kernel stack a(%p), b(%p, c(%p)\n", &a, &b, &c);
		__asm__("swi 77");
		msleep(1000);
	}
	return 0;
}
