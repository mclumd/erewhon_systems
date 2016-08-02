package alma;

import java.util.*;
import java.util.regex.*;

public class Runner {
	public static void main(String[] args){
		//simple read eval print loop
		KnowledgeBase kb = new KnowledgeBase();
		Scanner scan = new Scanner(System.in);
		
		String line = null;
		FormulaBuilder fb = new FormulaBuilder();
		
		while((line = scan.nextLine())!=null){
			if(line.startsWith("print")){
				kb.printHistory(System.out);
				continue;
			} else if(line.startsWith("step")){
				System.out.println(kb);
				kb.step();
				System.out.println(kb);
			} else if(line.startsWith("debug")){
				System.out.println("blah");
			} else if(line.startsWith("+")){
				fb.clear();
				if(readFormula(line.substring(1), fb)){
					kb.eval(new Formula(new AddCommand(fb.getFormulaNode())));
				}
				else System.out.println("Last Line not read");
			} else if(line.startsWith("-")){
				fb.clear();
				if(readFormula(line.substring(1), fb)){
					kb.eval(new Formula(new DeleteCommand(fb.getFormulaNode())));
				}
				else System.out.println("Last Line not read");
			}
		}
	}
	
	private static boolean readFormula(String input, FormulaBuilder fb){
		String tokens[] = input.split(" ");
		
		for(String s: tokens){
			if(s.length() < 1){
				continue;
			}else if(s.equals("&")){
				fb.addAnd();
			} else if(s.equals("|")){
				fb.addOr();
			} else if(s.equals("->")){
				fb.addIfNew();
			} else if(s.equals("=>")){
				fb.addIf();
			} else if(s.equals("~")){
				fb.addNot();
			} else if(s.startsWith("pred-")){
				fb.addPredicate(s.substring("pred-".length()));
			} else if(s.equals(".")){
				fb.endChildren();
			} else if(Character.isUpperCase(s.charAt(0))){
				fb.addVariable(s);
			} else if(Character.isLowerCase(s.charAt(0))){
				fb.addConstant(s);
			} else {
				return false;
			}
		}
		
		return true;
	}
}
