package alma;
import java.util.*;

public class ListSet<E> implements List<E>, Cloneable {
	private ArrayList<E> al = new ArrayList<E>();
	private HashSet<E> hs = new HashSet<E>();
	
	public boolean add(E o) {
		if(!hs.contains(o)) {
			return (al.add(o) & hs.add(o));
		}
		return false;
	}
	
	public void add(int index, E element) {
		if(!hs.contains(element)) {
			al.add(index,element);
		}
	}
	
	public boolean addAll(Collection<? extends E> c) {
		boolean answer = true;
		for(E e: c) {
			answer |= add(e);
		}
		return answer;
	}
	
	public boolean addAll(int index, Collection<? extends E> c) {
		int num = al.size();
		for(E e: c) {
			add(index,e);
		}
		return num == al.size();
	}
	
	public void clear() {
		al.clear();
		hs.clear();
	}
	
	public boolean contains(Object o) {
		return hs.contains(o);
	}
	
	public boolean containsAll(Collection<?> c) {
		return hs.containsAll(c);
	}
	
	public E get(int index) {
		return al.get(index);
	}
	
	public int indexOf(Object o) {
		return al.indexOf(o);
	}
	
	public boolean isEmpty() {
		return al.isEmpty();
	}
	
	public Iterator<E> iterator() {
		return al.iterator();
	}
	
	public int lastIndexOf(Object o) {
		return al.lastIndexOf(o);
	}
	
	public ListIterator<E> listIterator() {
		return al.listIterator();
	}
	
	public ListIterator<E> listIterator(int index) {
		return al.listIterator(index);
	}
	
	public boolean remove(Object o) {
		return (al.remove(o) & hs.remove(o));
	}
	
	public E remove(int index) {
		hs.remove(al.get(index));
		return al.remove(index);
	}
	
	public boolean removeAll(Collection<?> c) {
		return (al.removeAll(c) & hs.removeAll(c));
	}
	
	public boolean retainAll(Collection<?> c) {
		return (al.retainAll(c) & hs.retainAll(c));
	}
	
	public E set(int index, E element) {
		hs.remove(al.get(index));
		hs.add(element);
		return al.set(index,element);
	}
	
	public int size() {
		return al.size();
	}
	
	public List<E> subList(int fromIndex, int toIndex) {
		return al.subList(fromIndex, toIndex);
	}
	
	public Object[] toArray() {
		return al.toArray();
	}
	
	public <T> T[] toArray(T[] a) {
		return al.toArray(a);
	}

	public Object clone() {
		Object o = null;
		try { 
			o= super.clone();
			ListSet<E> other = (ListSet<E>) o;
			other.al = (ArrayList<E>) al.clone();
			other.hs = (HashSet<E>) hs.clone();
		} catch (CloneNotSupportedException e) {
			System.err.println("Cannot clone this ListSet");
		}
		return o;
	}
		
}
