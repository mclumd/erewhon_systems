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

public class Desk implements NewFurniture {
	public NewFurniture furniture; //A desk can have one furniture such as a light on it
	public Desk() {
		furniture=null;
	}
	public Desk(NewFurniture f) {
		furniture=f;
	}
	public void addFurniture(NewFurniture f) {
		furniture=f;
	}
	public void removeFurniture(NewFurniture f) {
		furniture=null;
	}
	/**
	 * Toggles the state of the furniture on the desk, unless no furniture exists in
	 * which case the method returns "No action performed"
	 */
	public String toggleFurniture() {
		if (furniture!=null) {
			return furniture.toggleFurniture();
		} else {
			return "No action performed";
		}
	}
	public String getState() {
		if (furniture==null) {
			return "Off";
		}
		return furniture.getState();
	}
	public boolean walkable() {
		return false;
	}
}
