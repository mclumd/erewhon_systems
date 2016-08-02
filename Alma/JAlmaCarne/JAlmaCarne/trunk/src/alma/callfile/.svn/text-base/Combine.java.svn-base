package alma.callfile;
import alma.*;

import java.util.*;

/**
 * Allows the user to combine strings such that combine(X,Y,Z) yields a predicate where Z is the 
 * result of combining X and Y, otherwise known as appending Y to X.  
 * 
 * i.e. 
 * combine("A","B","AB") would return combine("A","B","AB") but combine("A","B","BA") would return an empty array
 * 
 * combine("A","B",X) would return combine("A","B","AB").
 * combine(X,"B","AB") would return combine("A","B","AB").
 * combine("A",X,"AB") would return combine("A","B","AB").
 * the other four possible bindings cannot be implemented
 * 
 * @author joey
 *
 */

public class Combine extends SingleCallFormula {
		
	public Predicate generateAnswer(Predicate template) {
		ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
		FormulaBuilder fb = new FormulaBuilder();
		FormulaBuilder toReturn = new FormulaBuilder();

		
		if(template.getChildren().size() == 4) { //only handle combine with three arguments
			//combine(x,y,z) i.e. combine("a","b","ab");
			if(template.getChildren().get(1) instanceof StringConstant) {
				if(template.getChildren().get(2) instanceof StringConstant) {
					if(template.getChildren().get(3) instanceof StringConstant) {
						String first= args.get(1).toString();
						first = first.substring(1,first.length()-1);
						String second = args.get(2).toString();
						second = second.substring(1,second.length()-1);
						String ans = "\""+first+second+"\"";
						String finalAns = args.get(3).toString();
						if(ans.equals(finalAns))
							toReturn.add(template);
					}
					else {
						String first= args.get(1).toString();
						first = first.substring(1,first.length()-1);
						String second = args.get(2).toString();
						second = second.substring(1,second.length()-1);
						String ans = first+second;
						args.set(3,new StringConstant(ans));
						args.remove(0);
						
						fb.addPredicate(template.getName());
							for(FormulaNode f: args) {
								fb.add(f);
							}
						fb.endChildren();
						
						toReturn.add((Predicate)fb.getFormulaNode());
					}
				}
				else {
					if(template.getChildren().get(3) instanceof StringConstant) {
						String comb = args.get(3).toString();
						comb = comb.substring(1,comb.length()-1);
						String first = args.get(1).toString();
						first = first.substring(1,first.length()-1);
						String ans = comb.substring(first.length());
						args.set(2,new StringConstant(ans));
						args.remove(0);
						
						fb.addPredicate(template.getName());
						for(FormulaNode f: args) {
							fb.add(f);
						}
						fb.endChildren();
						
						toReturn.add((Predicate)fb.getFormulaNode());
					}
				}
			}
			else {
				if(template.getChildren().get(2) instanceof StringConstant) {
					if(template.getChildren().get(3) instanceof StringConstant) {
						String comb = args.get(3).toString();
						comb = comb.substring(1,comb.length()-1);
						String first = args.get(2).toString();
						first = first.substring(1,first.length()-1);
						String ans = comb.substring(0,comb.lastIndexOf(first));
						args.set(1,new StringConstant(ans));
						args.remove(0);
						
						fb.addPredicate(template.getName());
						for(FormulaNode f: args) {
							fb.add(f);
						}
						fb.endChildren();
						
						toReturn.add((Predicate)fb.getFormulaNode());
					}
				}
			}
		}
		if(toReturn.hasValidFormula())
			return ((Predicate)toReturn.getFormulaNode());
		return null;
	}	
}