package alma;

/**
 * InferenceRules are used by the KnowledgeBase to reason. They 
 * have the power to add and delete formulas from the KnowledgeBase
 * 
 * @author Percy
 *
 */
public abstract class InferenceRule {
	private KnowledgeBase kb;
	
	public InferenceRule(KnowledgeBase kb){
		this.kb = kb;
	}
	
	/**
	 * Tells the KnowledgeBase to add f in the next step
	 * 
	 * @param f
	 */
	public void kbAdd(Formula f){
		kb.add(f);
	}
	
	/**
	 * Tells the KnowledgeBase to Delete f in next step
	 * @param f
	 */
	public void kbDelete(Formula f){
		kb.delete(f);
	}
	
	/**
	 * Tells the KnowledgeBase to all Formulas with identification id
	 * 
	 * @param f
	 */
	public void kbDeleteID(int id){
		kb.deleteID(id);
	}
	
	/**
	 * If add returns "true", then the formula will be asserted 
	 * into the main KnowledgeBase. Example: a predicate will almost 
	 * always be added, however CommandNodes are not added
	 * to the KnowledgeBase.
	 * 
	 * @param f
	 */
	public abstract boolean add(Formula f);
	
	/**
	 * This is the command to do reasoning on the KnowledgeBase.
	 *
	 */
	public abstract void step();
	
	/**
	 * If the InferenceRule is keeping formulas in some sort of storage,
	 * this will give the InferenceRule a chance to remove the formula
	 * from its own personal memory.
	 *
	 */
	public abstract void delete(Formula f);
}