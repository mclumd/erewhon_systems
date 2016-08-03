/*
 * Created on Jun 9, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package NewHouse;

import java.util.*;

/**
 * This class handles the data receieved from Alfred and will also send
 * data back.  It is used to move the person around the house and to
 * interact with various objects
 */
public class DataHandler {

	House h;
	Person curPerson;
	public DataHandler() {
		
	}
	public String processData(String data) {
		if (data.substring(0, 6).equals("person")) { //Update the currently selected person
			String temp = data.substring(7, data.length());
			Person tempPerson = getPerson(temp);
			if (temp==null) {
				return "BAD";
			} else {
				return "GOOD";
			}
		}
		
		if (data.substring(0,4).equals("move")) { //Move the person
			String temp = data.substring(5, data.length());
			String[] split = temp.split(",");
			String pName = split[0]; //What person are you moving?
			Person tempPerson = getPerson(pName);
			if (temp==null) {
				return "BAD";
			}
			String rName = split[1]; //What room are you in?
			Room tempRoom = getRoom(rName);
			if (tempRoom==null) {
				return "BAD";
			}
			int x = Integer.parseInt(split[1]);
			int y = Integer.parseInt(split[2]);
			
			//This needs to be changed to the current navigation code
			curPerson.navigateTo(x,y);
			return "GOOD";
		}
		if (data.substring(0,6).equals(("toggle"))) {
			String dir = data.substring(7, data.length());
			if (dir.equals("UP")) {
				curPerson.toggleFurniture(Person.UP);
			} else if (dir.equals("DOWN")) {
				curPerson.toggleFurniture(Person.DOWN);
			} else if (dir.equals("LEFT")) {
				curPerson.toggleFurniture(Person.LEFT);
			} else if (dir.equals("RIGHT")) {
				curPerson.toggleFurniture(Person.RIGHT);
			} else { //Unexpected direction
				return "BAD";
			}
			return "GOOD";
		}
		return "BAD";
	}
	public Person getPerson(String name) {
		Iterator i = h.persons.iterator();
		while (i.hasNext()) {
			Person tempPerson = (Person) i.next();
			if (tempPerson.name.equals(name)) {
				return tempPerson;
			}
		}
		return null; //Nothing found
	}
	public Room getRoom(String name) {
		Iterator i = h.rooms.iterator();
		while (i.hasNext()) {
			Room tempRoom = (Room) i .next();
			if (tempRoom.name.equals(name)) {
				return tempRoom;
			}
		}
		return null;
	}
}
