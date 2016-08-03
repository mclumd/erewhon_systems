
import java.awt.*;
import java.awt.event.*;

/**
 * Handles the setup of the gui.
 * Accepts various parameters from the user,
 * and informs the parent PopKorn class when done.
 * @see PopKorn
 * @author  Sandeep Mukherjee msandeep@technologist.com
 * @author  Modified by Alexey Vedernikov (vedernikov@gmail.com)
 */
public class SetupPanel extends Panel implements ActionListener
{
	private TextField usertf, hosttf, passwdtf, filenametf, checktf;
	private Button OKButton;
	private PopKorn parent;
	private Checkbox onserver;	// Specify if messages are to be left on server

	SetupPanel(PopKorn pop)
	{
		this.parent = pop;

		GridBagLayout gb = new GridBagLayout();
		GridBagConstraints gc = new GridBagConstraints();
		this.setLayout(gb);	

		Label l = new Label ("User Name:", Label.CENTER);
		gb.setConstraints(l, gc);
		add(l);

		gc.gridwidth = gc.REMAINDER;
		usertf = new TextField ("alfredgroup", 20);
		gb.setConstraints(usertf, gc);
		add(usertf);

		gc.gridwidth = 1;
		l = new Label ("POP-3 Server:", Label.CENTER);
		gb.setConstraints(l, gc);
		add(l);

		gc.gridwidth = gc.REMAINDER;
		hosttf = new TextField ("pop.mail.ru", 20);
		gb.setConstraints(hosttf, gc);
		add(hosttf);

		gc.gridwidth = 1;
		l = new Label ("Password :", Label.CENTER);
		gb.setConstraints (l, gc);
		add(l);

		gc.gridwidth = gc.REMAINDER;
		passwdtf = new TextField (20);
		passwdtf.setEchoChar ('*');
		gb.setConstraints(passwdtf, gc);
		add(passwdtf);

		gc.gridwidth = 1;
		l = new Label("Filename :", Label.CENTER);
		gb.setConstraints(l, gc);
		add(l);

		gc.gridwidth = gc.REMAINDER;
		filenametf = new TextField("mail.txt", 20);
		gb.setConstraints(filenametf, gc);
		add(filenametf);

		gc.gridwidth = 1;
		l = new Label("Check Interval(mins):", Label.CENTER);
		gb.setConstraints(l, gc);
		add(l);

		gc.gridwidth = gc.REMAINDER;
		checktf = new TextField("0", 20);
		gb.setConstraints(checktf, gc);
		add(checktf);

		onserver = new Checkbox("Leave Messages on Server", true);
		gb.setConstraints(onserver, gc);
		add(onserver);


		gc.gridwidth = 1;
		OKButton = new Button("OK");
		gb.setConstraints(OKButton, gc);
		add(OKButton);
		OKButton.addActionListener(this);
		

	}

	/**
	 * User clicks on OK, new params are set
	 * in the parent PopKorn class.
	 */
	public void actionPerformed(ActionEvent event) 
	{
		Object source = event.getSource();
		if(source instanceof Button)
			if(source == OKButton)
			{
				int mins = 0;
				try{
					mins = Integer.parseInt(checktf.getText()) * 60000;
				}catch(NumberFormatException noe){}
				parent.setParams(hosttf.getText(), 
							usertf.getText(), 
							passwdtf.getText(), 
							filenametf.getText(), 
							mins, 
							onserver.getState()
						);
			}
			return ;
	}	// end action()


}


