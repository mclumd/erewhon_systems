package alma.callfile;

import java.util.Iterator;

import alma.util.*;
import alma.*;

public class CallInferenceRuleTest extends TestBase {
	public static void testGetCandidates1(){
		KnowledgeBase kb = new KnowledgeBase();

		Iterator<FormulaNode> iter = kb.getCandidates((Class)(Predicate.class), parseString("less(3,4)").getHead());
		assertTrue(iter.next().toString().equals("less(3,4)"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("less(5,3)").getHead());
		assertTrue(iter.hasNext() == false);
	}
	
	public static void testGetCandidates2(){
		KnowledgeBase kb = new KnowledgeBase();
		BiIterator iter = kb.getCandidates((Class)(Predicate.class), parseString("less(2,X)").getHead());
		assertTrue(iter.next().toString().equals("less(2,3)"));		
		assertTrue(iter.next().toString().equals("less(2,4)"));
		
		Iterator<FormulaNode> iter2 = kb.getCandidates((Class)(Predicate.class), parseString("less(2,X)").getHead());
		assertTrue(iter2.next().toString().equals("less(2,3)"));
		assertTrue(iter.next().toString().equals("less(2,5)"));

		assertTrue(iter.previous().toString().equals("less(2,5)"));
		assertTrue(iter.previous().toString().equals("less(2,4)"));
		assertTrue(iter.next().toString().equals("less(2,4)"));
		assertTrue(iter.previous().toString().equals("less(2,4)"));
		assertTrue(iter.previous().toString().equals("less(2,3)"));
		assertTrue(iter.hasPrevious() == false);
		
	}
	
	public static void testGetCandidates3(){
		KnowledgeBase kb = new KnowledgeBase();
		BiIterator iter = kb.getCandidates((Class)(Predicate.class), parseString("less(X,3)").getHead());
		assertTrue(iter.next().toString().equals("less(2,3)"));
		assertTrue(iter.next().toString().equals("less(1,3)"));

		assertTrue(iter.previous().toString().equals("less(1,3)"));
		assertTrue(iter.previous().toString().equals("less(2,3)"));
		assertTrue(iter.next().toString().equals("less(2,3)"));
		assertTrue(iter.next().toString().equals("less(1,3)"));
		assertTrue(iter.previous().toString().equals("less(1,3)"));
		assertTrue(iter.previous().toString().equals("less(2,3)"));
		assertTrue(iter.hasPrevious() == false);

	}
	
	//Note that the changes above are remembered
	public static void testGetCandidatesAll() {
		KnowledgeBase kb = new KnowledgeBase();
		Iterator<FormulaNode> iter = kb.getCandidates((Class)(Predicate.class), parseString("less(X,1)").getHead());
		assertTrue(iter.next().toString().equals("less(0,1)"));
		assertTrue(iter.next().toString().equals("less(-1,1)"));
		Iterator<FormulaNode> iter2 = kb.getCandidates((Class)(Predicate.class), parseString("less(X,1)").getHead());

		iter = kb.getCandidates((Class)(Predicate.class), parseString("less(4,X)").getHead());
		assertTrue(iter.next().toString().equals("less(4,5)"));
		assertTrue(iter.next().toString().equals("less(4,6)"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("less(2,3)").getHead());
		assertTrue(iter.next().toString().equals("less(2,3)"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("less(4,3)").getHead());
		assertTrue(!iter.hasNext());
		
		assertTrue(iter2.next().equals(parseString("less(0, 1)").getHead()));
	}
	
	public static void testCombine1() {
		KnowledgeBase kb = new KnowledgeBase();
		BiIterator<FormulaNode> iter = kb.getCandidates((Class)(Predicate.class), parseString("combine(x,\"a\",\"ba\")").getHead());
		assertTrue(iter.next().toString().equals("combine(\"b\",\"a\",\"ba\")"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("combine(\"b\",x,\"ba\")").getHead());
		assertTrue(iter.next().toString().equals("combine(\"b\",\"a\",\"ba\")"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("combine(\"b\",\"a\",x)").getHead());
		assertTrue(iter.next().toString().equals("combine(\"b\",\"a\",\"ba\")"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("combine(\"b\",\"a\",\"ba\")").getHead());
		assertTrue(iter.next().toString().equals("combine(\"b\",\"a\",\"ba\")"));
		assertTrue(!iter.hasNext() && iter.hasPrevious() && iter.previous().toString().equals("combine(\"b\",\"a\",\"ba\")"));
		iter = kb.getCandidates((Class)(Predicate.class), parseString("combine(\"b\",\"a\",\"ab\")").getHead());
		assertTrue(iter.hasNext() == false);
		
	}
	
}
