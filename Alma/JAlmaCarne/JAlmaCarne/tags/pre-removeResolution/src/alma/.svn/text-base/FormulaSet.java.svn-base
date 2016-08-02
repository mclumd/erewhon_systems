package alma;

import java.util.*;

/**
 * The Database class holds formulas. It is used to
 * hold a single "step" or could be used for the
 * primary/secondary databases K. Purang refered to.
 * 
 * Basically, this holds a bunch of formulas. No
 * formulas should repeat, and K. Purang's metric was
 * whether or not both 
 * 
 * @author Percy Tiglao
 *
 */

public class FormulaSet {
	HashMap<Formula, Formula> formulas;
	
	public FormulaSet(){
		formulas = new HashMap();
	}
	
	public void add(Formula f){
		formulas.put(f, toCNF(f));
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
		toCNF3(fn, fb); // move "and" outside and "or" inside
		fn = fb.getFormulaNode();
		//fb.clear();
		
		fn = fn.cleanup();

		return new Formula(fn);
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
		} else if( fn instanceof IfNewFormula){
			throw new IllegalArgumentException("toCNF does not take IfNewFormula");
		}
			else {
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
	private static void toCNF3(FormulaNode fn, FormulaBuilder fb){
		CNFIterator i = CNFIterator.create(fn);
		fb.addAnd();
			while(i.hasNext()){
				fb.add(i.getNext());
			}
			fb.endChildren();
	}
}