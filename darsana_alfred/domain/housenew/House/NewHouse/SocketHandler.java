
/*
 * Created on Jun 9, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package NewHouse;
import java.net.*;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.InputStreamReader; 
import java.io.BufferedReader;
import java.io.OutputStreamWriter;
import java.io.*;
import java.util.*;

/**
 * This class connects to the Alfred server and sends communication back and forth.
 * Data is sent to the DataHandler to be processed.
 */
public class SocketHandler {
	private DataHandler dh;
	private ServerSocket serverSocket;
	public SocketHandler() {
		dh = new DataHandler();
		try {
			serverSocket = new ServerSocket(9880);
			init();
		} catch (IOException e) {
			
		}
	}
	public void init() { //Starts the socket handler
		try {
			BufferedReader reader;
			BufferedWriter out;
			
			//while (true) { //Always have the server accepting connections, processing and then accepting connections again
				System.out.println(serverSocket.getLocalPort());
				
				Socket alfred = serverSocket.accept(); //Socket to connect to client with
				
				//Create a reader and writer to handle the input/output with the client
				reader = new BufferedReader(new InputStreamReader(alfred.getInputStream()));
				out = new BufferedWriter(new OutputStreamWriter(alfred.getOutputStream()));			
				
				String input; //Data received from the client
				
				while (alfred.isConnected()) {
					input=reader.readLine();
					if (input!=null) { //Read all non-null lines from Alfred
						out.write(dh.processData(input)); //Send back the result from the processing of the data
					}
				}

				reader.close();
				out.close();
				alfred.close();
				serverSocket.close();
			//}
		} catch (IOException e) { //Input Output Exception thrown
			System.out.println("Error: Connection error or closure");
		}
	}

}
