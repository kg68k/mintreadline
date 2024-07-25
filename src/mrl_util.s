;mrl_util.s - mintreadline utility
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
;Under Section 7 of GPL version 3, you are granted additional
;permissions described in the GCC Runtime Library Exception, version
;3.1, as published by the Free Software Foundation.
;
;You should have received a copy of the GNU General Public License and
;a copy of the GCC Runtime Library Exception along with this program;
;see the files COPYING and COPYING.RUNTIME respectively.  If not, see
;<http://www.gnu.org/licenses/>.


* Include File -------------------------------- *

		.include	mrl_util.mac
		.include	doscall.mac


* Text Section -------------------------------- *

		.cpu	68000

		.text
		.even


* ReadLineSaveFnckey -------------------------- *

_ReadLineSaveFnckey::
		movem.l	d0-d1,-(sp)
		moveq	#12-1,d1
		pea	(fnckey_buf,pc)
		move	#21,-(sp)
@@:
		DOS	_FNCKEY			;キー定義を保存
		addq.l	#6,(2,sp)
		addq	#1,(sp)
		dbra	d1,@b
		addq.l	#6,sp
		movem.l	(sp)+,d0-d1
		rts


* ReadLineRestoreFnckey ----------------------- *

_ReadLineRestoreFnckey::
		movem.l	d0-d1,-(sp)
		moveq	#12-1,d1
		pea	(fnckey_buf,pc)
		move	#$100+21,-(sp)
@@:
		DOS	_FNCKEY			;キー定義を復帰
		addq.l	#6,(2,sp)
		addq	#1,(sp)
		dbra	d1,@b
		addq.l	#6,sp
		movem.l	(sp)+,d0-d1
		rts


* Block Storage Section ----------------------- *

**		.bss
		.even

fnckey_buf:
		.ds.b	6*12


		.end

* End of File --------------------------------- *
