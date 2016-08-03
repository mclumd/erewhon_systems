/*
 * Created on Jul 2, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package ClientTester;


import javax.swing.*;

import java.awt.*;
import java.awt.event.*;

import java.net.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Tester extends JPanel {
	Socket cliSocket;
	BufferedWriter out;
	BufferedReader in;
	JTextField text;
	int port;
	InetAddress host;
	JLabel output;
	
	public Tester(InetAddress host, int port) {
		this.host=host;
		this.port=port;
		drawProgram();
		

	}
	
	public void drawProgram() {
		JFrame frame = new JFrame("Client Tester");
		frame.setSize(500, 500);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel mainPanel = new JPanel();
		mainPanel.setLayout(new GridLayout(2, 2));
		text = new JTextField("Client Data", 100);
		JButton send = new JButton("Send");
		output = new JLabel("Not connected yet");
		JButton connect = new JButton("Connect");
		
		java.awt.event.MouseListener sendListener = new java.awt.event.MouseListener() {
			public void mouseClicked(MouseEvent e) {
				try {
					output.setText("Sending " + text.getText());
					out.write(text.getText());
					out.newLine();
					out.flush();
				} catch (Exception ex) {
					System.out.println("IO exception");
				}
			}
			public void mousePressed(MouseEvent e) {
				
			}
			public void mouseEntered(MouseEvent e) {
				
			}
			public void mouseExited(MouseEvent e) {
				
			}
			public void mouseReleased(MouseEvent e) {
				
			}
		};
		
		java.awt.event.MouseListener connectListener = new java.awt.event.MouseListener() {
			public void mouseClicked(MouseEvent e) {
				try {
					output.setText("Attempting To Connect");
					Socket cliSocket = new Socket(host, 9880); //Socket to connect to the server with
					output.setText("Connected");
					//Create objects to handle input and output for cliSocket:
					out = new BufferedWriter(new OutputStreamWriter(cliSocket.getOutputStream()));
					in = new BufferedReader(new InputStreamReader(cliSocket.getInputStream()));
					String dataIn;
					while ((dataIn=in.readLine())!=null) {
						output.setText(dataIn);
					}
				} catch (Exception ex) {
					System.out.println("IO exception");
				}
			}
			public void mousePressed(MouseEvent e) {
				
			}
			public void mouseEntered(MouseEvent e) {
				
			}
			public void mouseExited(MouseEvent e) {
				
			}
			public void mouseReleased(MouseEvent e) {
				
			}
		};
		
		send.addMouseListener(sendListener);
		connect.addMouseListener(connectListener);
		
		mainPanel.add(connect);
		mainPanel.add(output);
		mainPanel.add(text);
		mainPanel.add(send);
		
		frame.getContentPane().add(mainPanel);
		frame.pack();
		frame.show();
	}
	public void paint() {
		updateGraphics();
	}
	public void repaint() {
		updateGraphics();
	}
	public void updateGraphics() {
		
	}

	public void close() {
		try {
			out.close();
			in.close(); 
			cliSocket.close();
		} catch (Exception e) {
			
		}
	}
}
