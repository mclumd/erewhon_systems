package alma;

import java.util.ArrayList;

/**
 * There is a strange inheritance tree here. CommandNodes are ComplexNodes, meaning
 * the FormulaBuilder class will be able to supply "children" to this class. The
 * child of a SelectCommand is the template.
 * @author percy
 *
 */
public class SelectCommand extends CommandNode { /* The child is the template*/

	String answerSet;		// will generate a predicate to represent a set
	ArrayList<Variable> notSearch;
	int numHits;
	
	SelectCommand(String myAnswerSet, ArrayList<Variable> vars, int myNumHits){
		answerSet = myAnswerSet;
		notSearch = vars;
		numHits = myNumHits;
	}
	
	public FormulaNode getTemplate(){
		return children.get(0);
	}
	
	public String toString(){
		return "#{" + answerSet + "}" + notSearch.toString() + "[" + numHits + "]" + " " + getTemplate();
	}
}