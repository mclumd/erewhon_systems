import java.awt.*;
import java.net.*;
import java.sql.*;
import javax.swing.*;

public class MovieDB {
	private static Component createComponents() {
		/*JButton titleBtn = new JButton("Title");
		JButton sImgBtn = new JButton("SmImage");
		JButton mImgBtn = new JButton("MedImage");
		JButton dirBtn = new JButton("Director");
		JButton castBtn = new JButton("Cast");*/
		
			Font headerFont = new Font("SansSerif", Font.BOLD, 18);	
 		JLabel titleLbl = new JLabel ("Lara Croft Tomb Raider", JLabel.CENTER);
 		titleLbl.setFont(headerFont);

 		/* Adding border and put header on the top */
 		URL imgUrl = null;
 		try {
 			imgUrl = new URL("http://images.blockbuster.com/is/amg/dvd/cov150/drt100/t145/t14555kdopd.jpg?cell=130,300&cvt=jpeg");
 		} catch (MalformedURLException e) {
 			e.getMessage();
 		}
 		
 		ImageIcon icon = new ImageIcon(imgUrl);
 		JLabel empty1 = new JLabel ("                             ");
 		JLabel empty2 = new JLabel ("                             ");
 		JLabel empty3 = new JLabel ("                             ");
 		JLabel empty4 = new JLabel ("                             ");
 		JLabel empty5 = new JLabel ("                             ");
 		JLabel empty6 = new JLabel ("                             ");
 		JLabel empty7 = new JLabel ("                             ");
 		JLabel mImgLbl = new JLabel (icon, JLabel.CENTER);
 		JLabel dirLbl = new JLabel ("Director: Jan de Bont");
 		JLabel castLbl = new JLabel ("Cast: Angeline Jolie, Gerard Butler, Ciaran Hinds");                        
 		JLabel genreLbl = new JLabel ("Genre: Action & Adventure, Sci-Fi & Fantasy");
 		JLabel runLbl = new JLabel ("Running Time: 1 hour 40 minutes");
 		JLabel langLbl = new JLabel ("Languange; English, French");
 		JLabel dateLbl = new JLabel ("Release Date: 11/13/2001");
 		JLabel rateLbl = new JLabel ("Rating; PG-13");
 		JLabel synLbl = new JLabel ("Synopsis: A popular video game comes to the screen");
 		
 		//JLabel synLbl = new JLabel ("Synopsis: A popular video game comes to the screen with this big-budget " +
 			//	"adventure starring Angelina Jolie as a buxom heroine recalling equal parts " +
 				//"Indiana Jones and James Bond.");
		
		/*titleLbl.setLabelFor(titleBtn);
		sImgLbl.setLabelFor(sImgBtn);*/
		
		JPanel pane = new JPanel(new GridLayout(5, 1));
				
		//pane.setLayout(new BorderLayout());
		//pane.add(titleLbl);
		pane.add(empty1);
		pane.add(titleLbl, BorderLayout.PAGE_START);
		pane.add(titleLbl, BorderLayout.CENTER);
		pane.add(titleLbl, BorderLayout.SOUTH);
		pane.add(empty2);
		pane.add(mImgLbl);
		pane.add(dirLbl);
		pane.add(empty3);
		pane.add(castLbl);
		pane.add(empty4);
		pane.add(genreLbl);
		pane.add(empty5);
		pane.add(runLbl);
		pane.add(empty6);
		pane.add(langLbl);
		
		pane.add(dateLbl);
		pane.add(empty7);
		pane.add(rateLbl);
		pane.add(synLbl);
		
		/*pane.add(titleLbl, BorderLayout.NORTH);
		pane.add(titleLbl, BorderLayout.CENTER);
		pane.add(titleLbl, BorderLayout.SOUTH);*/
		pane.setBorder(BorderFactory.createEmptyBorder(0, 0, 70, 0));
		
		return pane;
	}
	
	
	private static void createAndShowGUI() {
		JFrame.setDefaultLookAndFeelDecorated(true);
		
		// Create and set up the Window
		JFrame frame = new JFrame("Movie Database");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(70, 70);
		
		MovieDB mdb = new MovieDB();
		Component contents = mdb.createComponents();
		
		// Add the label
		//JLabel titleLbl = new JLabel("Title");
		//JLabel sImgLbl = new JLabel("SmallImage");
		
		//frame.getContentPane().add(titleLbl);
		frame.getContentPane().add(contents, BorderLayout.CENTER);
		
		// Displaying Window
		frame.pack();
		frame.setVisible(true);
	}
	
	public static void main(String[] args) {
		// need to connect to mysql in disco server
		
		// creating and run the application's GUI
				createAndShowGUI();
	};

}
