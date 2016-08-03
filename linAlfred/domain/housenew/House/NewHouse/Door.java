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
public class Door implements NewFurniture {
	public String linkTo; //What room this door points to
	public Door(String lT) {
		linkTo=lT;
	}
	public String toggleFurniture() {
		return "Moved to " + linkTo;
	}
	public String getState() {
		return linkTo;
	}
	public boolean walkable() {
		return true;
	}
}
