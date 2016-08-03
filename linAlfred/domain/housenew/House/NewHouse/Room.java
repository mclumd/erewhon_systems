
package NewHouse;


import java.util.ArrayList;
import java.util.List;

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
public class Room {
	Tile grid[][];
	String name;
	int houseX, houseY; //X and Y Positions of the top left corner of the room in the house
	int width, height; //How wide and tall the room is
	public Room(int nWidth, int nHeight, int x, int y, String nName) {
		grid = new Tile[nWidth][nHeight];
		for (int gx=0; gx<grid.length; gx++) {
			for (int gy=0; gy<grid[0].length; gy++) {
				grid[gx][gy] = new Tile(this, gx,gy);
			}
		}
		updateAdjsList(); //Set the things that are adjacent to each other
		name=nName;
		houseX=x;
		houseY=y;
		width=nWidth;
		height=nHeight;
	}
	public Room(Room r) {
		this.grid=r.grid;
		this.name=r.name;
		this.width=r.width;
		this.height=r.height;
		
	}
	
	/**
	 * This method updates the adjacencies list of each of the tiles, based on if they're
	 * corner pieces or if they're next to unwalkable tiles.  It needs to be called every
	 * time the room is changed.
	 *
	 */
	public void updateAdjsList() {
		for (int gx=0; gx<grid.length; gx++) {
			for (int gy=0; gy<grid[0].length; gy++) {
				ArrayList tempList = new ArrayList();
				if (gx>0) {
					if (grid[gx-1][gy].furniture==null || grid[gx-1][gy].furniture.walkable()) { //Nothing on this tile to prohbit moving there
						tempList.add(grid[gx-1][gy]);
					}
				}
				if (gx<grid.length-1) {
					if (grid[gx+1][gy].furniture==null || grid[gx+1][gy].furniture.walkable()) {
						tempList.add(grid[gx+1][gy]);
					}
				}
				if (gy>0) {
					if (grid[gx][gy-1].furniture==null || grid[gx][gy-1].furniture.walkable()) {
						tempList.add(grid[gx][gy-1]);
					}
				} 
				if (gy<grid[0].length-1) {
					if (grid[gx][gy+1].furniture==null || grid[gx][gy+1].furniture.walkable()) {
						tempList.add(grid[gx][gy+1]);
					}
				}
				grid[gx][gy].addAdjs(tempList);
			}
		}
	}
	public void clearTiles() {
		for (int x=0; x<grid.length; x++) {
			for (int y=0; y<grid[0].length; y++) {
				grid[x][y].reset();
			}
		}
	}
	
	public boolean equals(Room r) {
		if (this.houseX==r.houseX && this.houseY==r.houseY && this.name.equals(r.name)) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public String toggleFurniture(int x, int y) {
		return grid[x][y].furniture.toggleFurniture();
	}
	/**
	 * Attemps to move the person, p, to coordinates x,y in the room 
	 * @param p
	 * @param x
	 * @param y
	 */
	public void navigateTo(Person p, int x, int y) {
		if (grid[x][y].furniture==null || grid[x][y].furniture.walkable()) { //Not a furniture piece, you can move there
			//Update the coordinates of the person
			p.x=x;
			p.y=y;
		} else {
			//You can't move there, do nothing
		}
	}
	
	public Tile getDoorTile(String sRoom) {
		for (int x=0; x<width; x++) {
			for (int y=0; y<height; y++) {
				if (grid[x][y].furniture instanceof Door) {
					Door tempDoor = (Door) grid[x][y].furniture;
					if (tempDoor.linkTo.equals(sRoom)) {
						return grid[x][y]; //This is the door you want
					}
				}
			}
		}
		return null; //Nothing found
	}
	
	/**
	 * Adds a new furniture object to the grid array at the specified
	 * coordinates
	 * @param f
	 * @param x
	 * @param y
	 */
	public void addFurniture(NewFurniture f, int x, int y) {
		grid[x][y].furniture=f; //Assign the furniture to that location
	}
	/**
	 * Removes the furniture from the x,y location in the room grid
	 * by setting the furniture equal to null
	 * @param x
	 * @param y
	 */
	public void removeFurniture(int x, int y) {
		grid[x][y]=null;
	}
	/**
	 * Finds a viable path to a certain place in a room.  The turn value is a list
	 * that represents tiles corresponding to rooms and coordinates, these then are placed
	 * in the person's moveQueue
	 * @param orgX -Starting position in x direction
	 * @param orgY - Starting position in y direction
	 * @param destX - Where you want to go X
	 * @param destY - Where you want to go Y
	 */
	public List findPathInRoom(int orgX, int orgY, int destX, int destY) {

		Tile start=grid[orgX][orgY];
		Tile finish=grid[destX][destY];
		clearTiles();
		
		List sVerts=new ArrayList(); //List of seen vertices
		/* Add starting vertex to algorithm */
		sVerts.add(0, start);
		start.markAsSeen();
		
		while (sVerts.size()>0) { //while there are still vertices in the seen vertices list
			Tile orgV = (Tile) sVerts.remove(0); //Retreive the first vertex from the list 
			if (! orgV.hasBeenVisited()) { //Have not visited this vertex yet
				orgV.visit();
				if (orgV.equals(finish)) { //You're at the end
					//Now return the path you took to get to this object
					ArrayList tempList=new ArrayList();
					Tile tempPred=finish;
					tempList.add(tempPred);
					while (tempPred.getPredecessor()!=null) {
						tempPred=tempPred.getPredecessor();
						tempList.add(0, tempPred);
					}
					return tempList; //Add more code here, return the actual path
				}
				List curAdjs; //Current adjacencies to the current vertex list
				curAdjs = orgV.getAdjs(); //What verticees are adjacent to the current vertex?
				for (int i=0; i<curAdjs.size(); i++) { //Cycle through adjacent vertices
					Tile adjV = (Tile) curAdjs.get(i); //A shallow copy of the current adjacent vertex from the adjacencies list
					if (adjV.hasBeenVisited()==false) { //If you haven't visited it yet, add it to the list
						adjV.setPredecessor(orgV);
						adjV.markAsSeen();
						sVerts.add(adjV); //Add to the end of the list (breadth first search)
					}
				} //for int i
			} //if orgV.beenVisited
		} //while (sVerts.size)
		
		return null; //No path found
		
	}
	
}

/**
 * The Tile class possess a furniture object, in addition to knowing which tiles it is adjacent to.  Primarily
 * used in path finding.
 */
class Tile {
	private int x, y;
	private boolean visited;
	private boolean seen;
	private ArrayList adjs;
	private Tile pred;
	private Room room;
	public NewFurniture furniture;
	public Tile(Room nRoom, int newX, int newY, ArrayList newAdjs) {
		x=newX;
		y=newY;
		adjs=newAdjs;
		visited=false;
		seen=false;
		pred=null;
		room=nRoom;
	}
	public Tile(Room nRoom, int newX, int newY) {
		x=newX;
		y=newY;
		adjs=null;
		visited=false;
		pred=null;
		room=nRoom;
	}
	public boolean equals(Tile compare) {
		if (compare.x==this.x && compare.y==this.y) {
			return true;
		} else {
			return false;
		}
	}
	public void setPredecessor(Tile nPred) {
		pred=nPred;
	}
	public Tile getPredecessor() {
		return pred;
	}
	public void addAdjs(ArrayList newAdjs) {
		adjs=newAdjs;
	}
	public void visit() {
		visited=true;
	}
	public boolean hasBeenVisited() {
		return visited;
	}
	public void markAsSeen() {
		seen=true;
	}
	public boolean getSeen() {
		return seen;
	}
	public ArrayList getAdjs() {
		return adjs;
	}
	public int getX() {
		return x;
	}
	public int getY() {
		return y;
	}
	public Room getRoom() {
		return room;
	}
	/**
	 * Reset the values of the tile for path finding
	 *
	 */
	public void reset() {
		visited=false;
		pred=null;
		seen=false;
	}
}
