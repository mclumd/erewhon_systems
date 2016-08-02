package alma.callfile;

import alma.FormulaNode;
import java.util.*;

public class DoubleIterator<T> implements BiIterator<T> {
	BiIterator<T> i1;
	BiIterator<T> i2;
	boolean first;
	
	public DoubleIterator(BiIterator i, BiIterator j){
		i1 = i;
		i2 = j;
		first = true;
	}
	
	public boolean hasPrevious() {
		return i1.hasPrevious() || i2.hasPrevious();
	}
	public T previous() {
		if(!first){
			if(!i2.hasPrevious()){
				first = true;
				return previous();
			}
			return i2.previous();
		} else {
			return i1.previous();
		}
	}
	public boolean hasNext() {
		return i1.hasNext() || i2.hasNext();
	}
	public T next() {
		if(first){
			if(!i1.hasNext()){
				first = false;
				return next();
			}
			return i1.next();
		} else {
			return i2.next();
		}
	}
	public void remove() {
		throw new UnsupportedOperationException("Remove not implemented for DoubleIterator");
	}
}
