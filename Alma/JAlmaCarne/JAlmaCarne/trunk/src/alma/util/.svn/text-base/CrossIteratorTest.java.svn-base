package alma.util;

import junit.framework.TestCase;

public class CrossIteratorTest extends TestCase {
	private static class Simple implements BiIterator<Integer>{
		int max;
		int min = 0;
		int current=0;
		public Simple(int max){
			this.max = max;
		}
		
		public Simple(int max, int start){
			this(max);
			current = min = start;
		}
		
		public boolean hasPrevious() {
			return current>min;
		}
		public Integer previous() {
			return --current;
		}
		public boolean hasNext() {
			return current <= max;
		}
		public Integer next() {
			return current++;
		}
		public void remove() {
			throw new UnsupportedOperationException();
		}
	}
	
	/**
	 * Make Sure the testing framework is good...
	 *
	 */
	public static void testSimple(){
		Simple i = new Simple(3);
		assertTrue(i.next() == 0);
		assertTrue(i.previous() == 0);
		assertFalse(i.hasPrevious());
		assertTrue(i.next() == 0);
		assertTrue(i.next() == 1);
		assertTrue(i.next() == 2);
		assertTrue(i.next() == 3);
		assertFalse(i.hasNext());
		assertTrue(i.previous() == 3);
	}
	
	public static void testSimple2(){
		Simple i = new Simple(5, 2);
		assertFalse(i.hasPrevious());
		assertTrue(i.hasNext());
		assertTrue(i.next() == 2);
		assertTrue(i.hasPrevious());
		assertTrue(i.previous() == 2);
		assertFalse(i.hasPrevious());
		assertTrue(i.next() == 2);
		assertTrue(i.next() == 3);
		assertTrue(i.next() == 4);
		assertTrue(i.next() == 5);
		assertFalse(i.hasNext());
		assertTrue(i.previous() == 5);
	}
	
	/**
	 * Simple Test Case: both inner iterators have the same length.
	 *
	 */
	public static void testCrossSimilar(){
		Simple i1 = new Simple(3);
		Simple i2 = new Simple(3);
		CrossIterator<Integer> i = new CrossIterator<Integer>(i1, i2);
		
		assertFalse(i.hasPrevious());
		assertTrue(i.next() == 0);
		assertTrue(i.next() == 0);
		assertTrue(i.hasPrevious());
		assertTrue(i.previous() == 0);
		assertTrue(i.previous() == 0);
		assertFalse(i.hasPrevious());
		
		for(int j=0; j<=3; j++){
			assertTrue(i.hasNext());
			assertTrue(i.next() == j);
			assertTrue(i.next() == j);
			assertTrue(i.hasPrevious());
		}
		
		assertFalse(i.hasNext());
		assertTrue(i.previous()==3);
		assertTrue(i.hasNext());
	}
	
	/**
	 * Simple test case, make sure 2nd thing is getting called correctly...
	 */
	
	public static void testCrossSimilar2(){
		Simple i1 = new Simple(3);
		Simple i2 = new Simple(5, 2);
		CrossIterator<Integer> i = new CrossIterator<Integer>(i1, i2);
		
		assertFalse(i.hasPrevious());
		assertTrue(i.next() == 0);
		assertTrue(i.next() == 2);
		assertTrue(i.hasPrevious());
		assertTrue(i.previous() == 2);
		assertTrue(i.previous() == 0);
		assertFalse(i.hasPrevious());
		
		for(int j=0; j<=3; j++){
			assertTrue(i.hasNext());
			assertTrue(i.next() == j);
			assertTrue(i.next() == j+2);
			assertTrue(i.hasPrevious());
		}
		
		assertFalse(i.hasNext());
		assertTrue(i.previous()==5);
		assertTrue(i.hasNext());
	}
	
	/**
	 * Different Lengths
	 *
	 */
	public static void testCrossLengths(){
		Simple i1 = new Simple(1);
		Simple i2 = new Simple(3);
		
		CrossIterator<Integer> i = new CrossIterator<Integer>(i1, i2);
		assertTrue(i.hasNext());
		assertFalse(i.hasPrevious());
		
		assertTrue(i.next() == 0);
		assertTrue(i.hasNext());
		assertTrue(i.hasPrevious());
		
		assertTrue(i.next() == 0);
		assertTrue(i.hasNext());
		assertTrue(i.hasPrevious());
		
		assertTrue(i.next() == 1);
		assertTrue(i.hasNext());
		assertTrue(i.hasPrevious());
		
		assertTrue(i.next() == 1);
		assertTrue(i.hasNext());
		assertTrue(i.hasPrevious());
		
		assertTrue(i.next() == 2);
		assertTrue(i.hasNext());
		assertTrue(i.hasPrevious());
		
		assertTrue(i.next() == 3);
		assertFalse(i.hasNext());
		assertTrue(i.hasPrevious());
	}
	
	private static Simple[] makeMany(int max, int length){
		Simple[] toReturn= new Simple[length];
		for(int i=0 ;i<toReturn.length; i++){
			toReturn[i] = new Simple(max);
		}
		
		return toReturn;
	}
	
	private static CrossIterator<Integer> fromMany(Simple[] toMake){
		CrossIterator<Integer> iter = new CrossIterator<Integer>(toMake[0], toMake[1]);
		for(int i=2; i<toMake.length; i++){
			iter = new CrossIterator<Integer>(iter, toMake[i]);
		}
		
		return iter;
	}
	
	private static int getCount(BiIterator i){
		int count = 0;
		while(i.hasNext()){
			count++; i.next();
		}
		
		return count;
	}
	
	/**
	 * Test the magic of the recursive case... unpredictable behavior so
	 * this only tests the length of the iterator. This only tests one "tree", the
	 * "fromMany" function only creates one kind of Tree... so a randomized tree
	 * generator would be useful for a more complete test.
	 *
	 */
	public static void testComplex(){
		CrossIterator<Integer> iter = fromMany(makeMany(3, 4)); //Makes a cross iterator from 4 Simples with max 3
		assertTrue(getCount(iter) == 16);
		
		java.util.Random rnd = new java.util.Random();
		
		for(int i=0; i<30; i++){
			int r1 = rnd.nextInt(5);
			int r2 = rnd.nextInt(5)+2;
			assertTrue(getCount(fromMany(makeMany(r1, r2))) == (r1+1) * r2);
		}
		
		byte[] randoms = new byte[100];
		rnd.nextBytes(randoms);
		
		int count = 0;
		Simple[] simples = new Simple[randoms.length];
		for(int i=0; i<randoms.length; i++){
			randoms[i] %= 20;
			randoms[i] = (byte) Math.abs(randoms[i]);
			simples[i] = new Simple(randoms[i]);
			count += randoms[i] + 1;
		}
		
		assertTrue(getCount(fromMany(simples)) == count);
		
	}
}
