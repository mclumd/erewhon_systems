package alma.util;

import java.util.ListIterator;

public class ListBiIterator<T> implements BiIterator<T> {
	
	ListIterator<T> i;
	
	public ListBiIterator(ListIterator<T> iter){
		i = iter;
	}

	public boolean hasPrevious() {
		return i.hasPrevious();
	}

	public T previous() {
		return i.previous();
	}

	public boolean hasNext() {
		return i.hasNext();
	}

	public T next() {
		return i.next();
	}

	public void remove() {
		i.remove();
	}

}
