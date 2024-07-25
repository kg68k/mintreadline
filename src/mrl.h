// mrl.h - mintreadline header file
// Copyright (C) 2024 TcbnErik

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// Under Section 7 of GPL version 3, you are granted additional
// permissions described in the GCC Runtime Library Exception, version
// 3.1, as published by the Free Software Foundation.
//
// You should have received a copy of the GNU General Public License and
// a copy of the GCC Runtime Library Exception along with this program;
// see the files COPYING and COPYING.RUNTIME respectively.  If not, see
// <http://www.gnu.org/licenses/>.

#ifndef mintreadline_mrl_h
#define mintreadline_mrl_h

#include <stddef.h>

typedef struct {
  unsigned char* buf;
  int size;
  unsigned char* yank_buf;
  unsigned const char* words;
  void (*null)(void);
  void (*bell)(void);
  int (*complete)(unsigned char* buf, unsigned const char** top_ptr,
                  int* len_ptr, unsigned char* list_buf, int list_buf_len);
  void* (*malloc)(size_t size);
  void (*mfree)(void* ptr);
  int csr_x;
  int mark_x;
  int margin;
  int width;
  short win_x;
  short win_y;

  unsigned char col;
  unsigned char c_col;
  unsigned char c_atr;
  unsigned char c_slash;
  unsigned char c_adds;
  unsigned char c_disp;

  unsigned char f_dot;
  unsigned char f_emacs;
  unsigned char f_fep;
  unsigned char f_up;
  unsigned char f_down;
  unsigned char f_ru;
  unsigned char f_rd;
} RL;

#ifdef __cplusplus
extern "C" {
#endif

const char* ReadLineVersion(void);
int ReadLine(RL* rl);
void ReadLineSaveFnckey(void);
void ReadLineRestoreFnckey(void);

#ifdef __cplusplus
}
#endif

#endif
