package alma;

import java.util.*;

import alma.util.*;
public class FormulaIDTest extends TestBase {
	public static void testBoundBound(){
		KnowledgeBase kb = new KnowledgeBase();
		Formula testform = parseString("a(X) -> b(X).");
		kb.add(testform);
		kb.add(parseString("+a(4)."));
		kb.step();
		kb.step();
		kb.step();
		
		BiIterator<FormulaNode> iter = FormulaID.findAnswer(((Predicate)(parseString("formulaID("+testform.getHead()+","+new TimeConstant(testform.getID())+")").getHead())), kb);
		assertTrue(iter.next().equals(((Predicate)(parseString("formulaID("+testform.getHead()+","+new TimeConstant(testform.getID())+")").getHead()))));
		assertTrue(iter.hasNext() == false);
		assertTrue(iter.previous().equals(((Predicate)(parseString("formulaID("+testform.getHead()+","+new TimeConstant(testform.getID())+")").getHead()))));
	}
	public static void testUnboundBound(){
		KnowledgeBase kb = new KnowledgeBase();
		Formula testform = parseString("a(X) -> b(X).");
		kb.add(testform);
		kb.add(parseString("+a(4)."));
		kb.step();
		kb.step();
		kb.step();
		
		Iterator<FormulaNode> iter = FormulaID.findAnswer(((Predicate)(parseString("formulaID(X,"+new TimeConstant(testform.getID())+")").getHead())), kb);
		assertTrue(iter.next().equals((Predicate)(parseString("formulaID("+testform.getHead()+","+new TimeConstant(testform.getID())+")").getHead())));
	}
	public static void testBoundUnbound(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("+a(X) -> b(X)."));
		kb.add(parseString("+a(4)."));
		kb.step();
		kb.step();
		kb.step();
		
		//Iterator<FormulaNode> iter = FormulaID.findAnswer(((Predicate)(parseString("formulaID(a(4),X)").getHead())), kb);
	}
}