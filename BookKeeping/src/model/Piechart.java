package model;

public class Piechart {

	private double value;
	
	private String name;

	public Piechart() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Piechart(double value, String name) {
		super();
		this.value = value;
		this.name = name;
	}

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
