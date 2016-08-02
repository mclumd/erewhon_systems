package alma;

import java.util.*;
import alma.util.*;


/**
 * Steps for doing an Iterated Deepening Search:
 * 
 * <ol>
 * <li> Pop stack
 * <li> Traverse Poped item
 * <li> Push Children onto stack
 * </ol>
 *
 * <p>The "tree" traversed is a converted binary tree similar to Infinite Modus Ponens.
 * Convert the tree of infinite bredth and depth into a binary tree using the procedure
 * in Knuth Art of Computer Programming Chapter 2.3.2 "Binary Tree Representation of Trees".
 * A brief overview is described in the InfiniteModusPonens.java file.</p>
 * 
 * <p>The "original" tree is defined as follows. The children of a node are the 
 * results of a single step of resolution. Each child has to satisfy the requirements
 * of a "linear" resolution: ie each resolvant has to be either an input clause, or a
 * "parent". The first node is the negated conclusion.</p>
 * 
 * <p>When converted into a binary tree, the left child is the current node resolving
 * with another node. The right child is the "true parent" resolving with another node, where
 * a true parent is the node's parent in the original tree. </p>
 *
 */
public class GoalInferenceRule extends InferenceRule {
	
	/**
	 * Given two OrFormulas, a Resolver iterates over all possible resolvants of these
	 * two OrFormulas. I promise to only go "Forward".
	 * @author percy
	 *
	 */
	static class Resolver implements Iterator<OrFormula>{
		List<FormulaNode> nearChildren;
		List<FormulaNode> farChildren;
		OrFormula next;
		int nearindex = 0;
		int farindex = 0;
		
		public Resolver(OrFormula nearParent, OrFormula farParent){
			nearChildren = nearParent.getChildren();
			farChildren = ((OrFormula)SubstitutionList.standardizeApart(nearParent, farParent))
								.getChildren();
			next = rawNext();
		}
		
		public boolean hasNext() {
			return next != null;
		}
		
		private boolean hasNextRaw(){
			return nearindex < nearChildren.size();
		}
		
		private void increment(){
			farindex++;
			nearindex += farindex/farChildren.size();
			farindex %= farChildren.size();
		}

		private OrFormula rawNext(){
			if(!hasNextRaw()) return null;
			FormulaNode f1 = nearChildren.get(nearindex);
			FormulaNode f2 = farChildren.get(farindex);
			
			while(!(f1 instanceof NotFormula ^ f2 instanceof NotFormula)){
				increment();
				if(! hasNextRaw()) break;
				f1 = nearChildren.get(nearindex);
				f2 = farChildren.get(farindex);
			}
			
			if(! hasNextRaw()){
				return null;
			}
			
			OrFormula toReturn;
			NotFormula nf;
			FormulaNode other;
			if(f1 instanceof NotFormula){
				nf = (NotFormula) f1;
				other = f2;
			} else {
				nf = (NotFormula) f2;
				other = f1;
			}
			
			SubstitutionList sl = new SubstitutionList();
			if(sl.unify(nf.getChild(), other)){
				//System.out.print("Resolved: " + f1 + " --and-- " + f2);
				FormulaBuilder fb = new FormulaBuilder();
				fb.addOr();
					for(FormulaNode fn: nearChildren){
						if(fn.equals(f1))
							continue;
						fb.add(fn);
					}
					for(FormulaNode fn: farChildren){
						if(fn.equals(f2))
							continue;
						fb.add(fn);
					}
				fb.endChildren();
				toReturn = (OrFormula)fb.getFormulaNode().applySubstitution(sl);
				//System.out.println(" --> " + toReturn);
				//System.out.println("Sublist == " + sl);
			} else {
				increment();
				return rawNext();
			}
			
			increment();
			return merge(toReturn);
		}
		/**
		 * Returns the merged literals
		 */
		private OrFormula merge(OrFormula of){
			ArrayList<FormulaNode> al = new ArrayList<FormulaNode>();
			for(FormulaNode fn: of.getChildren()){
				if(!al.contains(fn)){
					al.add(fn);
				}
			}
			
			FormulaBuilder fb = new FormulaBuilder();
			fb.addOr();
			for(FormulaNode fn: al){
				fb.add(fn);
			}
			fb.endChildren();
			return (OrFormula)fb.getFormulaNode();
		}
		
		public OrFormula next() {
			OrFormula toReturn = next;
			next = rawNext();
			return toReturn;
		}

		public void remove() {
			throw new UnsupportedOperationException("Remove not supported");
		}		
	}
	
	/**
	 * Given an OrFormula and a iterator of OrFormulas, a
	 * MassResolver is an iterator over all possible resolvants. The Iterator
	 * of OrFormulas can be countably infinite. I'm too lazy to make
	 * a CrossIterator that is compadible with normal Iterators, so 
	 * MassResolver is simply a BiIterator that does not support "previous".
	 */
	
	static class MassResolver implements BiIterator<OrFormula>{
		Resolver current;
		OrFormula nearParent;
		Iterator<OrFormula> farParents;
		OrFormula next;
		
		public MassResolver(OrFormula nearParent, Iterator<OrFormula> farParents){
			this.nearParent = nearParent;
			this.farParents = farParents;
			current = new Resolver(nearParent, farParents.next());
			next = rawNext();
		}
		
		/**
		 * Helper function to next
		 * @return Null if no more, the next resolvant if it exists.
		 */
		private OrFormula rawNext(){
			if(current.hasNext()) return current.next();
			else{
				if(farParents.hasNext()){
					current = new Resolver(nearParent, farParents.next());
					return rawNext();
				} else {
					return null;
				}
			}
		}

		public boolean hasNext() {
			return next!= null;
		}

		public OrFormula next() {
			if(next == null) throw new NoSuchElementException();
			OrFormula toReturn = next;
			next = rawNext();
			return toReturn;
		}

		public void remove() {
			throw new UnsupportedOperationException();
		}
		
		public boolean hasPrevious() {
			throw new UnsupportedOperationException("Previous Not Supported");
		}

		public OrFormula previous() {
			throw new UnsupportedOperationException("Previous Not Supported");
		}
		
	}
	
	/**
	 * Given a formula in CNF Form, a OrIterator returns every OrFormula inside
	 * of the CNF formula. A CNF Formula can be either an AndFormula, OrFormula,
	 * NotFormula, or Predicate. AndFormulas need to be "split up" into their 
	 * respective OrFormulas. An OrFormula can just be returned. NotFormulas and
	 * Predicates must be wrapped into an OrFormula and then returned.
	 * 
	 * AndFormulas are hardest, each individual element of an AndFormula is split
	 * up and returned individually.
	 */
	
	static class OrIterator implements BiIterator<OrFormula>{
		BiIterator<FormulaNode> iter;
		ListBiIterator<FormulaNode> andFormulas;
		OrFormula next;

		OrIterator(BiIterator<FormulaNode> cnfFormulas){
			this.iter = cnfFormulas;			
			andFormulas = null;
			next = rawNext();
		}
		
		private OrFormula rawNext(){
			if(andFormulas != null && andFormulas.hasNext()){
				return toOrFormula(andFormulas.next());
			} else {
				if(! iter.hasNext()) {
					return null;
				}
				FormulaNode toReturn = iter.next();
				if(toReturn instanceof AndFormula){
					List<FormulaNode> children = ((AndFormula) toReturn).getChildren();
					andFormulas = new ListBiIterator<FormulaNode>(children.listIterator());
					return toOrFormula(andFormulas.next());
				} else {
					return toOrFormula(toReturn);
				}
			}
		}
		
		public boolean hasPrevious() {
			throw new UnsupportedOperationException("hasPrevious is not supported");
		}
		
		private OrFormula toOrFormula(FormulaNode fn){
			if(fn instanceof OrFormula){
				return (OrFormula) fn;
			} else if(fn instanceof NotFormula || fn instanceof Predicate){
				FormulaBuilder fb = new FormulaBuilder();
				fb.addOr();
					fb.add(fn);
				fb.endChildren();
				return (OrFormula)fb.getFormulaNode();
			} else {
				throw new IllegalArgumentException("Only accepts NotFormulas, Predicates, or OrFormulas");
			}
		}

		public OrFormula previous() {
			throw new UnsupportedOperationException("Previous is not supported");
		}

		public boolean hasNext() {
			return next!= null;
		}

		public OrFormula next() {
			OrFormula toReturn = next;
			next = rawNext();
			return toReturn;
		}

		public void remove() {
			throw new UnsupportedOperationException("Remove is not supported");
		}
		
	}
	
	/**
	 * Similar to InfiniteModusPonens, a GoalInferenceRule will traverse a possibly
	 * infinite tree. Therefore, we need to traverse it through IterativeDeepening.
	 * This organization is similar to InfiniteModusPonenes. The Stepper is an object
	 * that contains everything necessary to continue traversing the search tree, and
	 * StepStates represent each node.
	 * 
	 * Stepper.step traverses a single node. I suggest reading over "InfiniteModusPonens"
	 * first before looking at this code.
	 * 
	 * @author percy
	 *
	 */
	
	static class Stepper{
		
		/**
		 * Represents a single "node" of the tree. Current represents the current 
		 * node of the tree. ResolveCandidates generates the siblings of this tree.
		 * FarParents needs to be tracked: every candidate for a LinearResolution
		 * is as follows: an input node (IE: from the KnowledgeBase.getCNFCandidates), 
		 * or a far parent.
		 * 
		 * A Far Parent is either a near parent, or a near parent of a near parent.
		 * @author percy
		 *
		 */
		private static class StepState{
			public OrFormula current;
			public ArrayList<OrFormula> parents;
			public Iterator<OrFormula> resolveCandidates;
			int depth;
			
			public StepState(OrFormula current, Iterator<OrFormula> resolveCandidates, ArrayList<OrFormula> parents, int depth){		
				this.current = current;
				this.parents = parents;
				this.resolveCandidates = resolveCandidates;
				this.depth = depth;
			}
			
			public String toString(){
				return "[" + current + " , " + resolveCandidates + "]";
			}
		}
		
		private ArrayList<FormulaNode> returned = new ArrayList<FormulaNode>();
		private Stack<StepState> dfs = new Stack<StepState>();
		private int maxDepth=20;
		private int lastMaxDepth = 0;
		private int numAnswered = 0;
		private int maxAnswers;
		private KnowledgeBase kb;
		private GoalCommand goal;
		private OrFormula conclusion; //Raw conclusion in CNF form
		private OrFormula yesConclusion; 
		private FormulaNode answerTemplate;
		
		public Stepper(GoalCommand gc, KnowledgeBase kb){
			this.kb = kb;
			goal = gc;
			FormulaNode f = FormulaSet.toCNF(gc.getTemplate());
			if(f instanceof AndFormula){
				throw new UnsupportedOperationException("Template: " + gc.getTemplate() + "could not be converted into OrFormula. Try a simpler template");
			}
			conclusion = toOr(f);	
			
			List<Variable> listOfVariables = createVariableList(conclusion, new ArrayList<Variable>());
			FormulaBuilder fb = new FormulaBuilder();
			answerTemplate = gc.getAnswerTemplate();
			yesConclusion = convertToYes(conclusion, answerTemplate);
			
			maxAnswers = gc.getNum();
			
			reinit();
		}
		
		/**
		 * Adds formulanode to the knowledge base. Only use this function. This function handles the
		 * bookkeeping necessary to return the correct answers.
		 * @param fn
		 */
		private void addToKB(FormulaNode fn){
			if(!returned.contains(fn)){
				returned.add(fn);
				kb.add(new Formula(fn));
				numAnswered++;
			}
		}
		
		private static OrFormula toOr(FormulaNode fn){
			if(fn instanceof OrFormula)
				return (OrFormula) fn;
			else {
				FormulaBuilder fb  = new FormulaBuilder();
				fb.addOr();
					fb.add(fn);
				fb.endChildren();
				
				return (OrFormula) fb.getFormulaNode();
			}
		}
		
		/**
		 * An alternative way to start off a negated conclusion resolution is to convert the
		 * input clause into the form "input(x) -> answer(x)", where "x" is the vector
		 * of variables used by the input. For efficiency, I don't bother starting with the
		 * implication and instead optimized it to simply "~input(x) | ans(x)", where input
		 * is assumed to be an OrFormula, and ans is the answer predicate.
		 * @param or OrFormula that is assumed to be the (non-negated) conclusion
		 * @param ans the predicate that should be the answer clause
		 * @return
		 */
		private static OrFormula convertToYes(OrFormula or, FormulaNode ans){
			FormulaBuilder fb = new FormulaBuilder();
			fb.addOr();
				for(FormulaNode fn: or.getChildren()){
					if(fn instanceof NotFormula){
						fb.add(((NotFormula) fn).getChild());
					} else {
						fb.addNot();
							fb.add(fn);
						fb.endChildren();
					}
				}
				fb.add(ans);
			fb.endChildren();
			
			return (OrFormula)fb.getFormulaNode();
		}
		
		/**
		 * Creates a list of all the variables that are contained in the complex node cn. Returns them
		 * in the accumulator. The accumulator is the return value.
		 * @param cn
		 * @param accumulator
		 * @return
		 */
		private static List<Variable> createVariableList(ComplexNode cn, List<Variable> accumulator){
			for(FormulaNode fn: cn.getChildren()){
				if(fn instanceof ComplexNode){
					createVariableList((ComplexNode)fn, accumulator);
				} else if (fn instanceof Variable){
					accumulator.add((Variable)fn);
				}
			}
			
			return accumulator;
		}
		
		/**
		 * Creates a Predicate List. Similar to VariableList except this one makes a list of
		 * Predicates
		 *
		 */
		
		private static List<Predicate> createPredicateList(ComplexNode cn, List<Predicate> accumulator){
			if(cn instanceof Predicate){
				accumulator.add((Predicate) cn);
				return accumulator;
			}
			for(FormulaNode fn: cn.getChildren()){
				if(fn instanceof ComplexNode){
					createPredicateList((ComplexNode) fn, accumulator);
				}
			}
			return accumulator;
		}
		
		public void reinit(){
			lastMaxDepth = 0;
			//No parents, no other candidates
			dfs.add(new StepState(yesConclusion, new EmptyIterator<OrFormula>(), new ArrayList<OrFormula>() ,0));
		}
		
		/**
		 * How to tell if this Stepper is done
		 * @return
		 */
		private boolean finished(){
			return ((dfs.empty() && lastMaxDepth < maxDepth)
				|| (numAnswered >= maxAnswers)) && !infinite();
		}
		
		/**
		 * If maxAnswers is -1, then this Stepper is going to step forever non-stop.
		 * It is never finished.
		 * @return
		 */
		private boolean infinite(){
			return maxAnswers == -1;
		}
		
		public void step(){
			if(finished()){
				return;
			}
			if(dfs.empty()){
				maxDepth+=3;
				reinit();
			}
			
			StepState current = dfs.pop();
			lastMaxDepth = Math.max(current.depth, lastMaxDepth);
			
			if(current.depth >= maxDepth){
				return;
			}
			
			List<Predicate> preds = createPredicateList(current.current, new ArrayList<Predicate>());
			
			boolean onlyAnswers = true;
			SubstitutionList sl = new SubstitutionList();
			for(Predicate p: preds){
				sl.reset();
				if(!sl.unify(p, answerTemplate)){
					onlyAnswers = false;
					break;
				}
			}
			
			/* Examples of answer clauses:
			 * ans(1), ans(1) | ans(3), etc. etc.
			 * 
			 * Example of things not to add to the kb:
			 * ans(1) | a(X), ans(2) | c(X), etc. etc.
			 */
			if(onlyAnswers){
				// Return only the first predicate in the simple case
				if(current.current.getChildren().size() == 1){
					addToKB(current.current.getChildren().get(0));
				} else {
					// Return the full OrFormula if avaliable.
					addToKB(current.current);
				}
				if(finished()){
					return;
				}
			} else {
				/* If there weren't an answer clause, then continue exploring this node.
				 * Create left and right child. Left child is a resolution step. The
				 * right child should just replace the current node with its own sibling.
				 */				
				
				// Lets start with creating the left child
				/* Create the resolve candidates as per the rules of LinearResolution:
				 * Either an input clause, or a parent.
				 */
				
				BiIterator<FormulaNode> candidates = kb.getCNFCandidates(preds);
				BiIterator<OrFormula> iter = new OrIterator(candidates);
				ArrayList<OrFormula> newParents = (ArrayList<OrFormula>)current.parents.clone();
				newParents.add(current.current); // Now a parent of the new node
				CrossIterator<OrFormula> resolvantCandidates = 
									new CrossIterator<OrFormula>(
											new ListBiIterator<OrFormula>(newParents.listIterator()),
											iter);
				
				MassResolver resolvants = new MassResolver(current.current, resolvantCandidates);
				if(resolvants.hasNext()){
					StepState leftChild = new StepState(resolvants.next(), resolvants, newParents, current.depth+1);
					dfs.add(leftChild);
				}
				
				//Right Child is easy
				StepState rightChild = current;
				if (rightChild.resolveCandidates.hasNext()){
					rightChild.current = current.resolveCandidates.next();
					current.depth += 1;
					dfs.add(rightChild);
				}
			}
		}
		
		public String toString(){
			return dfs.peek().toString();
		}
	}
	
	ArrayList<Stepper> steppers = new ArrayList<Stepper>();
	
	public GoalInferenceRule(KnowledgeBase kb){
		super(kb);
	}

	@Override
	public boolean add(Formula f) {
		if(f.getHead() instanceof GoalCommand){
			steppers.add(new Stepper((GoalCommand)f.getHead(), getKnowledgeBase()));
			return false; // Don't let any other IR handle this.
		}
		return true;
	}

	@Override
	public void delete(Formula f) {
	}

	@Override
	public void step() {
		for(Stepper s: steppers){
			for(int i=0; i<500; i++){
				s.step();
			}
		}
	}

}