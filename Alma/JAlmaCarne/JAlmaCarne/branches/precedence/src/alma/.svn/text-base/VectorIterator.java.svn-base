package alma;

import alma.callfile.BiIterator;
import java.util.*;

/**
 * The VectorIterator combines two countably infinite iterators
 * into a single countably infinite iterator. If the elements in
 * the two iterators are a1, a2, a3... and b1, b2, b3..., this class
 * returns (a1, b1), then (a1, b2), then (a2, b1), etc. etc.
 * 
 * @author percy
 *
 */

/*
 * Check for Bug: Does this work for finite lists?
 */
public class VectorIterator implements BiIterator{

	/**
	 * This class is defined recursively as either a pair of pairs, or a
	 * pair of Objects.
	 * @author percy
	 *
	 */
	public static class Pair{
		public Object o1;
		public Object o2;

		public Pair(Object a, Object b){
			o1 = a;
			o2 = b;
		}
		
		public Object[] flatten(){
			Object[] a1, a2;
			if (o1 instanceof Pair){
				a1 = ((Pair)o1).flatten();
			} else {
				a1 = new Object[1];
				a1[0] = o1;
			}
			
			if (o2 instanceof Pair){
				a2 = ((Pair)o2).flatten();
			} else {
				a2 = new Object[1];
				a2[0] = o2;
			}
			
			Object[] toReturn = new Object[a1.length + a2.length];
			for(int i = 0; i < a1.length ; i++){
				toReturn[i] = a1[i];
			}
			
			for(int i = a1.length; i< a2.length + a1.length; i++){
				toReturn[i] = a2[i - a1.length];
			}
			
			return toReturn;
		}
	}

	BiIterator i1;
	BiIterator i2;
	
	boolean direction = false;
	
	public VectorIterator(BiIterator i, BiIterator j){
		i1 = i;
		i2 = j;
	}

	public boolean hasNext() {
		if(direction){
			if(i1.hasNext()) return i2.hasPrevious() || i2.hasNext();
			if(i2.hasNext()) {
				if(!i1.hasPrevious()) return false;
				i2.next();
				boolean toReturn = i2.hasNext();
				i2.previous();
				return toReturn;
			}
			return false;
		} else {
			if(i2.hasNext()) return i1.hasPrevious() || i1.hasNext();
			if(i1.hasNext()){
				if(!i2.hasPrevious()) return false;
				i1.next();
				boolean toReturn = i1.hasNext();
				i1.previous();
				return toReturn;
			}
			return false;
		}
	//	return (i1.hasNext() && i2.hasPrevious()) || (i2.hasNext() && i1.hasPrevious());
	}

	/**
	 * Check for off by one errors!!!
	 */
	public Pair next() {
		Object next1;
		Object next2;
		if(direction){
			if(i1.hasNext()){
				next1 = i1.next();
			} else {
				i2.next();
				direction = !direction;
				return next();
			}
			if(i2.hasPrevious()){
				next2 = i2.previous();
			} else {
				direction = !direction;
				//System.out.println("Reverse!");
				return next();
			}
		} else {
			if(i2.hasNext()){
				next2 = i2.next();
			} else {
				i1.next();
				direction = !direction;
				return next();
			}
			if(i1.hasPrevious()){
				next1 = i1.previous();
			} else {
				direction = !direction;
				//System.out.println("Reverse!");
				return next();
			}
		}
		return new Pair(next1, next2);
	}

	public void remove() {
		throw new UnsupportedOperationException("Does not support Remove");
	}

	public boolean hasPrevious() {
		if(direction){
			if(! i1.hasPrevious()){
				i2.previous();
				boolean toReturn = i2.hasPrevious();
				i2.next();
				return toReturn;
			}
		}
		return i1.hasPrevious() || i2.hasPrevious();
	}

	public Pair previous() {
		Object last1;
		Object last2;
		if(direction){
			if(i1.hasPrevious()){
				last2 = i2.next();
				last1 = i1.previous();
			} else {
				i2.previous();
				direction = !direction;
				//System.out.println("Reverse!");
				return previous();
			}
		} else {
			if(i2.hasPrevious()){
				last1 = i1.next();
				last2 = i2.previous();
			} else {
				i1.previous();
				direction = !direction;
				//System.out.println("Reverse!");
				return previous();
			}
		}
		// TODO Auto-generated method stub
		return new Pair(last1, last2);
	}

}
