package alma.callfile;

import alma.*;
import alma.util.*;

/**
 * This abstract class defines the method by which external programmers can write CallFormulas
 * There are TWO ways that you can define a Call's behavior, one which is more difficult but more
 * powerful than the other.
 * <p>
 * <ol>
 * <li>
 * <b>Easier</b> to write but <b>Less Powerful</b>: <br>
 * Define generateAnswers which takes a Predicate template, acting as arguments, and returns an array of answers
 * 		I.E. <code>combine("A","B",X)</code> would call combine's class's generateAnswer's method and return and 
 * 		array containing <code>combine("A","B","AB")</code>, which is returned as an iterator in the default implementation of 
 * 		findAnswer.  This method of doing things can ONLY be uses for simple calls with a finite number of answers.  
 * 		If you need infinites, keep reading.
 * NOTE if you want to represent that there is no suitable answer return an <b>Empty Array or (less preferably) NULL</b>.
 * </li>
 * <li>
 * <b>Harder</b> to write but <b>More Powerful</b>: <br>
 * Override findAnswer which takes a Predicate template, acting as arguments, and returns an Iterator to FormulaNodes,
 * which are the answers.
 * 		I.E. <code>less(0,X)</code> would call less's class's findAnswer method, circumventing generateAnswers allowing you to 
 * 		exactly control how the iterators work.  NOTE that this requires a little more overhead code and should only really 
 * 		be used if the first method cannot work for you
 * </ol>
 * </ul>
 * </p>
 */

public interface CallFormula {
	/**
	 * A default implementation of findAnswer such that if {@link #generateAnswers(Predicate template)} is defined and your class is called
	 * findAnswer will return a BiIterator over the returned array, note that if you override this method there
	 * is little point in actually writing anything in generateAnswers.
	 * 
	 * @param template The complete call, in Predicate form.  
	 * @return a {@link alma.util.BiIterator BiIterator} over answers generated from the call.
	 */
	public BiIterator<FormulaNode> findAnswer(Predicate template);
	
}


