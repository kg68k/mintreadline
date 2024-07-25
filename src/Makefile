# Makefile for mintreadline

ifeq ($(notdir $(CURDIR)),src)
$(error do not execute make in src directory)
endif

SRCDIR_MK = ../srcdir.mk
SRC_DIR = ../src
-include $(SRCDIR_MK)

U8TOSJ = u8tosj
AR = oar
ARFLAGS = -cv
AS = has060
ASFLAGS = -w2
CP_P = cp -p

ifndef LD
LD = hlk
endif
LDFLAGS =

SRCS = mrl.s mrl_util.s
OBJS = $(SRCS:.s=.o)

INCLUDES = mrl.h mrl.mac mrl_util.mac
DOC_TXT = COPYING COPYING.RUNTIME CHANGELOG.txt README.txt mintreadline.txt

TARGET = libmrl.a
MRL_ZIP = mrl.zip

.PHONY: all archive

all: $(TARGET)

libmrl.a: mrl.o mrl_util.o
	$(AR) $(ARFLAGS) $@ $^

mrl.o: mrl.s mrl.mac
	$(AS) $(ASFLAGS) -o $@ $<

mrl_util.o: mrl_util.s mrl_util.mac
	$(AS) $(ASFLAGS) -o $@ $<

archive: $(MRL_ZIP)

$(MRL_ZIP):
	rm -f $@ $(DOC_TXT)
	rm -fr include lib sample
	-mkdir include lib sample sample/src
	$(CP_P) $(INCLUDES) include/
	$(CP_P) libmrl.a lib/
	$(U8TOSJ) < $(SRC_DIR)/../sample/README.md > sample/README.txt
	$(CP_P) $(addprefix $(SRC_DIR)/../sample/src/,Makefile mrl_asm.s mrl_c.c) sample/src/
	$(CP_P) $(addprefix $(SRC_DIR)/../,COPYING COPYING.RUNTIME) ./
	$(U8TOSJ) < $(SRC_DIR)/../CHANGELOG.md > CHANGELOG.txt
	$(U8TOSJ) < $(SRC_DIR)/../README.md > README.txt
	$(U8TOSJ) < $(SRC_DIR)/../mintreadline.md > mintreadline.txt
	zip -9r $@ include lib sample $(DOC_TXT)

clean:
	rm -fr include lib sample
	rm -f $(MRL_ZIP) $(DOC_TXT) $(TARGET) $(OBJS)

# EOF
