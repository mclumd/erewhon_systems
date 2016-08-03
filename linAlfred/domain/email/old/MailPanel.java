
import java.awt.*;
import java.awt.event.*;
import java.io.*;

/**
 * A panel that appears after setup.
 * Has buttons to check for mail and get mail to
 * a local file.
 * A textarea shows messages from the POP3Client.
 * @see PopKorn
 * @author Sandeep Mukherjee msandeep@technologist.com
 */

public class MailPanel extends Panel  implements POP3Reader, ActionListener
{
	private Button checkButton, getButton, clearButton;
	private PopKorn parent;
	private TextArea statusta;
	private RandomAccessFile fileout;

	MailPanel(PopKorn pop)
	{
		this.parent = pop;

		GridBagLayout gb = new GridBagLayout();
		GridBagConstraints gc = new GridBagConstraints();
		this.setLayout(gb);	

		gc.gridwidth = gc.REMAINDER;
		gc.weightx = gc.weighty = 1.0;
		statusta = new TextArea(5, 40);
		statusta.setEditable(false);
		gb.setConstraints(statusta, gc);
		add(statusta);

		gc.gridwidth = 1;
		getButton = new Button("Get Mail");
		gb.setConstraints(getButton, gc);
		add(getButton);
		getButton.addActionListener(this);

		gc.gridwidth = 1;
		checkButton = new Button("Check Mail");
		gb.setConstraints(checkButton, gc);
		add(checkButton);
		checkButton.addActionListener(this);

		gc.gridwidth = gc.REMAINDER;
		clearButton = new Button("Clear");
		gb.setConstraints(clearButton, gc);
		clearButton.addActionListener(this);
		add(clearButton);

	}

	public void actionPerformed(ActionEvent event) 
	{
		Object source = event.getSource();
		if(source == getButton)
		{
			// Get the mails from the server and store them in the file
			// Delte them from server if specified..

			POP3Client popper = new POP3Client(parent.getHost(), parent.getUser(),
				parent.getPasswd(), this);
			try
			{
				fileout = new RandomAccessFile(parent.getFilename(), "rw");
				fileout.seek(fileout.length());	// Messages appended at end
				// If user specified leave on server, set  delete flag
				// to false on getting mail
				popper.getMail(!parent.getOnServer());
				fileout.close();
				fileout = null;
			}
			catch(POP3Exception poe){}
			catch(IOException poe){System.err.println(poe.toString()); }

		} else
		if(source == checkButton)
		{
			POP3Client popper = new POP3Client(parent.getHost(), parent.getUser(),
				parent.getPasswd(), this);
			int nmails = popper.checkMail();
			if(nmails >= 0)
				info("You have " + nmails + " message(s) on " +
					parent.getHost());

		}else
		if(source == clearButton)
			statusta.setText("");

		return ;

	}	// end action()

	public void info(String str)
	{
		statusta.append(str + "\n");
	}

	/**
	 * Write the string to output stream
	 */
	public void data(String str) throws IOException
	{
		if(fileout != null)
			fileout.writeBytes(str + "\n");

	}


}


