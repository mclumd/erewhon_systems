/*
 * Settings.java
 *
 * Created on August 4, 2003, 6:45 PM
 */

/**
 *
 * @author  paolodm
 */
import java.io.*;
import java.util.*;
import java.net.*;

public class Settings {
    public int port= 0;    
    public ServerSocket ss= null;
    public String domainhostPath= null;
    public FileWriter fw= null;
    
    /** Creates a new instance of Settings */
    public Settings(String domainhostPath) {
	domainhostPath= new String(domainhostPath);

        Random rand = new Random();
        
        while (port < 100) {
           try {
              port= rand.nextInt(6000);
              ss= new ServerSocket(port);
           }
           catch (Exception e) {
              port= 0;
           }
        }
        
        if (!domainhostPath.equals(""))
           this.domainhostPath= domainhostPath;
    } 
    
    public void writeFile() {
        try {
	    File f= new File(domainhostPath);
	    f.delete();
	    fw= new FileWriter(f);

	    String hs= InetAddress.getLocalHost().getCanonicalHostName();
	    
	    fw.write("port " + port + "\n");
	    fw.write("host " + hs + "\n");
	    fw.write("process " + getProcess() + "\n");
	    fw.flush();
        } catch (Exception e) {
	    System.out.println("Sorry... cannot print out write to file " + domainhostPath);
	    e.printStackTrace();
        }
    }
    
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
    
    public static void main(String[] args) {
        Settings s= new Settings(".");
        
        s.writeFile();
    }
    
    public ServerSocket getServerSocket() {
        return ss;
    }
}

