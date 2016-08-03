/*
 * Created on Jun 30, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package NewHouse;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Television implements NewFurniture {
	boolean state;
	int channel; //What channel the TV is on
	public Television() {
		state=false; //TV is off when you first start it
	}
	public String toggleFurniture() {
		if (state==false) {
			state=true;
			return "Turned TV On";
		} else {
			state=false;
			return "Turned TV Off";
		}
	}
	public String getState() {
		if (state==false ){
			return "Off";
		} else {
			return "On";
		}
	}
	public boolean walkable() {
		return false;
	}
}
