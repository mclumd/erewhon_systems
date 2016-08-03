/*
 * bitmaps.h - Include bitmap files for pieces and icons
 * $Id: bitmaps.h,v 1.1 2004/06/17 22:06:14 darsana Exp $
 *
 * Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts.
 * Enhancements Copyright 1992-95 Free Software Foundation, Inc.
 *
 * The following terms apply to Digital Equipment Corporation's copyright
 * interest in XBoard:
 * ------------------------------------------------------------------------
 * All Rights Reserved
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted,
 * provided that the above copyright notice appear in all copies and that
 * both that copyright notice and this permission notice appear in
 * supporting documentation, and that the name of Digital not be
 * used in advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
 * ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
 * DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
 * ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
 * WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
 * ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
 * SOFTWARE.
 * ------------------------------------------------------------------------
 *
 * The following terms apply to the enhanced version of XBoard distributed
 * by the Free Software Foundation:
 * ------------------------------------------------------------------------
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 * ------------------------------------------------------------------------
 *
 * See the file ChangeLog for a revision history.
 */

#include "p80s.bm"
#include "n80s.bm"
#include "b80s.bm"
#include "r80s.bm"
#include "q80s.bm"
#include "k80s.bm"

#include "p80o.bm"
#include "n80o.bm"
#include "b80o.bm"
#include "r80o.bm"
#include "q80o.bm"
#include "k80o.bm"

#include "p64s.bm"
#include "n64s.bm"
#include "b64s.bm"
#include "r64s.bm"
#include "q64s.bm"
#include "k64s.bm"

#include "p64o.bm"
#include "n64o.bm"
#include "b64o.bm"
#include "r64o.bm"
#include "q64o.bm"
#include "k64o.bm"

#include "p40s.bm"
#include "n40s.bm"
#include "b40s.bm"
#include "r40s.bm"
#include "q40s.bm"
#include "k40s.bm"

#include "p40o.bm"
#include "n40o.bm"
#include "b40o.bm"
#include "r40o.bm"
#include "q40o.bm"
#include "k40o.bm"

#define BUILT_IN_BITS {\
{ 80,\
  { { p80s_bits, n80s_bits, b80s_bits, r80s_bits, q80s_bits, k80s_bits },\
    { p80o_bits, n80o_bits, b80o_bits, r80o_bits, q80o_bits, k80o_bits } } },\
{ 64,\
  { { p64s_bits, n64s_bits, b64s_bits, r64s_bits, q64s_bits, k64s_bits },\
    { p64o_bits, n64o_bits, b64o_bits, r64o_bits, q64o_bits, k64o_bits } } },\
{ 40,\
  { { p40s_bits, n40s_bits, b40s_bits, r40s_bits, q40s_bits, k40s_bits },\
    { p40o_bits, n40o_bits, b40o_bits, r40o_bits, q40o_bits, k40o_bits } } },\
{ 0,\
  { { NULL, NULL, NULL, NULL, NULL, NULL },\
    { NULL, NULL, NULL, NULL, NULL, NULL } } }\
}

#include "icon_white.bm"
#include "icon_black.bm"
#include "checkmark.bm"
