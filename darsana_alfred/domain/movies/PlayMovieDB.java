// FINAL VERSION PLAYMOVIE
// PLEASE DO NOT MODIFY
//
// ANTON PAOLO C. DEL MUNDO


//edited by Sonny Singh

import java.io.*;
import java.util.*;
import java.net.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.awt.*;
import java.net.MalformedURLException;
import java.net.URL;

import javax.swing.*;

public class PlayMovie extends JFrame {
    
	// system wide settings
	public static String vlc_base= "/fs/disco/geoffr/vlc/INST/bin";
	public static String movies_base= "movies";
	
	// socket related 
	public static ServerSocket ss= null;
	public static Socket alfred= null;
	public static BufferedInputStream bis= null;
	
	// state 
	public static Process movieProcess= null;
	public static Settings setting= null;
	
	// record keeping
	public static int cmdNum= 1;
	public static String currMovieName= null;
	public static String curr_height = "300";
	public static String curr_width = "300";
	
	
	// miscellaneous
	public static Runtime rt= Runtime.getRuntime();

	public static void main(String[] args) throws Exception 
	{ 
		if (args.length != 2) 
		{
			System.out.println("Usage: java PlayMovie $movie_dir $HOSTFILE");
			System.exit(-1);
		}
		
		movies_base= args[0];
		setting= new Settings(args[1]);
		
		setting.writeFile();
		
		ss= setting.getServerSocket();

		while(true) 
		{
			System.out.println("Waiting for connection with Alfred...");
			alfred= ss.accept();
			System.out.println("Connection with Alfred established!");
			
			bis= new BufferedInputStream(alfred.getInputStream());
			
			while (alfred.isConnected()) 
			{
				processCommand(getCommand("Command " + cmdNum++ + " from Alfred"));
			}
			
		}
	}
	
	public static String getCommand(String request) throws Exception 
	{
		byte[] bt= new byte[1000];
		
		try 
		{	    
			bis.read(bt);
			System.out.println(request + ": " + new String(bt));
		} catch (IOException ioe) {
			System.out.println("Sorry unable to get your command...");
			System.exit(-1);
		}
		
		return new String(bt);
	}
	
	public static void processCommand(String command) throws Exception 
	{
		
		//tokenizes by: , ' ' [ ]
		StringTokenizer tok= new StringTokenizer(command, "[], ", false);
		String first= tok.nextToken();
		
		first= first.trim().toLowerCase();
		
		if (first.equals("play")) 
		{
			
			currMovieName= tok.nextToken();
			
			String adder = "";
			String whole = "";
			String checker = "";
			int cnt = 0;
			Vector vect = new Vector();
			
			while(tok.hasMoreTokens())             //add movie titles
			{
				checker  = tok.nextToken();
				
				//prevents duplicate entries from being queued up
				//tokenizer gets empty strings...so check to see if its a movie name
				//length of title is at least 3 because of .mov or .avi ending.
				
				if(vect.contains(checker) == false)
				{
					if((checker.equals(currMovieName) == false) && (checker.length() > 3)
							&& (checker.equals("") == false))
					{
						cnt++;
						vect.add(checker);
					}
				}
				else
					System.out.println("Tried to enqueue "+checker+" but it is already on playlist");
				
				
			}
			
			cnt--;  //compensates for deliminator of the tokenized string.
			
			// creates array
			if(cnt == 0)
			{
				startMovieProcess(new String[] {vlc_base + "/vlc", 
						"--volume", "10", "--width", curr_width, "--height", curr_height, 
						movies_base + "/" + currMovieName});
			}
			
			else if(cnt == 1)
			{
				startMovieProcess(new String[] {vlc_base + "/vlc",
						"--volume", "10",  "--width", curr_width, "--height", curr_height,
						movies_base + "/" + currMovieName, 
						movies_base + "/" + ((String)vect.get(0))});
			}
			else if(cnt == 2)
			{
				startMovieProcess(new String[] {vlc_base + "/vlc",
						"--volume", "10",  "--width", curr_width, "--height", curr_height,
						movies_base + "/" + currMovieName,
						movies_base + "/" + ((String)vect.get(0)),
						movies_base + "/" + ((String)vect.get(1))});
			}
			else if(cnt == 3)
			{
				startMovieProcess(new String[] {vlc_base + "/vlc",
						"--volume", "10", "--width", curr_width, "--height", curr_height,
						movies_base + "/" + currMovieName,
						movies_base + "/" + ((String)vect.get(0)),
						movies_base + "/" + ((String)vect.get(1)),
						movies_base + "/" + ((String)vect.get(2))});
			}
			else
			{
				System.out.println("too many movies requested.  Max is 4.");
			}
			
			
			
			System.out.println("Started Playing Movie");
			
		}
		else if (first.equals("fullscreen")) {
			if (currMovieName== null) {
				System.out.println("You currently do not have a running movie...");
				return;
			}
			startMovieProcess(new String[] {vlc_base + "/vlc",
					"--volume", "10",
					"--fullscreen",
					movies_base + "/" + currMovieName});
			
			
			
		}
		else if (first.equals("set")) {   //format: set volume to < int >
			
			if (currMovieName== null) {
				System.out.println("You currently do not have a running movie...");
				return;
			}
			
			String type= tok.nextToken();               // height or width or volume
			type= type.trim().toLowerCase();
			
			String value = tok.nextToken();   
			value= value.trim();
			
			if(type.equals("volume"))
			{
				startMovieProcess(new String[]{vlc_base + "/vlc",
						"--volume", value, "--width", curr_width, "--height", curr_height,
						movies_base + "/" + currMovieName});
				
				System.out.println("Adjusted volume to "+value);
			}
			else   //adjust height or width or both
			{
				
				if(type.equals("width"))
				{
					curr_width = value;
					startMovieProcess(new String[]{vlc_base + "/vlc",
							"--volume", "10", "--width", curr_width, "--height", curr_height,
							movies_base + "/" + currMovieName});
					System.out.println("Adjusted width to "+value);
				}
				else if (type.equals("height"))
				{
					curr_height = value;
					startMovieProcess(new String[]{vlc_base + "/vlc",
							"--volume", "10", "--width", curr_width, "--height", curr_height,
							movies_base + "/" + currMovieName});
					
					
					System.out.println("Adjusted height to "+value);
				}
			}
		}
		else if (first.equals("mute")) { //format: mute
			
			if (currMovieName== null) {
				System.out.println("You currently do not have a running movie...");
				return;
			}
			//no audio
			System.out.println("Movie volume muted");
			startMovieProcess(new String[]{vlc_base + "/vlc",
					"--noaudio", "--width", curr_width, "--height", curr_height,
					movies_base + "/" + currMovieName});
		}
		else if(first.equals("list"))    //uses bufferreader class to output results of runtime "ls" command
		{                               //list movies (command)
			
			String garbage = tok.nextToken();   //gets garbage word 'movies' 
			Process proc = rt.exec("ls" + " " + movies_base);
			
			// BufferReader reads ls output
			
			InputStream inputstream = proc.getInputStream();
			InputStreamReader inputstreamreader = new InputStreamReader(inputstream);
			BufferedReader bufferedreader = new BufferedReader(inputstreamreader);
			
			System.out.println("Here is list of currently available movies: ");
			String read_line;
			while ((read_line = bufferedreader.readLine()) != null) 
			{
				System.out.println(read_line);
			}
			
			
			
			try                             //checks to see if "ls" command failed
			{
				if (proc.waitFor() != 0) 
				{
					System.err.println("exit value = " + proc.exitValue());
				}
			}
			catch (InterruptedException e) {
				System.err.println(e);
			}
		}
		else if (first.equals("show movies")) {
			Connection con = null;
			try {
				//Added jdbc driver here 
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/movieDB",
						"valva", "kucing21");
				
				if(!con.isClosed())
					System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
				
				System.out.println("Showing movies from database...");
				
				Statement stmt = con.createStatement();
				ResultSet rset = stmt.executeQuery( "select * from MovieInfo");
				
				while (rset.next()) 
					System.out.println(rset.getString(2));
			}	catch(Exception e) {
				System.err.println("Exception: " + e.getMessage());
			}	finally {
				try {
					if(con != null)
						con.close();
				}	catch(SQLException e) {
					System.out.println("Failed to close connection.");
				}
			}		
		}
		else if (first.equals("stop")) {
			System.out.println("Closing movie process...");
			destroyMovieProcess();
		}
		else if (first.equals("quit")) {
			System.out.println("Qutting PlayMovie...");
			System.exit(-1);
		}
		else {
			System.out.println("You did not provide a " + 
					"valid command: " + first);
			System.out.println("Closing...");
			System.exit(-1);
		}
	}
	
	public static void startMovieProcess(String[] cmd) throws Exception {
		destroyMovieProcess();
		
		movieProcess= rt.exec(cmd);
		//exec parses command by command and substitutes in spaces
	}
	
	
	public static void destroyMovieProcess() {
		if (movieProcess != null) {
			movieProcess.destroy();
			movieProcess= null;
		}
	}
}
