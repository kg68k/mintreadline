# Makefile for mintreadline/sample

ifeq ($(notdir $(CURDIR)),src)
$(error do not execute make in src directory)
endif

CC = gcc
CFLAGS = -Wall -O
AS = has060
ASFLAGS = -w2

ifndef LD
LD = hlk
endif
LDFLAGS =

SRCS = mrl_asm.s mrl_c.c
OBJS = mrl_asm.o

TARGET = mrl_asm.x mrl_c.x

all: $(TARGET)

mrl_asm.x: mrl_asm.o
	$(LD) $(LDFLAGS) -o$@ $^ -lmrl

mrl_asm.o: mrl_asm.s
	$(AS) $(ASFLAGS) -o$@ $<

mrl_c.x: mrl_c.c
	$(CC) $(CFLAGS) -o$@ $^ -lmrl -lsignal

clean: $(OBJS) $(TARGET)
	-rm -f $^

# EOF
