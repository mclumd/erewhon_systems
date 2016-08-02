package alma.callfile;

import alma.Predicate;
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
public abstract class SingleCallFormula extends SimpleCallFormula {

	public abstract Predicate generateAnswer(Predicate template);
	
	@Override
	protected final Predicate[] generateAnswers(Predicate template) {
		Predicate p[] = {generateAnswer(template)};
		if(p[0]==null) return null;
		return p;
	}

}
