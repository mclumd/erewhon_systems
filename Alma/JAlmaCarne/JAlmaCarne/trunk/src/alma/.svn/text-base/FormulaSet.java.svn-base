package alma;

import java.util.*;

/**
 * The Database class holds formulas. It is used to
 * hold a single "step" or could be used for the
 * primary/secondary databases K. Purang refered to.
 * 
 * Basically, this holds a bunch of formulas. No
 * formulas should repeat, and K. Purang's metric was
 * whether or not both subsumed each other
 * 
 * @author Percy Tiglao
 *
 */

public class FormulaSet {
	HashMap<Formula, Formula> formulas=new HashMap<Formula, Formula>();
	
	public FormulaSet(){
	}
	
	public void add(Formula f){
		formulas.put(f, toCNF(f));
	}
	
	public Formula get(Formula f) {
		return formulas.get(f);
	}
	
	public void remove(Formula f) {
		formulas.remove(f);
	}
	
	public String toString() {
		return formulas.toString();
	}
	
//These steps turn an arbitrary formula into CNF
	public static Formula toCNF(Formula f){
		FormulaBuilder fb = new FormulaBuilder();
		FormulaNode fn = f.getHead();
		toCNF1(fn, fb); // Convert a -> b to ~a | b
		fn = fb.getFormulaNode();
		fb.clear();
		toCNF2(fn, fb); // move negations inward and take care of 2x negative
		fn = fb.getFormulaNode();
		fb.clear();
		toCNF3(fn, fb,new ArrayList<Variable>(),new HashMap<Variable,FormulaNode>(),new HashSet<Variable>(),new IntWrapper()); // Skolemize to remove Existential quantifiers
		fn = fb.getFormulaNode();
		fb.clear();
		toCNF4(fn, fb); // move "and" outside and "or" inside
		fn = fb.getFormulaNode();
		//fb.clear();
		
		fn = fn.cleanup();

		return new Formula(fn);
	}
	
	public static FormulaNode toCNF(FormulaNode fn){
		return toCNF(new Formula(fn)).getHead();
	}
	
	private static void toCNF1(FormulaNode fn, FormulaBuilder fb){
		if(! (fn instanceof ComplexNode)){
			fb.add(fn); // Might want to be a "clone", check later
		} else if( fn instanceof IfFormula){
			IfFormula f = (IfFormula) fn;
			fb.addOr();
				fb.addNot();
					toCNF1(f.getLeft(), fb);
					fb.endChildren();
				toCNF1(f.getRight(), fb);
				fb.endChildren();
		} else {
			ComplexNode c = (ComplexNode) fn;
			fb.addType(c);
				for(FormulaNode f: c.getChildren()){
					toCNF1(f, fb);
				}
				fb.endChildren();
		}
	}
	
	private static void toCNF2(FormulaNode fn, FormulaBuilder fb){
		if(! (fn instanceof ComplexNode)){
			fb.add(fn); // Might want to be a "clone", check later
		} else if( fn instanceof NotFormula){
			NotFormula nf = (NotFormula) fn;
			FormulaNode child = nf.getChild();
			if(child instanceof NotFormula){ // Remove double negatives
				NotFormula nfChild = (NotFormula) child;
				toCNF2(nfChild.getChild(), fb);
				return;
			} else if (child instanceof AndFormula){ //Demorgan's Law. And
				AndFormula andChild = (AndFormula) child;
				fb.addOr();
					for(FormulaNode f: andChild.getChildren()){
						if(f instanceof NotFormula){ // Double Negative
							toCNF2(((NotFormula)f).getChild(), fb);
						} else {
							fb.addNot();
								toCNF2(f, fb);
								fb.endChildren();
						}
					}
					fb.endChildren(); // the "fb.addOr()" ~10 lines back
				return;
			} else if (child instanceof OrFormula){ //Demorgan's Law. Or
				OrFormula andChild = (OrFormula) child;
				fb.addAnd();
					for(FormulaNode f: andChild.getChildren()){
						if(f instanceof NotFormula){ // Double Negative
							toCNF2(((NotFormula)f).getChild(), fb);
						} else {
							fb.addNot();
								toCNF2(f, fb);
								fb.endChildren();
						}
					}
					fb.endChildren(); // the "fb.addAND()" ~10 lines back
				return;
			} else if(child instanceof ExistentialFormulaNode) {
				ExistentialFormulaNode e = (ExistentialFormulaNode)child;
				fb.addUniversal(e.getVariables());
					if(e.getFormula() instanceof NotFormula){
						toCNF2(((NotFormula)e.getFormula()).getChild(), fb);
					}
					else if(e.getFormula() instanceof ExistentialFormulaNode || e.getFormula() instanceof UniversalFormulaNode ) {
						NotFormula notForm = new NotFormula(e.getFormula());
						toCNF2(notForm,fb);
					}
					else {
					fb.addNot();
						toCNF2(e.getFormula(),fb);
						fb.endChildren();
					}
					fb.endChildren();
			} else if(child instanceof UniversalFormulaNode) {
				UniversalFormulaNode e = (UniversalFormulaNode)child;
				fb.addExistential(e.getVariables());
					if(e.getFormula() instanceof NotFormula){
						toCNF2(((NotFormula)e.getFormula()).getChild(), fb);
					}
					else if(e.getFormula() instanceof ExistentialFormulaNode || e.getFormula() instanceof UniversalFormulaNode ) {
						NotFormula notForm = new NotFormula(e.getFormula());
						toCNF2(notForm,fb);
					}
					else {
					fb.addNot();
						toCNF2(e.getFormula(),fb);
						fb.endChildren();
					}
					fb.endChildren();
			} else { //"normal" not formula
				fb.add(fn);
			}
		} else {
			ComplexNode c = (ComplexNode) fn;
			fb.addType(c);
				for(FormulaNode f: c.getChildren()){
					toCNF2(f, fb);
				}
				fb.endChildren();
		}
	}
	
	private static Set<Variable> argHelper(ArrayList<Variable> dontTouch, FormulaNode fn) {
		HashSet<Variable> ans = new HashSet<Variable>();
		if(fn instanceof ComplexNode) {
			ComplexNode cn = (ComplexNode)fn;
			if(fn instanceof ExistentialFormulaNode) {
				ArrayList<Variable> dontTouchCopy = new ArrayList<Variable>(dontTouch);
				dontTouchCopy.addAll(((ExistentialFormulaNode)fn).getVariables());
				ans.addAll(argHelper(dontTouchCopy,((ExistentialFormulaNode)fn).getFormula()));
			}
			else if(fn instanceof UniversalFormulaNode) { 
				ArrayList<Variable> dontTouchCopy = new ArrayList<Variable>(dontTouch);
				dontTouchCopy.addAll(((UniversalFormulaNode)fn).getVariables());
				ans.addAll(argHelper(dontTouchCopy,((UniversalFormulaNode)fn).getFormula()));
			}
			else {
				for	(FormulaNode child : cn.getChildren()) {
					if(child instanceof Variable &&  !dontTouch.contains(child)) {
						ans.add((Variable)child);
					}
					else if(child instanceof ComplexNode) {
						ans.addAll(argHelper(dontTouch, child));
					}
				}
			}
		}
		return ans;
	}
	
	private static class IntWrapper {
		public int value = 0;
	}
	
	private static void toCNF3(FormulaNode fn, FormulaBuilder fb, 
							   ArrayList<Variable> toReplace, 
							   HashMap<Variable,FormulaNode> bound, 
							   Set<Variable> args,
							   IntWrapper formulaNumber) {
		//System.out.println(fn + " " +toReplace+ " " +bound+ " " +args);
		if(fn instanceof Variable && toReplace.contains(fn)) {
			//System.out.println("\t Var: " + fn);
			if(bound.containsKey((Variable)fn)) {
				fb.add(bound.get(fn));		
			}
			else {
				Function func = new Function("f"+String.valueOf(formulaNumber.value), true);
				FormulaNode toAdd = func;
				func.getChildren().addAll(args);
			
				if(args.size() == 0) toAdd= new SymbolicConstant("\\C"+String.valueOf(formulaNumber.value), true);
				fb.add(toAdd);
				bound.put((Variable)fn,toAdd);
				formulaNumber.value += 1;
			}
		} else if(! (fn instanceof ComplexNode)){
			fb.add(fn); // Might want to be a "clone", check later
		} else if( fn instanceof ExistentialFormulaNode){
			ExistentialFormulaNode f = (ExistentialFormulaNode) fn;
			ArrayList<Variable> replace = f.getVariables();
			replace.addAll(toReplace);
			HashMap<Variable,FormulaNode> newBound = new HashMap<Variable,FormulaNode>();
			toCNF3(f.getFormula(),fb,replace,bound,argHelper(f.getVariables(),f.getFormula()),formulaNumber);
		} else if( fn instanceof UniversalFormulaNode) {
			UniversalFormulaNode f = (UniversalFormulaNode) fn;
			Set<Variable> newArgs = argHelper(toReplace,f.getFormula());
			newArgs.addAll(f.getVariables());
				if(toReplace.size() > 0 && args.size()==0) {
					for(Variable v : toReplace) {
						if(!bound.containsKey(v)) {
							bound.put(v,new SymbolicConstant("\\C"+String.valueOf(formulaNumber.value),true));
							formulaNumber.value += 1;
						}
					}
				} else if(toReplace.size() > 0) {
					for(Variable v : toReplace) {
						if(bound.containsKey(v)) continue;
						Function func = new Function("f"+String.valueOf(formulaNumber.value), true);
						func.getChildren().addAll(args);
						bound.put(v, func);
						formulaNumber.value += 1;
					}
				}
			toCNF3(f.getFormula(),fb,toReplace,bound,newArgs,formulaNumber);
		} else {
			ComplexNode c = (ComplexNode) fn;
			fb.addType(c);
				for(FormulaNode f: c.getChildren()){
					toCNF3(f, fb,toReplace,bound, args, formulaNumber);
				}
				fb.endChildren();
		}
	}
	
	private static abstract class CNFIterator{
		protected CNFIterator(){
		}
		
		public abstract FormulaNode getNext();
		public abstract boolean hasNext();
		
		public static CNFIterator create(FormulaNode fn){
			if(fn instanceof AndFormula){
				return new CNFAndIterator((AndFormula)fn);
			} else if (fn instanceof OrFormula){
				return new CNFOrIterator((OrFormula)fn);
			} else {
				return new CNFGeneralIterator(fn);
			}
		}
	}
	private static class CNFGeneralIterator extends CNFIterator{
		FormulaNode fn;
		boolean sent = false;
		
		CNFGeneralIterator(FormulaNode fn){
			this.fn = fn;
		}

		@Override
		public FormulaNode getNext() {
			sent = true;
			return fn;
		}

		@Override
		public boolean hasNext() {
			return !sent;
		}
		
		
	}
	
	private static class CNFAndIterator extends CNFIterator{
		AndFormula af;
		CNFIterator currentIterator;
		int currentChild = 1;
		
		CNFAndIterator(AndFormula af){
			this.af = af;
			currentIterator = CNFIterator.create(af.getChildren().get(0));
		}

		@Override
		public FormulaNode getNext() {
			if(currentIterator.hasNext()){
				return currentIterator.getNext();
			} else {
				currentIterator = CNFIterator.create(af.getChildren().get(currentChild));
				++currentChild;
				return getNext();
			}
		}

		@Override
		public boolean hasNext() {
			if(currentIterator.hasNext()){
				return true;
			} else {
				return currentChild < af.getChildren().size();
			}
		}
	}
	
	private static class CNFOrIterator extends CNFIterator{
		OrFormula of;
		CNFIterator iterators[];
		FormulaBuilder fb= new FormulaBuilder();
		
		CNFOrIterator(OrFormula of){
			this.of = of;
			iterators = new CNFIterator[of.getChildren().size()];
			for(int i=0; i<iterators.length; i++){
				createIterator(i);
			}
			fb.addOr();
				for(CNFIterator i:iterators){
					fb.add(i.getNext());
				}
		}
		
		private void createIterator(int i){
			iterators[i] = CNFIterator.create(of.getChildren().get(i));
		}

		@Override
		public FormulaNode getNext() {
			FormulaNode toReturn = fb.getFormulaNode();
			int i;
			
			fb.pop();
			
			for(i=iterators.length-1; ! iterators[i].hasNext() && i>0; i--){
				fb.pop();
				createIterator(i);
			}
			if(i == 0 && !(iterators[i].hasNext())){
				iterators = null;
				return toReturn;
			}
			for(; i<iterators.length; i++){
				fb.add(iterators[i].getNext());
			}
			
			return toReturn;
		}

		@Override
		public boolean hasNext() {
			return iterators != null;
		}
	}
	
	//From previous 2 steps, now move "or" inside of "ands"
	//through distributive law
	private static void toCNF4(FormulaNode fn, FormulaBuilder fb){
		CNFIterator i = CNFIterator.create(fn);
		fb.addAnd();
			while(i.hasNext()){
				fb.add(i.getNext());
			}
			fb.endChildren();
	}
}