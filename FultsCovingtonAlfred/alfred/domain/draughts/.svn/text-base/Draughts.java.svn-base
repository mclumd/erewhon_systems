/*
   This applet lets two uses play checkers against each other.
   Red always starts the game.  If a player can jump an opponent's
   piece, then the player must jump.  When a plyer can make no more
   moves, the game ends.
   
   This file defines four classes: the main applet class, Draughts;
   DraughtsCanvas, DraughtsMove, and DraughtsData.
   (This is not very good style; the other classes really should be
   nested classes inside the Draughts class.)
*/

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import java.io.*;
import java.util.*;
import java.net.*;


public class Draughts extends Applet {

   /* The main applet class only lays out the applet. The work of
      the game is all done in the DraughtsCanvas object. The applet
      class gives them their visual appearance and sets their
      size and positions. It also deals connect the game to ALFRED
      in the main function.*/
  
   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static DraughtsCanvas board = new DraughtsCanvas();
	public static Settings setting= null;

	//	 socket related 
    public static ServerSocket ss= null;
    public static Socket alfred= null;
    public static BufferedInputStream bis= null;

    //  record keeping
    public static int cmdNum= 1;
	
    public void init() {
   
      setLayout(null);  // I will do the layout myself.
   
      setBackground(new Color(0,150,0));  // Dark green background.
      
      /* Create the components and add them to the applet. */

      //DraughtsCanvas board = new DraughtsCanvas();
          // Note: The constructor creates the buttons board.resignButton
          // and board.newGameButton and the Label board.message.      
      add(board);

      board.newGameButton.setBackground(Color.lightGray);
      add(board.newGameButton);

      board.resignButton.setBackground(Color.lightGray);
      add(board.resignButton);

      board.message.setForeground(Color.green);
      //board.message.setFont(new Font("Serif", Font.BOLD, 14));
      add(board.message);
      
      board.moveField.setBackground(Color.white);
      add(board.moveField);
      
      /* Set the position and size of each component by calling
         its setBounds() method. */

      board.setBounds(50,150,612,612); // Note:  size MUST be 164-by-164 !
      board.newGameButton.setBounds(50, 50, 100, 25);
      board.resignButton.setBounds(250, 50, 100, 25);
      //board.moveField.setBounds(500, 50, 100, 25);
      board.message.setBounds(50, 100, 330, 25);
      resize(750,850);
      
   }
   
// code from java.sun.com
   static public void main(String argv[]) throws Exception {
		final Applet applet = new Draughts();
		System.runFinalizersOnExit(true);
		Frame frame = new Frame("Draughts");
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent event) {
				applet.stop();
				applet.destroy();
				System.exit(0);
			}
		});
		frame.add("Center", applet);
		// applet.setStub (new MyAppletStub (argv, applet));
		frame.show();
		frame.resize(750, 850);
		applet.init();
		applet.start();
		// frame.pack();
		// board.message.setText("board works outside of canvas");
		//board.doMoveProcess("a4b5");

		/* code for Alfred connectivity */

		setting = new Settings(argv[0]);

		setting.writeFile();

		ss = setting.getServerSocket();

		while (true) {
			System.out.println("Waiting for connection with Alfred...");
			alfred = ss.accept();
			System.out.println("Connection with Alfred established!");

			bis = new BufferedInputStream(alfred.getInputStream());

			while (alfred.isConnected()) {
				processCommand(getCommand("Command " + cmdNum++
						+ " from Alfred"));
			}
		}

	} // end main
 

   	// Get the command string
	public static String getCommand(String request) throws Exception {
		byte[] bt = new byte[1000];

		try {
			bis.read(bt);
			System.out.println(request + ": " + new String(bt));
		} catch (IOException ioe) {
			System.out.println("Sorry unable to get your command...");
			System.exit(-1);
		}

		return new String(bt);
	}

	
	// Process the command received from Alfredo
	public static void processCommand(String command) throws Exception {
		
		// tokenizes by: , ' ' [ ]
		StringTokenizer tok= new StringTokenizer(command, "[], ", false);
		String first= tok.nextToken();
		
		first= first.trim().toLowerCase();
		
		if (first.equals("move")) {
			String origin = "";
			String dest = "";
			
			if (tok.hasMoreTokens())
			    origin = tok.nextToken();
			if (tok.hasMoreTokens()) {
			    dest = tok.nextToken();
			}
			
			String move = origin+dest;
			board.doMoveProcess(move);
		}
			
		else if (first.equals("quit")) {
			System.out.println("Quitting Draughts...");
		    System.exit(-1);
		}
		else if (first.equals("new")) {
			board.doResign();
		}
		else if (first.equals("resign")) {
			board.doNewGame();
		}
		else {
		    System.out.println("You did not provide a " + 
				       "valid command: " + first);
		    System.out.println("Closing...");
		    System.exit(-1);
		}

	}

} // end class Draughts





