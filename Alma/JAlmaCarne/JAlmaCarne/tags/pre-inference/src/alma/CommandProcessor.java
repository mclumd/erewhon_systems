package alma;

/**
 * This serves as the bear-bones "interpreter" to 
 * the system. It takes in commands, and spits out 
 * output. All internally however, no Strings attached.
 * 
 * @author Percy Tiglao
 *
 */

public class CommandProcessor {
	KnowledgeBase kb;
	
	Database newFormulas;
	
	public void addFormula(Formula f){
		newFormulas.add(f);
	}
	
	public void deleteFormula(Formula f){
		throw new UnsupportedOperationException();
	}
	
	public void step(){
	}
}