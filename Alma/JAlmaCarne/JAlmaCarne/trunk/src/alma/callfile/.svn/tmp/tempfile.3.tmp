package alma.callfile;
import alma.*;

import java.util.*;

/**
 * 
 *
 */

public class UniqueID extends SingleCallFormula {
	
	long currentID = 0;							//incremented with each UniqueID call
		
	public Predicate generateAnswer(Predicate template) {
		ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
		FormulaBuilder fb = new FormulaBuilder();
		FormulaBuilder toReturn = new FormulaBuilder();

		
		if(template.getChildren().size() == 2) { //only handle combine with one argument
		//UniqueID(x)
					if(template.getChildren().get(1) instanceof StringConstant) {
						//UniqueID(10)
						toReturn.add(template);				// return true;  ??
					}
					else {
						//UniqueID(x)
						String ans = Long.toString(currentID++);
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
		if(toReturn.hasValidFormula())
			return ((Predicate)toReturn.getFormulaNode());
		return null;
	}	
}