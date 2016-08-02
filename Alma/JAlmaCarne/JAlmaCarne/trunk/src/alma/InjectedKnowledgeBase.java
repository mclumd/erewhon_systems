package alma;

import java.util.*;
import alma.util.*;

/**
 * This is a specific kind of MockKnowledgeBase where one can easily control
 * the "GetCandidates" list.
 * @author percy
 *
 */
public class InjectedKnowledgeBase extends KnowledgeBase {
	Map<FormulaNode, BiIterator<FormulaNode>> candidates = new HashMap<FormulaNode, BiIterator<FormulaNode>>();
	
	public InjectedKnowledgeBase(){
		clearAll();
	}
	
	public void addCandidate(FormulaNode template, BiIterator<FormulaNode> iter){
		candidates.put(template, iter);
	}
	
	@Override
	public BiIterator<FormulaNode> getCandidates(Class c, FormulaNode template){
		if(candidates.get(template) == null) return new EmptyIterator<FormulaNode>();
		return candidates.get(template);
	}
	
	@Override
	public BiIterator<FormulaNode> getCNFCandidates(List<Predicate> preds){
		BiIterator<FormulaNode> ci = new EmptyIterator<FormulaNode>();
		SubstitutionList sl = new SubstitutionList();
		for(Predicate p: preds){
			for(FormulaNode fn: candidates.keySet() ){
				sl.reset();
				if(sl.unify(p, fn) && (sl.isAllVars())){
					ci = new CrossIterator<FormulaNode>(ci, candidates.get(fn));
				}
			}
		}
		return ci;
	}
	
	@Override
	public void addIR(InferenceRule ir){
		super.addIR(ir);
	}
	
}