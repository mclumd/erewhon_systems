/*
 * moves.c - Move generation and checking
 * $Id: moves.c,v 1.2 2004/09/23 02:32:58 randofu Exp $
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

#include "config.h"

#include <stdio.h>
#if HAVE_STRING_H
# include <string.h>
#else /* not HAVE_STRING_H */
# include <strings.h>
#endif /* not HAVE_STRING_H */
#include "common.h"
#include "backend.h" 
#include "moves.h"
#include "parser.h"

int WhitePiece P((ChessSquare));
int BlackPiece P((ChessSquare));
int SameColor P((ChessSquare, ChessSquare));


int WhitePiece(piece)
     ChessSquare piece;
{
    return (int) piece >= (int) WhitePawn && (int) piece <= (int) WhiteKing;
}

int BlackPiece(piece)
     ChessSquare piece;
{
    return (int) piece >= (int) BlackPawn && (int) piece <= (int) BlackKing;
}

int SameColor(piece1, piece2)
     ChessSquare piece1, piece2;
{
    return ((int) piece1 >= (int) WhitePawn &&
	    (int) piece1 <= (int) WhiteKing &&
	    (int) piece2 >= (int) WhitePawn &&
	    (int) piece2 <= (int) WhiteKing)
      ||   ((int) piece1 >= (int) BlackPawn &&
	    (int) piece1 <= (int) BlackKing &&
	    (int) piece2 >= (int) BlackPawn &&
	    (int) piece2 <= (int) BlackKing);
}

ChessSquare PromoPiece(moveType)
     ChessMove moveType;
{
    switch (moveType) {
      default:
	return EmptySquare;
      case WhitePromotionQueen:
	return WhiteQueen;
      case BlackPromotionQueen:
	return BlackQueen;
      case WhitePromotionRook:
	return WhiteRook;
      case BlackPromotionRook:
	return BlackRook;
      case WhitePromotionBishop:
	return WhiteBishop;
      case BlackPromotionBishop:
	return BlackBishop;
      case WhitePromotionKnight:
	return WhiteKnight;
      case BlackPromotionKnight:
	return BlackKnight;
      case WhitePromotionKing:
	return WhiteKing;
      case BlackPromotionKing:
	return BlackKing;
    }
}

ChessMove PromoCharToMoveType(whiteOnMove, promoChar)
     int whiteOnMove;
     int promoChar;
{
    if (whiteOnMove) {
	switch (promoChar) {
	  case 'n':
	  case 'N':
	    return WhitePromotionKnight;
	  case 'b':
	  case 'B':
	    return WhitePromotionBishop;
	  case 'r':
	  case 'R':
	    return WhitePromotionRook;
	  case 'q':
	  case 'Q':
	    return WhitePromotionQueen;
	  case 'k':
	  case 'K':
	    return WhitePromotionKing;
	  case NULLCHAR:
	  default:
	    return NormalMove;
	}
    } else {
	switch (promoChar) {
	  case 'n':
	  case 'N':
	    return BlackPromotionKnight;
	  case 'b':
	  case 'B':
	    return BlackPromotionBishop;
	  case 'r':
	  case 'R':
	    return BlackPromotionRook;
	  case 'q':
	  case 'Q':
	    return BlackPromotionQueen;
	  case 'k':
	  case 'K':
	    return BlackPromotionKing;
	  case NULLCHAR:
	  default:
	    return NormalMove;
	}
    }
}

char pieceToChar[] = {
    'P', 'N', 'B', 'R', 'Q', 'K',
    'p', 'n', 'b', 'r', 'q', 'k', 'x'
  };

char PieceToChar(p)
     ChessSquare p;
{
    return pieceToChar[(int) p];
}

ChessSquare CharToPiece(c)
     int c;
{
    switch (c) {
      default:
      case 'x':	return EmptySquare;
      case 'P':	return WhitePawn;
      case 'R':	return WhiteRook;
      case 'N':	return WhiteKnight;
      case 'B':	return WhiteBishop;
      case 'Q':	return WhiteQueen;
      case 'K':	return WhiteKing;
      case 'p':	return BlackPawn;
      case 'r':	return BlackRook;
      case 'n':	return BlackKnight;
      case 'b':	return BlackBishop;
      case 'q':	return BlackQueen;
      case 'k':	return BlackKing;
    }
}

void CopyBoard(to, from)
     Board to, from;
{
    int i, j;
    
    for (i = 0; i < BOARD_SIZE; i++)
      for (j = 0; j < BOARD_SIZE; j++)
	to[i][j] = from[i][j];
}

int CompareBoards(board1, board2)
     Board board1, board2;
{
    int i, j;
    
    for (i = 0; i < BOARD_SIZE; i++)
      for (j = 0; j < BOARD_SIZE; j++) {
	  if (board1[i][j] != board2[i][j])
	    return FALSE;
    }
    return TRUE;
}


/* Call callback once for each pseudo-legal move in the given
   position, except castling moves. A move is pseudo-legal if it is
   legal, or if it would be legal except that it leaves the king in
   check.  In the arguments, epfile is EP_NONE if the previous move
   was not a double pawn push, or the file 0..7 if it was, or
   EP_UNKNOWN if we don't know and want to allow all e.p. captures.
   Promotion moves generated are to Queen only.
*/
void GenPseudoLegal(board, flags, epfile, callback, closure)
     Board board;
     int flags;
     int epfile;
     MoveCallback callback;
     VOIDSTAR closure;
{
    int rf, ff;
    int i, j, d, s, fs, rs, rt, ft;

    for (rf = 0; rf <= 7; rf++) 
      for (ff = 0; ff <= 7; ff++) {
	  if (flags & F_WHITE_ON_MOVE) {
	      if (!WhitePiece(board[rf][ff])) continue;
	  } else {
	      if (!BlackPiece(board[rf][ff])) continue;
	  }
	  switch (board[rf][ff]) {
	    case EmptySquare:
	    default:
	      /* can't happen */
	      break;

	    case WhitePawn:
	      if (rf < 7 && board[rf + 1][ff] == EmptySquare) {
		  callback(board, flags,
			   rf == 6 ? WhitePromotionQueen : NormalMove,
			   rf, ff, rf + 1, ff, closure);
	      }
	      if (rf == 1 && board[2][ff] == EmptySquare &&
		  board[3][ff] == EmptySquare) {
		  callback(board, flags, NormalMove,
			   rf, ff, 3, ff, closure);
	      }
	      for (s = -1; s <= 1; s += 2) {
		  if (rf < 7 && ff + s >= 0 && ff + s <= 7 &&
		      ((flags & F_KRIEGSPIEL_CAPTURE) ||
		       BlackPiece(board[rf + 1][ff + s]))) {
		      callback(board, flags, 
			       rf == 6 ? WhitePromotionQueen : NormalMove,
			       rf, ff, rf + 1, ff + s, closure);
		  }
		  if (rf == 4) {
		      if (ff + s >= 0 && ff + s <= 7 &&
			  (epfile == ff + s || epfile == EP_UNKNOWN) &&
			  board[4][ff + s] == BlackPawn &&
			  board[5][ff + s] == EmptySquare) {
			  callback(board, flags, WhiteCapturesEnPassant,
				   rf, ff, 5, ff + s, closure);
		      }
		  }
	      }		    
	      break;

	    case BlackPawn:
	      if (rf > 0 && board[rf - 1][ff] == EmptySquare) {
		  callback(board, flags, 
			   rf == 1 ? BlackPromotionQueen : NormalMove,
			   rf, ff, rf - 1, ff, closure);
	      }
	      if (rf == 6 && board[5][ff] == EmptySquare &&
		  board[4][ff] == EmptySquare) {
		  callback(board, flags, NormalMove,
			   rf, ff, 4, ff, closure);
	      }
	      for (s = -1; s <= 1; s += 2) {
		  if (rf > 0 && ff + s >= 0 && ff + s <= 7 &&
		      ((flags & F_KRIEGSPIEL_CAPTURE) ||
		       WhitePiece(board[rf - 1][ff + s]))) {
		      callback(board, flags, 
			       rf == 1 ? BlackPromotionQueen : NormalMove,
			       rf, ff, rf - 1, ff + s, closure);
		  }
		  if (rf == 3) {
		      if (ff + s >= 0 && ff + s <= 7 &&
			  (epfile == ff + s || epfile == EP_UNKNOWN) &&
			  board[3][ff + s] == WhitePawn &&
			  board[2][ff + s] == EmptySquare) {
			  callback(board, flags, BlackCapturesEnPassant,
				   rf, ff, 2, ff + s, closure);
		      }
		  }
	      }		    
	      break;

	    case WhiteKnight:
	    case BlackKnight:
	      for (i = -1; i <= 1; i += 2)
		for (j = -1; j <= 1; j += 2)
		  for (s = 1; s <= 2; s++) {
		      rt = rf + i*s;
		      ft = ff + j*(3-s);
		      if (rt < 0 || rt > 7 || ft < 0 || ft > 7) continue;
		      if (SameColor(board[rf][ff], board[rt][ft])) continue;
		      callback(board, flags, NormalMove,
			       rf, ff, rt, ft, closure);
		  }
	      break;

	    case WhiteBishop:
	    case BlackBishop:
	      for (rs = -1; rs <= 1; rs += 2) 
		for (fs = -1; fs <= 1; fs += 2)
		  for (i = 1;; i++) {
		      rt = rf + (i * rs);
		      ft = ff + (i * fs);
		      if (rt < 0 || rt > 7 || ft < 0 || ft > 7) break;
		      if (SameColor(board[rf][ff], board[rt][ft])) break;
		      callback(board, flags, NormalMove,
			       rf, ff, rt, ft, closure);
		      if (board[rt][ft] != EmptySquare) break;
		  }
	      break;

	    case WhiteRook:
	    case BlackRook:
	      for (d = 0; d <= 1; d++)
		for (s = -1; s <= 1; s += 2)
		  for (i = 1;; i++) {
		      rt = rf + (i * s) * d;
		      ft = ff + (i * s) * (1 - d);
		      if (rt < 0 || rt > 7 || ft < 0 || ft > 7) break;
		      if (SameColor(board[rf][ff], board[rt][ft])) break;
		      callback(board, flags, NormalMove,
			       rf, ff, rt, ft, closure);
		      if (board[rt][ft] != EmptySquare) break;
		  }
	      break;

	    case WhiteQueen:
	    case BlackQueen:
	      for (rs = -1; rs <= 1; rs++) 
		for (fs = -1; fs <= 1; fs++) {
		    if (rs == 0 && fs == 0) continue;
		    for (i = 1;; i++) {
			rt = rf + (i * rs);
			ft = ff + (i * fs);
			if (rt < 0 || rt > 7 || ft < 0 || ft > 7) break;
			if (SameColor(board[rf][ff], board[rt][ft])) break;
			callback(board, flags, NormalMove,
				 rf, ff, rt, ft, closure);
			if (board[rt][ft] != EmptySquare) break;
		    }
		}
	      break;

	    case WhiteKing:
	    case BlackKing:
	      for (i = -1; i <= 1; i++)
		for (j = -1; j <= 1; j++) {
		    if (i == 0 && j == 0) continue;
		    rt = rf + i;
		    ft = ff + j;
		    if (rt < 0 || rt > 7 || ft < 0 || ft > 7) continue;
		    if (SameColor(board[rf][ff], board[rt][ft])) continue;
		    callback(board, flags, NormalMove,
			     rf, ff, rt, ft, closure);
		}
	      break;
	  }
      }
}


typedef struct {
    MoveCallback cb;
    VOIDSTAR cl;
} GenLegalClosure;

extern void GenLegalCallback P((Board board, int flags, ChessMove kind,
				int rf, int ff, int rt, int ft,
				VOIDSTAR closure));

void GenLegalCallback(board, flags, kind, rf, ff, rt, ft, closure)
     Board board;
     int flags;
     ChessMove kind;
     int rf, ff, rt, ft;
     VOIDSTAR closure;
{
    register GenLegalClosure *cl = (GenLegalClosure *) closure;

    if (!(flags & F_IGNORE_CHECK) &&
	CheckTest(board, flags, rf, ff, rt, ft,
		  kind == WhiteCapturesEnPassant ||
		  kind == BlackCapturesEnPassant)) return;
    if (flags & F_ATOMIC_CAPTURE) {
      if (board[rt][ft] != EmptySquare ||
	  kind == WhiteCapturesEnPassant || kind == BlackCapturesEnPassant) {
	int r, f;
	ChessSquare king = (flags & F_WHITE_ON_MOVE) ? WhiteKing : BlackKing;
	if (board[rf][ff] == king) return;
	for (r = rt-1; r <= rt+1; r++) {
	  for (f = ft-1; f <= ft+1; f++) {
	    if (r >= 0 && r <= 7 && f >= 0 && f <= 7 &&
		board[r][f] == king) return;
	  }
	}
      }
    }
    cl->cb(board, flags, kind, rf, ff, rt, ft, cl->cl);

}


/* Like GenPseudoLegal, but (1) include castling moves, (2) unless
   F_IGNORE_CHECK is set in the flags, omit moves that would leave the
   king in check, and (3) if F_ATOMIC_CAPTURE is set in the flags, omit
   moves that would destroy your own king.  The CASTLE_OK flags are
   true if castling is not yet ruled out by a move of the king or
   rook.  Return TRUE if the player on move is currently in check and
   F_IGNORE_CHECK is not set.  */
int GenLegal(board, flags, epfile, callback, closure)
     Board board;
     int flags;
     int epfile;
     MoveCallback callback;
     VOIDSTAR closure;
{
    GenLegalClosure cl;
    int ff;
    int ignoreCheck = (flags & F_IGNORE_CHECK) != 0;

    cl.cb = callback;
    cl.cl = closure;
    GenPseudoLegal(board, flags, epfile, GenLegalCallback, (VOIDSTAR) &cl);

    if (!ignoreCheck &&
	CheckTest(board, flags, -1, -1, -1, -1, FALSE)) return TRUE;

    /* Generate castling moves */
    for (ff = 4; ff >= 3; ff-- /*ics wild 1*/) {
      if ((flags & F_WHITE_ON_MOVE) &&
	    (flags & F_WHITE_KCASTLE_OK) &&
	    board[0][ff] == WhiteKing &&
	    board[0][ff + 1] == EmptySquare &&
	    board[0][ff + 2] == EmptySquare &&
	    board[0][6] == EmptySquare &&
	    board[0][7] == WhiteRook &&
	    (ignoreCheck ||
	     (!CheckTest(board, flags, 0, ff, 0, ff + 1, FALSE) &&
	      !CheckTest(board, flags, 0, ff, 0, ff + 2, FALSE)))) {

	      callback(board, flags,
		     ff==4 ? WhiteKingSideCastle : WhiteKingSideCastleWild,
		     0, ff, 0, ff + 2, closure);
		     }
	if ((flags & F_WHITE_ON_MOVE) &&
	    (flags & F_WHITE_QCASTLE_OK) &&
	    board[0][ff] == WhiteKing &&
	    board[0][ff - 1] == EmptySquare &&
	    board[0][ff - 2] == EmptySquare &&
	    board[0][1] == EmptySquare &&
	    board[0][0] == WhiteRook &&
	    (ignoreCheck ||
	     (!CheckTest(board, flags, 0, ff, 0, ff - 1, FALSE) &&
	      !CheckTest(board, flags, 0, ff, 0, ff - 2, FALSE)))) {

	      callback(board, flags,
		     ff==4 ? WhiteQueenSideCastle : WhiteQueenSideCastleWild,
		     0, ff, 0, ff - 2, closure);
		     }
	if (!(flags & F_WHITE_ON_MOVE) &&
	    (flags & F_BLACK_KCASTLE_OK) &&
	    board[7][ff] == BlackKing &&
	    board[7][ff + 1] == EmptySquare &&
	    board[7][ff + 2] == EmptySquare &&
	    board[7][6] == EmptySquare &&
	    board[7][7] == BlackRook &&
	    (ignoreCheck ||
	     (!CheckTest(board, flags, 7, ff, 7, ff + 1, FALSE) &&
	      !CheckTest(board, flags, 7, ff, 7, ff + 2, FALSE)))) {

	    callback(board, flags,
		     ff==4 ? BlackKingSideCastle : BlackKingSideCastleWild,
		     7, ff, 7, ff + 2, closure);
	}
	if (!(flags & F_WHITE_ON_MOVE) &&
	    (flags & F_BLACK_QCASTLE_OK) &&
	    board[7][ff] == BlackKing &&
	    board[7][ff - 1] == EmptySquare &&
	    board[7][ff - 2] == EmptySquare &&
	    board[7][1] == EmptySquare &&
	    board[7][0] == BlackRook &&
	    (ignoreCheck ||
	     (!CheckTest(board, flags, 7, ff, 7, ff - 1, FALSE) &&
	      !CheckTest(board, flags, 7, ff, 7, ff - 1, FALSE)))) {

	    callback(board, flags,
		     ff==4 ? BlackQueenSideCastle : BlackQueenSideCastleWild,
		     7, ff, 7, ff - 2, closure);
	}
    }

    return FALSE;
}


typedef struct {
    int rking, fking;
    int check;
} CheckTestClosure;


extern void CheckTestCallback P((Board board, int flags, ChessMove kind,
				 int rf, int ff, int rt, int ft,
				 VOIDSTAR closure));


void CheckTestCallback(board, flags, kind, rf, ff, rt, ft, closure)
     Board board;
     int flags;
     ChessMove kind;
     int rf, ff, rt, ft;
     VOIDSTAR closure;
{
    register CheckTestClosure *cl = (CheckTestClosure *) closure;
    if (rt == cl->rking && ft == cl->fking) cl->check++;
}


/* If the player on move were to move from (rf, ff) to (rt, ft), would
   he leave himself in check?  Or if rf == -1, is the player on move
   in check now?  enPassant must be TRUE if the indicated move is an
   e.p. capture.  The possibility of castling out of a check along the
   back rank is not accounted for (i.e., we still return nonzero), as
   this is illegal anyway.  Return value is the number of times the
   king is in check. */ 
int CheckTest(board, flags, rf, ff, rt, ft, enPassant)
     Board board;
     int flags;
     int rf, ff, rt, ft, enPassant;
{
    CheckTestClosure cl;
    ChessSquare king = flags & F_WHITE_ON_MOVE ? WhiteKing : BlackKing;
    ChessSquare captured = EmptySquare;
    /*  Suppress warnings on uninitialized variables    */

    if (rf >= 0) {
	if (enPassant) {
	    captured = board[rf][ft];
	    board[rf][ft] = EmptySquare;
	} else {
	    captured = board[rt][ft];
	}
	board[rt][ft] = board[rf][ff];
	board[rf][ff] = EmptySquare;
    }

    /* For compatibility with ICS wild 9, we scan the board in the
       order a1, a2, a3, ... b1, b2, ..., h8 to find the first king,
       and we test only whether that one is in check. */
    cl.check = 0;
    for (cl.fking = 0; cl.fking <= 7; cl.fking++)
	for (cl.rking = 0; cl.rking <= 7; cl.rking++) {
	  if (board[cl.rking][cl.fking] == king) {
	      GenPseudoLegal(board, flags ^ F_WHITE_ON_MOVE, -1,
			     CheckTestCallback, (VOIDSTAR) &cl);
	      goto undo_move;  /* 2-level break */
	  }
      }

  undo_move:

    if (rf >= 0) {
	board[rf][ff] = board[rt][ft];
	if (enPassant) {
	    board[rf][ft] = captured;
	    board[rt][ft] = EmptySquare;
	} else {
	    board[rt][ft] = captured;
	}
    }

    return cl.check;
}


typedef struct {
    int rf, ff, rt, ft;
    ChessMove kind;
} LegalityTestClosure;

extern void LegalityTestCallback P((Board board, int flags, ChessMove kind,
				    int rf, int ff, int rt, int ft,
				    VOIDSTAR closure));

void LegalityTestCallback(board, flags, kind, rf, ff, rt, ft, closure)
     Board board;
     int flags;
     ChessMove kind;
     int rf, ff, rt, ft;
     VOIDSTAR closure;
{
    register LegalityTestClosure *cl = (LegalityTestClosure *) closure;

    if (rf == cl->rf && ff == cl->ff && rt == cl->rt && ft == cl->ft)
      cl->kind = kind;

}

ChessMove LegalityTest(board, flags, epfile, rf, ff, rt, ft, promoChar)
     Board board;
     int flags, epfile;
     int rf, ff, rt, ft, promoChar;
{
    LegalityTestClosure cl;
    cl.rf = rf;
    cl.ff = ff;
    cl.rt = rt;
    cl.ft = ft;
    cl.kind = IllegalMove;
    GenLegal(board, flags, epfile, LegalityTestCallback, (VOIDSTAR) &cl);
    if (promoChar != NULLCHAR && promoChar != 'x') 
    {
	if (cl.kind == WhitePromotionQueen || cl.kind == BlackPromotionQueen) {
	    cl.kind = 
	      PromoCharToMoveType((flags & F_WHITE_ON_MOVE) != 0, promoChar);
	} else {
	    cl.kind = IllegalMove;
	}
    }
    return cl.kind;
}

typedef struct {
    int count;
} MateTestClosure;

extern void MateTestCallback P((Board board, int flags, ChessMove kind,
				int rf, int ff, int rt, int ft,
				VOIDSTAR closure));

void MateTestCallback(board, flags, kind, rf, ff, rt, ft, closure)
     Board board;
     int flags;
     ChessMove kind;
     int rf, ff, rt, ft;
     VOIDSTAR closure;
{
    register MateTestClosure *cl = (MateTestClosure *) closure;

    cl->count++;
}

/* Return MT_NONE, MT_CHECK, MT_CHECKMATE, or MT_STALEMATE */
int MateTest(board, flags, epfile)
     Board board;
     int flags, epfile;
{
    MateTestClosure cl;
    int inCheck;

    cl.count = 0;
    inCheck = GenLegal(board, flags, epfile, MateTestCallback, (VOIDSTAR) &cl);
    if (cl.count > 0) {
	return inCheck ? MT_CHECK : MT_NONE;
    } else {
	return inCheck ? MT_CHECKMATE : MT_STALEMATE;
    }
}

     
extern void DisambiguateCallback P((Board board, int flags, ChessMove kind,
				    int rf, int ff, int rt, int ft,
				    VOIDSTAR closure));

void DisambiguateCallback(board, flags, kind, rf, ff, rt, ft, closure)
     Board board;
     int flags;
     ChessMove kind;
     int rf, ff, rt, ft;
     VOIDSTAR closure;
{
    register DisambiguateClosure *cl = (DisambiguateClosure *) closure;
    if ((cl->pieceIn == EmptySquare || cl->pieceIn == board[rf][ff]) &&
	(cl->rfIn == -1 || cl->rfIn == rf) &&
	(cl->ffIn == -1 || cl->ffIn == ff) &&
	(cl->rtIn == -1 || cl->rtIn == rt) &&
	(cl->ftIn == -1 || cl->ftIn == ft)) {

	cl->count++;
	cl->piece = board[rf][ff];
	cl->rf = rf;
	cl->ff = ff;
	cl->rt = rt;
	cl->ft = ft;
	cl->kind = kind;
    }

}

void Disambiguate(board, flags, epfile, closure)
     Board board;
     int flags, epfile;
     DisambiguateClosure *closure;
{
    int illegal = 0;
    closure->count = 0;
    closure->rf = closure->ff = closure->rt = closure->ft = 0;
    closure->kind = ImpossibleMove;
    GenLegal(board, flags, epfile, DisambiguateCallback, (VOIDSTAR) closure);
    if (closure->count == 0) {
	/* See if it's an illegal move due to check */
        illegal = 1;
	GenLegal(board, flags|F_IGNORE_CHECK, epfile, DisambiguateCallback,
		 (VOIDSTAR) closure);	
	if (closure->count == 0) {
	    /* No, it's not even that */
	    return;
	}
    }
    if (closure->promoCharIn != NULLCHAR && closure->promoCharIn != 'x') {
	if (closure->kind == WhitePromotionQueen
	    || closure->kind == BlackPromotionQueen) {
	    closure->kind = 
	      PromoCharToMoveType((flags & F_WHITE_ON_MOVE) != 0,
				  closure->promoCharIn);
	} else {
	    closure->kind = IllegalMove;
	}
    }
    closure->promoChar = ToLower(PieceToChar(PromoPiece(closure->kind)));
    if (closure->promoChar == 'x') closure->promoChar = NULLCHAR;
    if (closure->count > 1) {
	closure->kind = AmbiguousMove;
    }
    if (illegal) {
	/* Note: If more than one illegal move matches, but no legal
	   moves, we return IllegalMove, not AmbiguousMove.  Caller
	   can look at closure->count to detect this.
	*/
	closure->kind = IllegalMove;
    }
}


typedef struct {
    /* Input */
    ChessSquare piece;
    int rf, ff, rt, ft;
    /* Output */
    ChessMove kind;
    int rank;
    int file;
    int either;
} CoordsToAlgebraicClosure;

extern void CoordsToAlgebraicCallback P((Board board, int flags,
					 ChessMove kind, int rf, int ff,
					 int rt, int ft, VOIDSTAR closure));

void CoordsToAlgebraicCallback(board, flags, kind, rf, ff, rt, ft, closure)
     Board board;
     int flags;
     ChessMove kind;
     int rf, ff, rt, ft;
     VOIDSTAR closure;
{
    register CoordsToAlgebraicClosure *cl =
      (CoordsToAlgebraicClosure *) closure;



    if (rt == cl->rt && ft == cl->ft &&
	board[rf][ff] == cl->piece) {
	if (rf == cl->rf) {
	    if (ff == cl->ff) {
		cl->kind = kind; /* this is the move we want */
	    } else {
		cl->file++; /* need file to rule out this move */
	    }
	} else {
	    if (ff == cl->ff) {
		cl->rank++; /* need rank to rule out this move */
	    } else {
		cl->either++; /* rank or file will rule out this move */
	    }
	}	    
    }
    
}

/* Convert coordinates to normal algebraic notation.
   promoChar must be NULLCHAR or 'x' if not a promotion.
*/
ChessMove CoordsToAlgebraic(board, flags, epfile,
			    rf, ff, rt, ft, promoChar, out)
     Board board;
     int flags, epfile;
     int rf, ff, rt, ft;
     int promoChar;
     char out[MOVE_LEN];
{
    ChessSquare piece;
    ChessMove kind;
    char *outp = out;
    CoordsToAlgebraicClosure cl;
    
    if (rf == DROP_RANK) {
	/* Bughouse piece drop */
	*outp++ = ToUpper(PieceToChar((ChessSquare) ff));
	*outp++ = '@';
	*outp++ = ft + 'a';
	*outp++ = rt + '1';
	*outp = NULLCHAR;
	return (flags & F_WHITE_ON_MOVE) ? WhiteDrop : BlackDrop;
    }

    if (promoChar == 'x') promoChar = NULLCHAR;
    piece = board[rf][ff];
    switch (piece) {
      case WhitePawn:
      case BlackPawn:
	kind = LegalityTest(board, flags, epfile, rf, ff, rt, ft, promoChar);
	if (kind == IllegalMove && !(flags&F_IGNORE_CHECK)) {
	    /* Keep short notation if move is illegal only because it
               leaves the player in check, but still return IllegalMove */
	    kind = LegalityTest(board, flags|F_IGNORE_CHECK, epfile,
			       rf, ff, rt, ft, promoChar);
	    if (kind == IllegalMove) break;
	    kind = IllegalMove;
	}
	/* Pawn move */
	*outp++ = ff + 'a';
	if (ff == ft) {
	    /* Non-capture; use style "e5" */
	    *outp++ = rt + '1';
	} else {
	    /* Capture; use style "exd5" */
	    *outp++ = 'x';
	    *outp++ = ft + 'a';
	    *outp++ = rt + '1';
	}
	/* Use promotion suffix style "=Q" */
	if (promoChar != NULLCHAR && promoChar != 'x') {
	    *outp++ = '=';
	    *outp++ = ToUpper(promoChar);
	}
	*outp = NULLCHAR;
	return kind;

	
      case WhiteKing:
      case BlackKing:
	/* Test for castling or ICS wild castling */
	/* Use style "O-O" (oh-oh) for PGN compatibility */
	if (rf == rt &&
	    rf == ((piece == WhiteKing) ? 0 : 7) &&
	    ((ff == 4 && (ft == 2 || ft == 6)) ||
	     (ff == 3 && (ft == 1 || ft == 5)))) {
	    switch (ft) {
	      case 1:
	      case 6:
		strcpy(out, "O-O");
		break;
	      case 2:
	      case 5:
		strcpy(out, "O-O-O");
		break;
	    }
	    /* This notation is always unambiguous, unless there are
	       kings on both the d and e files, with "wild castling"
	       possible for the king on the d file and normal castling
	       possible for the other.  ICS rules for wild 9
	       effectively make castling illegal for either king in
	       this situation.  So I am not going to worry about it;
	       I'll just generate an ambiguous O-O in this case.
	    */
	    return LegalityTest(board, flags, epfile,
				rf, ff, rt, ft, promoChar);
	}
	/* else fall through */
	
      default:
	/* Piece move */
	cl.rf = rf;
	cl.ff = ff;
	cl.rt = rt;
	cl.ft = ft;
	cl.piece = piece;
	cl.kind = IllegalMove;
	cl.rank = cl.file = cl.either = 0;
	GenLegal(board, flags, epfile,
		 CoordsToAlgebraicCallback, (VOIDSTAR) &cl);

	if (cl.kind == IllegalMove && !(flags&F_IGNORE_CHECK)) {
	    /* Generate pretty moves for moving into check, but
	       still return IllegalMove.
	    */
	    GenLegal(board, flags|F_IGNORE_CHECK, epfile,
		     CoordsToAlgebraicCallback, (VOIDSTAR) &cl);
	    if (cl.kind == IllegalMove) break;
	    cl.kind = IllegalMove;
	}

	/* Style is "Nf3" or "Nxf7" if this is unambiguous,
	   else "Ngf3" or "Ngxf7",
	   else "N1f3" or "N5xf7",
	   else "Ng1f3" or "Ng5xf7".
	*/
	*outp++ = ToUpper(PieceToChar(piece));
	
	if (cl.file || (cl.either && !cl.rank)) {
	    *outp++ = ff + 'a';
	}
	if (cl.rank) {
	    *outp++ = rf + '1';
	}

	if(board[rt][ft] != EmptySquare)
	  *outp++ = 'x';

	*outp++ = ft + 'a';
	*outp++ = rt + '1';
	*outp = NULLCHAR;
	return cl.kind;
	
      case EmptySquare:
	/* Moving a nonexistent piece */
	break;
    }
    
    /* Not a legal move, even ignoring check.
       If there was a piece on the from square, 
       use style "Ng1g3" or "Ng1xe8";
       if there was a pawn or nothing (!),
       use style "g1g3" or "g1xe8".  Use "x"
       if a piece was on the to square, even
       a piece of the same color.
    */
    outp = out;
    if (piece != EmptySquare && piece != WhitePawn && piece != BlackPawn) {
	*outp++ = ToUpper(PieceToChar(piece));
    }
    *outp++ = ff + 'a';
    *outp++ = rf + '1';
    if (board[rt][ft] != EmptySquare) *outp++ = 'x';
    *outp++ = ft + 'a';
    *outp++ = rt + '1';
    /* Use promotion suffix style "=Q" */
    if (promoChar != NULLCHAR && promoChar != 'x') {
	*outp++ = '=';
	*outp++ = ToUpper(promoChar);
    }
    *outp = NULLCHAR;

    return IllegalMove;
}










