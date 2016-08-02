package alma.util;

import java.util.*;

/**
 * Percy here: refactoring the DoublyLinkedList to remove compiler errors.
 * The purpose of this class is to provide an iterator that IS NOT fail-fast.
 * We need more robust iterators in this program.
 * 
 * @author Joey
 *
 * @param <E>
 */

public class DoublyLinkedList<E> extends AbstractCollection<E> implements Cloneable {

	private class DoublyLinkedListIterator implements BiIterator<E> {
		Node<E> next; 
		Node<E> prev;
		boolean nextCalled = false;
		public DoublyLinkedListIterator(Node<E> inithead, DoublyLinkedList<E> toIterover) {
			next = inithead;
			prev = null;
		}
		
		public boolean hasPrevious() {
			while(prev!= null && prev.isDeleted)
				prev= prev.prev;
			return prev!=null && prev.data!=null;
		}

		public E previous() {
			while(prev!= null && prev.isDeleted)
				prev= prev.prev;
			nextCalled = false;
			next = prev;
			prev = prev.prev;
			return next.data;
		}

		public boolean hasNext() {
			while(next!= null && next.isDeleted)
				next = next.next;
			return next!=null && next.data!=null;
		}

		public E next() {
			while(next!=null && next.isDeleted)
				next = next.next;
			nextCalled = true;
			prev = next;
			next = next.next;
			return prev.data;
		}

		public void remove() {
			Node<E> newprev = (nextCalled? prev.prev : next.next);
			DoublyLinkedList.this.remove(nextCalled?prev.data:next.data);
			if(nextCalled) 
				prev = newprev;
			else
				next = newprev;
			
		}
		
	}

	private static class Node<T> implements Cloneable {
		T data = null;
		Node<T> prev = null;
		Node<T> next = null;
		boolean isDeleted = false;
		public Node (T d, Node<T> p, Node<T> n) {
			data = d; prev = p; next = n;
		}
		
		public String toString() {
			return "-"+data+"=";
		}
	}
	
	Node<E> head = new Node<E>(null,null,null);
	Node<E> tail = head;
	int size = 0;
	
	public boolean add(E o) {
		if(size == 0) {
			head = new Node<E>(null,null,null);
			head.data = o;
			tail = head;
		}
		else {
			Node<E> tba = new Node<E>(o,tail,null);
			tail.next = tba;
			tail = tba;
		}
		size+=1;
		return true;
	}

	public boolean addAll(Collection<? extends E> c) {
		boolean toReturn = true;
			for(E thing:c) {
				toReturn |= add(thing);
			}
		return toReturn;
	}

	public void clear() {
		head = null;
		size = 0;
	}

	public boolean contains(Object o) {
		Node mod = head;
		while(mod != null) {
			if(mod.data.equals(o))
				return true;
			mod = mod.next;
		}
		return false;
	}

	public boolean containsAll(Collection<?> c) {
		boolean toReturn = false;
		for(Object e : c) {
			toReturn |= contains(e);
		}
		return toReturn;
	}

	public boolean isEmpty() {
		return size==0;
	}

	public Iterator<E> iterator() {
		return new DoublyLinkedListIterator(head,this);
	}
	
	public BiIterator<E> biIterator() {
		return new DoublyLinkedListIterator(head,this);
	}

	public boolean remove(Object o) {
		int s = size;
		
		Node<E> mod = head;
		while(mod != null) {
	
			if(mod.data!=null && mod.data.equals(o)) {
				mod.isDeleted = true;
				if(mod.prev == null && mod.next ==null) {
					head = null;
					tail = null;
				}
				else if(mod.prev == null) {
					mod.next.prev= null;
					head = mod.next;
				}
				else if(mod.next == null) {
					mod.prev.next = null;
					tail = mod.prev;
				}
				else {
					mod.prev.next = mod.next;
					mod.next.prev = mod.prev;
				}
				size -= 1;
			}
			mod = mod.next;
		}
		
		return size != s;
	}

	public boolean removeAll(Collection<?> c) {
		boolean toReturn = true;
		for(Object thing:c) {
			toReturn |= remove(thing);
		}
		return toReturn;
	}

	public boolean retainAll(Collection<?> c) {
		boolean toReturn = true;
		Node<?> mod = head;
		while(mod!=null)
			if(!c.contains(mod.data)) {
				toReturn |= remove(mod.data);
			}
		return toReturn;
	}

	public int size() {
		return size;
	}
/*
	public Object[] toArray() {
		Object[] array = new Object[size];
		Node mod = head;
		for(int i=0;i<size && mod!=null;i++) {
			array[i] = mod.data;
			mod = mod.next;
		}
		return array;
	}

	public <T> T[] toArray(T[] a) {
		throw new UnsupportedOperationException("Generic toArray not Supported");
	}*/
	
	public String toString() {
		String ans = "[["+head+tail+"]";
	//	String ans = "[";
		Node mod = head;
		while(mod != null) {
			if(mod.next == null)
				ans= ans+ mod.data;
			else
				ans= ans+ mod.data+", ";
			mod = mod.next;
		}
		ans = ans +"]";
		return ans;
	}

	public Object clone() {
		DoublyLinkedList<E> other = new DoublyLinkedList<E>();
		DoublyLinkedListIterator iter = (DoublyLinkedListIterator)biIterator();
		while(iter.hasNext()) {
			other.add(iter.next());
		}
		
		return other;
	}
	
}