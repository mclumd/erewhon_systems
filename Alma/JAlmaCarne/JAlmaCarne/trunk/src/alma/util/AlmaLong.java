package alma.util;

public class AlmaLong {
	private Long val;
	
	
	public AlmaLong(Long other) {
		val = other;
	}
	
	public AlmaLong(AlmaLong other) {
		val = other.val;
	}
	
	public long longValue(){
		return val;
	}
	
	public void add(AlmaLong other) { val = other.longValue() + val;}
	public void subtract(AlmaLong other) { val = val - other.longValue();}
	public void divide(AlmaLong other) { val = val / other.longValue();}
	public void multiply(AlmaLong other) { val = val * other.longValue();}
	public void mod(AlmaLong other) { val = val % other.longValue();}
	
	public void add(Long other) { val = other.longValue() + val;}
	public void subtract(Long other) { val = val - other.longValue();}
	public void divide(Long other) { val = val / other.longValue();}
	public void multiply(Long other) { val = val * other.longValue();}
	public void mod(Long other) { val = val % other.longValue();}

	public String toString() {
		return val.toString();
	}
	public Long getValue() {
		return val;
	}

}
