//Author: Chun-yan Mi
//Date: December 2, 2005
//Connection updated @ Dec 7, 2005 by Iva Nasrun

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.awt.*;
import java.net.MalformedURLException;
import java.net.URL;

import javax.swing.*;

public class movieInfo extends JFrame
{
    //Global public static variables for the connections
    public static String inputTitle = new String();
    public static Connection con = null;
    public static Statement stmt = null;
    public static ResultSet rset = null;

    public static void main(String[] args) {
	try {
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	    con = DriverManager.getConnection
		("jdbc:mysql://localhost:3306/movieDB","valva","kucing21");
	    
	    inputTitle = new String(args[0]);
	    for ( int x = 1; x < args.length; x++ )
		inputTitle += " " + args[x];
	    
	    stmt = con.createStatement();
	    rset = stmt.executeQuery("select * from MovieInfo where title like '%" + inputTitle + "'" );
	    
	    //while (rset.next()) System.out.println(rset.getString(1));
	    rset.next(); 
	    System.out.println(rset.getString("title"));
	    
	    if(!con.isClosed())
		System.out.println("Successfully connected to MySQL");
			
	    JFrame.setDefaultLookAndFeelDecorated(true);
	    JDialog.setDefaultLookAndFeelDecorated(true);
			
	    new movieInfo();
	    
	}catch(Exception e) {
	    System.err.println("Exception: " + e.getMessage());
	}finally {
	    try {
		if(con != null)
		    con.close();
	    }catch(SQLException e) {
		System.out.println("Failed to close connection.");
	    }
	}
    }


    // Variables declaration
    private JLabel titleLbl;
    private JLabel movieImg;
    private JLabel movieInfoLbl;
    private JLabel SynopsisLbl;
    private JPanel contentPane;

    public movieInfo()
    {
	super();
	initializeComponent();
	this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	//this.setVisible(true);
    }


    private void initializeComponent()
    {
	titleLbl = new JLabel();
	movieImg = new JLabel();
	movieInfoLbl = new JLabel();
	SynopsisLbl = new JLabel();
	contentPane = (JPanel)this.getContentPane();

	//setting the location of the image
	URL imgUrl = null;

	try {
	    imgUrl = new URL(rset.getString("SmImage") );
	} catch (MalformedURLException e) {
	    e.getMessage();
	}catch(SQLException e) {
	    e.getMessage();
	}

 		
	// titleLbl
	titleLbl.setHorizontalAlignment(SwingConstants.CENTER);
	titleLbl.setHorizontalTextPosition(SwingConstants.CENTER);
	Font headerFont = new Font("SansSerif", Font.BOLD, 18);	
	titleLbl.setFont(headerFont);
	
	try {
	    titleLbl.setText(rset.getString("title"));
	
	// movieImg
	movieImg.setHorizontalAlignment(SwingConstants.CENTER);
	movieImg.setHorizontalTextPosition(SwingConstants.CENTER);
	movieImg.setIcon(new ImageIcon(imgUrl));
	
	//String mId = rset.getString("MovieId");
		
	// movieDirector
	ResultSet rsetD = stmt.executeQuery
	    ("select Name from (Movie_to_Director md natural inner join PersonInfo p) where md.MovieId = mId"); 
	rsetD.next();
	System.out.println("director " + rsetD.getString(1));

	// movieCasts
	ResultSet rsetC = stmt.executeQuery
	    ("select Name from (Movie_to_Cast mc natural inner join PersonInfo p) where mc.MovieId = mId");

	// movieGenre
	ResultSet rsetG = stmt.executeQuery
	    ("select GenreName from (Movie_to_Genre mg natural inner join GenreInfo) where mg.MovieId = mId");

	// movieRating
	ResultSet rsetR = stmt.executeQuery
	    ("select RatingName from (Movie_to_Rating mr natural inner join RatingInfo) where mr.MovieId = mId"); 

	// movieInfoLbl
	movieInfoLbl.setHorizontalAlignment(SwingConstants.LEFT);
	movieInfoLbl.setText("<html>Director: Simon West <br> " +
			     "Cast: Angelina Jolie<br>" +
			     "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Jon Voight<br>" +
			     "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Noah Taylor<br>" +
			     "Genre: Action & Adventure<br>" +
			     "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp " +
			     "Sci-Fi & Fantasy<br>Language:English, French<br>Rating: PG-13<br>" +
			     "Running Time: 1 hour, 40 minutes</html>");
	movieInfoLbl.setVerticalAlignment(SwingConstants.TOP);
		
	// SynopsisLbl
	SynopsisLbl.setHorizontalAlignment(SwingConstants.CENTER);
	SynopsisLbl.setHorizontalTextPosition(SwingConstants.CENTER);
	SynopsisLbl.setText("<html>Synopsis: A popular video game comes to the screen with this big-budget adventure starring Angelina Jolie as a buxom heroine recalling equal parts Indiana Jones and James Bond. Jolie is Lara Croft, a proper British aristocrat groomed at schools for the children of the elite. Croft leads a double life, however, as an acquirer of lost antiquities through questionable means, highly trained in combat skills with the help of a robotic opponent called Simon. Despite her exciting profession and a life of wealth and breeding, Lara pines for her father, Lord Croft (Jon Voight), whose passing left her orphaned. </html>");
	SynopsisLbl.setVerticalAlignment(SwingConstants.TOP);
     } catch (SQLException e) {
	e.getMessage();
    }

	// contentPane
	contentPane.setLayout(null);
	contentPane.setBackground(new Color(230, 230, 230));
	addComponent(contentPane, titleLbl, 0,0,439,42);
	addComponent(contentPane, movieImg, 35,20,160,187);
	addComponent(contentPane, movieInfoLbl, 200,46,236,159);
	addComponent(contentPane, SynopsisLbl, 22,189,397,150);
		
	// movieInfo
	this.setTitle("Movie Infomation");
	this.setLocation(new Point(-1, -1));
	this.setSize(new Dimension(445, 379));
    }
    
    /** Add Component Without a Layout Manager (Absolute Positioning) */
    private void addComponent(Container container,Component c,int x,int y,int width,int height)
    {
	c.setBounds(x,y,width,height);
	container.add(c);
    }
}






