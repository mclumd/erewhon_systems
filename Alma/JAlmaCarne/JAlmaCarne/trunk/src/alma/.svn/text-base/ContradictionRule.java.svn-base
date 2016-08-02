package alma;

import java.util.*;

/**
 * This rule checks for simple contradictions and asserts the contradiction into the
 * knowledgebase
 * @author percy
 *
 */
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
		SubstitutionList sl = new SubstitutionList();
		for(Predicate p : predicates){	
			for(Predicate q : notPredicates) {
				sl.reset();
				if(sl.unify(p,q)) {
					FormulaBuilder fb = new FormulaBuilder();
					fb.addPredicate("contra");
						fb.add(p);
						fb.addNot();
							fb.add(q);
						fb.endChildren();
					fb.endChildren();
					
					kbAdd(fb.getFormula());
					kbDelete(new Formula(p));
					
					kbDelete(new Formula(q));
					predicates.remove(p);
					notPredicates.remove(q);
				}
			}
		}
	}

}
