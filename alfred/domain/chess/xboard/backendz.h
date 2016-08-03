/*
 * backendz.h -- Internal interface exported by XBoard backend.c to zippy.c
 * $Id: backendz.h,v 1.1 2004/06/17 22:04:54 darsana Exp $
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
 */

#ifndef _BACKENDZ
#define _BACKENDZ

#include "common.h"
#include "frontend.h"

extern long whiteTimeRemaining, blackTimeRemaining;
extern int forwardMostMove;
extern char star_match[STAR_MATCH_N][MSG_SIZ];
extern ProcRef firstProgramPR;
extern int startedFromSetupPosition;
extern int firstMove;
extern GameInfo gameInfo;
extern void SendToICS P((char *s));
extern int looking_at P((char *, int *, char *));
extern void SendToProgram P((char *message, ChessProgramState *cps));
extern void SendBoard P((ChessProgramState *cps, int moveNum));
void SendTimeRemaining P((ChessProgramState *cps,
			  int/*boolean*/ machineWhite));

extern char ics_handle[];
extern char *ics_prefix;

#endif
