package alma.callfile;

import alma.FormulaNode;
import java.util.Iterator;

/**
 * BiIterators are iterators that may or may not be countably infinite. So be sure to
 * keep this fact in mind when using stuff that return BiIterators.
 * 
 */

public interface BiIterator<T> extends Iterator<T> {
	public boolean hasPrevious();
	public T previous();
}
