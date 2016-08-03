/****************************************************************/
/*                      Food	                            */
/*                                                              */
/****************************************************************/
import java.awt.*;
import javax.swing.*;
/**
 * Summary description for Food
 *
 */
public class Food extends JFrame
{
	// Variables declaration
	private JLabel jLabel1;
	private JLabel jLabel2;
	private JLabel jLabel3;
	private JTextPane jTextPane1;
	private JScrollPane jScrollPane1;
	private JPanel contentPane;
	// End of variables declaration


	public Food()
	{
	  super();
	  initializeComponent();
	  //
	  // TODO: Add any constructor code after initializeComponent call
	  //
	  this.setVisible(true);
	}

	/**
	 * This method is called from within the constructor to initialize the form.
	 * WARNING: Do NOT modify this code. The content of this method is always regenerated
	 * by the Windows Form Designer. Otherwise, retrieving design might not work properly.
	 * Tip: If you must revise this method, please backup this GUI file for JFrameBuilder
	 * to retrieve your design properly in future, before revising this method.
	 */
	private void initializeComponent()
	{
	  jLabel1 = new JLabel();
	  jLabel2 = new JLabel();
	  jLabel3 = new JLabel();
	  jTextPane1 = new JTextPane();
	  jScrollPane1 = new JScrollPane();
	  contentPane = (JPanel)this.getContentPane();
	  
	  //
	  // jLabel1
	  //
	  jLabel1.setBackground(new Color(102, 102, 255));
	  jLabel1.setForeground(new Color(51, 51, 51));
	  jLabel1.setText("   List of Cuisines    ");
	  //
	  // jLabel2
	  //
	  jLabel2.setText("or enter the type of food");
	  //
	  // jLabel3
	  //
	  jLabel3.setText("e.g.. chicken, turkey, ham and veggie");
	  //
	  // jTextPane1
	  //
	  jTextPane1.setBackground(new Color(255, 102, 102));
	  jTextPane1.setText("1. Chinese\n\n2. Indian\n\n3. Italian\n\n4. Sandwiches\n\n5. Fast Food\n\n6. Mexican");
	  //
	  // jScrollPane1
	  //
	  jScrollPane1.setViewportView(jTextPane1);
	  //
	  // contentPane
	  //
	  contentPane.setLayout(null);
	  addComponent(contentPane, jLabel1, 26,48,300,16);
	  //addComponent(contentPane, jLabel2, 29,301,160,18);
	  //addComponent(contentPane, jLabel3, 28,322,220,24);
	  addComponent(contentPane, jScrollPane1, 26,78,117,218);
	  //
	  // Food
	  //
	  this.setTitle("Please select one of the following cuisines");
	  this.setLocation(new Point(100, 100));
	  this.setSize(new Dimension(473, 503));
	}
  
  /** Add Component Without a Layout Manager (Absolute Positioning) */
private void addComponent(Container container,Component c,int x,int y,int width,int height)
  {
    c.setBounds(x,y,width,height);
    container.add(c);
  }
  
  //
  // TODO: Add any method code to meet your needs in the following area
  //
  
  




























 

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
