import java.awt.*;
import javax.swing.*;
import java.io.*;
import java.lang.*;
import java.util.*;
import java.util.StringTokenizer;
import java.net.*;


class sys{	  
    
    BasicDraw img = new BasicDraw();
    String m1 = new String("Stored Environment LOADED, Listening for commands ....");				
    
    public static void main(String args[])throws Exception{
	if (args.length < 3) {
	    System.out.println("Usage: java sys $HOSTFILE");
	    System.exit(-1);
	} 
	
	new sys(args[0], args[1], args[2]);
    }
    
    sys(String dom, String cf, String sf){
	
	img.setCoordFile(cf);
	img.setStateFile(sf);

	JFrame frame = new JFrame("Command Listener");	
	Comm kk = new Comm();
	frame.getContentPane().add(kk);
	frame.setSize(882,43);
	frame.setLocation(20,694);
	frame.setVisible(true);	
	frame.repaint();
	
	try{
	    String clientSentence;
            ServerSocket welcomeSocket = null;
	    for(int c=1025; c<49151; c++){
		try{    
		    welcomeSocket = new ServerSocket(c);	    

		    File f= new File(dom);
		    f.delete();
		    FileWriter w = new FileWriter(f); 
		    w.write( "port" +" " + c);
		    System.out.println("port" + " " + c);
		    
		    String ht = InetAddress.getLocalHost().getCanonicalHostName();
		    
		    w.write( "\nhost" + " " + ht);
		    System.out.println("host" + " " + ht);

		    String pid = getProcess();

		    w.write( "\nprocess " + pid);
		    System.out.println("process " + pid); 

		    w.close();
                    break; 
		}
		
		catch(Exception e){ 
		}  
	    }
	    
	    
	    
	    Socket connectionSocket = welcomeSocket.accept();
	    
	    BufferedInputStream bis= new BufferedInputStream(connectionSocket.getInputStream());
	    byte[] bt= new byte[1000];
	    while(true){
		bis.read(bt);
		clientSentence= new String(bt);
		System.out.println(clientSentence);
	    	
		if(clientSentence.equals("quit")){
			System.exit(1);
		}

		m1 = new String("Command Recieved:  "+clientSentence);
		frame.repaint();	 
		
		String t1 = null;
		String t2 = null;
		String t3 = null;
		String t4 = null;

		try{
		    StringTokenizer st = new StringTokenizer(clientSentence, "[], ", false);													 
		    t1=st.nextToken();
		    if(t1.equals("quit")){
			System.exit(1);
		    }
		    t2=st.nextToken();
		    t3=st.nextToken();
		    if(st.hasMoreTokens())
		       t4=st.nextToken();

		    if(t1.equals("light")){
			if(t2.equals("on")){	
			    img.turnon(t3, t4);
			    m1 = new String("Command Recieved:  "+clientSentence+"           "+t3+" "+t4+" TURNED ON");
			    frame.repaint();																			
			}
			else if(t2.equals("off")){
			    img.turnoff(t3,t4);
			    m1 = new String("Command Recieved:  "+clientSentence+"           "+t3+" "+t4+" TURNED OFF");
			    frame.repaint();		
			}									  
			else{
			    throw new Exception();
			} 
		    }
		    else if(t1.equals("door")){
			m1 = new String("Command Recieved:  "+clientSentence+"           DOOR COMMANDS NOT IMPLEMENTED!");
			frame.repaint();						 
		    }
		    else{
			throw new Exception();
		    }
		    
		}
		catch(Exception tok){
		    m1 = new String("Command Recieved:  "+clientSentence+"           MALFORMED INPUT!");
		    frame.repaint();								
		    System.exit(1);
		}
	    }		
	}
	catch (Exception e){
	    System.out.println("CONNECT ERROR: Connection Lost or Closed");
	    System.exit(1);		
	}
	
    }

    // getProcess
    // written by Paolo del Mundo	
    public String getProcess() throws Exception {
        Runtime r= Runtime.getRuntime();
	
        String[] cmmds= {"ps"};
	
        Process p= r.exec(cmmds);
        p.waitFor();
        BufferedReader br= new BufferedReader(new InputStreamReader(p.getInputStream()));
	
        String str;
        String result= new String();
        
        while ((str = br.readLine()) != null) {
            if (str.indexOf("java") != -1) {
		result= new String(str);
            }
        }
	
        StringTokenizer strtok= new StringTokenizer(result, " ", false);
	
        return strtok.nextToken();
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
}


    
    
    
    
    
