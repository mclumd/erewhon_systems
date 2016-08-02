package alma;

public class SelectCommand extends ComplexNode { /* The child is the template*/
	int numHits;
	String answer;
	Variable var;
	SelectCommand(int hits, String ans, Variable v){
		numHits = hits;
		answer= ans;
		var = v;
	}
	
	public FormulaNode getTemplate(){
		return children.get(0);
	}
	
	public String toString(){
		return "#{" + answer + "}" + var.toString() + "[" + numHits + "]" + " " + getTemplate();
	}
}