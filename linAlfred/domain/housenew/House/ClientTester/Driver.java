/*
 * Created on Jul 14, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package ClientTester;

import java.net.*;
/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Driver {

	public static void main(String[] args) {
		try {
			Tester test = new Tester(InetAddress.getLocalHost(), 0);
		} catch (Exception e) {
			
		}
	}
}
