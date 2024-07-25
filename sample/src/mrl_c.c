// mrl_c.c - mintreadline ReadLine() sample
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
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

#define __IOCS_INLINE__
#include <stdlib.h>
#include <string.h>
#include <sys/iocs.h>

#include "mrl.h"

int c_num;
char** c_list;

static int complete(unsigned char* buf, unsigned const char** top_ptr,
                    int_* len_ptr, unsigned char* list_buf, int_ list_buf_len) {
  int i;
  int n = 0;

  for (i = 0; i < c_num; ++i) {
    unsigned char* s = c_list[i];

    if (strncasecmp(s, *top_ptr, *len_ptr) == 0) {
      int l = strlen(s) + 2;

      if ((list_buf_len -= l) < 0) break;

      list_buf[0] = 0;
      strcpy(&list_buf[1], s);
      list_buf += l;

      ++n;
    }
  }

  return n;
}

int main(int argc, char* argv[]) {
  int rc;
  unsigned char test_buf[255 + 1];
  RL rl = {
      test_buf,        /* buf */
      sizeof test_buf, /* size */
      NULL,            /* yank_buf */
      "*?_-.[]~=",     /* words */
      NULL,            /* null */
      NULL,            /* bell */
      complete,        /* complete */
      malloc,          /* malloc */
      free,            /* mfree */
      0,               /* csr_x */
      -1,              /* mark_x */
      5,               /* margin */
      80,              /* width */
      8,               /* win_x */
      8,               /* win_y */

      3,    /* col */
      3,    /* c_col */
      0xf7, /* c_atr */
      '/',  /* c_slash */
      -1,   /* c_adds */
      -1,   /* c_disp */

      -1, /* f_dot */
      -1, /* f_emacs */
      -1, /* f_fep */
      0,  /* f_up */
      0,  /* f_down */
      0,  /* f_ru */
      0   /* f_rd */
  };

  c_num = argc - 1;
  c_list = argv + 1;

#ifndef DONT_SAVE_FNCKEY
  ReadLineSaveFnckey();
  onexit(ReadLineRestoreFnckey);
#endif

  test_buf[0] = '\0';
  rc = ReadLine(&rl);

#ifdef PRINT_RESULT
  printf("%s\n", test_buf);
#endif

  return rc;
}
