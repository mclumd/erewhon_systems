/****************************************************************/
/*                      Options	                            */
/*                                                              */
/****************************************************************/
import java.awt.*;
import javax.swing.*;


public class Options extends JFrame
{
	
  // Variables declaration
private JLabel jLabel1;
private JLabel jLabel2;
private JLabel jLabel3;
private JTextPane jTextPane1;
private JScrollPane jScrollPane1;
private JPanel contentPane;
  // End of variables declaration
  
public Options(String [] list)
  {
    super();
    initializeComponent(list);
    //
    // TODO: Add any constructor code after initializeComponent call
    //
    
    this.setVisible(true);
  }
  
private void initializeComponent(String [] list)
  {
    jTextPane1 = new JTextPane();
    jScrollPane1 = new JScrollPane();
    jLabel1 = new JLabel();

    contentPane = (JPanel)this.getContentPane();
   
    jLabel1.setText("Please select one of the following restaurants:");

    //
    // jTextPane1
    //
    jTextPane1.setBackground(new Color(255, 102, 102));
    String total = "";

    for(int i = 0; i < list.length; i++)
      {
	if(i == 0)
	  total += list[i];
	else
	  total += "\n\n"+list[i]; 
      }

    jTextPane1.setText(total);
    
    //
    // jScrollPane1
    //
    jScrollPane1.setViewportView(jTextPane1);
    //
    // contentPane
    //
    contentPane.setLayout(null);
    addComponent(contentPane, jScrollPane1, 26,78,220,218);
    addComponent(contentPane, jLabel1, 67,26,150,18);
    //
    // Options
    //
    this.setTitle("Available Restaurants");
    this.setLocation(new Point(100, 100));
    this.setSize(new Dimension(473, 503));
  }

  /** Add Component Without a Layout Manager (Absolute Positioning) */
private void addComponent(Container container,Component c,int x,int y,int width,int height)
  {
    c.setBounds(x,y,width,height);
    container.add(c);
  }

//============================= Testing ================================//
//=                                                                    =//
//= The following main method is just for testing this class you built.=//
//= After testing,you may simply delete it.                            =//
//======================================================================//
  /*	public static void main(String[] args)
	{
	  JFrame.setDefaultLookAndFeelDecorated(true);
		JDialog.setDefaultLookAndFeelDecorated(true);
		try
		{
			UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
		}
		catch (Exception ex)
		{
			System.out.println("Failed loading L&F: ");
			System.out.println(ex);
		}
		new Food();
		}*/
//= End of Testing =
}
