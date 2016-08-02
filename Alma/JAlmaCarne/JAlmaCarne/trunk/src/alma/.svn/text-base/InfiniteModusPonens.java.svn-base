package alma;

import java.util.*;

import alma.util.*;

/**
 * This class is just like GeneralizedModusPonens except that it works even when
 * the Iterators are infinite.
 * @author percy
 *
 */
public class InfiniteModusPonens extends InferenceRule {
	
	/**
	 * <p>InfiniteModusPonens may be stepping across an infinite search tree. So
	 * we need to break it up into steps so that the program doesn't lock up.
	 * "BiIterator" isn't cloned onto the stack.</p>
	 * 
	 * <p>This infinite search tree is a BinaryTree representation of the "obvious" tree.
	 * See Knuth to see how to convert arbitrary trees into Binary Trees. The obvious
	 * tree is a tree of bindings where each of the children of the nodes is a 
	 * possible specification of that binding. IE: The root node will always be
	 * an empty substitution list. Its children can be the binding [X=1] and [X=2].
	 * And the children of [X=1] can be [X=1, Y=1], etc. etc. </p>
	 * 
	 * <p>Going "right" down this Binary tree gets the siblings of the current node, 
	 * and is thus correlated to Iterator.next. Going "left" down this binary tree
	 * gets the first child of the current node, and is thus correlated with an
	 * attempted unification.</p>
	 * 
	 * <p>The conversion from arbitrary trees into Binary trees is as follows. The
	 * left child of a node in the binary tree is the first child of that node in the
	 * "real" tree. The right child of a node is the children </p>
	 * 
	 * 
	 * @author percy
	 *
	 */
	static class Stepper{
		/**
		 * All the information necessary to save a step onto a stack to
		 * do a depth first search is in this StepState. The substitution list
		 * and BiIterator are there as obvious necessities in a depth first search.
		 * The depth is used to help the IterativeDeepening search. Predicate is
		 * needed for this case in InfiniteModusPonens to see which child of the "lhs"
		 * variable the state is working on at the moment.
		 * @author percy
		 *
		 */
		private class StepState{
			public SubstitutionList sl;
			public Iterator<FormulaNode> iter;
			int depth;
			int pred; //The predicate this State is on (first, second, etc. etc.)
			
			public StepState(SubstitutionList s, BiIterator<FormulaNode> i, int depth, int pred){
				sl = s;
				iter = i;
				this.depth = depth;
				this.pred = pred;
			}
			
			public StepState(StepState s){
				sl = s.sl.clone();
				iter = s.iter;	// Class invariant that parent's left tree is fully explored before
								// iter is called, thus iter doesn't need to be cloned
				depth = s.depth;
				pred = s.pred;
				
			}
			
			public String toString(){
				StringBuffer toReturn = new StringBuffer();
				toReturn.append(sl);
				toReturn.append(iter);
				toReturn.append(' ');
				toReturn.append(depth);
				toReturn.append(' ');
				toReturn.append(pred);
				
				return toReturn.toString();
			}
			
		}
		
		Stack<StepState> dfs = new Stack<StepState>();
		List<FormulaNode> lhs; //children of an AndFormula
		FormulaNode rhs;
		KnowledgeBase kb;
		
		int maxDepth=20;
		int lastMaxDepth = 0;
		
		boolean finished=false; //Sometimes... these are finite
		
		public Stepper(AndFormula left, FormulaNode right, KnowledgeBase k){
			rhs = right;
			lhs = left.getChildren();
			kb = k;
			reinit();
		}
		
		/**
		 * Kind of a constructor...
		 *
		 */
		private void reinit(){
			BiIterator<FormulaNode> iter = kb.getCandidates(Predicate.class, lhs.get(0));
			dfs.push(new StepState(new SubstitutionList(), iter, 0, 0));
			finished = false;
		}
		
		/**
		 * A Depth First search is typically pop an item off the stack, "explore" it,
		 * then push its children. Lather, rinse, repeat.
		 *
		 */
		public void step(){
			if(dfs.empty()){
				if(lastMaxDepth < maxDepth){
					finished = true;
					return;
				}
				maxDepth++;
				reinit();
			}

			StepState current = dfs.pop(); 
			//Done poping, now "explore"
			

			FormulaNode fn=null;
			//If working on the last predicate...

			lastMaxDepth = Math.max(current.depth, lastMaxDepth);
			if(!current.iter.hasNext()){
				//if somehow empty before we start...
				return; //Nothing we can do...
			}
			if(current.pred == lhs.size()-1 ){
				 SubstitutionList sl = current.sl.clone();
				 fn = current.iter.next();
				 if(sl.unify(lhs.get(current.pred), fn)){
					 kb.add(new Formula(rhs.applySubstitution(sl)));
				 }
			} else {
				if(current.iter.hasNext()){
					fn = current.iter.next();
				}
			}

			//Done Exploring, now push the children if not at max depth yet
			if(current.depth < maxDepth){
				if(current.iter.hasNext()){
					current.depth++;
					dfs.push(current);
				}
				SubstitutionList sl = current.sl.clone();
				
				//current.depth is already incremented above...
				if(current.pred+1 < lhs.size() && fn!=null && sl.unify(lhs.get(current.pred), fn)){
					dfs.push(new StepState(sl, kb.getCandidates(Predicate.class, lhs.get(current.pred+1).applySubstitution(sl)),
												current.depth, current.pred+1));
				}
			}
		}
		
		public String toString(){
			return dfs.toString();
		}
	}
	
	LinkedList<Stepper> steppers = new LinkedList<Stepper>();
	LinkedList<Stepper> diedSteppers = new LinkedList<Stepper>();
	LinkedList<Stepper> toReset = new LinkedList<Stepper>(); //if a stepper needs to be reset, wait for KB to step first
	
	
	public InfiniteModusPonens(KnowledgeBase kb){
		super(kb);
	}

	@Override
	public boolean add(Formula f) {
		if(f.getHead() instanceof IfFormula){
			FormulaNode lhs = ((IfFormula)(f.getHead())).getLeft();
			FormulaNode rhs = ((IfFormula)(f.getHead())).getRight();
			if(lhs instanceof AndFormula){
				steppers.add(new Stepper( (AndFormula)lhs, 
											rhs, getKnowledgeBase()));
			} else if (lhs instanceof Predicate){
				FormulaBuilder fb = new FormulaBuilder();
				fb.addAnd();
					fb.add(lhs);
				fb.endChildren();
				
				steppers.add(new Stepper( (AndFormula) fb.getFormulaNode(),
								rhs, getKnowledgeBase()));
			}
		} else if (f.getHead() instanceof Predicate){
			/*
			 * Reset the steppers that contain this predicate and try again
			 */
			
			Predicate p = (Predicate)f.getHead();
			
			for(Stepper s: diedSteppers){
				reinitIfContainsPredicate(s, p, toReset);
			}
			for(Stepper s: steppers){
				reinitIfContainsPredicate(s,p, toReset);
			}
		}
		return true;
	}
	
	private void reinitIfContainsPredicate(Stepper s, Predicate p, Collection<Stepper> toAdd){
		for(FormulaNode fn: s.lhs){
			if(fn instanceof Predicate){
				if(((Predicate)fn).getName().equals(p.getName())){
					s.reinit();
					if(toAdd != null) toAdd.add(s);
				}
			}
		}
	}

	@Override
	public void delete(Formula f) {
	}

	@Override
	public void step() {
		for(Stepper s: toReset){
			s.reinit();
			if(steppers.contains(s));
			else steppers.add(s);
		}
		ArrayList<Stepper> toRemove = new ArrayList<Stepper>();
		for(Stepper s: steppers){
			s.step();

			// Hard cap of 500 steps... so that we don't degenerate into an infinite loop

			for(int i=0; i<500 && !s.dfs.empty(); i++){
				s.step();
			}
			if(s.finished){
				//System.out.println("Removing a stepper");	//commented out by Shomir--no longer needed?
				toRemove.add(s);
				diedSteppers.add(s);
			}
		}
		
		steppers.removeAll(toRemove);
	}

}
