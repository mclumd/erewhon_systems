package NewHouse;

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;
import java.util.Iterator;


public class DrawHouse extends JPanel {
	Person p;
	House house;
	public static Image personl, personr;
	Image person, floor, top, bottom, left, right, topleft, topright, bottomleft, bottomright, couchl, couchr, desk, deskon, tv, tvon, leftdoor, rightdoor, topdoor, bottomdoor;
	JPanel hPanel;
	Dimension size;
	boolean createPerson;
	
	
	public DrawHouse(boolean cp) {
		p=null;
		house=null;
		createPerson=cp;
	}
	
	public void loadHouse() {
		house = House.SINGLETON();
		p = new Person("Mike"); //Needs to be changed
		Room nw = new Room(5, 5, 5, 0, "Northwest Corridor");
		nw.addFurniture(new Desk(new Light()), 1, 1);
		nw.addFurniture(new Desk(new Light()), 3, 2);
		nw.addFurniture(new Door("Northeast Corridor"), 0, 2);
		Room ne = new Room(5, 5, 0, 0, "Northeast Corridor");
		ne.addFurniture(new Desk(new Light()), 1, 1);
		ne.addFurniture(new Desk(new Light()), 4, 2);
		ne.addFurniture(new Door("Northwest Corridor"), 4, 2);
		Room sh = new Room(10, 5, 0, 5, "South Hallway");
		sh.addFurniture(new Desk(new Light()), 2, 2);
		sh.addFurniture(new Door("Northeast Corridor"), 2, 0);
		sh.addFurniture(new Door("Northwest Corridor"), 7, 0);
		sh.addFurniture(new Television(), 5, 1);
		sh.addFurniture(new Couch(true), 4, 2);
		sh.addFurniture(new Couch(false), 6, 2);
		nw.addFurniture(new Door("South Hallway"), 2, 4);
		ne.addFurniture(new Door("South Hallway"), 2, 4);
		house.addRoom(nw);
		house.addRoom(ne);
		house.addRoom(sh);
		
		/* Set the coordinates of the person in the northwest room */
		//This is old code, Alfred will now create a person in the house
		if (createPerson) { //If you create a person or not
			p.room=ne;
			p.x=2;
			p.y=2;
			p.destTile = new Tile(p.room, 2, 2);
			System.out.println(p);
			house.addPerson(p);
		}
		
		/* Load all of the various images */
		floor = Toolkit.getDefaultToolkit().getImage("floor.gif");
		top = Toolkit.getDefaultToolkit().getImage("top.gif");
		bottom = Toolkit.getDefaultToolkit().getImage("bottom.gif");
		left = Toolkit.getDefaultToolkit().getImage("left.gif");
		right = Toolkit.getDefaultToolkit().getImage("right.gif");
		topleft = Toolkit.getDefaultToolkit().getImage("topleft.gif");
		topright = Toolkit.getDefaultToolkit().getImage("topright.gif");
		bottomleft = Toolkit.getDefaultToolkit().getImage("bottomleft.gif");
		bottomright = Toolkit.getDefaultToolkit().getImage("bottomright.gif");
		desk = Toolkit.getDefaultToolkit().getImage("desk.gif");
		deskon = Toolkit.getDefaultToolkit().getImage("deskon.gif");
		personr = Toolkit.getDefaultToolkit().getImage("personr.gif");
		personl = Toolkit.getDefaultToolkit().getImage("personl.gif");
		leftdoor = Toolkit.getDefaultToolkit().getImage("leftdoor.gif");
		rightdoor = Toolkit.getDefaultToolkit().getImage("rightdoor.gif");
		topdoor = Toolkit.getDefaultToolkit().getImage("topdoor.gif");
		bottomdoor = Toolkit.getDefaultToolkit().getImage("bottomdoor.gif");
		tv = Toolkit.getDefaultToolkit().getImage("tvoff.gif");
		tvon = Toolkit.getDefaultToolkit().getImage("tvon.gif");
		couchl = Toolkit.getDefaultToolkit().getImage("couchl.gif");
		couchr = Toolkit.getDefaultToolkit().getImage("couchr.gif");
		
		
		person=personr;
		
		drawHouse();
	}
	public void drawHouse() {
		try {
			JFrame frame = new JFrame("House");
			frame.setContentPane(this);
			frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			size = new Dimension(500, 500);
			//frame.setResizable(false);
			
			JPanel hPanel = new JPanel(); //House Panel
			/* Add a mouse listener so you can click the form and move the guy around */
			java.awt.event.MouseListener m = new java.awt.event.MouseListener() {
				public void mouseClicked(MouseEvent e) {
					int x = e.getX();
					int y = e.getY();
					x = x / 40;
					y = y / 40;
					
					
					if (e.getButton() == MouseEvent.BUTTON1) { //Left click, move to the tile
						
					
						if (x<p.destTile.getRoom().houseX || x>=p.destTile.getRoom().houseX + p.destTile.getRoom().width || y<p.destTile.getRoom().houseY || y>=p.destTile.getRoom().houseY + p.destTile.getRoom().height) { //Out of bounds of the room
							int hX, hY; //Positions of the clicks in the house
							//hX=p.room.houseX+x;
							//hY=p.room.houseY+y;
							Iterator i = house.rooms.iterator();
							while (i.hasNext()) {
								Room tempRoom = (Room) i.next();
								/* Is the new click within another room in the house? */
								if (x >= tempRoom.houseX && x < tempRoom.houseX + tempRoom.width && y>=tempRoom.houseY && y<tempRoom.houseY + tempRoom.height)  {
									//The click is within this other room in the house
									Room oldRoom = p.room; //Save the old room in case you can't get there
									
									/* Add code for traveling to the door here */
									
									Tile tempTile = oldRoom.getDoorTile(tempRoom.name);
								
									if (tempTile!=null) { //Found a door to that room
										//Move the person to the door
										
										boolean toDoor = p.addListToQueue(p.destTile.getRoom().findPathInRoom(p.destTile.getX(), p.destTile.getY(), tempTile.getX(), tempTile.getY()));
										//Now move the person to the tile in the new room
										//Start at the door for the room
										Tile secDoorTile = tempRoom.getDoorTile(oldRoom.name);
										boolean toRoom = p.addListToQueue(tempRoom.findPathInRoom(secDoorTile.getX(), secDoorTile.getY(), x-tempRoom.houseX, y-tempRoom.houseY));
										
										//Update where you'll end up
										if (toRoom==true) {
											p.destTile = new Tile(tempRoom, x-tempRoom.houseX, y-tempRoom.houseY);
											
										} else if (toDoor==true) {
											p.destTile = new Tile (p.room, tempTile.getX(), tempTile.getY());
										}
										
										
										repaint();
										break;
									
									} else { //You are in a room but there is no door to that room
										break;
									}
								}
							}
						} else {
							boolean canGet = p.addListToQueue(p.room.findPathInRoom(p.destTile.getX(), p.destTile.getY(), x-p.room.houseX, y-p.room.houseY));
							if (canGet) {
								p.destTile = new Tile(p.room, x-p.room.houseX, y-p.room.houseY); //Update where the person will be at the end of his movement
							}
							//p.navigateTo(x-p.room.houseX, y-p.room.houseY);
							//System.out.println("click");
							repaint();
						}
					} else { //Right mouse click, interact with nearby furniture
						/* Check to see if you're in the bounds of the current room */
						if (x >= p.room.houseX && x < p.room.houseX + p.room.width && y>= p.room.houseY && y< p.room.houseY + p.room.height)  {
							if (p.room.grid[x-p.room.houseX][y-p.room.houseY]!=null) { //Furniture actually exists where you clicked
								/* Check that you clicked within one square of the person */
								if (Math.abs((x-p.room.houseX) - p.x) + Math.abs((y-p.room.houseY) - p.y) <= 1) {
									System.out.println(p.room.grid[x-p.room.houseX][y-p.room.houseY].furniture.toggleFurniture());
									repaint();
								}
							}
						}
					}
					
				}
				public void mouseEntered(MouseEvent e) {
					
				}
				public void mouseExited(MouseEvent e) {

				}
				public void mousePressed(MouseEvent e) {

				}
				public void mouseReleased(MouseEvent e) {

				}
			};

			
			/* Add a timer to redraw the people as he travels do these new rooms */
			Timer timer = new Timer(500, new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					Iterator i = house.getPersonIterator();
					if (i!=null) {
						while (i.hasNext()) {
							Person tempPerson=(Person) i.next();
							if (tempPerson.hasAnotherMove()) { //If there's a move to make in the queue
								Tile tempTile = tempPerson.getFromMoveQueue();
								if (tempTile.getRoom()!=tempPerson.room) {
									tempPerson.room=tempTile.getRoom();
								}
								
								//Update the picture of the person:
								if (tempTile.getX()<tempPerson.x) {
									tempPerson.assignFrame(personl);
								} else {
									tempPerson.assignFrame(personr);
								}
								tempPerson.navigateTo(tempTile.getX(), tempTile.getY()); //Change the person's position to the new location
								
								
								repaint(); //Update the graphics
							}
						}
					}
				}
			});
			timer.start();
			
			
			frame.getContentPane().add(hPanel);
			frame.getContentPane().addMouseListener(m);
			
			
			frame.pack();
			frame.show();
			
		} catch (Exception e) {
			//Do nothing for the moment
		}
	}
	public void paint(Graphics g) {
		updateGraphics(g);
	}
	public void repaint(Graphics g) {
		updateGraphics(g);
	}
	/**
	 * This draws all of the graphics for the house
	 * @param g
	 */
	public void updateGraphics(Graphics g) {
		for (int i=0; i<house.rooms.size(); i++) { //Loop through all of the rooms in the house
			Room tempRoom = (Room) house.rooms.get(i);
			JPanel rPanel = new JPanel();
			rPanel.setLayout(new GridLayout(tempRoom.grid.length, tempRoom.grid[0].length));
			
			//Loop through each element in the room and draw the appropriate image
			for (int x=0; x<tempRoom.grid.length; x++) {
				for (int y=0; y<tempRoom.grid[0].length; y++) {
					NewFurniture tempF = tempRoom.grid[x][y].furniture;
					/* Draw the background room */
					if (x==0) { //A left piece
						if (y==0) { //Draw a top left corner piece
							g.drawImage(topleft, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
						} else if (y==tempRoom.grid[0].length-1) { //Draw a bottom left corner piece
							g.drawImage(bottomleft, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
						} else { //Draw a left wall
							g.drawImage(left, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
						}
					} else if (x==tempRoom.grid.length-1) {
						if (y==0) { //Draw a top right corner piece
							g.drawImage(topright, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
						} else if (y==tempRoom.grid[0].length-1) { //Draw a bottom right corner piece
							g.drawImage(bottomright, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
						} else { //Draw a right wall
							g.drawImage(right, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
						}
					} else if (y==0) { //Top row of room
						//Draw a top wall
						g.drawImage(top, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
					} else if (y==tempRoom.grid[0].length-1) { //Bottom row of room
						//Draw a bottom wall
						g.drawImage(bottom, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
					} else { //Not a corner peice, draw a floor
						g.drawImage(floor, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);	
					}
					/* Draw the furniture on top of the room */
					if (tempF!=null) { //An actual piece of furniture
						if (tempF instanceof Door) { //Draw a door depending on where it's located
							if (x==0) {
								g.drawImage(leftdoor, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);	
							} else if (x==tempRoom.grid.length-1) {
								g.drawImage(rightdoor, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							} else if (y==0) {
								g.drawImage(topdoor, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							} else {
								g.drawImage(bottomdoor, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							}
							
						}
						else if (tempF instanceof Desk) {
							Desk tempDesk = (Desk) tempF;
							if (tempDesk.getState().equals("On")) { //light on
								g.drawImage(deskon, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							} else { //light off
								g.drawImage(desk, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							}
						}
						else if (tempF instanceof Television) {
							Television tempTV = (Television) tempF;
							if (tempTV.getState().equals("On")) { //TV On
								g.drawImage(tvon, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							} else { //TV Off
								g.drawImage(tv, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							}
						}
						else if (tempF instanceof Couch) {
							Couch tempC = (Couch) tempF;
							if (tempC.getState().equals("Left")) { //Couch to the left
								g.drawImage(couchl, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							} else { //Couch to the right
								g.drawImage(couchr, (x+tempRoom.houseX)*40, (y+tempRoom.houseY)*40, this);
							}
						}
					}
				} //Y for loop
			} //X for loop
		} //room for loop
		Iterator i = house.getPersonIterator();
		if (i!=null) {
			while (i.hasNext()) {
				Person tempPerson = (Person) i.next(); 
				g.drawImage(tempPerson.getFrame(), (tempPerson.x+tempPerson.room.houseX)*40, (tempPerson.y+tempPerson.room.houseY)*40, this);
			}
		}
		
		
	}
	public Dimension getPreferredSize() {
		return size;
	}
	
}
