import java.awt.Button;
import java.awt.Canvas;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Label;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

class DraughtsCanvas extends Canvas implements ActionListener, MouseListener {

     // This canvas displays a 160-by-160 draughtboard pattern with
     // a 2-pixel black border.  It is assumed that the size of the
     // canvas is set to exactly 164-by-164 pixels.  This class does
     // the work of letting the users play draughts, and it displays
     // the draughtboard.

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	TextField moveField;			// will hold the move inputs
    //Label value = new Label("", Label.CENTER);
    
   Button resignButton;   // Current player can resign by clicking this button.
   Button newGameButton;  // This button starts a new game.  It is enabled only
                          //     when the current game has ended.
   
   Label message;   // A label for displaying messages to the user.
   
   
   DraughtsData board;  // The data for the board is kept here.
                        //    This board is also responsible for generating
                        //    lists of legal moves.

   boolean gameInProgress; // Is a game currently in progress?
   
   /* The next three variables are valid only when the game is in progress. */
   
   int currentPlayer;      // Whose turn is it now?  The possible values
                           //    are DraughtsData.RED and DraughtsData.BLACK.
   int selectedRow, selectedCol;  // If the current player has selected a piece to
                                  //     move, these give the row and column
                                  //     containing that piece.  If no piece is
                                  //     yet selected, then selectedRow is -1.
   DraughtsMove[] legalMoves;  // An array containing the legal moves for the
                               //   current player.
  
   int row=1, col=1;  // for nothing, to be removed
   int row1, col1, row2, col2;

   public DraughtsCanvas() {
          // Constructor.  Create the buttons and lable.  Listen for mouse
          // clicks and for clicks on the buttons.  Create the board and
          // start the first game.
      setBackground(Color.black);
      addMouseListener(this);
      setFont(new  Font("Serif", Font.BOLD, 14));
      moveField = new TextField(4);
      moveField.addActionListener(this);
      resignButton = new Button("Resign");
      resignButton.addActionListener(this);
      newGameButton = new Button("New Game");
      newGameButton.addActionListener(this);
      message = new Label("",Label.CENTER);
      board = new DraughtsData();
      doNewGame();
   }
   

   public void actionPerformed(ActionEvent evt) {
         // Respond to user's click on one of the two buttons.
      Object src = evt.getSource();
      if (src == newGameButton)
         doNewGame();
      else if (src == resignButton)
         doResign();
      else if (src == moveField)
    	  //doClickSquare(row, col);
    	  doMoveProcess(moveField.getText());
   }
   

   void doNewGame() {
         // Begin a new game.
      if (gameInProgress == true) {
             // This should not be possible, but it doens't 
             // hurt to check.
         message.setText("Finish the current game first!");
         return;
      }
      board.setUpGame();   // Set up the pieces.
      currentPlayer = DraughtsData.RED;   // RED moves first.
      legalMoves = board.getLegalMoves(DraughtsData.RED);  // Get RED's legal moves.
      selectedRow = -1;   // RED has not yet selected a piece to move.
      message.setText("Red:  Make your move.");
      gameInProgress = true;
      newGameButton.setEnabled(false);
      resignButton.setEnabled(true);
      repaint();
   }
   

   void doResign() {
          // Current player resigns.  Game ends.  Opponent wins.
       if (gameInProgress == false) {
          message.setText("There is no game in progress!");
          return;
       }
       if (currentPlayer == DraughtsData.RED)
          gameOver("RED resigns.  BLACK wins.");
       else
          gameOver("BLACK resigns.  RED winds.");
   }
   
   void doMoveEvent() {
	   if (gameInProgress == false)
	         message.setText("Click \"New Game\" to start a new game.");
	      else {

	         if (col >= 0 && col < 10 && row >= 0 && row < 10)
	            doClickSquare(row,col);
	      }
   }
   
   void gameOver(String str) {
          // The game ends.  The parameter, str, is displayed as a message
          // to the user.  The states of the buttons are adjusted so playes
          // can start a new game.
      message.setText(str);
      newGameButton.setEnabled(true);
      resignButton.setEnabled(false);
      gameInProgress = false;
   }
      

   void doMoveProcess(String moveStr) {
	   
	   // moveStr must have format "xx-xx" as in "a1-b3"
         
      /* If the player clicked on one of the pieces that the player
         can move, mark this row and col as selected and return.  (This
         might change a previous selection.)  Reset the message, in
         case it was previously displaying an error message. */
	   
	   /***Dom's implementation***/
	 
	   col1 = ((int) moveStr.charAt(0)) - 96-1;
	   row1 = ((int) moveStr.charAt(1)) - 48-1;
	   row1 = 9 - row1;
	   col2 = ((int) moveStr.charAt(2)) - 96-1;
	   row2 = ((int) moveStr.charAt(3)) - 48-1;
	   row2 = 9 - row2;
	   
	   System.out.println(row1+" "+col1+" "+row2+" "+col2);
	   for (int i = 0; i < legalMoves.length; i++)
		   if (legalMoves[i].fromRow == row1 && legalMoves[i].fromCol == col1
		           && legalMoves[i].toRow == row2 && legalMoves[i].toCol == col2) {
			  doMakeMove(legalMoves[i]);
		      return;
		   }
	   /***end Dom's ***/
	   
	   for (int i = 0; i < legalMoves.length; i++)
		   if (legalMoves[i].fromRow == row && legalMoves[i].fromCol == col) {
			   selectedRow = row1;
	           selectedCol = col1;
	           if (currentPlayer == DraughtsData.RED)
	              message.setText("RED:  Make your move.");
	           else
	              message.setText("BLACK:  Make your move.");
	           repaint();
	           return;
	      }

	   /* If no piece has been selected to be moved, the user must first
	        select a piece.  Show an error message and return. */

	   if (selectedRow < 0) {
		   message.setText("Invalid Move. Enter Your Move Again.");
	       return;
	   }
	      
	   /* If the user clicked on a square where the selected piece can be
	      legally moved, then make the move and return. */

	   for (int i = 0; i < legalMoves.length; i++)
	      if (legalMoves[i].fromRow == selectedRow && legalMoves[i].fromCol == selectedCol
	              && legalMoves[i].toRow == row2 && legalMoves[i].toCol == col2) {
	         doMakeMove(legalMoves[i]);
	         return;
	      }
	         
	   /* If we get to this point, there is a piece selected, and the square where
	      the user just clicked is not one where that piece can be legally moved
	      Show an error message. */

	   message.setText("Enter Your Move.");
   }  // end doClickSquare()
   
   
   void doClickSquare(int row, int col) {
       // This is called by mousePressed() when a player clicks on the
       // square in the specified row and col.  It has already been checked
       // that a game is, in fact, in progress.
       
    /* If the player clicked on one of the pieces that the player
       can move, mark this row and col as selected and return.  (This
       might change a previous selection.)  Reset the message, in
       case it was previously displaying an error message. */

    for (int i = 0; i < legalMoves.length; i++)
       if (legalMoves[i].fromRow == row && legalMoves[i].fromCol == col) {
          selectedRow = row;
          selectedCol = col;
          if (currentPlayer == DraughtsData.RED)
             message.setText("RED:  Make your move.");
          else
             message.setText("BLACK:  Make your move.");
          repaint();
          return;
       }

    /* If no piece has been selected to be moved, the user must first
       select a piece.  Show an error message and return. */

    if (selectedRow < 0) {
        message.setText("Click the piece you want to move.");
        return;
    }
    
    /* If the user clicked on a squre where the selected piece can be
       legally moved, then make the move and return. */
System.out.println("Coordinates from Mouse: rcrc"+selectedRow+" "+selectedCol+" "+row+" "+col);
    for (int i = 0; i < legalMoves.length; i++)
       if (legalMoves[i].fromRow == selectedRow && legalMoves[i].fromCol == selectedCol
               && legalMoves[i].toRow == row && legalMoves[i].toCol == col) {
          doMakeMove(legalMoves[i]);
          return;
       }
       
    /* If we get to this point, there is a piece selected, and the square where
       the user just clicked is not one where that piece can be legally moved.
       Show an error message. */

    message.setText("Click the square you want to move to.");

 }  // end doClickSquare() int
   

   void doMakeMove(DraughtsMove move) {
          // Thiis is called when the current player has chosen the specified
          // move.  Make the move, and then either end or continue the game
          // appropriately.
          
      board.makeMove(move);
      
      /* If the move was a jump, it's possible that the player has another
         jump.  Check for legal jumps starting from the square that the player
         just moved to.  If there are any, the player must jump.  The same
         player continues moving.
      */
      
      if (move.isJump()) {
         legalMoves = board.getLegalJumpsFrom(currentPlayer,move.toRow,move.toCol);
         if (legalMoves != null) {
            if (currentPlayer == DraughtsData.RED)
               message.setText("RED:  You must continue jumping.");
            else
               message.setText("BLACK:  You must continue jumping.");
            selectedRow = move.toRow;  // Since only one piece can be moved, select it.
            selectedCol = move.toCol;
            repaint();
            return;
         }
      }
      
      /* The current player's turn is ended, so change to the other player.
         Get that player's legal moves.  If the player has no legal moves,
         then the game ends. */
      
      if (currentPlayer == DraughtsData.RED) {
         currentPlayer = DraughtsData.BLACK;
         legalMoves = board.getLegalMoves(currentPlayer);
         if (legalMoves == null)
            gameOver("BLACK has no moves.  RED wins.");
         else if (legalMoves[0].isJump())
            message.setText("BLACK:  Make your move.  You must jump.");
         else
            message.setText("BLACK:  Make your move.");
      }
      else {
         currentPlayer = DraughtsData.RED;
         legalMoves = board.getLegalMoves(currentPlayer);
         if (legalMoves == null)
            gameOver("RED has no moves.  BLACK wins.");
         else if (legalMoves[0].isJump())
            message.setText("RED:  Make your move.  You must jump.");
         else
            message.setText("RED:  Make your move.");
      }
      
      /* Set selectedRow = -1 to record that the player has not yet selected
          a piece to move. */
      
      selectedRow = -1;
      
      /* As a courtesy to the user, if all legal moves use the same piece, then
         select that piece automatically so the use won't have to click on it
         to select it. */
      
      if (legalMoves != null) {
         boolean sameStartSquare = true;
         for (int i = 1; i < legalMoves.length; i++)
            if (legalMoves[i].fromRow != legalMoves[0].fromRow
                                 || legalMoves[i].fromCol != legalMoves[0].fromCol) {
                sameStartSquare = false;
                break;
            }
         if (sameStartSquare) {
            selectedRow = legalMoves[0].fromRow;
            selectedCol = legalMoves[0].fromCol;
         }
      }
      
      /* Make sure the board is redrawn in its new state. */
      
      repaint();
      
   }  // end doMakeMove();
   

   public void update(Graphics g) {
        // The paint method completely redraws the canvas, so don't erase
        // before calling paint().
      paint(g);
   }
   

   public void paint(Graphics g) {
        // Draw  draughtboard pattern in gray and lightGray.  Draw the
        // pieces.  If a game is in progress, hilite the legal moves.
      
      /* Draw a two-pixel black border around the edges of the canvas. */
      
      g.setColor(Color.black);
      g.drawRect(0,0,getSize().width-1,getSize().height-1);
      g.drawRect(1,1,getSize().width-3,getSize().height-3);
      
      /* Draw the squares of the draughtboard and the pawns. */
      
      for (int row = 0; row < 10; row++) {
         for (int col = 0; col < 10; col++) {
             if ( row % 2 == col % 2 )
                g.setColor(Color.lightGray);
             else
                g.setColor(Color.gray);
             g.fillRect(6 + col*60, 6 + row*60, 60, 60);
             switch (board.pieceAt(row,col)) {
                case DraughtsData.RED:
                   g.setColor(Color.red);
                   g.fillOval(12 + col*60, 12 + row*60, 48, 48);
                   break;
                case DraughtsData.BLACK:
                   g.setColor(Color.black);
                   g.fillOval(12 + col*60, 12 + row*60, 48, 48);
                   break;
                case DraughtsData.RED_KING:
                   g.setColor(Color.red);
                   g.fillOval(12 + col*60, 12 + row*60, 48, 48);
                   g.setColor(Color.white);
                   g.drawString("K", 21 + col*60, 48 + row*60);
                   break;
                case DraughtsData.BLACK_KING:
                   g.setColor(Color.black);
                   g.fillOval(12 + col*60, 12 + row*60, 48, 48);
                   g.setColor(Color.white);
                   g.drawString("K", 21 + col*60, 48 + row*60);
                   break;
             }
         }
      }
    
      /* If a game is in progress, hilite the legal moves.   Note that legalMoves
         is never null while a game is in progress. */      
      
      if (gameInProgress) {
            // First, draw a cyan border around the pieces that can be moved.
         g.setColor(Color.cyan);
         for (int i = 0; i < legalMoves.length; i++) {
            g.drawRect(6 + legalMoves[i].fromCol*60, 6 + legalMoves[i].fromRow*60, 57, 57);
         }
            // If a piece is selected for moving (i.e. if selectedRow >= 0), then
            // draw a 2-pixel white border around that piece and draw green borders 
            // around eacj square that that piece can be moved to.
         if (selectedRow >= 0) {
            g.setColor(Color.white);
            g.drawRect(6 + selectedCol*60, 6 + selectedRow*60, 57, 57);
            g.drawRect(9 + selectedCol*60, 9 + selectedRow*60, 51, 51);
            g.setColor(Color.green);
            for (int i = 0; i < legalMoves.length; i++) {
               if (legalMoves[i].fromCol == selectedCol && legalMoves[i].fromRow == selectedRow)
                  g.drawRect(6 + legalMoves[i].toCol*60, 6 + legalMoves[i].toRow*60, 57, 57);
            }
         }
      }
   }  // end paint()
   
   
   public Dimension getPreferredSize() {
         // Specify desired size for this component.  Note:
         // the size MUST be 164 by 164.
      return new Dimension(552, 552);
   }


   public Dimension getMinimumSize() {
      return new Dimension(552, 552);
   }
   

   public void mousePressed(MouseEvent evt) {
         // Respond to a user click on the board.  If no game is
         // in progress, show an error message.  Otherwise, find
         // the row and column that the user clicked and call
         // doClickSquare() to handle it.
      if (gameInProgress == false)
         message.setText("Click \"New Game\" to start a new game.");
      else {
         int col = (evt.getX() - 2) / 60;
         int row = (evt.getY() - 2) / 60;
         if (col >= 0 && col < 10 && row >= 0 && row < 10)
         	doClickSquare(row,col);
      }
   }
   

   public void mouseReleased(MouseEvent evt) { }
   public void mouseClicked(MouseEvent evt) { }
   public void mouseEntered(MouseEvent evt) { }
   public void mouseExited(MouseEvent evt) { }


}  // end class boardCanvas