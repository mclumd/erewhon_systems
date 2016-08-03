/*
 * Created on Jul 18, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package NewHouse;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.util.Random;
import java.util.StringTokenizer;


/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Settings {
    public int port= 0;    
    public ServerSocket ss= null;
    public String domainhostPath= null;
    public FileWriter fw= null;
    public String fileName= new String("domainhost");
	
    public static void main(String[] args) {
        Settings s= new Settings(".");
        
        s.writeFile();
    }
    
    public ServerSocket getServerSocket() {
        return ss;
    }
    
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
			File f= new File(domainhostPath + "/" + fileName);
			f.delete();
			fw= new FileWriter(f);
			
			String hs= InetAddress.getLocalHost().getCanonicalHostName();
			
			fw.write("port " + port + "\n");
			fw.write("host " + hs + "\n");
			fw.write("process " + getProcess() + "\n");
			fw.flush();
		} catch (Exception e) {
			System.out.println("Sorry... cannot print out write to file " + fileName);
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
}
