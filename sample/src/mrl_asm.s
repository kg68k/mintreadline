;mrl_asm.s - mintreadline _ReadLine sample
;Copyright (C) 2024 TcbnErik

;This program is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.
;
;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.
;
;You should have received a copy of the GNU General Public License
;along with this program.  If not, see <https://www.gnu.org/licenses/>.


* Include File -------------------------------- *

		.include	mrl.mac
		.include	mrl_util.mac

		.include	doscall.mac
		.include	iocscall.mac


* Macro --------------------------------------- *

STRCPY: .macro src,dst,rewind
  .sizem sz,argc
  @loop:
    move.b (src)+,(dst)+
  bne @loop
  .if argc>=3
    subq.l #-rewind,dst
  .endif
.endm

ATR_VOL: .equ 3


* Text Section -------------------------------- *

		.cpu	68000

		.text
		.even

main:
		lea	(16,a0),a0
		suba.l	a0,a1
		movem.l	a0-a1,-(sp)
		DOS	_SETBLOCK
		addq.l	#8,sp


.ifndef DONT_SAVE_FNCKEY
		bsr	_ReadLineSaveFnckey

		pea	(errjvc_job,pc)
		move	#_ERRJVC,-(sp)
		DOS	_INTVCG
		lea	(errjvc_old,pc),a0
		move.l	d0,(a0)
		DOS	_INTVCS
.endif

		lea	(test_rl,pc),a0
		lea	(wordchars,pc),a1
		move.l	a1,(_RL_WORDS,a0)
		lea	(test_buf,pc),a1
		move.l	a1,(_RL_BUF,a0)
		addq.l	#1,a2
		STRCPY	a2,a1

		IOCS	_B_DOWN_S
		moveq	#-1,d1
		IOCS	_B_LOCATE
		subq	#1,d0
		move	d0,(_RL_WIN_Y,a0)
		moveq	#-1,d1
		moveq	#-1,d2
		IOCS	_B_CONSOL
		lsr	#4,d1
		add	d1,(_RL_WIN_Y,a0)

		pea	(a0)
		bsr	_ReadLine
		move	d0,(sp)
.ifdef PRINT_RESULT
		move	#LF,-(sp)
		DOS	_PUTCHAR
		pea	(test_buf,pc)
		DOS	_PRINT
		addq.l	#4,sp
		DOS	_PUTCHAR
		addq.l	#2,sp
.endif
		DOS	_EXIT2


.ifndef DONT_SAVE_FNCKEY
errjvc_job:
		bsr	_ReadLineRestoreFnckey
		move.l	(errjvc_old,pc),-(sp)
		rts
.endif


* Data Section -------------------------------- *

		.data
		.even

test_rl:
		.dc.l	0			;_RL_BUF
		.dc.l	255+1			;_RL_SIZE
		.dc.l	0			;_RL_YANK_BUF
		.dc.l	0			;_RL_WORDS
		.dc.l	0			;_RL_NULL
		.dc.l	0			;_RL_BELL
		.dc.l	0			;_RL_COMPLETE
		.dc.l	0			;_RL_MALLOC
		.dc.l	0			;_RL_MFREE
		.dc.l	0			;_RL_CSR_X
		.dc.l	-1			;_RL_MARK_X
		.dc.l	5			;_RL_MARGIN
		.dc.l	80			;_RL_WIDTH
		.dc	8			;_RL_WIN_X
		.dc	0			;_RL_WIN_Y

		.dc.b	3			;_RL_COL
		.dc.b	3			;_RL_C_COL
		.dc.b	$ff-(1<<ATR_VOL)	;_RL_C_ATR
		.dc.b	'/'			;_RL_C_SLASH
		.dc.b	$ff			;_RL_C_ADDS
		.dc.b	$ff			;_RL_C_DISP
		.dc.b	$ff			;_RL_F_DOT
		.dc.b	$ff			;_RL_F_EMACS
		.dc.b	$ff			;_RL_F_FEP
		.dc.b	0			;_RL_F_UP
		.dc.b	0			;_RL_F_DOWN
		.dc.b	0			;_RL_F_RU
		.dc.b	0			;_RL_F_RD

wordchars:	.dc.b	'*?_-.[]~=',0
		.even


* Block Storage Section ----------------------- *

		.bss
		.even

.ifndef DONT_SAVE_FNCKEY
errjvc_old:	.ds.l	1
.endif

test_buf:	.ds.b	255+1
		.text


		.end	main

* End of File --------------------------------- *
