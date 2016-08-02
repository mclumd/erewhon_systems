package alma;

import java.util.*;

public class GeneralizedModusPonens extends InferenceRule {
	
	public GeneralizedModusPonens(KnowledgeBase kb){
		super(kb);
	}
	
	@Override
	public boolean add(Formula f) {
		return true;
	}

	@Override
	public void delete(Formula f) {
	}

	@Override
	public void step() {
		Iterator<FormulaNode> i = getKnowledgeBase().getCandidates(IfFormula.class, null);
		while(i.hasNext()){
			FormulaNode fn = i.next();
			if(fn instanceof IfFormula){
				IfFormula ifs = (IfFormula) fn;
				FormulaNode lhs = ifs.getLeft();
				if (lhs instanceof AndFormula)
					GMP(lhs, ifs);
				if (lhs instanceof Predicate){
					FormulaBuilder fb = new FormulaBuilder();
					fb.addAnd();
						fb.add(lhs);
						fb.endChildren();
					GMP(fb.getFormulaNode(), ifs);
				}
			}
		}
	}

	// Generalizied Modus Ponens
	// lhs can not have OR 
	// lhs has AND and NEGATION (?) only
	
	public void GMP(FormulaNode lhs, IfFormula myIf) {
		AndFormula af = (AndFormula) lhs;
		GMP_helper(0, af, myIf, new SubstitutionList());
	}
	
	private void GMP_helper(int index, AndFormula lhs, IfFormula myIf, SubstitutionList sl){	
		if (index==lhs.getChildren().size()-1){							// last predicate for processing on lhs of if
			AndFormula af = (AndFormula) lhs;
			if(! (af.getChildren().get(index) instanceof Predicate)){
				return;
			}
			Predicate currentlhs = (Predicate) af.getChildren().get(index); // add NOT case later to here?
			
			FormulaNode template = currentlhs.applySubstitution(sl);
			Iterator<FormulaNode> i = getKnowledgeBase().getCandidates(Predicate.class, template);
			while(i.hasNext()){
				FormulaNode fn = i.next();
				if(fn instanceof Predicate){
					Predicate p = (Predicate)fn;
					SubstitutionList tmp = sl.clone();
					if(currentlhs.unify(p, sl)){			
						kbAdd(new Formula(myIf.getRight().applySubstitution(sl)));
					}
					sl = tmp;
				}
			}
		} else {								// more than one predicate on lhs of if
			AndFormula af = (AndFormula) lhs;
			if(! (af.getChildren().get(index) instanceof Predicate)){
				return;
			}
			Predicate currentlhs = (Predicate) af.getChildren().get(index);			
			Iterator<FormulaNode> i = getKnowledgeBase().getCandidates(Predicate.class, currentlhs.applySubstitution(sl));
			while(i.hasNext()){
				FormulaNode fn = i.next();
				if(fn instanceof Predicate){
					Predicate p = (Predicate)fn;
					SubstitutionList tmp = sl.clone();
					if(currentlhs.unify(p, sl)){
						GMP_helper(index+1, lhs, myIf, sl );
					}
					sl = tmp;
				}
			}
		}
	}
}


