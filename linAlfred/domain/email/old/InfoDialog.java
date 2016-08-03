
import java.awt.*;
import java.awt.event.*;

/**
 * A dialog frame to show messages
 */

public class InfoDialog extends Dialog implements ActionListener
{
	private Label label;
	private Button OKButton;

	InfoDialog(Frame f, String title)
	{
		super(f, title, true);
		GridBagLayout gb = new GridBagLayout();
		GridBagConstraints gc = new GridBagConstraints();
		this.setLayout(gb);	
		gc.weightx = gc.weighty = 1.0;

		gc.gridwidth = gc.REMAINDER;
		label = new Label("Hello World", Label.CENTER);
		gb.setConstraints(label, gc);
		add(label);

		OKButton = new Button("OK");
		gb.setConstraints(OKButton, gc);
		add(OKButton);
		OKButton.addActionListener(this);
		pack();
	}

	/**
	 * Pop up this frame with the message
	 */
	public void message(String str)
	{
		label.setText(str);
		validate();
		this.pack();
		this.show();
	}

	public void actionPerformed(ActionEvent event) 
	{
		Object source = event.getSource();
		if(source == OKButton)
			this.setVisible(false);
	}

}
