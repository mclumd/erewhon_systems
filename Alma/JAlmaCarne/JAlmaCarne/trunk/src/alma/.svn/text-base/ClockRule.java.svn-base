package alma;

/**
 * This rule gives the proposition "now" into the knowledgebase. IE: now(1), now(2), etc
 * etc. It counts up during each step.
 * @author Hamid
 *
 */
public class ClockRule extends InferenceRule {

	int currentStep; 
	
	public ClockRule(KnowledgeBase kb){
		super(kb);
		currentStep = kb.history.stepNumber();
	}
	
	@Override
	public boolean add(Formula f) {
		return true;
	}

	@Override
	public void delete(Formula f) {
	}

	@Override
	public void step() {
		currentStep++;												// ?
		
		// print for debugging:
		System.out.print("will delete:" + currentStep);
		
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("Now");
			fb.addTimeConst(currentStep+1 );
			fb.endChildren();
		kbAdd(fb.getFormula());

		FormulaBuilder fbOld = new FormulaBuilder();
		fbOld.addPredicate("Now");
			fbOld.addTimeConst(currentStep );		
			fbOld.endChildren();
		kbDelete(fbOld.getFormula());
		
	}

}


