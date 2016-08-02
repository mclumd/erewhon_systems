package alma.callfile;

import java.awt.*;
import java.awt.event.*;
import java.util.LinkedList;

import alma.FormulaBuilder;
import alma.Predicate;
import javax.swing.*;        

/**
 * <p>
 * A Simple Call which gets an utterance and returns it to the kb as a predicate .
 * So if "recharge at six" is the utterance this call will temporarily add the
 * predicate: get_utterance("recharge at six") to the knowledgebase.
 * </p>
 * 
 * <p>
 * Example Usage (assumes that the call has been loaded as getUtt):<br>
 * <br>
 * <code>
 * +selected_utterance(X) -> utterance(X).<br>
 * </code>
 * <br>
 * ...<br>
 * Then whenever you need an utterance<br>
 * Use a select on the call<br>
 * ...<br>
 * <br>
 * <code>
 * #{selected_utterance(X)}[1]getUtt(X)<br>
 * </code>
 * <br>
 * ...<br>
 * This select call would trigger the call getUtt(X), and would assert selected_utterance("some utterance") <br>
 * into the knowledgebase, which would then trigger gmp and utterance("some utterance") would be <br>
 * asserted, at which point you have the utterance.<br>
 * ...<br>
 * 
 * 
 * </p>
 * 
 * 
 * @author joey
 */



public class GetUtterance extends SingleCallFormula implements ActionListener, KeyListener{
	static JTextArea text = new JTextArea();
	static JTextField line = new JTextField("Enter Text Here");
	static JButton read = new JButton("Send");
	String entireMessage = "";
	LinkedList<String> statements = new LinkedList<String>(); //Using as a queue
	boolean hasUtterance = false;
	long uniqueid = 0;
	
    private static void createAndShowGUI()  {
        //Create and set up the window.
        JFrame frame = new JFrame("Utterance");
        JPanel panel = new JPanel();
        frame.getContentPane().add(panel);
        GridBagLayout layout = new GridBagLayout();
        panel.setLayout(layout);
        GridBagConstraints con = new GridBagConstraints();
        con.fill = GridBagConstraints.BOTH;

        //Layout
        con.fill = GridBagConstraints.BOTH;
        con.weightx = .5; con.weighty = 10;
        con.gridx = 0;
        con.gridy = 0;
        con.gridwidth = 5;
        con.gridheight = 4;
        JScrollPane scrollPane = new JScrollPane(text);
        layout.setConstraints(scrollPane, con);
        panel.add(scrollPane);

        con.fill = GridBagConstraints.HORIZONTAL;
        con.gridy = 5;
        con.gridwidth = 1;
        con.gridheight = 1;
        con.weighty = 1;
        layout.setConstraints(line,con);
        panel.add(line);
        con.gridx = 1;
        con.weightx=.1;
        layout.setConstraints(read,con);
        panel.add(read);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        frame.setSize(400,400);
        frame.setVisible(true);
    }

    public GetUtterance(){
        //Schedule a job for the event-dispatching thread:
        //creating and showing this application's GUI.
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
            }
        });
        read.addActionListener(this);
        line.addKeyListener(this);
        text.setLineWrap(true);
        text.setWrapStyleWord(false);
        text.setLineWrap(true);
        text.setWrapStyleWord(true);

    }

	/**
	 * <p>
	 * generateAnswer takes a Predicate as a template and returns a single Predicate as an answer.
	 * This answer is a predicate get_utterance(X) where X is the utterance, which is a string.
	 * </p>
	 */
    
	public Predicate generateAnswer(Predicate template) {
		//The only part left to be written is where to get x from
		//
		//System.out.println("Im called " + statements.peek());

		if(!hasUtterance)
			return null;
		hasUtterance = false;
		FormulaBuilder fb = new FormulaBuilder();
			fb.addPredicate(template.getName());
				fb.addStringConst(statements.poll());
				fb.addTimeConst(uniqueid++);
			fb.endChildren();
			System.out.println(fb.getFormula());
		return (Predicate) fb.getFormulaNode();
	}

	private void submitNextLine() {
		if(!line.getText().equals("")) {
			String temp = line.getText();
			statements.offer(temp);
			System.out.println("Offering"+line.getText()+" "+statements.size());
			entireMessage = entireMessage + "\n<User>"+temp;
			text.setText(entireMessage);
			line.setText("");
			hasUtterance = true;
		}
	}
	
	public void actionPerformed(ActionEvent e) {
		if(e.getSource() == read && e.getID()==ActionEvent.ACTION_PERFORMED) {
			submitNextLine();
		}
    }

	public void keyPressed(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void keyReleased(KeyEvent e) {
		if(e.getKeyCode() ==KeyEvent.VK_ENTER)
			submitNextLine();
	}

	public void keyTyped(KeyEvent e) {
	}
	
}