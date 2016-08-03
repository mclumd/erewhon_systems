import java.io.*;
import java.awt.*;
import java.util.regex.*;
import java.util.ArrayList;
import javax.swing.*;
import java.net.*;
import java.util.*;
import java.util.regex.Matcher;
import java.lang.*;

class Restaurants
{
  // socket related 
    public static ServerSocket ss= null;
    public static Socket alfred= null;
    public static BufferedInputStream bis= null;
    public static Settings setting = null;


    private static String [] menus;
    private static String [] restaurantNames;
    private static String [] restaurantTypes;

    private static String [] order;
    private static Double [] price;
    private static Double [] quantity;

    private static int numItems;
    private static Double total;


    public static int cmdNum = 1;

    public static void main(String[] args)
    {
	/*	numItems = 0;
	total = 0.0;
	order = new String[1000];
	price = new Double[1000];
	quantity = new Double[1000];
        readMenuFile();

        System.out.println("Entering the shit");
	// System.out.println("rest length " + restaurantNames.length);
	// System.out.println("res types length " + restaurantTypes.length);
       	
        setting= new Settings(args[0]); // have to check 
	
        setting.writeFile();
	
        ss= setting.getServerSocket();
	try 
	    {
		
		while(true) 
		    {
			System.out.println("Waiting for connection with Alfred...");
			alfred= ss.accept();
			System.out.println("Connection with Alfred established!");
			
			bis= new BufferedInputStream(alfred.getInputStream());
                        numItems = 0;

			
			while (alfred.isConnected()) 
			{
			  try 
			  {
			    byte[] bt= new byte[1000];
			    bis.read(bt);
			    System.out.println("Command" + cmdNum++ + " from Alfred");
			    System.out.println("request" + ": " + new String(bt));
			    int temp = System.in.read();
			    String comm = new String(bt);
                            if (comm.equals("quit")) {
				comm = "[[" + comm + "]]";
			    }
			    processCommand(comm);
			  }
			  catch (Exception ex)
			      {
				  System.out.println("Sorry unable to get your command...");
				  System.exit(-1);
			      }
			} // end of while
		    }
	    }
	catch (Exception ee) { try {
	    int lun= System.in.read(); }
	catch(IOException ie) {}
      }
	*/
       	try 
	    {
		numItems = 0;
		total = 0.0;
		order = new String[1000];
		price = new Double[1000];
		quantity = new Double[1000];
                System.out.println("args " + args[0]);
		readMenuFile(args[0]);
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

		boolean cond = true;
		do {
		String takeCommand = in.readLine();
		processCommand(takeCommand);
		}while(cond);
		}
	
		catch (Exception ee) {}  
    }
    
    
    public static void readMenuFile(String f)
    {
	try {
	  
	    BufferedReader read1 = new BufferedReader(new FileReader(f));
	  
	    int count = 0;
	       
	    String allMenus = "";
	    String line1 = "";
	    while((line1 = read1.readLine()) != null)
		{
		    allMenus += line1;
		    count++;
		}
	    
	    restaurantNames = new String[count];
	    restaurantTypes = new String[count];
	    menus = allMenus.split("\\s*;\\s*");
	    
	    //for(int i = 0; i < menus.length; i++)
	   
	    
	    BufferedReader read2 = new BufferedReader(new FileReader(f));
	    String line2 = "";
	    int index = 0;
	    while((line2 = read2.readLine()) != null)
		{
		    String [] content  = line2.split("\\s*,\\s*");
		    content[0] = content[0].trim();
		    content[1] = content[1].trim();
		    restaurantNames[index] = content[0];
		    restaurantTypes[index] = content[1];
		    index++;
		}
	}
	
	catch(IOException ioe) { 
	}
	catch(Exception e) { 
	}
    }
    
    public static String getCommand (String request)
    {
	// FILL IT .. EXTRACTS THE COMMAND
	return "display";
    }
    
    public static void processCommand(String command) throws Exception
    {
	try {
	  
	    Pattern pattern = Pattern.compile("\\[\\[(.*)\\]\\]");
	    Matcher M = pattern.matcher(command);
	    boolean matchFound = M.find();
	    
	    String commandStr = M.group(1);
	    
	    String [] tokens = commandStr.split("\\s*,\\s*");
	    
	    for(int i = 0; i < tokens.length; i++)
		{
		    tokens[i] = tokens[i].toLowerCase();
		    tokens[i] = tokens[i].trim();
		}
	   
	    if(tokens[0].equalsIgnoreCase("quit"))
		System.exit(1);

	    if(tokens.length == 1 && tokens[0].equalsIgnoreCase("cancel_order"))
		{
		    numItems = 0;
		    total = 0.0;
		}

	    if(tokens.length == 3)
		{
		    //  System.out.println("&*&*&*&*&"+tokens[0]+"&*&*&*&*"+tokens[1]+"^&^&^&^&^&"+tokens[2]);

		    if(tokens[0].equalsIgnoreCase("display") && tokens[1].equalsIgnoreCase("cuisines") && tokens[2].equalsIgnoreCase("all"))
			{
			    JFrame.setDefaultLookAndFeelDecorated(true);
			    JDialog.setDefaultLookAndFeelDecorated(true);
			    
			    try
				{
				    UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
				}
			    catch (Exception ex)
				{
				    System.out.println("Failed loading L&F: ");
				    System.out.println(ex);
				}
			    Food F = new Food();
			    // F.dispose();
			}
		
		    else if(tokens[0].equalsIgnoreCase("display") && tokens[1].equalsIgnoreCase("restaurants") && tokens[2].equalsIgnoreCase("all"))
			{
			    System.out.println("Before calling display");
			    DisplayAllRestaurants dispAllRest = new DisplayAllRestaurants(restaurantNames, restaurantTypes);
			}
		
		    else if(tokens[0].equalsIgnoreCase("display") && tokens[1].equalsIgnoreCase("restaurants"))
			{
			    //System.out.println("Show food type window");
			    // for(int i = 0; i < restaurantNames.length; i++)
			    //	System.out.println(restaurantNames[i] + "," +restaurantTypes[i]);

			    boolean [] present = new boolean[menus.length];

			    for(int i = 0; i < present.length; i++)
				present[i] = false;

			    // searching list of menus for type of cuisine or food
			    for(int i = 0; i < menus.length; i++)
				{
				    String [] sub = menus[i].split("\\s*,\\s*");

				    for(int j = 0; j < sub.length; j++)
					{
					    sub[j] = sub[j].trim();
					    
					    String toMatch = "\\s*"+tokens[2]+"\\s*";
					    Pattern p = Pattern.compile(toMatch);
					    Matcher match = p.matcher(sub[j]);

					    if(match.find())
						{
						    present[i] = true;
						    //System.out.println("Found in "+restaurantNames[i]);
						}
					}
				}

			    JFrame.setDefaultLookAndFeelDecorated(true);
			    JDialog.setDefaultLookAndFeelDecorated(true);
			    
			    try
				{
				    UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
				}
			    catch (Exception ex)
				{
				    System.out.println("Failed loading L&F: ");
				    System.out.println(ex);
				}

			    try {
				new DisplaySelectRestaurants(restaurantNames, restaurantTypes, present, tokens[2]);
			    }
			    catch (Exception e) { System.out.println(e); }
			}

		    else if(tokens[0].equalsIgnoreCase("display") && tokens[1].equalsIgnoreCase("menu"))
			{
			    tokens[2] = tokens[2].toLowerCase();
			    displayMenu(tokens[2]);
			}

		    else if(tokens[0].equalsIgnoreCase("display") && tokens[1].equalsIgnoreCase("order") && tokens[2].equalsIgnoreCase("total"))
			{
			    //System.out.println("numItems ="+numItems+" Total is "+total);
			    
			    JFrame.setDefaultLookAndFeelDecorated(true);
			    JDialog.setDefaultLookAndFeelDecorated(true);
			    
			    try
				{
				    UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
				}
			    catch (Exception ex)
				{
				    System.out.println("Failed loading L&F: ");
				    System.out.println(ex);
				}
			     Bill B= new Bill(order, quantity, price, numItems);
			}

		    else if(tokens[0].equalsIgnoreCase("choose"))
			{
			    // System.out.println("command = "+command);
			    orderFood(tokens[1], Double.parseDouble(tokens[2]));
			}
		}
	} 
    	catch(PatternSyntaxException pse) { System.out.println(pse); }
	//catch(IOException ioe) { System.out.println(ioe); }
	catch(Exception E) { System.out.println(E); }
	/*
	System.out.println("Press any key to exit");
	int randomKey;
	try {
	    randomKey = System.in.read(); }
	catch(IOException ie)
	    {}
	
	System.exit(1);
	*/
    }

    public static void displayList(String List)
    {
	String [] available = List.split("\\s*,\\s*");
	String [] uniqueNames = new String [available.length];
	
	for(int i = 0; i < available.length; i++)
	    uniqueNames[i] = "%";
    
	int index = 0;
	int count = 0;
	for(int i = index; i < available.length; i++)
	    {   
		boolean found = false;
		for(int j = 0; j < uniqueNames.length; j++)
		    {
			if(available[i].equalsIgnoreCase(uniqueNames[j]))
			    {
				found = true;
			    }
		    }
		if(found == false)
		    {
			uniqueNames[count] = available[index];
			count++;
		    }
		index++;
	    }
	
	String [] restaurants = new String[count];
	
	for(int i = 0; i < count; i++)
	    {
		//System.out.println("*"+uniqueNames[i]);
		restaurants[i] = uniqueNames[i];
	    }
	
	{
	    JFrame.setDefaultLookAndFeelDecorated(true);
	    JDialog.setDefaultLookAndFeelDecorated(true);
	    try
		{
		    UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
		}
	    catch (Exception ex)
		{
		    System.out.println("Failed loading L&F: ");
		    System.out.println(ex);
		}
	    try 
		{
		    new Options(restaurants);
		}
	    catch (Exception e) { System.out.println(e); }    
	}
	
	try 
	    {
		//System.out.println("Enter the exact name of the restaurant");
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		String choice = in.readLine();
		displayMenu(choice);
	    }
	catch(IOException ioe) { System.out.println(ioe); }
	catch(Exception e) { System.out.println(e); }
	
    }
    
    public static void displayMenu(String name)
    {
	boolean exists = false;
	int index = -1;
	do {
	    for(int i = 0; i < menus.length; i++)
		{
		    String [] s = menus[i].split("\\s*,\\s*");
		    if(s[0].equalsIgnoreCase(name))
			{
			    exists = true;
			    index = i;
			}
		}
	    if (!exists) {
		//System.out.println("Sorry no restaurant with that name exists");
		//System.out.println("Enter the exact name of the restaurant");
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		try {
		    name = in.readLine();
		}
		catch (IOException e)
		    {
			System.out.println("IOException ");
		    }
	    }
	} while (!exists);
	// boolean found = false;
	//  do
	// {
	if(exists == true)
	    {
		
		//System.out.println("MENU FOR " + name);
		
		String [] items = menus[index].split("\\s*,\\s*");
		//System.out.println("ITEM   ........................ PRICE");
		
		
		String [] entry = new String[items.length/2-1];
		Double [] price = new Double[items.length/2-1];
		
		//System.out.print("items.length = "+items.length);
		//System.out.print(" entry.length = "+entry.length);
		//System.out.println(" price.length = "+price.length);
		
		int count1 = 0;
		int count2 = 0;
		
		for(int i = 2; i < items.length; i++)
		    {
			//System.out.println("iteration "+i);
			if(i % 2 == 0)
			    {
				entry[count1] = items[i];
				//System.out.println("entry " + entry[count1]);
				count1++;
			    }
			else
			    {
				price[count2] = new Double(Double.parseDouble(items[i]));
				//System.out.println("price "+ price[count2]);
				count2++;
			    }
		    }
		
		JFrame.setDefaultLookAndFeelDecorated(true);
		JDialog.setDefaultLookAndFeelDecorated(true);
		
		try
		    {
			UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
		    }
		catch (Exception ex)
		    {
			System.out.println("Failed loading L&F: ");
			System.out.println(ex);
		    }
		try 
		    {
			new Display(entry,price,items[0]);
		    }
		catch (Exception e) { System.out.println(e); }
		
		//orderFood(entry,price,items[0]);
		//	found = true;
	    }
	else
	    {
		//System.out.println("Sorry no restaurant by that name");
	    }
	// } while (!found);
    }

    public static void orderFood(String name, Double numOrdered)
    {
	try
	    {
		name = name.trim();
		name = name.toLowerCase();
		//System.out.println("name of item = "+name);

		for(int i = 0; i < menus.length; i++)
		    {
			String [] foods = menus[i].split("\\s*,\\s*");
			
			for(int j = 2; j < foods.length; j++)
			    {
				if(foods[j].equalsIgnoreCase(name))
				    {
					//System.out.println("Found in "+foods[0]);
				        order[numItems] = foods[j];
					price[numItems] = Double.parseDouble(foods[j+1]);
					quantity[numItems] = numOrdered;
					total += price[numItems] * quantity[numItems];

					//System.out.println(total);
					numItems++;
				    }
			    }
		    }
	    }
	catch(Exception e) { System.out.println(e); }
    }
}

