package alma.callfile;

import alma.*;
import java.util.Iterator;
import java.util.NoSuchElementException;

import alma.FormulaNode;
import alma.Predicate;
import alma.TimeConstant;

public class Less {
		
		public static BiIterator findAnswer(Predicate template) {
			BiIterator iter = new NoAnswer(template);
			if(template.getChildren().size() == 3) { //only handle less with two arguments
				//We should make this easier for the end programmer
				if(template.getChildren().get(1) instanceof TimeConstant) {
					if(template.getChildren().get(2) instanceof TimeConstant) {
						iter = new BoundBound(template);
					}
					else if(template.getChildren().get(2) instanceof Variable){
						iter = new BoundUnbound(template);
					}
				}
				else if(template.getChildren().get(1) instanceof Variable) {
					if(template.getChildren().get(2) instanceof TimeConstant) {
						iter = new UnboundBound(template);
					}
					else {
					}
				}
			}

			return (iter);
		}
		
		public static class BoundBound implements BiIterator{
			Predicate nextPred = null;
			
			public BoundBound (Predicate template) {
				long num1 = Integer.parseInt(template.getChildren().get(1).toString());
				long num2 = Integer.parseInt(template.getChildren().get(2).toString());
				if(num1<num2) 
					nextPred = template;
			}
			
			public boolean hasNext() {
				return nextPred!=null;
			}

			public FormulaNode next() {
				FormulaNode fn = nextPred;
				if(nextPred == null) throw new NoSuchElementException("This does not exist");
				nextPred = null;
				return fn;
			}

			public void remove() {
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
		
		public static class UnboundBound implements BiIterator {
			long last;
			Predicate template;
			Predicate nextPred = null;
			Predicate prevPred = null;
			
			public UnboundBound(Predicate template) {
				this.template = template;
				long num = Integer.parseInt(template.getChildren().get(2).toString());
				last = num-1;		
				nextPred = new Predicate
				(template.getName(), 
				(FormulaNode)(new TimeConstant(last)), 
				template.getChildren().get(2));
				prevPred = template;
			}
			
			public void remove() {
			}

			public boolean hasNext() {
				return true;
			}

			public FormulaNode next() {
				nextPred = new Predicate
				(template.getName(), 
				(FormulaNode)(new TimeConstant(last)), 
				template.getChildren().get(2));
				last-=1;
				return nextPred;
			}

			public boolean hasPrevious() {
				return Integer.parseInt(template.getChildren().get(2).toString())!=last+1;
			}

			public FormulaNode previous() {
				prevPred = new Predicate
				(template.getName(), 
				(FormulaNode)(new TimeConstant(last+1)), 
				template.getChildren().get(2));
				
				last+=1;
				return prevPred;
			}
			
			
		}
		
		public static class BoundUnbound implements BiIterator{
			long last;
			Predicate template;
			Predicate nextPred = null;
			Predicate prevPred = null;
			
			public BoundUnbound(Predicate template) {
				this.template = template;
				long num = Integer.parseInt(template.getChildren().get(1).toString());
				last = num+1;
				nextPred = new Predicate
				(template.getName(), 
				template.getChildren().get(1),
				(FormulaNode)(new TimeConstant(last)));
				prevPred = template;
			}
			
			public void remove() {
			}

			public boolean hasNext() {
				return true;
			}

			public FormulaNode next() {
				nextPred = new Predicate
				(template.getName(), 
				template.getChildren().get(1),
				(FormulaNode)(new TimeConstant(last)));

				last+=1;
				return nextPred;
			}

			public boolean hasPrevious() {
				return Integer.parseInt(template.getChildren().get(1).toString())!=last-1;
			}

			public FormulaNode previous() {
				prevPred = new Predicate
				(template.getName(), 
				template.getChildren().get(1),
				(FormulaNode)(new TimeConstant(last-1)));
				
				last-=1;
				return prevPred;
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
				throw new NoSuchElementException("Impossible to compute answer");
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