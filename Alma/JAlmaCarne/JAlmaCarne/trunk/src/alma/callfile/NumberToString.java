package alma.callfile;

import alma.FormulaBuilder;
import alma.Predicate;
import alma.TimeConstant;
import alma.StringConstant;

public class NumberToString extends SingleCallFormula {

	//NumberToString takes a predicate in the form of number_to_string(4,X), and X becomes "4"
	@Override
	public Predicate generateAnswer(Predicate template) {
		if(template.getChildren().get(1) instanceof TimeConstant) {
			try {
				System.out.println("ans");
				String ans = String.valueOf(((TimeConstant)template.getChildren().get(1)).toLong());
				StringConstant arg2 = new StringConstant(ans);
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
