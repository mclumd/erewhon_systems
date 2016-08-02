package alma.util;

public class SingleIterator<T> implements BiIterator<T> {
	
	T toReturn;
	boolean returned;
	
	public SingleIterator(T toReturn){
		this.toReturn = toReturn;
	}

	public boolean hasPrevious() {
		return returned;
	}

	public T previous() {
		if(!hasPrevious()) throw new java.util.NoSuchElementException();
		returned = false;
		return toReturn;
	}

	public boolean hasNext() {
		return !returned;
	}

	public T next() {
		if(!hasNext()) throw new java.util.NoSuchElementException();
		returned = true;
		return toReturn;
	}

	public void remove() {
		throw new UnsupportedOperationException();
	}

}