import java.awt.*;
import javax.swing.*;
import java.io.*;
import java.lang.*;
import java.util.*;
import java.util.StringTokenizer;

public class BasicDraw {
    
    String coordinatesfile;
    String statefile;

    MyComponent kk = new MyComponent();	 
    // Create a frame
    JFrame frame = new JFrame("Model House Lighting System");		
    HashMap hashCord = new HashMap();
    HashMap hashState = new HashMap();				
    
    BasicDraw(){
	
	// Add a component with a custom paint method
	frame.getContentPane().add(kk);
	
	// Display the frame
	int frameWidth = 922;
	int frameHeight = 691;
	
	frame.setSize(frameWidth, frameHeight);
	frame.setVisible(true);
	
    }
    
    public void setCoordFile(String f){
	coordinatesfile = f;
    }

    public void setStateFile(String f){
	statefile = f;
    }
    
    public void turnon(String room, String light) throws Exception{
	
	String coord = new String();		
	
	if( (room.equals("master")) || (room.equals("room1")) ){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(1)));	
		hashState.put(new Integer(1), new Integer(1));								 											 
	    }
	    else if(light.equals("w")){
		coord = (String)hashCord.get((new Integer(2)));	
		hashState.put(new Integer(2), new Integer(1));										 									
	    }
	    else if(light.equals("desk") || light.equals("se")){
		coord = (String)hashCord.get((new Integer(3)));
		hashState.put(new Integer(3), new Integer(1));											
	    }
	    else if(light.equals("toilet") || light.equals("sw")){
		coord = (String)hashCord.get((new Integer(4)));
		hashState.put(new Integer(4), new Integer(1));											
	    }			
	    else throw new Exception();																						
	}
	else if(room.equals("room2")){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(5)));
		hashState.put(new Integer(5), new Integer(1));																						 
	    }
	    else if(light.equals("desk") || light.equals("se")){
		coord = (String)hashCord.get((new Integer(6)));
		hashState.put(new Integer(6), new Integer(1));											
	    }
	    else if(light.equals("toilet") || light.equals("sw")){
		coord = (String)hashCord.get((new Integer(8)));
		hashState.put(new Integer(8), new Integer(1));											
	    }			
	    else throw new Exception();						
	}												
	else if(room.equals("room3")){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(7)));
		hashState.put(new Integer(7), new Integer(1));																						 
	    }
	    else if(light.equals("desk") || light.equals("se")){
		coord = (String)hashCord.get((new Integer(9)));
		hashState.put(new Integer(9), new Integer(1));											
	    }
	    else if(light.equals("toilet") || light.equals("w")){
		coord = (String)hashCord.get((new Integer(8)));
		hashState.put(new Integer(8), new Integer(1));											
	    }
	    else throw new Exception();	
	}
	else if(room.equals("corridor")){
	    coord = (String)hashCord.get((new Integer(10)));
	    hashState.put(new Integer(10), new Integer(1));							
	}	
	else if(room.equals("pantry")){
	    coord = (String)hashCord.get((new Integer(11)));
	    hashState.put(new Integer(11), new Integer(1));						
	}
	else if(room.equals("kitchen")){
	    if(light.equals("w")){
		coord = (String)hashCord.get((new Integer(12)));
		hashState.put(new Integer(12), new Integer(1));									
	    }
	    else if(light.equals("e")){
		coord = (String)hashCord.get((new Integer(13)));
		hashState.put(new Integer(13), new Integer(1));									
	    }
	    else throw new Exception();															
	}																		
	
	else if(room.equals("living")){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(14)));
		hashState.put(new Integer(14), new Integer(1));																				 
	    }
	    else if(light.equals("ne")){
		coord = (String)hashCord.get((new Integer(15)));
		hashState.put(new Integer(15), new Integer(1));									
	    }
	    else if(light.equals("sw")){
		coord = (String)hashCord.get((new Integer(16)));
		hashState.put(new Integer(16), new Integer(1));									
	    }
	    else if(light.equals("se")){
		coord = (String)hashCord.get((new Integer(17)));
		hashState.put(new Integer(17), new Integer(1));									
	    }
	    else throw new Exception();								
	}
	else throw new Exception();	
	
	Graphics2D g2 = (Graphics2D)(kk.getGraphics());
	
	g2.setColor(new Color(255,255,0));							
	
	StringTokenizer st = new StringTokenizer(coord);													 
	while(st.hasMoreTokens()) {
	    g2.fillOval( Integer.parseInt(st.nextToken()),
			 Integer.parseInt(st.nextToken()),
			 Integer.parseInt(st.nextToken()),
			 Integer.parseInt(st.nextToken()) );
	}
	
	try{ 
	    FileWriter output = new FileWriter(statefile); 
	    for(int i=1; i<=hashState.size(); i++){
		output.write( ((hashState.get(new Integer(i))).toString())+" ");
	    } 
	    output.flush();
	    output.close(); 
	} 
	catch(java.io.IOException e){ 
	    System.out.println("Exception: " + e); 
	    System.exit(1); 
	}				
	
	frame.setVisible(true);
    }
    
    
    
    
    public void turnoff(String room, String light) throws Exception{
	
	String coord = new String();		
	
	if( (room.equals("master")) || (room.equals("room1")) ){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(1)));	
		hashState.put(new Integer(1), new Integer(0));								 											 
	    }
	    else if(light.equals("w")){
		coord = (String)hashCord.get((new Integer(2)));	
		hashState.put(new Integer(2), new Integer(0));										 									
	    }
	    else if(light.equals("desk") || light.equals("se")){
		coord = (String)hashCord.get((new Integer(3)));
		hashState.put(new Integer(3), new Integer(0));											
	    }
	    else if(light.equals("toilet") || light.equals("sw")){
		coord = (String)hashCord.get((new Integer(4)));
		hashState.put(new Integer(4), new Integer(0));			
	    }
	    else throw new Exception();																								
	}
	else if(room.equals("room2")){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(5)));
		hashState.put(new Integer(5), new Integer(0));																						 
	    }
	    else if(light.equals("desk") || light.equals("se")){
		coord = (String)hashCord.get((new Integer(6)));
		hashState.put(new Integer(6), new Integer(0));											
	    }
	    else if(light.equals("toilet") || light.equals("sw")){
		coord = (String)hashCord.get((new Integer(8)));
		hashState.put(new Integer(8), new Integer(0));											
	    }
	    else throw new Exception();									
	}												
	else if(room.equals("room3")){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(7)));
		hashState.put(new Integer(7), new Integer(0));																						 
	    }
	    else if(light.equals("desk") || light.equals("se")){
		coord = (String)hashCord.get((new Integer(9)));
		hashState.put(new Integer(9), new Integer(0));											
	    }
	    else if(light.equals("toilet") || light.equals("w")){
		coord = (String)hashCord.get((new Integer(8)));
		hashState.put(new Integer(8), new Integer(0));											
	    }
	    else throw new Exception();	
	}
	else if(room.equals("corridor")){
	    coord = (String)hashCord.get((new Integer(10)));
	    hashState.put(new Integer(10), new Integer(0));							
	}	
	else if(room.equals("pantry")){
	    coord = (String)hashCord.get((new Integer(11)));
	    hashState.put(new Integer(11), new Integer(0));						
	}
	else if(room.equals("kitchen")){
	    if(light.equals("w")){
		coord = (String)hashCord.get((new Integer(12)));
		hashState.put(new Integer(12), new Integer(0));									
	    }
	    else if(light.equals("e")){
		coord = (String)hashCord.get((new Integer(13)));
		hashState.put(new Integer(13), new Integer(0));									
	    }
	    else throw new Exception();															
	}																		
	
	else if(room.equals("living")){
	    if(light.equals("nw")){
		coord = (String)hashCord.get((new Integer(14)));
		hashState.put(new Integer(14), new Integer(0));																				 
	    }
	    else if(light.equals("ne")){
		coord = (String)hashCord.get((new Integer(15)));
		hashState.put(new Integer(15), new Integer(0));									
	    }
	    else if(light.equals("sw")){
		coord = (String)hashCord.get((new Integer(16)));
		hashState.put(new Integer(16), new Integer(0));									
	    }
	    else if(light.equals("se")){
		coord = (String)hashCord.get((new Integer(17)));
		hashState.put(new Integer(17), new Integer(0));									
	    }
	    else throw new Exception();								
	}
	else throw new Exception();	
	
	
	Graphics2D g2 = (Graphics2D)(kk.getGraphics());
	
	g2.setColor(new Color(0,0,0));							
	StringTokenizer st = new StringTokenizer(coord);													 
	while(st.hasMoreTokens()) {
	    g2.fillOval( Integer.parseInt(st.nextToken()),
			 Integer.parseInt(st.nextToken()),
			 Integer.parseInt(st.nextToken()),
			 Integer.parseInt(st.nextToken()) );
	}
	
	try{ 
	    FileWriter output = new FileWriter(statefile); 
	    for(int i=1; i<=hashState.size(); i++){									
		output.write( ((hashState.get(new Integer(i))).toString())+" ");
		System.out.println(((hashState.get(new Integer(i))).toString()));
	    } 
	    output.flush();
	    output.close(); 
	} 
	catch(java.io.IOException e){ 
	    System.out.println("Exception: " + e); 
	    System.exit(1); 
	}				
	
	frame.setVisible(true);
    }
    
    
    
    
    
    
    class MyComponent extends JComponent {
	
	// This method is called whenever the contents needs to be painted
	public void paint(Graphics g) {
	    // Retrieve the graphics context; this object is used to paint shapes
	    Graphics2D g2d = (Graphics2D)g;
	    
	    
	    //ROOMS ****************
	    g2d.setColor(new Color(0,0,0));
	    g2d.setFont(new Font("Verdana", Font.BOLD, 12));
	    
	    Rectangle rr = new Rectangle(2,2,910,660);
	    g2d.draw(rr);
	    
	    Rectangle r1 = new Rectangle(22,22,290,250);
	    g2d.draw(r1);
	    g2d.drawString("Room1/Master", 22,20);
								
	    Rectangle r11 = new Rectangle(22,192,120,80);
	    g2d.draw(r11);
	    g2d.drawString("Master Toilet", 24,190);
	    
	    Rectangle r2 = new Rectangle(22,295,290,170);
	    g2d.draw(r2);
	    g2d.drawString("Room2", 22,292);
	    
	    Rectangle r23 = new Rectangle(22,472,53,170);
	    g2d.draw(r23);
	    g2d.drawString("R2/R3 Toilet", 22,654);
	    
	    Rectangle r3 = new Rectangle(82,472,230,170);
	    g2d.draw(r3);
	    g2d.drawString("Room3", 264,654);
	    
	    Rectangle k = new Rectangle(618,22,290,250);
	    g2d.draw(k);
	    g2d.drawString("Kitchen", 618,20);
	    
	    Rectangle p = new Rectangle(411,22,200,250);
	    g2d.draw(p);
	    g2d.drawString("Pantry", 411,20);
	    
	    g2d.drawString("Living Room", 620,465);
	    
	    
	    //DESKS **************
	    g2d.setColor(new Color(122,0,0));
	    
	    Rectangle desk1 = new Rectangle(242,232,64,38);
	    g2d.draw(desk1);
	    g2d.drawString("Desk1", 242,230);
	    Rectangle desk2 = new Rectangle(242,424,64,38);
	    g2d.draw(desk2);
	    g2d.drawString("Desk2", 242,422);								
	    Rectangle desk3 = new Rectangle(242,602,64,38);
	    g2d.draw(desk3);
	    g2d.drawString("Desk3", 242,600);
	    g2d.drawRect(244,234,60,34);
	    g2d.drawRect(244,426,60,34);
	    g2d.drawRect(244,604,60,34);
	    
	    
	    //DOORS **************
	    g2d.setColor(new Color(53,53,202));
	    
	    //pantry
	    Rectangle dp1 = new Rectangle(409,32,4,50);
	    g2d.draw(dp1);
	    g2d.fill(dp1);
	    
	    Rectangle dp2 = new Rectangle(421,270,50,4);
	    g2d.draw(dp2);
	    g2d.fill(dp2);
	    
	    //kitchen
	    Rectangle dk = new Rectangle(609,32,12,50);
	    g2d.draw(dk);
	    g2d.fill(dk);
	    
	    //room1
	    Rectangle d1 = new Rectangle(310,32,4,50);
	    g2d.draw(d1);
	    g2d.fill(d1);
	    
	    Rectangle d11 = new Rectangle(140,202,4,50);
	    g2d.draw(d11);
	    g2d.fill(d11);
	    
	    //room2
	    Rectangle d2 = new Rectangle(310,305,4,50);
	    g2d.draw(d2);
	    g2d.fill(d2);
	    
	    Rectangle d231 = new Rectangle(73,482,11,50);
	    g2d.draw(d231);
	    g2d.fill(d231);								
	    
	    Rectangle d232 = new Rectangle(29,463,40,11);
	    g2d.draw(d232);
	    g2d.fill(d232);															
	    
	    //room3
	    Rectangle d3 = new Rectangle(310,482,4,50);
	    g2d.draw(d3);
	    g2d.fill(d3);
	    
	    //Main
	    Rectangle m = new Rectangle(910,420,4,90);
	    g2d.draw(m);
	    g2d.fill(m);
	    
	    
	    
	    //Reading the state file to get original state
	    try{
		String line = new String(); 
		int a,b,c,d;          
		FileReader fis=new FileReader(statefile); 
		FileReader cor=new FileReader(coordinatesfile);
		BufferedReader dis = new BufferedReader(fis);
		BufferedReader dor = new BufferedReader(cor);
		int i=1;
		
		while((line=dis.readLine())!=null){
		    StringTokenizer st = new StringTokenizer(line);															 
		    while (st.hasMoreTokens()) {
			String lined = dor.readLine();
			StringTokenizer dt = new StringTokenizer(lined);
			Integer state = new Integer(Integer.parseInt(st.nextToken()));
			//System.out.println(state+"  "+lined);
			hashCord.put(new Integer(i), lined);
			hashState.put(new Integer(i), state);
			if(state.intValue() == 1){
			    g2d.setColor(new Color(255,255,0));
			    a = Integer.parseInt(dt.nextToken());
			    b = Integer.parseInt(dt.nextToken());
			    c = Integer.parseInt(dt.nextToken());
			    d = Integer.parseInt(dt.nextToken());
			    g2d.fillOval(a,b,c,d);																																																	
			}
			else{
			    g2d.setColor(new Color(0,0,0));
			    a = Integer.parseInt(dt.nextToken());
			    b = Integer.parseInt(dt.nextToken());
			    c = Integer.parseInt(dt.nextToken());
			    d = Integer.parseInt(dt.nextToken());
			    g2d.fillOval(a,b,c,d);																	
			}
			//System.out.println("State Read"+hashState.size()+" "+hashCord.size());
			i++;
		    } 
		} 
		dis.close(); 
		fis.close(); 
	    } 
	    catch (IOException ioe) { 
		System.out.println("FILE READING ERROR");
	    } 
	    System.out.println("bbbbb");
	    
	}
    }
}


