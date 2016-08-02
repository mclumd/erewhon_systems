package alma.util;
import java.util.*;


public class ListSet<E> implements Collection<E>, Cloneable {
	private DoublyLinkedList<E> ll = new DoublyLinkedList<E>();
	private HashSet<E> hs = new HashSet<E>();
	
	public boolean add(E o) {
		if(!hs.contains(o)) {
			return (ll.add(o) & hs.add(o));
		}
		return false;
	}
	
	public boolean addAll(Collection<? extends E> c) {
		boolean answer = true;
		for(E e: c) {
			answer |= add(e);
		}
		return answer;
	}
	
	public void clear() {
		ll.clear();
		hs.clear();
	}
	
	public boolean contains(Object o) {
		return hs.contains(o);
	}
	
	public boolean containsAll(Collection<?> c) {
		return hs.containsAll(c);
	}
	
	public boolean isEmpty() {
		return ll.isEmpty();
	}
	
	public Iterator<E> iterator() {
		return ll.iterator();
	}
	
	public BiIterator<E> biIterator() {
		return ll.biIterator();
	}
	
	public boolean remove(Object o) {
		return (ll.remove(o) && hs.remove(o));
	}
	
	public boolean removeAll(Collection<?> c) {
		return (ll.removeAll(c) && hs.removeAll(c));
	}
	
	public boolean retainAll(Collection<?> c) {
		return (ll.retainAll(c) && hs.retainAll(c));
	}
	
	public int size() {
		return ll.size();
	}
	
	public Object[] toArray() {
		return ll.toArray();
	}
	
	public <T> T[] toArray(T[] a) {
		return ll.toArray(a);
	}

	public Object clone() {
		Object o = null;
		try { 
			o= super.clone();
			ListSet<E> other = (ListSet<E>) o;
			other.ll = (DoublyLinkedList<E>) ll.clone();
			other.hs = (HashSet<E>) hs.clone();
		} catch (CloneNotSupportedException e) {
			System.err.println("Cannot clone this ListSet");
		}
		return o;
	}
	
	public String toString(){
		StringBuilder sb = new StringBuilder();
		sb.append('[');
		BiIterator<E> iter = ll.biIterator(); 
		while(iter.hasNext()) {
			sb.append(iter.next());
			if(iter.hasNext())
				sb.append(", ");
		}
			
		sb.append(']');
		return sb.toString();
	}
		
}
