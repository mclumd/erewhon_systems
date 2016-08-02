package alma.util;
import alma.*;
import java.util.*;

import alma.Formula;
import alma.TimeConstant;

public class DoublyLinkedListTest extends TestBase {
	
	public static void testAddition(){
		DoublyLinkedList<Formula> list = new DoublyLinkedList<Formula>();
		ArrayList<Formula> al = new ArrayList<Formula>();
		
		int r = 0;
		for(Integer i =0;i<40;i++) {
			r = (int)Math.random()*100;
			list.add(new Formula(new TimeConstant(r)));
			al.add(new Formula(new TimeConstant(r)));			
		}
		
		boolean sameList = true;
		BiIterator<Formula> iter1 = list.biIterator();
		ListIterator<Formula> liter1 = al.listIterator();

		while(iter1.hasNext() || liter1.hasNext()) {
			sameList &= al.contains(iter1.next()) && list.contains(liter1.next());
		}
		assertTrue(sameList);
	}
	
	public static void testRemoval() {
		DoublyLinkedList<Formula> list = new DoublyLinkedList<Formula>();
		ArrayList<Formula> al = new ArrayList<Formula>();
		
		for(Integer i =0;i<20;i++) {
			list.add(new Formula(new TimeConstant(i)));
			al.add(new Formula(new TimeConstant(i)));			
		}
		
		assertTrue(list.size() == 20);
		BiIterator<Formula> iter = list.biIterator();
		ListIterator<Formula> liter = al.listIterator();
		int cntr = 0;
		while(iter.hasNext() && liter.hasNext() && cntr<10) {
			iter.next();
			iter.next();
			if(iter.hasNext())
			iter.remove();
			liter.next();
			liter.next();
			if(liter.hasNext())
			liter.remove();
			cntr+=1;
		}
		
		boolean sameList = true;
		BiIterator<Formula> iter1 = list.biIterator();
		ListIterator<Formula> liter1 = al.listIterator();

		while(iter1.hasNext() || liter1.hasNext()) {
			sameList &= al.contains(iter1.next()) && list.contains(liter1.next());
		}
		assertTrue(sameList);
		
	}
	
	public static void testAgain() {
		DoublyLinkedList<Formula> list = new DoublyLinkedList<Formula>();
		ArrayList<Formula> al = new ArrayList<Formula>();
		for(Integer i =0;i<20;i++) {
			list.add(new Formula(new TimeConstant(i+25)));
			al.add(new Formula(new TimeConstant(i+25)));			
		}
		BiIterator<Formula> iter2 = list.biIterator();
		ListIterator<Formula> liter2 = al.listIterator();

		while(iter2.hasNext() || liter2.hasNext()) {
			iter2.next(); liter2.next();
		}
		int cntr = 0;
		while(iter2.hasPrevious() && liter2.hasPrevious() && cntr<5) {
			iter2.previous();
			if(iter2.hasPrevious())
			iter2.previous();
			iter2.remove();
			liter2.previous();
			if(liter2.hasPrevious())
			liter2.previous();
			liter2.remove();
			cntr+=1;
		}
		boolean sameList = true;
		while(iter2.hasNext() && liter2.hasNext()) {
			sameList &= al.contains(iter2.next()) && list.contains(liter2.next());
		}
		assertTrue(sameList);
	}
	
	
	public static void testIterators() {
		DoublyLinkedList<Formula> list = new DoublyLinkedList<Formula>();
		for(Integer i =0;i<20;i++) {
			list.add(new Formula(new TimeConstant(i)));
		}
		
		assertTrue(list.size() == 20);
		BiIterator<Formula> iter = list.biIterator();
		while(iter.hasNext()) {
			list.remove(iter.next());
			if(iter.hasNext())
				assert(((TimeConstant)(iter.next().getHead())).toLong() % 2 == 1);
		}

		for(Integer i =0;i<20;i++) {
			list.add(new Formula(new TimeConstant(i)));
		}
		System.out.println(list);
		
		BiIterator<Formula> iter2 = list.biIterator();
		iter2.next();
		for(int i=1;i<5;i++) list.remove(new Formula(new TimeConstant(i)));
		System.out.println(list);

		System.out.println(iter2.next());
		System.out.println(iter2.next());
		System.out.println(iter2.previous());
		System.out.println(iter2.previous());
		System.out.println(iter2.previous());
		
		iter2 = list.biIterator();
		for(int i=0;i<20;i++) list.remove(new Formula(new TimeConstant(i)));
		System.out.println(iter2.hasNext());
		
		Formula f = new Formula(new TimeConstant(3));
		Formula f2 = new Formula(new SymbolicConstant("hello"));
		Formula f3 = new Formula(new TimeConstant(3));

		System.out.println(f.hashCode()+" " +f2.hashCode()+" "+f3.hashCode());
		

}
	
}
