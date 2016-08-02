package alma.callfile;

import alma.FormulaNode;
import alma.Predicate;
import alma.util.BiIterator;
/**
 * <p>
 * One more abstraction of the Call API.  SimpleCallFormula is the class to extend when you only need
 * to return a single answer.  All the end user has to do is program the generateAnswer method, 
 * which takes a Predicate template and returns a Predicate answer.  Once a SimpleCall is loaded, it functions
 * in the same fashion that other calls do, in that various inference rules can reference the call
 * even if the predicates are not explicitly in the kb.
 * 
 * @see @link CallFormula
 * </p>
 * 
 * @author joey
 */
public abstract class SimpleCallFormula implements CallFormula {

	public BiIterator<FormulaNode> findAnswer(Predicate template){
		return new GenericIterator(generateAnswers(template));
	}
	
	protected abstract Predicate[] generateAnswers(Predicate template);
	
	private class GenericIterator implements BiIterator<FormulaNode>{
		int index = 0;
		Predicate[] answers;
		boolean empty = false;
		
		public GenericIterator(Predicate[] answers) {
			this.answers = answers;
			empty = answers==null || answers.length==0;
		}
		
		public boolean hasPrevious() {
			return !empty && index>0;
		}

		public FormulaNode previous() {
			return answers[--index];
		}

		public boolean hasNext() {
			return !empty && index<answers.length;
		}

		public FormulaNode next() {
			Predicate temp = answers[index++];
			return temp;
		}

		public void remove() {
		}
		
	}

}
