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
public class Couch implements NewFurniture {
	public boolean left; //This controls what direction the couch is facing
	public Couch(boolean isLeft) {
		left=isLeft;
	}
	public boolean walkable() {
		return true;
	}
	public String toggleFurniture() {
		if (left==false) {
			left=true;
			return "Couch turned left";
		} else {
			left=false;
			return "Couch turned right";
		}
	}
	public String getState() {
		if (left==false) {
			return "Right";
		} else {
			return "Left";
		}
	}
}
