MCU=atmega328p
PART=m328p
F_CPU=16000000
CC=avr-gcc
OBJCOPY=avr-objcopy
CFLAGS=-Wall -g -Os -mmcu=${MCU} -DF_CPU=${F_CPU} -I.
TARGET=proyecto_uart
SRCS=main.c uart_hal.c adc_hal.c
PROGRAMMER=usbasp
LFUSE=0xDF

all:
	${CC} ${CFLAGS} -o ${TARGET}.bin ${SRCS} -lm
	${OBJCOPY} -j .text -j .data -O ihex ${TARGET}.bin ${TARGET}.hex

setlowfuse:
	avrdude -p ${PART} -c ${PROGRAMMER} -U lfuse:w:${LFUSE}:m
defaultlfuse:
	avrdude -p ${PART} -c ${PROGRAMMER} -U lfuse:w:0x62:m
flash:
	avrdude -p ${PART} -c ${PROGRAMMER} -U flash:w:${TARGET}.hex:i
