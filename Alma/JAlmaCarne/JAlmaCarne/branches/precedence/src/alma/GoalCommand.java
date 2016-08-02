package alma;

import java.util.ArrayList;

public class GoalCommand extends CommandNode {
	String answerSet;		// will generate a predicate to represent a set
	ArrayList<Variable> notSearch;
	int numHits;

	GoalCommand(String myAnswerSet, ArrayList<Variable> vars, int myNumHits){
		answerSet = myAnswerSet;
		notSearch = vars;
		numHits = myNumHits;
	}

	public FormulaNode getTemplate(){
		return children.get(0);
	}

	public String toString(){
		return "?{" + answerSet + "}" + notSearch.toString() + "[" + numHits + "]" + " " + getTemplate();
	}
}