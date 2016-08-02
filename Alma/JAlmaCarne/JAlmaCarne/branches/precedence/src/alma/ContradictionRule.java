package alma;

import java.util.*;

public class ContradictionRule extends InferenceRule {
	HashSet<Predicate> predicates = new HashSet<Predicate>();
	HashSet<Predicate> notPredicates = new HashSet<Predicate>(); //The "not" was removed
	
	public ContradictionRule(KnowledgeBase kb){
		super(kb);
	}

	@Override
	public boolean add(Formula f) {
		FormulaNode node = f.getHead();
		if(node instanceof Predicate){
			predicates.add((Predicate)node);
		} else if (node instanceof NotFormula && 
				((NotFormula)node).getChild() instanceof Predicate){
			notPredicates.add((Predicate)((NotFormula)node).getChild());
		}
		
		return true;
	}

	@Override
	public void delete(Formula f) {
		FormulaNode node = f.getHead();
		if(node instanceof Predicate){
			predicates.remove((Predicate)node);
		} else if (node instanceof NotFormula && 
				((NotFormula)node).getChild() instanceof Predicate){
			notPredicates.remove((Predicate)((NotFormula)node).getChild());
		}
	}

	@Override
	public void step() {
		HashSet<Predicate> tmp = (HashSet<Predicate>) predicates.clone();
		tmp.retainAll(notPredicates);
		
		for(Predicate p : tmp){	
			FormulaBuilder fb = new FormulaBuilder();
			fb.addPredicate("contra");
				fb.add(p);
				fb.addNot();
					fb.add(p);
				fb.endChildren();
			fb.endChildren();
			
			kbAdd(fb.getFormula());
			
			kbDelete(new Formula(p));
			
			fb.clear();
			fb.addNot();
				fb.add(p);
			kbDelete(fb.getFormula());
		}
		
		notPredicates.removeAll(tmp);
		predicates.removeAll(tmp);
	}

}
