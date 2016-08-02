package alma;

public class TimeConstant extends Constant {
	long time;
	
	public TimeConstant(long time){
		this.time = time;
	}
	
	public boolean equals(Object o){
		return (o instanceof TimeConstant) 
			&& ((TimeConstant)o).time == this.time;
	}
	
	@Override
	public int hashCode(){
		return (int) time;
	}

	@Override
	public boolean unify(Constant c, UnifiedMap um) {
		return this.equals(c);
		
	}

	@Override
	public FormulaNode applySubstitution(UnifiedMap um) {
		return new TimeConstant(this.time);
	}
	
	public String toString(){
		return Long.toString(time);
	}

}
