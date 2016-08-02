package alma.callfile;

import alma.FormulaBuilder;
import alma.Predicate;
import alma.SymbolicConstant;
import alma.StringConstant;

public class SymbolicConstantToString  extends SingleCallFormula {

	//ConstantToString takes a predicate in the form of number_to_string(hello,X), and X becomes "hello"
	@Override
	public Predicate generateAnswer(Predicate template) {
		if(template.getChildren().get(1) instanceof SymbolicConstant) {
			try {
				StringConstant arg2 = new StringConstant(((SymbolicConstant)template.getChildren().get(1)).toString());
				FormulaBuilder fb = new FormulaBuilder();
				fb.addPredicate(template.getName());
					fb.add(template.getChildren().get(1));
					fb.add(arg2);
				fb.endChildren();
				return (Predicate)fb.getFormulaNode();
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}

}
