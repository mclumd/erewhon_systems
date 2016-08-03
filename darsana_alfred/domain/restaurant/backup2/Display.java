/****************************************************************/
/*                      Display	                            */
/*                                                              */
/****************************************************************/
import java.awt.*;
import javax.swing.*;
/**
 * Summary description for Display
 *
 */
public class Display extends JFrame
{
  // Variables declaration
private JLabel jLabel1;
private JLabel jLabel2;
private JTextPane jTextPane1;
private JScrollPane jScrollPane1;
private JTextPane jTextPane2;
private JScrollPane jScrollPane2;
private JPanel contentPane;
  // End of variables declaration
  

public Display(String [] entry, Double [] price, String name)
  {
    super();
    initializeComponent(entry,price,name);
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
private void initializeComponent(String [] entry, Double [] price, String name)
  {
    jLabel1 = new JLabel();
    jLabel2 = new JLabel();
    jTextPane1 = new JTextPane();
    jScrollPane1 = new JScrollPane();
    jTextPane2 = new JTextPane();
    jScrollPane2 = new JScrollPane();
    contentPane = (JPanel)this.getContentPane();
    
    String finalText = "";
    for(int i = 0; i < entry.length; i++)
      {
	finalText += entry[i]+price[i].toString()+"\n\n";
      }
    
    
    String[] columnNames = {"Item","Price ($)"};
    
    String [] [] data = new String[entry.length][2];
    
    for(int i = 0; i < entry.length; i++)
      {
	data [i][0] = entry[i];
	data [i][1] = price[i].toString();
      }
    
    JTable jTable = new JTable(data, columnNames);
    
    
    JScrollPane scrollPane = new JScrollPane(jTable);
    jTable.setPreferredScrollableViewportSize(new Dimension(500, 70));
    //
    // jLabel1
    //
    //jLabel1.setText("Item");
    //
    // jLabel2
    //
    //jLabel2.setText("Price");
    //
    // jTextPane1
    //
    //jTextPane1.setText(finalText);
    //
    // jScrollPane1
    //
    jScrollPane1.setViewportView(jTable);//(jTextPane1)
    //
    // jTextPane2
    //
    //jTextPane2.setText("abc");
    //
    // jScrollPane2
    //
    //jScrollPane2.setViewportView(jTextPane2);
    //
    // contentPane
		//
    contentPane.setLayout(null);
    //addComponent(contentPane, jLabel1, 27,26,60,18);
    //addComponent(contentPane, jLabel2, 220,26,60,18);
    addComponent(contentPane, jScrollPane1, 29,45,400,150);
    //addComponent(contentPane, jScrollPane2, 218,45,60,100);
    //
    // Display
    //
    this.setTitle("Menu for "+name);
    this.setLocation(new Point(100, 50));
    this.setSize(new Dimension(500, 300));
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
		new Display();
		}*/
//= End of Testing =


}
