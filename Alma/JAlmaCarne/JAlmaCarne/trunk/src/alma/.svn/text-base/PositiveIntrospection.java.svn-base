package alma;


import java.util.*;

import alma.util.*;

public class PositiveIntrospection {
	
	public PositiveIntrospection() {}
	
	public static BiIterator<FormulaNode> findAnswer(Predicate template, HistoryDiff hist) {
		BiIterator<FormulaNode> iter = new EmptyIterator<FormulaNode>();
		if(template.getChildren().size() == 3 && template.getChildren().get(2) instanceof FormulaNode) { //only handle combine with three arguments
			if(template.getChildren().get(1) instanceof TimeConstant) {
				if(template.getChildren().get(2) instanceof FormulaNode && 
						!(template.getChildren().get(2) instanceof Variable)) {
					iter = new BoundBound(hist, template);
				}
				else {
					iter = new BoundUnbound(hist, template);
				}
			}
			else {
				if(template.getChildren().get(2) instanceof FormulaNode) {
					iter = new UnboundBound(hist, template);
				}
				else {}
			}
		}
		return (iter);
	}
	
	public static class BoundBound implements BiIterator<FormulaNode>{
		Predicate nextPred;
		boolean next = true;
		
		public BoundBound(HistoryDiff hist, Predicate template) {
			Iterator<Operation[]> iter = hist.iterator();
			Formula search = new Formula(template.getChildren().get(2));
			Operation[] ops;
			boolean correct = false;
			long num = (((TimeConstant)(template.getChildren().get(1)))).toLong();
			for(long i=0; i< num  & iter.hasNext();i++) {
				ops = iter.next();
				for(Operation o : ops) {
					if(o != null && o instanceof AddOperation && o.val.equals(search)) {
						correct = true;
					}
					else if(o != null && o instanceof SubOperation && o.val.equals(search))
						correct = false;
					}
			}
				if(correct)
					nextPred = template;
				else 
					nextPred = null;
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
		ArrayList<FormulaNode> all_answers= new ArrayList<FormulaNode>();
		ListIterator<FormulaNode> l_iter = all_answers.listIterator();
		
		public UnboundBound(HistoryDiff hist, Predicate template) {
			Iterator<Operation[]> iter = hist.iterator();
			Formula search = new Formula(template.getChildren().get(2));
			Operation[] ops;
			boolean correct = false;
			for(long i=0; iter.hasNext();i++) {
				ops = iter.next();
				for(Operation o : ops) {
					if(o != null && o instanceof AddOperation && o.val.equals(search)) {
						correct = true;
						break;
					}
					else if(o != null && o instanceof SubOperation && o.val.equals(search)) {
						correct = false;
					System.out.println("Saw: "+o);
					break;
					}
				}
				if(correct) {
					Predicate p = new Predicate(	template.getName(),
						      new TimeConstant(i+1),
							  template.getChildren().get(2));
					if(!all_answers.contains(p))all_answers.add(p);
				}
			}
			l_iter = all_answers.listIterator();
		}
		
		public boolean hasPrevious() {
			return l_iter.hasPrevious();
		}

		public FormulaNode previous() {
			return l_iter.previous();
		}

		public boolean hasNext() {
			return l_iter.hasNext();
		}

		public FormulaNode next() {
			return l_iter.next();
		}

		public void remove() {
			l_iter.remove();
		}
		
	}
	
	public static class BoundUnbound implements BiIterator<FormulaNode>{
		ArrayList<FormulaNode> all_answers= new ArrayList<FormulaNode>();
		ListIterator<FormulaNode> l_iter = all_answers.listIterator();
	
		public BoundUnbound(HistoryDiff hist, Predicate template) {
			Iterator<Operation[]> iter = hist.iterator();
			Operation[] ops;
			long num = (((TimeConstant)(template.getChildren().get(1)))).toLong();
			
			for(long i=0; i< num  & iter.hasNext();i++) {
				ops = iter.next();
				for(Operation o : ops) {
					if(o != null && o instanceof AddOperation) {
						all_answers.add(o.val.getHead());
					}
					else if(o != null && o instanceof SubOperation)
						all_answers.remove(o.val.getHead());
					}
			}
			for(int i=0;i<all_answers.size();i++) {
				all_answers.set(i, new Predicate(	template.getName(),
								   template.getChildren().get(1),
								   all_answers.get(i)));
			}
			
			l_iter = all_answers.listIterator();

		}
		
		public boolean hasPrevious() {
			return l_iter.hasPrevious();
		}

		public FormulaNode previous() {
			return l_iter.previous();
		}

		public boolean hasNext() {
			return l_iter.hasNext();
		}

		public FormulaNode next() {
			return l_iter.next();
		}

		public void remove() {
			l_iter.remove();
		}
	
		
	}
	}
