package alma.util;
import java.util.NoSuchElementException;

/**
 * Just an iterator that is always empty
 * @author percy
 *
 * @param <T>
 */
public class EmptyIterator<T> implements BiIterator<T> {
		public boolean hasPrevious() {
			return false;
		}

		public T previous() {
			throw new NoSuchElementException();
		}

		public boolean hasNext() {
			return false;
		}

		public T next() {
			throw new NoSuchElementException();
		}

		public void remove() {
			throw new UnsupportedOperationException();
		}
}
