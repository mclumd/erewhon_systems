import java.net.*;
import java.io.*;

/**
 * @author  Written by Alexey Vedernikov (vedernikov@gmail.com)
 */

public class Client
{
    private static String fileName = null;
	/*
	 * Connect with the server that is listening to the given port of the 
	 * given host.  Once the connection is established, "message" is 
	 * transmitted to the server as text.  The response from the server will 
	 * be one line of text, which is returned from this method.
	 * 
	 * This method does not know (or care) about the contents of the message or
	 * the contents of the server's response.
	 */
    
    public void connect()
    {
	    //this is what you will send
	    String message = "[[check,mail]]";
	    //could also be "exit"
	    
	    //the port we will connect to
	    int port = 0;
	    BufferedReader fileReader = null;
	    
	    //get the port number from a file
	    try
	    {
	        fileReader = new BufferedReader (new FileReader (fileName));
	        port = Integer.parseInt (fileReader.readLine());
	        System.out.println ("the port: " + port);
	    }
	    catch (FileNotFoundException e)
	    {
	        System.out.println (e);	        
	    }
	    catch (IOException e)
	    {
	        System.out.println (e);
	    }
	    
	    //connect to the server...
		try
		{
		    //create a socket through which the server and a client will communicate
		    //host is the local host and port is a local port
			Socket sock = new Socket (InetAddress.getLocalHost(), port);
			
			//Wrap streams around the sockets so we can send the data
			PrintWriter out = new PrintWriter (sock.getOutputStream (), true);
			
			//send the mesage to the server
			out.println (message);	
			
			//closing everything
			out.close ();
			sock.close ();
		}
	    catch (UnknownHostException e) 
	    {
	        System.out.println ("Exception: " + e);
	    }
		catch (IOException excptn)
		{
			System.out.println ("Exception: " + excptn);
		}
    }
	
	public static void main (String args[])
	{
	    if ((args.length != 0) && (!(args[0] == null)))
	        fileName = args[0];
	    else 
	        fileName = "connectioninfo";
		Client c = new Client();
		c.connect();
	}
}
