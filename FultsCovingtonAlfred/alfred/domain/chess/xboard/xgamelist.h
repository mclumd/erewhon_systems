/*
 * xgamelist.h -- Game list window, part of X front end for XBoard
 * $Id: xgamelist.h,v 1.1 2004/06/17 22:05:17 darsana Exp $
 *
 * Copyright 1995 Free Software Foundation, Inc.
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

#ifndef _XGAMEL_H
#define _XGAMEL_H 1

void ShowGameListProc P((Widget w, XEvent *event,
			 String *prms, Cardinal *nprms));
void LoadSelectedProc P((Widget w, XEvent *event,
			 String *prms, Cardinal *nprms));

#endif /* _XGAMEL_H */
