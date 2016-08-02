package alma.callfile;

import java.util.*;


import alma.*;
import alma.util.BiIterator;

public class CallInferenceRule extends InferenceRule {
	HashMap<Constant,CallFormula> classes = new HashMap<Constant,CallFormula>();
	
	public CallInferenceRule(KnowledgeBase kb) {
		super(kb);
	}
	
	//Load a particular class under a label
	public void loadClass(String name, String classLocation) {
		try {
			classes.put(new SymbolicConstant(name), (CallFormula)(Class.forName(classLocation).newInstance()));
		} catch (ClassNotFoundException e) {
			System.out.println("Please put your class files in the path");
			e.printStackTrace();
		} catch (InstantiationException e) {
			System.out.println("Could not instantiate singular class");
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			System.out.println("Mismatch in class visibility, check private/public declarations");
			e.printStackTrace();
		} catch (ClassCastException e) {
			System.out.println("Your subclass MUST EXTEND CallFormula");
			e.printStackTrace();
		}
	}
	
	@Override
	public boolean add(Formula f) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public void delete(Formula f) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void step() {
		// TODO Auto-generated method stub
		
	}
	
	//given a template that we can handle, go find the answers
	public BiIterator<FormulaNode> getAnswers(FormulaNode template) throws NoSuchMethodException {
		if(!(template instanceof Predicate))
			throw new IllegalArgumentException("Template is not a Predicate");
		if(contains((Predicate)template)) {
			Predicate tempPred = (Predicate) template;
			try {
				return (BiIterator<FormulaNode>)classes.get(tempPred.getChildren().get(0)).findAnswer(tempPred);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	//Do we know how to handle this predicate
	public boolean contains(Predicate node) {
		for(Constant c: classes.keySet()) {
			if(c.equals(node.getChildren().get(0))) return true;
		}
		return false;
	}
	
}

