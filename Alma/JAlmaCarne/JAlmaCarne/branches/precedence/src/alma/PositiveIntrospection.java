package alma;

import java.util.*;
import almaparse.*;

import alma.callfile.BiIterator;

public class PositiveIntrospection {
	
	public PositiveIntrospection() {}
	
	public static Iterator<FormulaNode> findAnswer(Predicate template, History hist) {
		BiIterator iter = new NoAnswer(template);
		if(template.getChildren().size() == 3) { //only handle combine with three arguments
			//combine(x,y,z) i.e. combine("a","b","ab");
			if(template.getChildren().get(1) instanceof TimeConstant) {
				if(template.getChildren().get(2) instanceof StringConstant) {
					iter = new BoundBound(hist, template);
				}
				else {
					iter = new BoundUnbound(hist, template);
				}
			}
			else {
				if(template.getChildren().get(2) instanceof StringConstant) {
					iter = new UnboundBound(hist, template);
				}
				else {}
			}
		}

		return (iter);
	}
	
	public static class BoundBound implements BiIterator{
		Predicate nextPred;
		boolean next = true;
		
		public BoundBound(History hist, Predicate template) {
			Iterator<List<Formula>> iter = hist.iterator();
			String search = template.getChildren().get(2).toString();
			search = search.substring(1,search.length()-1);
			for(long i=1; i< (((TimeConstant)(template.getChildren().get(1))).toLong()) & iter.hasNext();i++) {
				iter.next();
			}
			if(iter.hasNext()) {
				ArrayList<Formula> answer = new ArrayList<Formula>(iter.next());
				if(answer.contains(AlmaParser.parseString(search)))
					nextPred = template;
				else 
					nextPred = null;
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
	
	public static class UnboundBound implements BiIterator{
		ArrayList<Long> times = new ArrayList<Long>();
		public UnboundBound(History hist, Predicate template) {
			Iterator<List<Formula>> iter = hist.iterator();
			String search = template.getChildren().get(2).toString();
			search = search.substring(1,search.length()-1);
			ArrayList<Formula> answer = new ArrayList<Formula>();
			long i = 1;
			while(iter.hasNext()) {
				answer = new ArrayList<Formula>(iter.next());
				if(answer.contains(AlmaParser.parseString(search)))
					times.add(i);
				i++;
			}
			
					//nextPred = template;
				///else 
					//nextPred = null;
			
		}
		
		public boolean hasPrevious() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode previous() {
			// TODO Auto-generated method stub
			return null;
		}

		public boolean hasNext() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode next() {
			// TODO Auto-generated method stub
			return null;
		}

		public void remove() {
			// TODO Auto-generated method stub
			
		}
		
	}
	
	public static class BoundUnbound implements BiIterator{

		public BoundUnbound(History hist, Predicate template) {
			
		}
		
		public boolean hasPrevious() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode previous() {
			// TODO Auto-generated method stub
			return null;
		}

		public boolean hasNext() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode next() {
			// TODO Auto-generated method stub
			return null;
		}

		public void remove() {
			// TODO Auto-generated method stub
			
		}
		
	}
	
	public static class NoAnswer implements BiIterator{

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
