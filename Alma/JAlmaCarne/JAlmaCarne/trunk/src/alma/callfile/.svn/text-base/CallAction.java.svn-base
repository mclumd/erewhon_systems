package alma.callfile;

import java.util.*;

import alma.*;

public class CallAction {
	HashMap<Constant,Class<? extends CallActionFormula>> classes = new HashMap<Constant,Class<? extends CallActionFormula>>();

	//Load a particular class under a label
	public void loadClass(String name, String classLocation) {
		try {
			classes.put(new SymbolicConstant(name), (Class<? extends CallActionFormula>)(Class.forName(classLocation)));
		} catch (ClassNotFoundException e) {
			System.out.println("Please put your class files in the path");
			e.printStackTrace();
		}
	}

	public void callAction(FormulaNode template) {
		if(!(template instanceof Predicate))
			throw new IllegalArgumentException("Template is not a Predicate");
		if(contains((Predicate)template)) {
			Predicate tempPred = (Predicate) template;
			Thread t = null;
			try {
				t = new Thread((Runnable) classes.get(tempPred.getChildren().get(0)).getConstructor(Predicate.class).newInstance(template));
				t.start();
			} catch(Exception e) {
				System.err.println("Your actioncall class must have a constructor which takes a Predicate");
			}
		}
	}
	
	public boolean contains(Predicate node) {
		for(Constant c: classes.keySet()) {
			if(c.equals(node.getChildren().get(0))) return true;
		}
		return false;
	}

}
