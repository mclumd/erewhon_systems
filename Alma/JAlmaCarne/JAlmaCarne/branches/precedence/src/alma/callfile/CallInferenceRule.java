package alma.callfile;

import java.util.*;

import alma.*;

public class CallInferenceRule extends InferenceRule {
	ArrayList<Formula> answers = new ArrayList<Formula>();
	HashMap<Constant,Class> classes = new HashMap<Constant,Class>();
	
	public CallInferenceRule(KnowledgeBase kb) {
		super(kb);
	}
	
	public void loadClass(String name, String classLocation) {
		try {
			classes.put(new SymbolicConstant(name), Class.forName(classLocation));
		} catch (ClassNotFoundException e) {
			System.out.println("Please put your class files in the path");
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
	public BiIterator getAnswers(FormulaNode template) throws NoSuchMethodException {
		if(!(template instanceof Predicate))
			throw new IllegalArgumentException("Template is not a Predicate");
		if(contains((Predicate)template)) {
			Predicate tempPred = (Predicate) template;
			try {
				//We might want to make this more than one answer in the future, or not
				return (BiIterator)classes.get(tempPred.getChildren().get(0)).getMethod("findAnswer",Predicate.class).invoke(this,template);
			} catch(NoSuchMethodException e) {
				throw new NoSuchMethodException("Make sure that your class contains a method findAnswer(Predicate template) which returns a CallGenerator iterator");
			}
			catch (Exception e) {
				System.out.println(e.getMessage());
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

