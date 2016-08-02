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

	private FormulaNode answer;		// will generate a predicate to represent a set
	private ArrayList<Variable> notSearch;
	private int numHits;
	
	SelectCommand(FormulaNode ans, ArrayList<Variable> vars, int myNumHits){
		answer = ans;
		notSearch = vars;
		numHits = myNumHits;
	}
	
	public FormulaNode getTemplate(){
		return children.get(0);
	}
	
	public String toString(){
		return "#{" + answer + "}" + notSearch.toString() + "[" + numHits + "]" + " " + getTemplate();
	}
	
	@Override
	public boolean equals(Object o){
		if (o instanceof SelectCommand){
			SelectCommand sc = (SelectCommand) o;
			return numHits==sc.numHits && sc.answer.equals(answer) 
					&& super.equals(o) && notSearch.equals(sc.notSearch);
		}
		
		return false;
	}
	
	public int getNumHits(){
		return numHits;
	}
	
	public ArrayList<Variable> getNotSearch(){
		return notSearch;
	}
	
	public FormulaNode getAnswer(){
		return answer;
	}
}