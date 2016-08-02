package alma.callfile;

import alma.*;
import alma.util.TestBase;


/**
 * RAWR Infinite modus ponens needs to not do an iterative deepening on these, redo the tests or fix the bug?
 * 
 * 
 * 
 * @author joey
 *
 */
public class EvalTest extends TestBase{

	public static void testEvalPlusPure(){
		Formula f = parseString("eval(\"alma.util.AlmaLong.add\",1,[2],M)");
		Eval e = new Eval();
		FormulaNode next = e.findAnswer((Predicate)f.getHead()).next();
		SubstitutionList sl = new SubstitutionList();
		assertTrue(sl.unify(f.getHead(), next));
		assertTrue(sl.walk(new Variable("M")).equals(new TimeConstant(3)));
	}
	
	public static void testEvalPlusMinus() {
		KnowledgeBase kb = new KnowledgeBase();
		//Addition
		kb.add(parseString("a(1)"));
		kb.add(parseString("a(N) & eval(\"alma.util.AlmaLong.add\",N,[2],M) -> a(M)"));
		kb.add(parseString("a(N) & eval(\"alma.util.AlmaLong.add\",N,[2],M) -> b(M)"));
		kb.step();kb.step();kb.step();kb.step();
		assertTrue(kb.contains(parseString("a(3)")));
		kb.step();kb.step();kb.step();
		assertTrue(kb.contains(parseString("a(5)")));
		kb.step();kb.step();kb.step();
		kb.step();kb.step();kb.step();
		assertTrue(kb.contains(parseString("a(7)")));
		kb.step();kb.step();kb.step();
		kb.step();kb.step();kb.step();
		kb.step();kb.step();kb.step();
		assertTrue(kb.contains(parseString("a(9)")));
		
		
		//Subtraction
		kb.add(parseString("b(N) & eval(\"alma.util.AlmaLong.subtract\",N,[5],M) -> b(M)"));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("b(0)")));
		kb.step();
		assertTrue(kb.contains(parseString("b(2)"))); //b(7) should have been asserted by the first rule
		kb.step();
		assertTrue(kb.contains(parseString("b(4)"))); //b(9) should have been
		kb.step();
		assertTrue(kb.contains(parseString("b(6)"))); //b(11)
	}
	
	public static void testEvalMultDiv() {
		KnowledgeBase kb = new KnowledgeBase();
		//Multiplication
		kb.add(parseString("a(1)"));
		kb.add(parseString("a(N) & eval(\"alma.util.AlmaLong.multiply\",N,[3],M) -> a(M)"));
		kb.add(parseString("a(N) & eval(\"alma.util.AlmaLong.multiply\",N,[3],M) -> b(M)"));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("a(3)")));
		kb.step();
		assertTrue(kb.contains(parseString("a(9)")));
		kb.step();
		assertTrue(kb.contains(parseString("a(27)")));
		kb.step();
		assertTrue(kb.contains(parseString("a(81)")));
		assertFalse(kb.contains(parseString("a(2)")));
		
		//Division 
		kb.add(parseString("b(N) & eval(\"alma.util.AlmaLong.divide\",N,[2],M) -> b(M)"));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("b(1)")));
		kb.step();
		assertTrue(kb.contains(parseString("b(4)"))); //b(7) should have been asserted by the first rule
		kb.step();
		assertTrue(kb.contains(parseString("b(13)"))); //b(27) should have been
		kb.step();
		assertTrue(kb.contains(parseString("b(40)"))); //b(81)
	}
	
	public static void testEvalMod() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(1)"));
		kb.add(parseString("a(N) & eval(\"alma.util.AlmaLong.multiply\",N,[3],M) -> b(M)"));
		kb.add(parseString("a(N) & eval(\"alma.util.AlmaLong.multiply\",N,[3],M) -> a(M)"));
		kb.add(parseString("b(N) & eval(\"alma.util.AlmaLong.mod\",N,[2],M) -> mod(N,2,M)"));
		kb.step();kb.step(); kb.step();
		assertTrue(kb.contains(parseString("mod(3,2,1)")));
		kb.step();
		assertTrue(kb.contains(parseString("mod(9,2,1)")));
		kb.step();
		assertTrue(kb.contains(parseString("mod(27,2,1)")));		
	}
	
	public static void testStringPure1(){
		Formula f = parseString("eval(\"java.lang.String.length\",\"Hello\",[NULL],M)");
		Eval e = new Eval();
		FormulaNode next = e.findAnswer((Predicate)f.getHead()).next();
		SubstitutionList sl = new SubstitutionList();
		assertTrue(sl.unify(f.getHead(), next));
		assertTrue(sl.walk(new Variable("M")).equals(new TimeConstant("Hello".length())));
	}
	
	public static void testStrings() {
		KnowledgeBase kb = new KnowledgeBase();
		//StringBuilder

		//Tests append
		kb.add(parseString("a(\"hello\")"));
		kb.add(parseString("a(N) & eval(\"java.lang.StringBuilder.append\",N,[\" world\"],M) -> a(M)"));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("a(\"hello world\")")));
		kb.step();
		assertTrue(kb.contains(parseString("a(\"hello world world\")")));
		
		//String
		
		//Tests String's length method, as well as Less
		kb.add(parseString("a(N) &  eval(\"java.lang.String.length\",N,[NULL],M)-> length(N,M)"));
		kb.step();kb.step();
		kb.add(parseString("length(N,M) & less(12,M) -> candidate(N)"));
		kb.add(parseString("candidate(N) & eval(\"java.lang.String.substring\",N,[12],M) -> substring(N,12,M)"));
		kb.add(parseString("candidate(N) & eval(\"java.lang.String.substring\",N,[0,12],M) -> substring(N,0,12,M)"));
		
		kb.step();kb.step();
		assertFalse(kb.contains(parseString("candidate(\"hello world\")"))); //Only length 11, not 12
		assertTrue(kb.contains(parseString("candidate(\"hello world world\")"))); //length greater than 12
		kb.step();
		
		//Tests both String's substring(int) and substring(int,int) method
		assertTrue(kb.contains(parseString("substring(\"hello world world\",12,\"world\")"))); 
		assertTrue(kb.contains(parseString("substring(\"hello world world\",0,12,\"hello world \")"))); 
		kb.step();
		assertTrue(kb.contains(parseString("substring(\"hello world world world\",12,\"world world\")"))); 
		assertTrue(kb.contains(parseString("substring(\"hello world world world\",0,12,\"hello world \")"))); 

		//Tests String's regexes (i.e. replaceAll)
		kb.add(parseString("candidate(N) & eval(\"java.lang.String.replaceAll\",N,[\"[world]\",\"*\"],M) -> replaced(M)"));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("replaced(\"he*** ***** ***** *****\")")));
	}

		
}
