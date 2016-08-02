package alma.callfile;

import alma.*;

/**
 * Allows the user to find numbers between two other numbers such that between(X,Y,Z) yields a predicate 
 * where Y is in the middle of X and Z.  
 * 
 * i.e. 
 * between(4,X,10) would return an iterator with its first element: between(4,5,10).
 * 
 * @author joey
 *
 */

public class Between extends SimpleCallFormula{

	@Override
	/**
	 * Because the numbers between two other numbers is a finite set, we can extend SimpleCallFormula
	 * and overide generatoeAnswers.
	 * 
	 */
	protected Predicate[] generateAnswers(Predicate template) {
		Predicate[] toReturn = null;
		if(template.getChildren().size()==4) {
			//Look at the parameters, if all three are TimeConstants (numbers) then
			//return whether the middle number is between the two other numbers
			if(template.getChildren().get(1) instanceof TimeConstant) {
				if(template.getChildren().get(2) instanceof TimeConstant) {
					if(template.getChildren().get(3) instanceof TimeConstant) {
						TimeConstant c1 = (TimeConstant)template.getChildren().get(1);
						TimeConstant c2 = (TimeConstant)template.getChildren().get(2);
						TimeConstant c3 = (TimeConstant)template.getChildren().get(3);
						if(c2.toLong() > c1.toLong() && c3.toLong() > c2.toLong()) {
							toReturn = new Predicate[1];
							toReturn[0] =  template;
						}
					}
				//if the parameters are a TimeConstant, Variable, TimeConstant, then we know that Variable
				//must be replaced byt every value between the first and last parameter
				} else if(template.getChildren().get(2) instanceof Variable) {
					TimeConstant c1 = (TimeConstant)template.getChildren().get(1);
					Variable c2 = (Variable)template.getChildren().get(2);
					TimeConstant c3 = (TimeConstant)template.getChildren().get(3);
					//Create a big enough array
					toReturn = new Predicate[(int) (c3.toLong() - c1.toLong()-1)];
					FormulaBuilder fb = new FormulaBuilder();
					//Add each predicate to the array
					for(int i=1;i <= toReturn.length;i++) {
						fb.clear();
						fb.addPredicate(template.getName());
							fb.add(template.getChildren().get(1));
							fb.addTimeConst(c1.toLong()+i);
							fb.add(template.getChildren().get(3));
						fb.endChildren();
						toReturn[i-1] = (Predicate) fb.getFormulaNode();
					}
				}
			} 
		}
		//return the array
		return toReturn;
	}

}
