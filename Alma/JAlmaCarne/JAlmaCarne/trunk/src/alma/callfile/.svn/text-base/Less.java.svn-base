package alma.callfile;

import alma.*;
import java.util.*;
import alma.util.*;
/**
 * For something so simple as less it sure takes alot of code, mostly because less is infinite
 * i.e. less(0,X) returns an iterator which will go all the way to less(0,_really large number_) if you
 * want it to.
 * 
 * 
 * @author joey
 *
 */
public class Less implements CallFormula{
		
	/**
	 * Because this class imlements CallFormula, findAnswer must manually be defined.
	 * 
	 */
		public BiIterator<FormulaNode> findAnswer(Predicate template) {
			//By default, return an Empty Iterator
			BiIterator<FormulaNode> iter = new EmptyIterator<FormulaNode>();
			if(template.getChildren().size() == 3) { 

				//Which form should we use, less(1,5), less(1,X), less(X,5)?
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
		
		/**
		 * These are just the iterators that will be returned, each has very intuitive methods which 
		 * apply for their specific situation.  For instance, when you call next on BoundUnbound 
		 * 1 is added to the previous value so less(0,X) generates less(0,1) during the constructor and
		 * returns it when you call next, and in doing so also generates less(0,2) for the next call to 
		 * next.
		 * If both variables are bound the iterator simply does a correctness check
		 * i.e. less(4,5) should return less(4,5) but less(5,4) should return an empty iterator.
		 * 
		 * @author joey
		 *
		 */
		
		/**
		 * less(1,2)
		 */
		public class BoundBound implements BiIterator<FormulaNode>{
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
		
		/**
		 * less(X,2)
		 */
		public class UnboundBound implements BiIterator<FormulaNode> {
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
		
		/**
		 * less(1,X)
		 */
		public class BoundUnbound implements BiIterator<FormulaNode>{
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

	}