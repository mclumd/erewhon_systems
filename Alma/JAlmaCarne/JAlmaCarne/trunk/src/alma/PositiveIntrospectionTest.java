package alma;

import java.util.*;

import alma.util.*;
public class PositiveIntrospectionTest extends TestBase {
	public static void testBoundBound(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("+a(X) -> b(X)."));
		kb.add(parseString("+a(4)."));
		kb.step();
		kb.step();
		kb.step();
		Iterator<FormulaNode> iter = PositiveIntrospection.findAnswer(((Predicate)(parseString("pos_int(3,a(4))").getHead())), kb.history);
		assertTrue(iter.hasNext());
		iter = PositiveIntrospection.findAnswer(((Predicate)(parseString("pos_int(1,a(4))").getHead())), kb.history);
		assertFalse(iter.hasNext());
	}
	
	public static void testUnboundBound() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("+a(X) -> b(X)."));
		kb.add(parseString("+a(4)."));
		kb.step();
		kb.step();
		kb.step();
		kb.step();
		
		Iterator<FormulaNode> iter1 = PositiveIntrospection.findAnswer(((Predicate)(parseString("pos_int(X,a(4))").getHead())), kb.history);
		BiIterator<FormulaNode> iter = (BiIterator<FormulaNode>)iter1;
		assertTrue(iter.hasNext() && iter.next()!=null);
		assertTrue(parseString("pos_int(3,a(4))").getHead().equals(iter.next()));
		assertTrue(parseString("pos_int(4,a(4))").getHead().equals(iter.next()));
		assertFalse(iter.hasNext());
		assertTrue(iter.hasPrevious());
		assertTrue(parseString("pos_int(4,a(4))").getHead().equals(iter.previous()));
		assertTrue(parseString("pos_int(3,a(4))").getHead().equals(iter.previous()));
		assertTrue(parseString("pos_int(2,a(4))").getHead().equals(iter.previous()));
		assertFalse(iter.hasPrevious());
	}

	public static void testBoundUnbound() {
		KnowledgeBase kb = new KnowledgeBase();
		Formula f1 = parseString("a(X) -> b(X).");
		Formula f2 = parseString("a(4).");
		kb.add(f1);
		kb.add(f2);
		kb.step();
		kb.step();
		kb.step();
		kb.step();
		
		Iterator<FormulaNode> iter1 = PositiveIntrospection.findAnswer(((Predicate)(parseString("pos_int(3,X)").getHead())), kb.history);
		BiIterator<FormulaNode> iter = (BiIterator<FormulaNode>)iter1;
		HashSet<FormulaNode> toCheck = new HashSet<FormulaNode>();
		while(iter.hasNext()){
			toCheck.add(iter.next());
		}
		assertTrue(toCheck.contains(parseString("pos_int(3," + f1 + ")").getHead()));
		assertTrue(toCheck.contains(parseString("pos_int(3," + f2 + ")").getHead()));
	}

}
	