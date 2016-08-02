package alma.callfile;

import alma.Predicate;
import alma.*;

public class GetPlacement extends SingleCallFormula {
	@Override
	public Predicate generateAnswer(Predicate template) {
		if(template.getChildren().size() == 4) {
			if(template.getChildren().get(1) instanceof Constant) {
				if(template.getChildren().get(2) instanceof Pair) {
					FormulaBuilder fb = new FormulaBuilder();
					fb.addPredicate(template.getName());
						fb.add(template.getChildren().get(1));
						fb.add(template.getChildren().get(2));
						fb.addTimeConst(findPos((Pair)template.getChildren().get(2),(Constant)template.getChildren().get(1), 0));
					fb.endChildren();
					return (Predicate)fb.getFormulaNode();
				}
			}
			else if(template.getChildren().get(1) instanceof Variable) {
				FormulaBuilder fb = new FormulaBuilder();
				fb.addPredicate(template.getName());
					fb.add(findChar((Pair)template.getChildren().get(2),
						(int) ((TimeConstant)template.getChildren().get(3)).toLong(), 0));
					fb.add(template.getChildren().get(2));
					fb.add(template.getChildren().get(3));
				fb.endChildren();
				return (Predicate)fb.getFormulaNode();
			}
		}
		return null;
	}
	
	public int findPos(Pair list, Constant search, int num) {
		if(list.car().equals(search)) {
			return num;
		}
		else if(list.getChildren().size()>=2)
			return findPos((Pair)list.cdr(),search,num+1);
			
		return -1;
	}
	
	
	public Constant findChar(Pair list, int goal, int num) {
		if(goal == num) {
			return (Constant)list.car();
		}
		else if(list.getChildren().size()>=2)
			return findChar((Pair)list.cdr(),goal,num+1);
			
		return new NullConstant();
	}

}
