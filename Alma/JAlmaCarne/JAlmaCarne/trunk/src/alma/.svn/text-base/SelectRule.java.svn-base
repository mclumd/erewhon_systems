package alma;

import java.util.ArrayList;
import java.util.*;

public class SelectRule extends InferenceRule {
	ArrayList<Stepper> tointerpret;		// only one SelectCommand per step ?
	
	/**
	 * Stepper needs to remember things across steps. This class helps
	 */
	private class Stepper{
		ArrayList<FormulaNode> returned = new ArrayList<FormulaNode>();
		SelectCommand sc;
		
		public Stepper(SelectCommand selector){
			sc = selector;
		}
		
		public boolean finished(){
			return returned.size() >= sc.getNumHits() && !(sc.getNumHits()==-1);
		}
		
		public void step(){
			
			if(finished())
				return;
			
			SubstitutionList sl = new SubstitutionList();
			Iterator<FormulaNode> iter = getKnowledgeBase().getCandidates(Predicate.class, sc.getTemplate());
			
			while(iter.hasNext() && !finished()){
				sl.reset();
				Predicate fn = (Predicate) iter.next();
				if(sl.unify(sc.getTemplate(), fn)){
					boolean add = true;
					for(Variable v: sc.getNotSearch()){
						if(! (sl.walk(v) instanceof Variable)){
							add = false;
							break;
						}
					}
					
					if(add){
						FormulaNode toReturn = sc.getAnswer().applySubstitution(sl);
						
						if(! returned.contains(toReturn)){
							returned.add(toReturn);
							kbAdd(new Formula(toReturn));
						}
					}
				}
			}
		}
	}
	
	public SelectRule(KnowledgeBase kb) {
		super(kb);
		tointerpret = new ArrayList<Stepper>();
	}

	@Override
	public boolean add(Formula f) {
		if(f.getHead() instanceof SelectCommand){
			tointerpret.add(new Stepper((SelectCommand) (f.getHead())));
			return false;
		}
		return true;
	}

	@Override
	public void delete(Formula f) {
		if(tointerpret.contains(f.getHead())) tointerpret.remove(f.getHead());
	}

	@Override
	public void step() {
		ArrayList<Stepper> toRemove = new ArrayList<Stepper>();
		for(Stepper s : tointerpret) {
			s.step();
			if(s.finished()){
				toRemove.add(s);
			}
		}
		tointerpret.removeAll(toRemove);
	}
}
