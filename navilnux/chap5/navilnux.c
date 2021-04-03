#include <pxa255.h>
#include <time.h>
#include <gpio.h>
#include <stdio.h>
#include <string.h>

void swiHandler(unsigned int syscallnum)
{
	printf("system call %d\n", syscallnum);
}

void irqHandler(void)
{
}

int main(void)
{
	printf("chapter 5\n");
	while (1) {
		__asm__("swi 77");
		msleep(1000);
	}
	return 0;
}
