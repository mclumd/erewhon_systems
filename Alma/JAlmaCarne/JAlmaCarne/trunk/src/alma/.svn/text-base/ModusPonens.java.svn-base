package alma;

import java.util.*;

public class ModusPonens extends InferenceRule {
	Collection<IfFormula> rules = new ArrayList<IfFormula>();
	Collection<Predicate> predicates = new ArrayList<Predicate>();

	public ModusPonens(KnowledgeBase kb){
		super(kb);
	}
	
	@Override
	public boolean add(Formula f) {
		if(f.getHead() instanceof IfFormula){
			rules.add((IfFormula) f.getHead());
		} else if (f.getHead() instanceof Predicate){
			predicates.add((Predicate) f.getHead());
		}
		return true;
	}

	@Override
	public void delete(Formula f) {
		rules.remove(f);
		predicates.remove(f);
	}

	@Override
	public void step() {
		SubstitutionList sl = new SubstitutionList(); 
		for(Predicate p: predicates){
			for(IfFormula ifs: rules){
				sl.reset();
				FormulaNode lhs = ifs.getLeft();
				if(lhs instanceof Predicate){
					Predicate plhs = (Predicate)lhs;
					if(plhs.unify(p, sl)){
						kbAdd(new Formula(ifs.getRight().applySubstitution(sl)));
					}
				} else if (lhs instanceof AndFormula){
					/* And all children are predicates */
					/* Laters */
				}
			}
		}
	}
}
