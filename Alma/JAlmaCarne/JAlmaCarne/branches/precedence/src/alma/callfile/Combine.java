package alma.callfile;
import alma.*;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.NoSuchElementException;

import alma.FormulaNode;
import alma.Predicate;
import alma.StringConstant;

public class Combine {
		
		public static Iterator<FormulaNode> findAnswer(Predicate template) {
			BiIterator iter = new NoAnswer(template);
			if(template.getChildren().size() == 4) { //only handle combine with three arguments
				//combine(x,y,z) i.e. combine("a","b","ab");
				if(template.getChildren().get(1) instanceof StringConstant) {
					if(template.getChildren().get(2) instanceof StringConstant) {
						if(template.getChildren().get(3) instanceof StringConstant) {
							iter = new BoundBoundBound(template);
						}
						else {
							iter = new BoundBoundUnbound(template);
						}
					}
					else {
						if(template.getChildren().get(3) instanceof StringConstant) {
							iter = new BoundUnboundBound(template);
						}
					}
				}
				else {
					if(template.getChildren().get(2) instanceof StringConstant) {
						if(template.getChildren().get(3) instanceof StringConstant) {
							iter = new UnboundBoundBound(template);
						}
					}
				}
			}

			return (iter);
		}
		
		public static class UnboundBoundBound implements BiIterator{
			Predicate nextPred;
			boolean next = true;
			
			public UnboundBoundBound(Predicate template) {
				ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
				String comb = args.get(3).toString();
				comb = comb.substring(1,comb.length()-1);
				String first = args.get(2).toString();
				first = first.substring(1,first.length()-1);
				String ans = "\""+comb.substring(0,comb.lastIndexOf(first))+"\"";
				args.set(1,new SymbolicConstant(ans));
				args.remove(0);
				nextPred = new Predicate(template.getName(),args);
			}
			
			public boolean hasPrevious() {
				return !hasNext() && nextPred!=null;
			}

			public FormulaNode previous() {
				next = true;
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
		
		public static class BoundUnboundBound implements BiIterator{
			
			Predicate nextPred;
			boolean next = true;
			
			public BoundUnboundBound(Predicate template) {
				ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
				String comb = args.get(3).toString();
				comb = comb.substring(1,comb.length()-1);
				String first = args.get(1).toString();
				first = first.substring(1,first.length()-1);
				String ans = "\""+comb.substring(first.length())+"\"";
				args.set(2,new SymbolicConstant(ans));
				args.remove(0);
				nextPred = new Predicate(template.getName(),args);
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
		
		public static class BoundBoundUnbound implements BiIterator{
			Predicate nextPred;
			boolean next = true;
			
			public BoundBoundUnbound(Predicate template) {
				ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
				String first= args.get(1).toString();
				first = first.substring(1,first.length()-1);
				String second = args.get(2).toString();
				second = second.substring(1,second.length()-1);
				String ans = "\""+first+second+"\"";
				args.set(3,new SymbolicConstant(ans));
				args.remove(0);
				nextPred = new Predicate(template.getName(),args);
			}
			
			public boolean hasPrevious() {
				return !hasNext() && nextPred!=null;
			}

			public FormulaNode previous() {
				next = true;
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
		
		public static class BoundBoundBound implements BiIterator{
			Predicate nextPred;
			boolean next = true;
			
			public BoundBoundBound(Predicate template) {
				ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
				String first= args.get(1).toString();
				first = first.substring(1,first.length()-1);
				String second = args.get(2).toString();
				second = second.substring(1,second.length()-1);
				String ans = "\""+first+second+"\"";
				String finalAns = args.get(3).toString();
				if(ans.equals(finalAns))
					nextPred = template;

			}
			
			public boolean hasPrevious() {
				return !hasNext() && nextPred!=null;
			}

			public FormulaNode previous() {
				next = true;
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