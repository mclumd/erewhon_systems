import java.awt.*;
import javax.swing.*;


public class DisplayAllRestaurants extends JFrame
{

  // Variables declaration
    private JLabel jLabel1;
    private JLabel jLabel2;
    private JLabel jLabel3;
    private JTextPane jTextPane1;
    private JScrollPane jScrollPane1;
    private JTextPane jTextPane2;
    private JScrollPane jScrollPane2;
    private JPanel contentPane;
    // End of variables declaration
    
    public DisplayAllRestaurants(String [] names, String [] types)
    {
	super();
	initializeComponent(names, types);
	this.setVisible(true);
    }
    
    void initializeComponent(String [] names, String [] types)
    {
	//jLabel1 = new JLabel();
	//jLabel2 = new JLabel();
	//jLabel3 = new JLabel();
	jTextPane1 = new JTextPane();
	jScrollPane1 = new JScrollPane();
	jTextPane2 = new JTextPane();
	jScrollPane2 = new JScrollPane();
	contentPane = (JPanel)this.getContentPane();
	
	String [] columnNames = {"Name of Restaurant", "Type of cuisine"};
	String [][] data = new String[names.length][2];
	
	double total = 0;
	for(int i = 0; i < names.length; i++)
	    {
		data[i][0] = names[i];
		data[i][1] = types[i];
	    }
	
	JTable jTable = new JTable(data, columnNames);
    
	JScrollPane scrollPane = new JScrollPane(jTable);
	jTable.setPreferredScrollableViewportSize(new Dimension(500, 70));
	

	jScrollPane1.setViewportView(jTable);
	
	contentPane.setLayout(null);
	
	//addComponent(contentPane, jLabel1, 30,200,150,18);
	//addComponent(contentPane, jLabel2, 30,240, 100,18);
	//addComponent(contentPane, jLabel3, 30,280, 100,18);
	
	addComponent(contentPane, jScrollPane1, 100,60,400,150);
        
	//addComponent(contentPane, jScrollPane2, 218,45,60,100);
   
    this.setTitle("List of Available Restaurants");
    this.setLocation(new Point(200, 150));
    this.setSize(new Dimension(700, 500));
    }

    // Add Component Without a Layout Manager (Absolute Positioning)
    private void addComponent(Container container,Component c,int x,int y,int width,int height)
    {
	c.setBounds(x,y,width,height);
	container.add(c);
    }
    
}
