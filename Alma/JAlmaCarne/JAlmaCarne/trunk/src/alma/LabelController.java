package alma;

import java.util.HashMap;

import alma.util.BiIterator;

public class LabelController extends InferenceRule{
	enum Operation { ADD, REMOVE, ADDALL, REMOVEALL};
	String global = ""; 
	public LabelController(KnowledgeBase kb) {
		super(kb);
	}
	
	public Formula find(FormulaNode fn) {
		BiIterator<Formula> iter = getKnowledgeBase().getAllFormulas();
		Formula f;
		while(iter.hasNext()) {
			f = iter.next();
			if(f.getHead().equals(fn))
				return f;
		}
		return new Formula(new NullConstant());
	}
	
	public void eval(String oper, FormulaNode formulaNode, String label) {
		if (oper.equals("add")){
			find(formulaNode).getGroups().add(label);
		} else if(oper.equals("remove")) {
			if(formulaNode instanceof NullConstant) {
				BiIterator<Formula> iter = getKnowledgeBase().getAllFormulas();
				while(iter.hasNext()) {
					iter.next().getGroups().remove(label);
				}
			}
			else {
				find(formulaNode).getGroups().remove(label);
			}
		} else if(oper.equals("setdefault")) {
			global = label;
		} else if(oper.equals("unsetdefault")) {
			global = "";
		} else if(oper.equals("turnon")) {
			if(formulaNode instanceof NullConstant) {
				BiIterator<Formula> iter = getKnowledgeBase().getAllFormulas();
				Formula f;
				while(iter.hasNext()) {
					f = iter.next();
					if(f.getGroups().contains(label))
						f.getGroups().remove("*invalid*");
				}
			} else {
				find(formulaNode).getGroups().remove("*invalid*");
			}
		} else if(oper.equals("turnoff")) {
			if(formulaNode instanceof NullConstant) {
				BiIterator<Formula> iter = getKnowledgeBase().getAllFormulas();
				Formula f;
				while(iter.hasNext()) {
					f = iter.next();
					System.out.println(f+" "+f.getGroups());
					if(f.getGroups().contains(label)) {
						f.getGroups().add("*invalid*");
					}
				}
			} else {
				find(formulaNode).getGroups().add("*invalid*");
			}
		} else {
			System.err.println(oper+" is not supported");
		}
	}


	@Override
	public boolean add(Formula f) {
		if(!global.equals(""))
			f.getGroups().add(global);
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
}
