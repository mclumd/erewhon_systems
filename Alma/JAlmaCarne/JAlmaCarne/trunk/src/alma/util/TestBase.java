package alma.util;
import junit.framework.TestCase;

import alma.Formula;
import almaparse.*;

public abstract class TestBase extends TestCase {
	public static alma.Formula parseString(String s){
		return AlmaParser.parseString(s);
	}
	
	public static alma.FormulaNode parse(String s){
		return parseString(s).getHead();
	}
}