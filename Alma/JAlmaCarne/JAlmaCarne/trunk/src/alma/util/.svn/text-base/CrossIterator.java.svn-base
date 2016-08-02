package alma.util;

public class CrossIterator<T> implements BiIterator<T> {
	
	private BiIterator<T> i, j;
	private int icount=0, jcount=0;
	
	private T nextJ(){
		jcount++; return j.next();
	}
	
	private T nextI(){
		icount++; return i.next();
	}
	
	private T lastI(){
		icount--; return i.previous();
	}
	
	private T lastJ(){
		jcount--; return j.previous();
	}
	
	public CrossIterator(BiIterator<T> i, BiIterator<T> j){
		this.i = i; this.j=j;
	}

	public boolean hasPrevious() {
		return i.hasPrevious() || j.hasPrevious();
	}

	public T previous() {
		if((jcount >= icount || ! i.hasPrevious()) && j.hasPrevious()){
			return lastJ();
		} else if (i.hasPrevious()){
			return lastI();
		}
		
		throw new java.util.NoSuchElementException();
	}

	public boolean hasNext() {
		return i.hasNext() || j.hasNext();
	}

	public T next() {
		if((jcount < icount || ! i.hasNext()) && j.hasNext()){
			return nextJ();
		} else if (i.hasNext()){
			return nextI();
		}
		
		throw new java.util.NoSuchElementException();
	}

	public void remove() {
		throw new UnsupportedOperationException("CrossIterator.remove is not supported");
	}

}
