import java.io.*;
import java.net.*;

class tcpclient
{
    public static void main(String argv[]) throws Exception
    {
	while(true){
	    String sentence;
	    String modifiedSentence;
	    BufferedReader inFromUser = new BufferedReader( new InputStreamReader
		(System.in));
	    Socket clientSocket = new Socket("localhost", 1025);
	    DataOutputStream outToServer = new DataOutputStream(clientSocket.
								getOutputStream());
	    BufferedReader inFromServer = new BufferedReader(new InputStreamReader
		(clientSocket.
		 getInputStream()));
	    sentence = inFromUser.readLine();
	    outToServer.writeBytes(sentence + '\n');
	    clientSocket.close();
	}
    }
}
  
