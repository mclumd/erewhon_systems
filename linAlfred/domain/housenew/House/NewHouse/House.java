package NewHouse;

import java.util.*;
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
public class House {
	public ArrayList rooms;
	public ArrayList persons;
	public static House SINGLETON() {
		return new House();
	}
	private House() {
		persons = new ArrayList();
		rooms=new ArrayList();
	}
	public void addRoom(Room r) {
		rooms.add(r);
	}
	public void removeroom(Room r) {
		rooms.remove((Object) r);
	}
	public void addPerson(Person p) {
		persons.add(p);
	}
	public void removePerson(String name) {
		Iterator i = persons.iterator();
		while (i.hasNext()) { //Go through each person
			Person tempPerson = (Person) i.next();
			if (tempPerson.name.equals(name)) { //If this is the person, remove him
				i.remove();
				break;
			}
		}
	}
	public Iterator getPersonIterator() {
		if (persons!=null) {
			return persons.iterator();
		} else {
			return null;
		}
	}
}
