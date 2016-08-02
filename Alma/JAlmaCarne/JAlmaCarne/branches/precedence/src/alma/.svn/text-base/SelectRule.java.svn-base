package alma;

import java.util.ArrayList;
import java.util.Set;

public class SelectRule extends InferenceRule {
	ArrayList<SelectCommand> tointerpret;		// not necessary really, only one SelectCommand per step ?
	ArrayList<Predicate> predicates;
	
	public SelectRule(KnowledgeBase kb) {
		super(kb);
		tointerpret = new ArrayList<SelectCommand>();
		predicates = new ArrayList();
	}

	@Override
	public boolean add(Formula f) {
		/*if(f.getHead() instanceof SelectCommand){
			System.out.println("Stub in SelectRule (SelectCommand). Recieved: " + f);		// ?
			tointerpret.add((SelectCommand) (f.getHead()));
		} else if(f.getHead() instanceof Predicate){
			System.out.println("Stub in SelectRule (Predicate). Recieved: " + f);
			predicates.add((Predicate)f.getHead());
		}*/
		return true;
	}
/*
CommandInference + -
	public boolean add(Formula f) {
		if (f.getHead() instanceof CommandNode) {
			tointerpret.add((CommandNode) (f.getHead()));
			return false;
		} else
			return true;
	}
ModusPonens
	public boolean add(Formula f) {
		if(f.getHead() instanceof IfFormula){
			rules.add((IfFormula) f.getHead());
		} else if (f.getHead() instanceof Predicate){
			predicates.add((Predicate) f.getHead());
		}
		return true;
	}
*/	

	@Override
	public void delete(Formula f) {
		tointerpret.remove(f.getHead());
		predicates.remove(f.getHead());
	}

	@Override
	public void step() {
		SubstitutionList sl = new SubstitutionList(); 
		for (SelectCommand sc : tointerpret) {
			if (sc instanceof SelectCommand) {
				int numHitsCounter = 0;	// will numHits work properly considering the use of SubstitutionList ?
				for (Predicate p: predicates ){
					if ( sc.getTemplate().unify(p, sl) ){
						// create the answerSet predicate using formulaBuilder, bind to sl, add to kb
						FormulaBuilder fb = new FormulaBuilder();
						fb.addPredicate(sc.answerSet);
						Formula f = fb.getFormula();
						kbAdd(f.applySubstitution(sl));	
						sl.reset();
						
						numHitsCounter++;
						if (numHitsCounter < sc.numHits) break;
					}
				}														
			} else {
				System.out.println("Could not process: " + sc);
			}
			kbDelete(new Formula(sc));		// should it be deleted in the next step?
		}	
	}
/*	modus ponens
	public void step() {
		SubstitutionList sl = new SubstitutionList(); 
		for(Predicate p: predicates){
			for(IfFormula ifs: rules){
				sl.reset();
				FormulaNode lhs = ifs.getLeft();
				if(lhs instanceof Predicate){
					Predicate plhs = (Predicate)lhs;
					if(plhs.unify(p, sl)){
						kbAdd(new Formula(ifs.getRight().applySubstitution(sl)));
					}
				} else if (lhs instanceof AndFormula){
					// And all children are predicates, Laters
				}
			}
		}
	}

public class FormulaBuilderTest extends TestBase {
	public static void testBuilderPop(){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("Knows");
			fb.addConstant("John");
			fb.addConstant("Kelly");		
		Formula a = fb.getFormula();

  public void step() {
		for (CommandNode cn : tointerpret) {
			if (cn instanceof AddCommand) {
				kbAdd(new Formula(cn.getOperand()));
			} else if (cn instanceof DeleteCommand) {
				kbDelete(new Formula(cn.getOperand()));
			} else if (cn instanceof SpecificDeleteCommand) {
				kbDeleteID(((SpecificDeleteCommand) cn).getID());
			} else {
				System.out.println("Could not add: " + cn);
			}
			kbDelete(new Formula(cn));
		}
	}
*/

}
