package alma;

import java.util.ArrayList;

public class GoalCommand extends CommandNode {
	private FormulaNode answer;		// will generate a predicate to represent a set
	private ArrayList<Variable> notSearch;
	private int numHits;

	GoalCommand(FormulaNode myAnswer, ArrayList<Variable> vars, int myNumHits){
		answer = myAnswer;
		notSearch = vars;
		numHits = myNumHits;
	}

	public FormulaNode getTemplate(){
		return children.get(0);
	}

	public String toString(){
		return "?{" + answer + "}" + notSearch.toString() + "[" + numHits + "]" + " " + getTemplate();
	}

	public FormulaNode getAnswerTemplate(){
		return answer;
	}
	
	public int getNum(){
		return numHits;
	}
	
}