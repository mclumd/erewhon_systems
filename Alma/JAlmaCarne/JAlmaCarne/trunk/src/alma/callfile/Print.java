package alma.callfile;
import alma.*;
import java.util.*;

public class Print extends CallAction{
	Predicate template;
	
	public Print(Predicate template) {
		this.template = template;
	}
	
	//Where the entire action should take place
	public void run() {
		System.out.println("------- Print --------");
		ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
		args.remove(0);
		System.out.println(args);
		System.out.println("----- End Print ------");
    }

}