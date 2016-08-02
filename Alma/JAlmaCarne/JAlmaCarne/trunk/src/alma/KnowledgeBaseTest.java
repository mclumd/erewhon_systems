package alma;

import java.util.*;

import alma.util.BiIterator;
import alma.util.TestBase;


public class KnowledgeBaseTest extends TestBase {
	public static void testAdd(){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addAdd();
			fb.addAnd();
				fb.addConstant("1");
				fb.addConstant("2");
				fb.addConstant("3");
				
		Formula f = fb.getFormula();
		
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(f);
		
		fb.clear();
		fb.addAdd();
			fb.addOr();
				fb.addConstant("1");
				fb.addConstant("2");
				fb.addConstant("3");
				
		kb.add(fb.getFormula());
		
		kb.step();
		kb.step();
		kb.step();
		
		assertTrue("kbsize:" + kb.size(), kb.size() == 2);
	}
	
	public static void testDelete(){
		FormulaBuilder fb = new FormulaBuilder();
		
		fb.addDelete();
			fb.addPredicate("a");
				fb.addConstant("a");
		Formula todelete = fb.getFormula();
		
		fb.clear();
		fb.addAdd();
			fb.addPredicate("a");
				fb.addConstant("a");

		Formula f = fb.getFormula();
		
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(f);
		kb.step();
		kb.step();
		
		assertTrue("AddFormula not working", kb.size()==1);
		
		kb.add(todelete);
		kb.step();
		kb.step();
		
		assertTrue("KB size should be zero", kb.size() == 0);
	}
	
	public static void testContains(){
		KnowledgeBase kb = new KnowledgeBase();
		FormulaBuilder fb = new FormulaBuilder();
		
		fb.addAdd();
			fb.addPredicate("a");
				fb.addConstant("john");
			fb.endChildren();
		fb.endChildren();
		
		kb.add(fb.getFormula());
		
		kb.step();
		kb.step();
		
		assertTrue(kb.contains(parseString("a(john)")));
	}
	
	
	public static void testGetCNFCandidate(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(2)"));
		kb.add(parseString("l(X) -> b(X)"));
		kb.add(parseString("a(X) -> b(X)"));
		kb.add(parseString("l(X) -> a(X)"));
		kb.add(parseString("c(X)"));
		kb.step();kb.step();
		
		ArrayList<Predicate> s = new ArrayList<Predicate>();
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("a");
			fb.addVariable("X");
		fb.endChildren();
		s.add((Predicate) fb.getFormulaNode());
	    BiIterator<FormulaNode> bi = kb.getCNFCandidates(s);
	    Stack<FormulaNode> returns = new Stack<FormulaNode>();
		while(bi.hasNext())
			returns.push(bi.next());
	    assertTrue(returns.size()==3);
	    
		assertFalse(returns.contains(FormulaSet.toCNF(parseString("c(X)")).getHead()));
		assertTrue(returns.contains(FormulaSet.toCNF(parseString("a(2)")).getHead()));
		assertTrue(returns.contains(FormulaSet.toCNF(parseString("a(X) -> b(X)")).getHead()));
		assertTrue(returns.contains(FormulaSet.toCNF(parseString("l(X) -> a(X)")).getHead()));
		
	    
	    while(bi.hasPrevious())
    		assertTrue(bi.previous().equals(returns.pop()));
	}
	
	
	public static void testGetCNFCandidateWithCall(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(2)"));
		kb.add(parseString("l(X) -> b(X)"));
		kb.add(parseString("a(X) -> b(X)"));
		kb.add(parseString("l(X) -> a(X)"));
		kb.add(parseString("c(X)"));
		kb.step();kb.step();
		
		ArrayList<Predicate> s = new ArrayList<Predicate>();
		FormulaBuilder fb = new FormulaBuilder();

		fb.addPredicate("a");
			fb.addVariable("X");
		fb.endChildren();
		s.add((Predicate) fb.getFormulaNode());
		
		fb.clear();
		fb.addPredicate("combine");
			fb.addVariable("X");
			fb.addStringConst("B");
			fb.addStringConst("AB");
		fb.endChildren();
	
		s.add((Predicate) fb.getFormulaNode());
	    BiIterator<FormulaNode> bi = kb.getCNFCandidates(s);
	    Stack<FormulaNode> returns = new Stack<FormulaNode>();
		while(bi.hasNext()) 
			returns.push(bi.next());
		
		assertTrue(returns.size()==4);
		
		assertFalse(returns.contains(FormulaSet.toCNF(parseString("c(X)")).getHead()));
		assertTrue(returns.contains(FormulaSet.toCNF(parseString("a(2)")).getHead()));
		assertTrue(returns.contains(FormulaSet.toCNF(parseString("a(X) -> b(X)")).getHead()));
		assertTrue(returns.contains(FormulaSet.toCNF(parseString("l(X) -> a(X)")).getHead()));
		assertTrue(returns.contains(parseString("combine(\"A\",\"B\",\"AB\")").getHead()));
	    
	    while(bi.hasPrevious())
    		assertTrue(bi.previous().equals(returns.pop()));

	}
	
	
	public static void testGetCandidate(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("A(a)"));
		kb.add(parseString("B(b)"));
		kb.add(parseString("C(c)"));
		
		kb.add(parseString("(A(a) & A(b))"));
		kb.add(parseString("(B(a) & B(b))"));
		kb.add(parseString("(C(a) & C(b))"));
		
		kb.step();
		kb.step();
		
		ArrayList<FormulaNode> returns = new ArrayList<FormulaNode>();
		
		Iterator<FormulaNode> i  = kb.getCandidates(Predicate.class, null);
		
		while(i.hasNext()){
			returns.add(i.next());
		}
		
		assertTrue(returns.contains(parseString("A(a)").getHead()));
		assertTrue(returns.contains(parseString("B(b)").getHead()));
		assertTrue(returns.contains(parseString("C(c)").getHead()));
		
		assertFalse(returns.contains(parseString("(A(a) & A(b))").getHead()));
		assertFalse(returns.contains(parseString("(B(a) & B(b))").getHead()));
		assertFalse(returns.contains(parseString("(C(a) & C(b))").getHead()));	
	}
	
	public static void testGetCandidate2(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("A(a)"));
		kb.add(parseString("B(b)"));
		kb.add(parseString("C(c)"));
		
		kb.add(parseString("(A(a) & A(b))"));
		kb.add(parseString("(B(a) & B(b))"));
		kb.add(parseString("(C(a) & C(b))"));
		
		kb.step();
		kb.step();
		
		ArrayList<FormulaNode> returns = new ArrayList<FormulaNode>();
		
		Iterator<FormulaNode> i  = kb.getCandidates(AndFormula.class, null);
		
		while(i.hasNext()){
			returns.add(i.next());
		}
		assertFalse(returns.contains(parseString("A(a)").getHead()));
		assertFalse(returns.contains(parseString("B(b)").getHead()));
		assertFalse(returns.contains(parseString("C(c)").getHead()));
		
		assertTrue(returns.contains(parseString("(A(a) & A(b))").getHead()));
		assertTrue(returns.contains(parseString("(B(a) & B(b))").getHead()));
		assertTrue(returns.contains(parseString("(C(a) & C(b))").getHead()));	
	}

//	public static void testNormilization() {
//		KnowledgeBase kb = new KnowledgeBase();
//		kb.add(parseString("A(a)"));
//		kb.add(parseString("B(b)"));
//		kb.add(parseString("C(c)"));
//		
//		kb.add(parseString("A(a) & A(b) | B(X) | C(X) & C(Y)"));
//		kb.add(parseString("(B(a) & B(b))"));
//		kb.add(parseString("(C(a) & C(b))"));
//		kb.step();kb.step();
//		assertTrue(kb.contains(parseString("A(a) & A(b) | B(X) | C(X) & C(Y)")));
//		kb.delete(parseString(" C(Y) & C(X) | A(b) & A(a) | B(X)"));
//		kb.step();kb.step();
//		assertFalse(kb.contains(parseString("A(a) & A(b) | B(X) | C(X) & C(Y)")));
//		
//		kb.add(parseString("A(a) & A(b) | B(X,Y) & M(X,o) -> C(X) & C(Y) & C(Y,X,o) | P(Q)"));
//		kb.step();kb.step();
//		assertTrue(kb.contains(parseString("M(X,o) & B(X,Y) | A(b) & A(a) -> P(Q) | C(Y,X,o) & C(X) & C(Y)")));
//		assertFalse(kb.contains(parseString("M(X,o) & B(X,Y) | A(b) ->  A(a) & P(Q) | C(Y,X,o) & C(X) & C(Y)")));
//		assertFalse(kb.contains(parseString("B(X,Y) | A(b) & A(a) & M(X,o)  -> P(Q) | C(Y,X,o) & C(X) & C(Y)")));
//		
//	}
}
