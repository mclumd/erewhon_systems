package alma;

import java.util.*;

import alma.util.BiIterator;


public class FormulaID {
	
	public FormulaID() {}
	
	public static BiIterator<FormulaNode> findAnswer(Predicate template, KnowledgeBase kb) {
		BiIterator<FormulaNode> iter = new NoAnswer(template);
		if(template.getChildren().size() == 3) { //only handle formulaID with two arguments
			//formulaID(formula,id)
			if(template.getChildren().get(1) instanceof FormulaNode & !(template.getChildren().get(1) instanceof Variable)) {
				if(template.getChildren().get(2) instanceof TimeConstant) {
					iter = new BoundBound(kb, template);
				}
				else if(template.getChildren().get(2) instanceof Variable){
					iter = new BoundUnbound(kb, template);
				}
			}
			else if(template.getChildren().get(1) instanceof Variable) {
				if(template.getChildren().get(2) instanceof TimeConstant) {
					iter = new UnboundBound(kb, template);
				}
				else {}
			}
		}

		return (iter);
	}
	
	public static class BoundBound implements BiIterator<FormulaNode>{
		Predicate nextPred;
		boolean next = true;
		
		public BoundBound(KnowledgeBase kb, Predicate template) {
			BiIterator<Formula> iter = kb.getAllFormulas();
			Formula temp;
			while(iter.hasNext()) {
				temp = iter.next();
				if(temp.getHead().equals(template.getChildren().get(1)) &&
				   temp.getID() == ((TimeConstant)template.getChildren().get(2)).toLong()) {
					nextPred = template;
				}
			}
			
		}
		
		public boolean hasPrevious() {
			return !hasNext() && nextPred!=null;
		}

		public FormulaNode previous() {
			return nextPred;
		}

		public boolean hasNext() {
			return next && nextPred!=null;
		}

		public FormulaNode next() {
			next = false;
			return nextPred;
		}

		public void remove() {
		}
	}
	
	public static class UnboundBound implements BiIterator<FormulaNode>{
		Predicate nextPred;
		boolean next = true;
		
		public UnboundBound(KnowledgeBase kb, Predicate template) {
			BiIterator<Formula> iter = kb.getAllFormulas();
			Formula temp;
			while(iter.hasNext()) {
				temp = iter.next();
				if(temp.getID() == ((TimeConstant)template.getChildren().get(2)).toLong()) {
					nextPred = new Predicate(template.getName(),
											 temp.getHead(),
											 template.getChildren().get(2));
				}
			}
		}
		
		public boolean hasPrevious() {
			return !hasNext() && nextPred!=null;
		}

		public FormulaNode previous() {
			return nextPred;
		}

		public boolean hasNext() {
			return next && nextPred!=null;
		}

		public FormulaNode next() {
			next = false;
			return nextPred;
		}

		public void remove() {
		}
		
	}
	
	public static class BoundUnbound implements BiIterator<FormulaNode>{
		Predicate nextPred;
		boolean next = true;
		
		public BoundUnbound(KnowledgeBase kb, Predicate template) {
			BiIterator<Formula> iter = kb.getAllFormulas();
			Formula temp;
			while(iter.hasNext()) {
				temp = iter.next();
				if(temp.getHead().equals(template.getChildren().get(1))) {
					nextPred = new Predicate(template.getName(),
											 template.getChildren().get(1),
											 new TimeConstant(temp.getID()));
				}
			}
		}
		
		public boolean hasPrevious() {
			return !hasNext() && nextPred!=null;
		}

		public FormulaNode previous() {
			return nextPred;
		}

		public boolean hasNext() {
			return next && nextPred!=null;
		}

		public FormulaNode next() {
			next = false;
			return nextPred;
		}

		public void remove() {
		}
	}
	
	public static class NoAnswer implements BiIterator<FormulaNode>{

		public NoAnswer(Predicate template) {
			
		}
		
		public boolean hasNext() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode next() {
			// TODO Auto-generated method stub
			throw new NoSuchElementException("This does not exist");
		}

		public void remove() {
			// TODO Auto-generated method stub
			
		}

		public boolean hasPrevious() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode previous() {
			// TODO Auto-generated method stub
			return null;
		}
		
	}
	
	
	
}
