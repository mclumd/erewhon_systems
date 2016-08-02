package alma;

import java.util.*;

/**
 * This class takes care of commands that are asserted into the knowledge base
 * 
 * @author Percy
 *
 */
public class CommandInference extends InferenceRule {
	ArrayList<CommandNode> tointerpret;

	public CommandInference(KnowledgeBase kb) {
		super(kb);
		tointerpret = new ArrayList<CommandNode>();
	}

	@Override
	public boolean add(Formula f) {
		if(f.getHead() instanceof CommandNode && !(f.getHead() instanceof SelectCommand)
				&& !(f.getHead() instanceof GoalCommand)) {
			tointerpret.add((CommandNode) (f.getHead()));
			return false;
		} else
			return true;
	}

	@Override
	public void delete(Formula f) {
	}

	@Override
	public void step() {
		for (CommandNode cn : tointerpret) {
			if (cn instanceof AddCommand) {
				kbAdd(new Formula(cn.getOperand()));
			} else if (cn instanceof ActionCommand) {
				if(getKnowledgeBase().isCallAction(cn.getOperand())) {
					getKnowledgeBase().call(cn.getOperand());
				} 
				else
					System.err.println(cn.getOperand()+" is not a valid action");
			} else if(cn instanceof LabelCommand){
				LabelCommand lc = (LabelCommand)cn;
				getKnowledgeBase().label(lc.oper(),lc.getOperand(),lc.label());
			} else if (cn instanceof DeleteCommand) {
				kbDelete(new Formula(cn.getOperand()));
			} else if (cn instanceof SpecificDeleteCommand) {
				kbDeleteID(((SpecificDeleteCommand) cn).getID());
			} else if(cn instanceof SelectCommand){
				continue;
			} else {
				System.out.println("Could not add: " + cn);
			}
			kbDelete(new Formula(cn));
		}
		
		tointerpret.clear();
	}
}

