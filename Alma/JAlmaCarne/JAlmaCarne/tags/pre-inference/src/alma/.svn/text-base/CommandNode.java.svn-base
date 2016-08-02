package alma;

public abstract class CommandNode extends ComplexNode {
	
	public FormulaNode getOperand(){
		return children.get(0);
	}
	
	@Override
	public FormulaNode applySubstitution(UnifiedMap um) {
		throw new UnsupportedOperationException("CommandNodes do not support substitution");
	}

	@Override
	public boolean unify(FormulaNode fn, UnifiedMap um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}

	@Override
	public boolean unify(Variable v, UnifiedMap um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}

	@Override
	public boolean unify(Constant c, UnifiedMap um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}

	@Override
	public boolean unify(ComplexNode cn, UnifiedMap um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}
}

class AddCommand extends CommandNode {
	AddCommand(){
	}
	
	AddCommand(FormulaNode toAdd){
		children.add(toAdd);
	}
	
	public String toString(){
		return "+" + children.get(0);
	}
}

class DeleteCommand extends CommandNode {
	DeleteCommand(){
	}
	
	DeleteCommand(FormulaNode toDelete){
		children.add(toDelete);
	}
	
	public String toString(){
		return "-" + children.get(0);
	}
}

class DistrustCommand extends CommandNode {
	DistrustCommand(){
		throw new UnsupportedOperationException("DistrustCommand not yet built");
	}
	
	DistrustCommand(FormulaNode toDistrust){
		//children.add(toDistrust);
		throw new UnsupportedOperationException("DistrustCommand not yet built");
	}
	
	public String toString(){
		return "*" + children.get(0);
	}
}
