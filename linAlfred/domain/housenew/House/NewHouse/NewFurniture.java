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
public interface NewFurniture {
	/**
	 * Toggles the state of the furniture.  For a light, it would turn
	 * it on.  For a door, the user would enter the door.  Returns
	 * the action performed in a string such as "Light On" or 
	 * "Moved To New room"
	 * @return
	 */
	public abstract String getState();
	public abstract String toggleFurniture();
	public abstract boolean walkable(); //Can you walk on this square?
}
