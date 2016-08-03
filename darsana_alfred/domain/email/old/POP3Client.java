import java.net.*;
import java.io.*;
import java.util.*;

/**
 * A general purpose class for retrieving mails from 
 * a POP-3 server.
 * @author msandeep@technologist.com
 */
public class POP3Client
{
	public static final boolean debug = false;
	public static final int POP3PORT = 110;

	// States of client
	public static final int DISCONNECTED = 0;	
	public static final int CONNECTED = 1;	

	/******** Private variables for accessing the mailbox ****/
	private String user, password, host;
	private int state = DISCONNECTED;

	private Socket socket;
	private BufferedReader is;
	private PrintWriter out;

	// Data and status info are passed to any object
	// implementing the POP3Reader interface
	private POP3Reader reader;

	/**
	 * @param host POP3 Server from where to ger messages
	 * @param user  Name of the mailbox on pop3 server.
	 * @param pass Password of user
	 * @param reader A class that implements the POP3Reader interface.
	 *			This class gets the mail data and status information from server.
	 * @see POP3Reader
	 */
	POP3Client(String host, String user, String pass, POP3Reader reader)
	{
		this.host = host;
		this.user = user;
		this.password = pass;
		this.reader = reader;
	}

	/**
	 * Does the actual mail retrieval stuff
	 * @param todelete If true, messages are deleted from server.
	 * @exception POP3Exception If there was an error while retrieving messages
	 */
	public void getMail(boolean todelete) throws POP3Exception
	{
		try{
			// Do the initial stuff
			int nmesg = startTransaction();

		// Now go thru this list and spew the messages
		for(int i = 1; i <= nmesg; i++)
		{
			reader.info("Fetching message " + i + " of " + nmesg);
			out.println("RETR " + i);
			getResponse(is);
			

			String instr = is.readLine();
			while(!instr.equals("."))
			{
				reader.data(instr);
				instr = is.readLine();
			}

			// End of message. Delete if required
			if(todelete)
			{
				out.println("DELE " + i);
				getResponse(is);
			}

		}
	}	// End try
	catch(IOException ioe){
		reader.info(ioe.toString());
	}
	catch(POP3Exception poe){
		reader.info(poe.toString());
	}
	finally
	{
		popQuit();
	}


	}// end of getMail()

	/**
	 * Checks for mail in the server. 
	 * Does not retrieve or delete them.
	 * @return The no. of messages in mailbox.
	 *	-1 in case of errors.
	 */
	public int checkMail()  
	{
		try{
			int nmesg = startTransaction();
			return nmesg;
		}catch (POP3Exception poe){
			reader.info(poe.getMessage());
			return -1;
		}
		finally
		{
			popQuit();
		}

	}	// End checkMail()
	
	/**
	 * Sends appropriate commands before quitting
	 */
	private void popQuit()
	{
		if(socket != null)
		{
			try {
				out.println("QUIT");
				socket.close();
				if(debug)
					reader.info("Socket closed");
			}catch(IOException ioe){}
		}
		state = DISCONNECTED;
		reader.info("Channel closed");
	}	// End popQuit()


	/**
	 * Parses the response line from server
	 * Throws an exception if not ok.
	 * @param in Stream from where to read the response.
	 * @exception POP3Exception If there was any fatal error.
	 * @return The response message
	 */
	public String getResponse(BufferedReader in) throws POP3Exception
	{
		String str ;
		try{
			str =  in.readLine();
			if(debug)
				reader.info(str);
		}catch(IOException ioe)
		{
			throw new POP3Exception(ioe.toString());
		}
		StringTokenizer st = new StringTokenizer(str);
		String resp = st.nextToken();
		String mesg = st.nextToken("\r\n");	// The whole line
		if(!resp.equalsIgnoreCase("+OK"))
			throw new POP3Exception("POP Error:" + mesg);

		return mesg;

	}

	/**
	 * Establishes connection with server, sends initial strings
	 * and returns no. of mail messages in mailbox.
	 * Should always be called before doing any transaction with server.
	 * Remember to call popQuit() method after transactions are over.
	 * @return The number of message in mailbox.
	 */
	private int startTransaction() throws POP3Exception
	{
		if(user == null || user.equals(""))
			throw new POP3Exception("User Not Specified");
		
		if(password == null || password.equals(""))
			throw new POP3Exception("Password Not Specified");

		if(host == null || host.equals(""))
			throw new POP3Exception("Host Not Specified");

		// Start the connection and send request
		try{
			reader.info("Connecting to " + host + "..");
			socket = new Socket(host, POP3PORT);
			state = CONNECTED;
			reader.info("Connected.");
			// We expect only a few lines to go out to server and a
			// flood a data coming in.
			// Makes sense to buffer the input stream but not the output stream.
			is = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			out = new PrintWriter(socket.getOutputStream(), true);
		}catch(IOException ioe)
		{
			throw new POP3Exception(ioe.toString());
		}

		// Start the handshaking..
		reader.info("Sending login info..");
		getResponse(is);
		out.println("USER " + user);
		getResponse(is);
		out.println("PASS " + password);
		getResponse(is);
		reader.info("Login OK.");

		// Get info about mailbox
		out.println("STAT");
		String droplist = getResponse(is);
		// droplist is of form "+OK nummesg size"
		StringTokenizer st = new StringTokenizer(droplist);
		// Should check for exceptions. 
		int nmesg = Integer.parseInt(st.nextToken());
		int mboxsize = Integer.parseInt(st.nextToken());

		reader.info(nmesg + " messages in " + mboxsize + " bytes for " + user);

		return nmesg;
	}

}	// End class POP3Client

