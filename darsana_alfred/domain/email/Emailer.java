/*# Configuration file for javax.mail 
# If a value for an item is not provided, then 
# system defaults will be used. These items can 
# also be set in code. 

# Host whose mail services will be used 
# (Default value : localhost) 
mail.host=mail.blah.com 

Sattam Deb's send email domain. 

# Return address to appear on emails 
# (Default value : username@host) 
mail.from=webmaster@blah.net 

# Other possible items include: 
# mail.user= 
# mail.store.protocol= 
# mail.transport.protocol= 
# mail.smtp.host= 
# mail.smtp.user= 
# mail.debug= */ 

//    A class which uses this file to send an email : 


import java.util.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import java.awt.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.InetAddress;
import java.awt.event.*;
import java.util.StringTokenizer;

/**
 * Simple use case for the javax.mail API.
 */
public final class Emailer {

    public static void main( String[] args ){
	
	///////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////

		//this is what Alfred will send
		String clientsRequest = "";
	    
		//used to connect to Alfred
		ServerSocket serverSocket = null;
		//the socket through which server and client will communicate
		Socket client = null;
		
		try 
		{
			//try to connect...
			serverSocket = new ServerSocket(0);
			
			//print the local port number to a file so that the client knows what to connect to
			BufferedWriter fileWriter = null;		        
			if ((args.length != 0) && (!(args[0] == null)))
				fileWriter = new BufferedWriter (new FileWriter (args[0]));
			else
				fileWriter = new BufferedWriter (new FileWriter ("connectioninfo"));
			Integer port = new Integer (serverSocket.getLocalPort());
			//write the port number
			fileWriter.write ("port " + port.toString() + "\n");
			//write the local host address
			String host = InetAddress.getLocalHost().getCanonicalHostName();
			fileWriter.write ("host " + host + "\n");
			//write the process ID
			fileWriter.write ("process " + getProcess() + "\n");
			fileWriter.flush();
			fileWriter.close();
		} 
		catch (IOException e) {}
		catch (Exception e) {}
		//used to get commands from Alfred
		BufferedReader input = null;
		
		try
		{	
			//the socket through which server and client will communicate
			client = serverSocket.accept();
	        
			//Wrap streams so we can receive data
			input = new BufferedReader (
				new InputStreamReader (client.getInputStream()));
	        
			//reading the client's request
			clientsRequest = input.readLine();
		}
		catch (IOException e)
		{
			System.out.println ("Exception: " + e);
		}
		catch (NullPointerException e)
		{
			System.out.println ("Exception: " + e);	        
		}

		System.out.println(clientsRequest);

		//if we have received a valid command, start everything:
		if (clientsRequest.equalsIgnoreCase ("[[send,mail]]"))
		{
			/*PopKorn pop = new PopKorn();
			pop.pack();
			pop.setVisible(true);*/

			//////////////////////////////////////////////////////////////////////////////////

			//SEND EMAIL CODE

			Emailer emailer = new Emailer();
			//the domains of these email addresses should be valid,
			//or the example will fail:
	
	
			emailer.sendEmail("sdeb@wam.umd.edu",
				"generic.satty@gmail.com",
				"Testing 1-2-3",
				"blah blah blah"); 


			///////////////////////////////////////////////////////////////////////////////////


			//wait for other commands
			try
			{
				clientsRequest = input.readLine();
				if (clientsRequest != null)
					if (clientsRequest.equals ("[[exit]]"))
					{
						//close the sockets
						try
						{
							client.close();
							serverSocket.close();
						}
						catch (IOException e)
						{
						}
						//shut down
						System.exit(0);
					}
			}
			catch (IOException e)
			{
				System.out.println ("Exception: " + e);
			}
		}
	    
		//close both sockets
		try
		{
			client.close();
			serverSocket.close();
		}
		catch (IOException e)
		{
		}

	////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////
	
		
		
		/*	
	Emailer emailer = new Emailer();
	//the domains of these email addresses should be valid,
	//or the example will fail:
	
	
	emailer.sendEmail("webmaster@blah.net",
			  "somebody@somewhere.com",
			  "Testing 1-2-3",
			  "blah blah blah"); */
    }

    /**
     * Send a single email.
     */
    public void sendEmail( String aFromEmailAddr,
			   String aToEmailAddr,
			   String aSubject,
			   String aBody ) {

	//Here, no Authenticator argument is used (it is null).
	//Authenticators are used to prompt the user for user
	//name and password.
	Session session = Session.getDefaultInstance( fMailServerConfig, null );

	MimeMessage message = new MimeMessage( session );

	try {
	    //the "from" address may be set in code, or set in the
	    //config file under "mail.from" ; here, the latter style is used
	    //message.setFrom( new InternetAddress(aFromEmailAddr) );
	    message.addRecipient(Message.RecipientType.TO, new InternetAddress(aToEmailAddr));
	    message.setSubject( aSubject );
	    message.setText( aBody );

	    Transport.send( message );
	}
	catch (MessagingException ex){
	    System.err.println("Cannot send email. " + ex);
	}
    }

    /**
     * Allows the config to be refreshed at runtime, instead of
     * requiring a restart.
     */
    public static void refreshConfig() {
	fMailServerConfig.clear();
	fetchConfig();
    }

    // PRIVATE //

    private static Properties fMailServerConfig = new Properties();

    static {
	fetchConfig();
    }

    /**
     * Open a specific text file containing mail server
     * parameters, and populate a corresponding Properties object.
     */
    private static void fetchConfig() {
	InputStream input = null;
	try {
	    //If possible, one should try to avoid hard-coding a path in this
	    //manner; in a web application, one should place such a file in
	    //WEB-INF, and access it using ServletContext.getResourceAsStream.
	    //Another alternative is Class.getResourceAsStream.
	    //This file contains the javax.mail config properties mentioned above.
	    input = new FileInputStream( "C:\\Temp\\MyMailServer.txt" );
	    fMailServerConfig.load( input );
	}
	catch ( IOException ex ){
	    System.err.println( "Cannot open and load mail server properties file." );
	}
	finally {
	    try {
		if ( input != null ) input.close();
	    }
	    catch ( IOException ex ){
		System.err.println( "Cannot close mail server properties file." );
	    }
	}
    }
} 
