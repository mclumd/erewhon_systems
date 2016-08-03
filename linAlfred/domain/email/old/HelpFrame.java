
import java.awt.*;
import java.awt.event.*;

/**
 * A frame to show help messages
 */

public class HelpFrame extends Dialog implements ActionListener
{
	private TextArea infota;
	private Button OKButton;
	public static final String HELPSTRING = 
	"PopKorn: A Client for fetching mail messages from a POP-3 Server\n" +
	"Written by: Sandeep Mukherjee\n" +
	"Modified by: Alexey Vedernikov (vedernikov@gmail.com)\n" +
	"Version " + PopKorn.version + "\n" +
	"Send bug reports, comments to:\n" +
	"msandeep@technologist.com\n";

	HelpFrame(Frame f, String title)
	{
		super(f, title, true);
		GridBagLayout gb = new GridBagLayout();
		GridBagConstraints gc = new GridBagConstraints();
		this.setLayout(gb);	
		gc.weightx = gc.weighty = 1.0;

		gc.gridwidth = gc.REMAINDER;
		infota = new TextArea(HELPSTRING);
		infota.setEditable(false);
		gb.setConstraints(infota, gc);
		add(infota);

		OKButton = new Button("OK");
		gb.setConstraints(OKButton, gc);
		add(OKButton);
		OKButton.addActionListener(this);
		pack();
	}


	public void actionPerformed(ActionEvent event) 
	{
		Object source = event.getSource();
		if(source == OKButton)
			this.setVisible(false);
	}

}
