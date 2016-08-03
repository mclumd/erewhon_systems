import java.awt.*;
import javax.swing.*;


public class Bill extends JFrame
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
  
public Bill(String [] item, Double [] price, Double [] quantity, int index)
  {
    super();
    initializeComponent(item,price,quantity,index);
    this.setVisible(true);
  }
  
  void initializeComponent(String [] item, Double [] price, Double [] quantity, int index)
  {
    jLabel1 = new JLabel();
    jLabel2 = new JLabel();
    jLabel3 = new JLabel();
    jTextPane1 = new JTextPane();
    jScrollPane1 = new JScrollPane();
    jTextPane2 = new JTextPane();
    jScrollPane2 = new JScrollPane();
    contentPane = (JPanel)this.getContentPane();
    
    String [] columnNames = {"Item","Price ($)","Quantity","Sub-Total ($)"};
    String [][] data = new String[index][4];

    double total = 0;
    for(int i = 0; i < index; i++)
      {
	data[i][0] = item[i];
	data[i][1] = price[i].toString();
	data[i][2] = quantity[i].toString();
	Double subTotal = new Double(price[i].doubleValue() * quantity[i].doubleValue());
	data[i][3] = subTotal.toString();
	total += subTotal.doubleValue();
      }
    
    JTable jTable = new JTable(data, columnNames);
    
    JScrollPane scrollPane = new JScrollPane(jTable);
    jTable.setPreferredScrollableViewportSize(new Dimension(500, 70));

    jLabel1.setText("Subtotal:"+total);

    double tax = 0.05*total;

    jLabel2.setText("Tax (5%): "+tax);

    double finalTotal = total+tax;

    jLabel3.setText("Total: "+finalTotal);

    jScrollPane1.setViewportView(jTable);

    contentPane.setLayout(null);


    addComponent(contentPane, jLabel1, 30,200,150,18);
    addComponent(contentPane, jLabel2, 30,240, 100,18);
    addComponent(contentPane, jLabel3, 30,280, 100,18);
    addComponent(contentPane, jScrollPane1, 30,45,400,150);
    //addComponent(contentPane, jScrollPane2, 218,45,60,100);
    //
    // Display
    //
    this.setTitle("Your Order");
    this.setLocation(new Point(200, 150));
    this.setSize(new Dimension(700, 500));
  }
  /** Add Component Without a Layout Manager (Absolute Positioning) */
private void addComponent(Container container,Component c,int x,int y,int width,int height)
  {
    c.setBounds(x,y,width,height);
    container.add(c);
  }
  
}
