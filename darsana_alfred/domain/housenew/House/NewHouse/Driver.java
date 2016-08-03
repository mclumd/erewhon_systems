
package NewHouse;
/*
 * Created on Jun 2, 2005
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
import java.net.*;
import java.io.*;
import java.util.*;

public class Driver {
	
	// socket related 
	public static ServerSocket ss= null;
	public static Socket alfred= null;
	public static BufferedInputStream bis= null;
	public static int cmdNum= 1;
	public static House house;
	public static Person curPerson;
	public static DrawHouse gui;
	
	
	// miscellaneous
	public static Runtime rt= Runtime.getRuntime();
	
	
	public static void main(String[] args) {
		boolean cp=false; //Whether you should create a person at start or not
		if (args.length==2) {
			cp=true;
		} else if (args.length!=1) {
			System.out.println("Invalid domain path");
			return;
		}
		System.out.println(args.length);
		
		house=House.SINGLETON();
		curPerson=null;
		
		gui=new DrawHouse(cp);
		gui.loadHouse(); 
		try {
			SocketHandler sh = new SocketHandler();
			
			Settings setting= new Settings(args[1]);
			
			setting.writeFile();
			
			ss= setting.getServerSocket();
			
			while(true) {
				System.out.println("Waiting for connection with Alfred...");
				alfred= ss.accept();
				System.out.println("Connection with Alfred established!");
				
				bis= new BufferedInputStream(alfred.getInputStream());
				
				while (alfred.isConnected()) {
					processCommand(getCommand("Command " + cmdNum++ + " from Alfred"));
				}
			}
		} catch (Exception e) {
			
		}
	}
	
	
	public static String getCommand(String request) throws Exception {
		byte[] bt= new byte[1000];
		
		try {     
			bis.read(bt);
			System.out.println(request + ": " + new String(bt));
		} catch (IOException ioe) {
			System.out.println("Sorry unable to get your command...");
		}
		
		return new String(bt);
	}
	
	public static void processCommand(String command) throws Exception {
		StringTokenizer tok= new StringTokenizer(command, "[], ", false);
		String first= tok.nextToken();
		
		first= first.trim().toLowerCase();
		
		if (first.equals("person")) { //person, (name)
			Person tempPerson = getPerson(tok.nextToken());
			if (tempPerson==null) {
				System.out.println("Invalid Person");
			} else {
				curPerson=tempPerson;
			}
		} else if (first.equals("newperson")) { //newperson, (name), (Room), (x), (y)
			String tempName = tok.nextToken();
			String tempRoom = tok.nextToken();
			int x = Integer.parseInt(tok.nextToken());
			int y = Integer.parseInt(tok.nextToken());
			Person validate = getPerson(tempName);
			if (validate!=null) { //Alredy a person wtih this name
				System.out.println("Error, already a person with this name!");
			} else {
				Room r = getRoom(tempRoom);
				if (r!=null) {
					Person p = new Person(tempName, r, x, y); //Create a new person from the inputted data
					house.addPerson(p); //Add the person to the house
				} else {
					System.out.println("Error, invalid room");
				}
			}
			
			

		} else if (first.equals("move")) {  //move, (Room), (X), (Y)
			/*String pName = tok.nextToken(); //What person are you moving?
			Person tempPerson = getPerson(pName);
			if (tempPerson==null) {
				System.out.println("Invalid Person");
			} else {
				curPerson=tempPerson;
			}*/
			
			String rName = tok.nextToken(); //Get the name of the room you are in
			Room tempRoom = getRoom(rName); //Find the Room object from its name
			
			//Coordinates to move to:
			int x = Integer.parseInt(tok.nextToken());
			int y = Integer.parseInt(tok.nextToken());
			
			
			
			
			/*
			 * Move the person to the desired location
			 */
			
			//This move is in the current room
			if (!tempRoom.name.equals(curPerson.room)) { //Out of bounds of the room

				Room oldRoom = curPerson.room; //Save the old room in case you can't get there
				
				
				Tile tempTile = oldRoom.getDoorTile(tempRoom.name);
				
				if (tempTile!=null) { //Found a door to that room
					//Move the person to the door
					
					boolean toDoor = curPerson.addListToQueue(curPerson.destTile.getRoom().findPathInRoom(curPerson.destTile.getX(), curPerson.destTile.getY(), tempTile.getX(), tempTile.getY()));
					//Now move the person to the tile in the new room
					//Start at the door for the room
					Tile secDoorTile = tempRoom.getDoorTile(oldRoom.name);
					boolean toRoom = curPerson.addListToQueue(tempRoom.findPathInRoom(secDoorTile.getX(), secDoorTile.getY(), x-tempRoom.houseX, y-tempRoom.houseY));
					
					//Update where you'll end up
					if (toRoom==true) {
						curPerson.destTile = new Tile(tempRoom, x-tempRoom.houseX, y-tempRoom.houseY);
						
					} else if (toDoor==true) {
						curPerson.destTile = new Tile (curPerson.room, tempTile.getX(), tempTile.getY());
					}
					
					
					gui.repaint();
					
				} else { //You are in a room but there is no door to that room
					
				}
			} else { //You are moving to somewhere in the current room
				//Can you actually get to this tile?
				boolean canGet = curPerson.addListToQueue(curPerson.room.findPathInRoom(curPerson.destTile.getX(), curPerson.destTile.getY(), x-curPerson.room.houseX, y-curPerson.room.houseY));
				if (canGet) { //You can get to where you want to go
					curPerson.destTile = new Tile(curPerson.room, x-curPerson.room.houseX, y-curPerson.room.houseY); //Update where the person will be at the end of his movement
				}
				gui.repaint();
			}
			
			
		} else if (first.equals("toggle")) { //toggle, (Direction)
			String dir = tok.nextToken();
			
			if (dir.equals("up")) {
				curPerson.toggleFurniture(Person.UP);
			} else if (dir.equals("down")) {
				curPerson.toggleFurniture(Person.DOWN);
			} else if (dir.equals("left")) {
				curPerson.toggleFurniture(Person.LEFT);
			} else if (dir.equals("right")) {
				curPerson.toggleFurniture(Person.RIGHT);
			} else { //Unexpected direction
				System.out.println("Invalid direction");
			}
		
		} else if (first.equals("makeroom")) { //makeroom, (Name), (housex), (housey), (width), (height)
			String roomName=tok.nextToken();
			int houseX=Integer.parseInt(tok.nextToken());
			int houseY=Integer.parseInt(tok.nextToken());
			int width=Integer.parseInt(tok.nextToken());
			int height=Integer.parseInt(tok.nextToken());
			Room tempRoom=new Room(width, height, houseX, houseY, roomName);
			if (!roomOverlap(tempRoom)) {
				house.addRoom(tempRoom);
			}	
		
		} else if (first.equals("makeobject")) { //makeobject, (type), (Room), (x), (y)	
			String objectType = tok.nextToken();
			String roomName = tok.nextToken();
			int x = Integer.parseInt(tok.nextToken());
			int y = Integer.parseInt(tok.nextToken());
			
			NewFurniture nf = getFurniture(objectType);
			Room tempRoom = getRoom(roomName);
			if (tempRoom!=null) {
				if (nf!=null) {
					tempRoom.addFurniture(nf, x, y);
				}
			}
			
		
		} else if (first.equals("makedoor")) { //makedoor, (orgroom), (destroom), (x), (y)
			String orgRoom = tok.nextToken();
			String destRoom = tok.nextToken();
			int x = Integer.parseInt(tok.nextToken());
			int y = Integer.parseInt(tok.nextToken());
			
			Room tempRoom = getRoom(orgRoom);
			if (tempRoom!=null) { //The originating room actually exists
				tempRoom.addFurniture(new Door(destRoom),x,y); //Place the door in the room
			}
			
			
		} else {
			System.out.println("You did not provide a " + 
					"valid command: " + first);
		}
		
		
		
		
		
	}
	
	/**
	 * This method checks to see if there is a person with the same name as the name String, returning
	 * that Person if a match is found, returning null if no match is found.
	 * @param name
	 * @return
	 */
	public static Person getPerson(String name) {
		Iterator i = house.persons.iterator();
		while (i.hasNext()) {
			Person tempPerson = (Person) i.next();
			if (tempPerson.name.equals(name)) {
				return tempPerson;
			}
		}
		return null; //Nothing found
	}
	
	/**
	 * This method checks to see if there is a room with the same name as the given String, and
	 * returns that Room if so.  Null is returned if no matches are found
	 * @param name
	 * @return
	 */
	public static Room getRoom(String name) {
		Iterator i = house.rooms.iterator();
		while (i.hasNext()) {
			Room tempRoom = (Room) i .next();
			if (tempRoom.name.equals(name)) {
				return tempRoom;
			}
		}
		return null;
	}
	
	
	/**
	 * This method returns a type of furniture based on the input string, or null if no furniture
	 * matches
	 * @param name
	 * @return
	 */
	
	public static NewFurniture getFurniture(String name) {
		name=name.toLowerCase();
		if (name.equals("couch")) {
			return new Couch(false);
		} else if (name.equals("desk")) {
			return new Desk();
		} else if (name.equals("light")) {
			return new Light();
		}  else if (name.equals("television")) {
			return new Television();
		} else { //Invalid selection
			System.out.println("Invalid furniture selection");
			return null;
		}

	}
	
	/**
	 * This method determines if a new room, r, overlaps with existing rooms in the house.  It returns
	 * false if this room does overlap.
	 * @param r
	 * @return
	 */
	public static boolean roomOverlap(Room r) {
		Iterator i = house.rooms.iterator();
		while (i.hasNext()) {
			Room tempRoom = (Room) i .next();
			if (tempRoom.houseX+tempRoom.width>r.houseX && tempRoom.houseX<=r.houseX+r.houseY && tempRoom.houseY + tempRoom.height > r.houseY && tempRoom.houseY <= r.houseY + r.height) {
				return false;
			}
		}
		return true;
	}
	
}



