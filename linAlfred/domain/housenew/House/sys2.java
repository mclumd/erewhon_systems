import java.awt.*;
import javax.swing.*;
import java.io.*;
import java.lang.*;
import java.util.*;
import java.util.StringTokenizer;
import java.net.*;


class sys2{	  
    
    BasicDraw img = new BasicDraw();
    String m1 = "Stored Environment LOADED, Listening for commands ....";				
    
    public static void main(String args[])throws Exception{
	new sys2();		
    }
    
    sys2(){
	JFrame frame = new JFrame("Command Listener");	
	Comm kk = new Comm();
	frame.getContentPane().add(kk);
	frame.setSize(882,43);
	frame.setLocation(20,694);
	frame.setVisible(true);	
	frame.repaint();
	
	try{
	    String clientSentence;
	    ServerSocket welcomeSocket = getRandomServerSocket();
	    
	    while(true){
		Socket connectionSocket = welcomeSocket.accept();
		BufferedReader inFromClient = new BufferedReader(
		    new InputStreamReader(System.in));
                        //connectionSocket.getInputStream()));
		DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
		
		clientSentence = inFromClient.readLine();
		
		m1 = new String("Command Received:  "+clientSentence);
		frame.repaint();	 
		
		String t1 = null;
		String t2 = null;
		String t3 = null;
		String t4 = null;								
		
		try{
		    StringTokenizer st = new StringTokenizer(clientSentence);													 
		    while(st.hasMoreTokens()) {
			t1=st.nextToken();
			t2=st.nextToken();
			t3=st.nextToken();
			t4=st.nextToken();
		    }
		    if(t1.equals("light")){
			if(t2.equals("on")){								
			    img.turnon(t3, t4);
			    m1 = new String("Command Recieved:  "
					    +clientSentence+"           "+t3+" "+t4+" TURNED ON");
			    frame.repaint();						
			}
			else if(t2.equals("off")){
			    img.turnoff(t3,t4);
			    m1 = new String("Command Recieved:  "
					    +clientSentence+"           "+t3+" "+t4+" TURNED OFF");
			    frame.repaint();								
			}									  
			else{
			    throw new Exception();
			} 
		    }
		    else if(t1.equals("door")){
			m1 = new String("Command Recieved:  "
					+clientSentence+"           DOOR COMMANDS NOT IMPLEMENTED!");
			frame.repaint();						 
		    }
		    else{
			throw new Exception();
		    }
		    
		}
		catch(Exception tok){
		    m1 = new String("Command Recieved:  "+clientSentence+"           MALFORMED INPUT!");
		    frame.repaint();								
		}	 
	    }		
	}
	catch (Exception e){
	    System.out.println("CONNECT ERROR: Connection Lost or Closed");
	    System.exit(1);		
	}
	
	/*
	  img.turnoff("room2", "toilet");
	  img.turnon("room3", "toilet");	
	  m1 = new String("TURNOFF");		
	  frame.repaint();
	*/
    }
    
    
    class Comm extends JComponent {
	// This method is called whenever the contents needs to be painted
	public void paint(Graphics g) {
	    // Retrieve the graphics context; this object is used to paint shapes
	    Graphics2D g2d = (Graphics2D)g;
	    g2d.setColor(new Color(0,0,0));
	    g2d.setFont(new Font("Courier", Font.PLAIN, 13));
	    
	    g2d.drawString(m1,12,12);
	    
	}
    }   

    public static ServerSocket getRandomServerSocket() {
	Random rand= new Random();
	int port= 0;
	ServerSocket ss= null;
	
	while (port < 100) {
	    try {
		port= rand.nextInt(6000);
		ss= new ServerSocket(port);
	    }
	    catch (Exception e) {
		port= 0;
	    }
        }

	return ss;
    }
}



