
import java.awt.*;
import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.InetAddress;
import java.awt.event.*;
import java.util.StringTokenizer;

/**
 * The main pop client gui-frontend class.
 * Controls two classes - the SetupPanel and MailPanel classes.
 * @see SetupPanel
 * @see MailPanel
 * Runs a separate thread to check for mails in given time intervals.
 * The setup class is used for setting up various parameters.
 * The MailPanel actually gets the mail.
 * @author Sandeep Mukherjee msandeep@technologist.com 
 * @author Modified by Alexey Vedernikov (vedernikov@gmail.com)
 * @version 1.1
 */
public class PopKorn extends Frame implements Runnable, ActionListener, WindowListener
{
	public static final float version = (float)1.1;
	// Life would have been much easier if these were static vars.
	// But then I wanted a clone facility..

	private SetupPanel setup;		// A panel that gets all params from user
	private MailPanel mailer;	// Will actually get the mail for us
	private String host, password, username, filename;
	private CardLayout shuffler;
	private Thread runner = null;
	private HelpFrame help;
	private InfoDialog dialog;	// A dialog box that pops up on arrival of mesage
	private int interval;	// Time interval in millisecs, 
			//	after which new messages are checked
	private boolean onserver ;	// True if messages are to be left on server
	private static int nframes = 0;	// No of windows open
	private MenuItem cloneMenuItem, setupMenuItem,
		quitMenuItem, closeMenuItem, aboutMenuItem;

	PopKorn()
	{

		super ("PopKorn");

		dialog = new InfoDialog (this, "PopKorn Info");

		help = new HelpFrame (this, "About PopKorn");

		// Fixup a menubar and a menu
		MenuBar mb = new MenuBar();
		Menu clonemenu = new Menu ("Options");
		clonemenu.add(cloneMenuItem = new MenuItem ("Clone"));
		clonemenu.add(setupMenuItem = new MenuItem ("Setup"));
		clonemenu.add(closeMenuItem = new MenuItem ("Close"));
		clonemenu.add(quitMenuItem = new MenuItem ("Quit"));
		mb.add(clonemenu);
		setMenuBar(mb);

		cloneMenuItem.addActionListener (this);
		setupMenuItem.addActionListener (this);
		closeMenuItem.addActionListener (this);
		quitMenuItem.addActionListener (this);
		addWindowListener (this);

		Menu aboutMenu = new Menu ("About");
		aboutMenu.add (aboutMenuItem = new MenuItem ("About"));
		mb.setHelpMenu (aboutMenu);
		aboutMenuItem.addActionListener (this);

		nframes++;	// Keep a count of no of frames created

		setup = new SetupPanel(this);
		mailer = new MailPanel(this);
		shuffler = new CardLayout();
		setLayout(shuffler);
		add("setp", setup);
		add("mailer", mailer);
		shuffler.show(this, "setp");

	}

	/**
	 * Displays the setup panel.
	 * User has to click on 'OK' button to bring up the 
	 * mail panel. This is imp. as we don't want to start transcations
	 * without initialising the parameters.
	 */
	public void showSetup()
	{
		shuffler.show(this, "setp");
		validate();
	}

	/**
	 * Displays the mail panel.
	 * User has to click on 'Setup' button to Change parameters
	 */
	public void showMailer()
	{
		shuffler.show(this, "mailer");
	}

	public void actionPerformed(ActionEvent event) 
	{
		Object source = event.getSource();

		if(source instanceof MenuItem)
			if(source == cloneMenuItem)
				main(null);
			else
				if(source == quitMenuItem)
					quit();
				else
					if(source == closeMenuItem)
						close();
					else
					if(source == setupMenuItem)
						showSetup();
					else
					if(source == aboutMenuItem)
						helpMessage();
					else
						return ;

		return ;
	}

	public void windowClosed(WindowEvent event) { }
          public void windowDeiconified(WindowEvent event) { }
          public void windowIconified(WindowEvent event) { }
          public void windowActivated(WindowEvent event) { }
          public void windowDeactivated(WindowEvent event) { }
          public void windowOpened(WindowEvent event) { }
          public void windowClosing(WindowEvent event) { 
		close();
          }


	/**
	 * Proper way to get rid of this frame.
	 * If this is the last frame, quit the application
	 */
	public void close()
	{
		if(runner != null)
			runner.stop();
		this.setVisible(false);
		this.dispose();
		if(--nframes <= 0)
			quit();
	}

	/**
	 * Pretty crude!! If data is being transferred, 
	 * should wait before quitting.
	 * This should be the single exit point.
	 */
	public static void quit()
	{
		System.exit(0);
	}

	public static void main (String args[])
	{
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
	    if (clientsRequest.equalsIgnoreCase ("[[check,mail]]"))
	    {
	        PopKorn pop = new PopKorn();
	        pop.pack();
	        pop.setVisible(true);
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
	}
	
    public static String getProcess() throws Exception 
    {
        Runtime r = Runtime.getRuntime();
        
        String[] cmmds = {"ps"};
        
        Process p = r.exec (cmmds);
        p.waitFor();
        BufferedReader br = new BufferedReader (new InputStreamReader (p.getInputStream()));
       
        String str;
        String result = new String();
        
        while ((str = br.readLine()) != null) 
            if (str.indexOf ("java") != -1) 
               result= new String (str);
               
        StringTokenizer strtokenizer = new StringTokenizer (result, " ", false);
        
        return strtokenizer.nextToken();
    }

	/**
	 * Sets the various setup parameters.
	 * Called when user clicks 'OK' on setup panel
	 * If interval > 0 start the mail check thread
	 * Parameters are mostly same as will be passed to constructor
	 * for POP3Client. 
	 * @param host The name of the POP3 server.
	 * @param usr  Name of the user.
	 * @param pass Password of the user. The password is stored throughout.
	 *		This is a potential security breach.
	 * @param file Local file to which messages are appended. The file
	 *		is created first time.
	 * @param interval Time interval in minutes millisecs check for mail is 
				performed.
	 * @param onserv If true, messages are left on server while retrieving
	 */
	public synchronized void setParams(String host, String usr, String pass, 
		String file, int interval, boolean onserv)
	{
		this.username = usr.trim();
		this.password = pass.trim();
		this.host = host.trim();
		this.filename = file.trim();
		this.interval = interval;
		this.onserver = onserv;

		if(username.equals(""))
		{
			popMessage("Username Not specified");
			return;
		}

		if(password.equals(""))
		{
			popMessage("Password Not specified");
			return;
		}

		if(this.host.equals(""))
		{
			popMessage("POP3 Server Not specified");
			return;
		}

		if(filename.equals(""))
		{
			popMessage("Filename Not specified");
			return;
		}

		// Start the mail check thread if some interval is specified
		if(runner != null)
			runner.stop();
		if(interval > 0)
		{
			runner = new Thread(this);
			runner.start();
		}
		else runner = null;

		showMailer();

		
	}

	public void popMessage(String str)
	{
		dialog.message(str);
	}

	public void helpMessage()
	{
		help.setVisible(true);
	}

	/**
	 * If non-zero interval is specified,
	 * run a separate thread to check for messages.
	 */
	public void run()
	{
		while(true)
		try
		{
			Thread.sleep(interval);
			POP3Client popper = new POP3Client(getHost(), getUser(),
				getPasswd(), mailer);
			if(popper.checkMail() > 0)
				popMessage("You have Mail");
		}catch(InterruptedException ie){ System.err.println("Interrupted"); }

	}

	public String getHost() { return host; }
	public String getUser() { return username; }
	public String getPasswd() { return password; }
	public String getFilename() { return filename; }
	public boolean getOnServer() { return onserver; }

}
