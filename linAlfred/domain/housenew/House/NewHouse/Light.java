package NewHouse;

/*
 * Created on May 15, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Light implements NewFurniture {
	boolean turnedOn;
	public Light() {
		turnedOn=false;
	}
	/**
	 * Changes the state of a lightbulb
	 */
	public String toggleFurniture() {
		if (turnedOn==true) {
			turnedOn=false;
			return "Turned Off Light";
		} else {
			turnedOn=true;
			return "Turned On Light";
		}
	}
	public String getState() {
		if (turnedOn) {
			return "On";
		} else {
			return "Off";
		}
	}
	public boolean walkable() {
		return false;
	}
}
