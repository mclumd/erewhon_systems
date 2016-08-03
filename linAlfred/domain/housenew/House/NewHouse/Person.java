package NewHouse;
import java.util.*;
import java.awt.Image;

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
public class Person {
	public final static int UP=0;
	public final static int DOWN=1;
	public final static int LEFT=2;
	public final static int RIGHT=3;
	int x, y;
	Tile destTile; //The destination of the person
	ArrayList moveQueue;
	Room room;
	String name;
	Image frame;
	public Person(String n) {
		x=0;
		y=0;
		room=null;
		moveQueue=new ArrayList();
		name=n;
		frame=DrawHouse.personl;
	}
	public Person(String n, Room r, int nX, int nY) {
		x=nX;
		y=nY;
		name=n;
		room=r;
		moveQueue=new ArrayList();
		frame=DrawHouse.personl;
	}
	
	/**
	 * Adds a tile (room and coordinates) to where the person has to go next
	 * @param nTile
	 */
	public void addToMoveQueue(Tile nTile) {
		moveQueue.add(nTile);
	}
	public boolean addListToQueue(List tList) {
		if (tList==null) {
			return false;
		}
		Iterator i = tList.iterator();
		while (i.hasNext()) {
			moveQueue.add(i.next());
		}
		return true;
	}
	
	/**
	 * Gets the next move of a person
	 * @return
	 */
	public Tile getFromMoveQueue() {
		if (moveQueue.size()==0) { //Return null if there is no current move
			return null;
		} else {
			return (Tile) moveQueue.remove(0);
		}
	}
	public Tile getFromMoveQueueWithoutDelete() {
		if (moveQueue.size()==0) { //Return null if there is no current move
			return null;
		} else {
			return (Tile) moveQueue.get(0);
		}
	}
	/**
	 * Determines if there is another move in the queue
	 * @return
	 */
	public boolean hasAnotherMove() {
		return !(moveQueue.size()==0);
	}
	
	/**
	 * Move this person to the new location
	 * @param newX - X coordinate of movement
	 * @param newY - Y coordinate of movement
	 */
	
	public void navigateTo(int newX, int newY) {
		this.room.navigateTo(this, newX, newY);
	}
	
	public void assignRoom(Room r) {
		room=r;
	}
	
	public void assignFrame(Image i) {
		frame=i;
	}
	public Image getFrame() {
		return frame;
	}
	
	/**
	 * Toggles the adjacent furniture to the person depending on dir
	 * @param dir - Which light (up, down, left or right of person) to toggle
	 */
	public String toggleFurniture(int dir) {
		int posX=0, posY=0;
		switch (dir) {
			case (UP):
				posX=x;
				posY=y-room.grid[0].length;
				if (posY<0) {
					return "Invalid selection";
				}
			case (DOWN):
				posX=x;
				posY=y-room.grid[0].length;
				if (posY>room.grid[0].length*room.grid.length) {
					return "Invalid selection";
				}
			case (LEFT):
				posX=x-1;
				if (posX<0) {
					return "Invalid selection";
				}
				posY=y;
			case (RIGHT):
				posX=x+1;
				if (posX>room.grid.length) {
					return "Invalid selection";
				}
				posY=y;
		}
		return room.toggleFurniture(posX, posY);
	}
}
