package de.itemis.jmhmathexample.generator;

import java.util.Random;

public enum GenerationStrategy {
	WITH_DIV(4), WITHOUT_DIV(3);

	GenerationStrategy(int v) {
		value = v;
	}

	int value;

	private static Random r = new Random();

	public String randomOperator() {
		switch (r.nextInt(value)) {
		case 0:
			return "-";
		case 1:
			return "*";
		case 2:
			return "+";
		default:
			return "/";
		}
	}
}
