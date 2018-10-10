package de.itemis.jmhmathexample;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.List;

import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.validation.CheckMode;
import org.eclipse.xtext.validation.Issue;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.infra.Blackhole;

import de.itemis.jmhmathexample.generator.GenerationStrategy;
import de.itemis.jmhmathexample.generator.MathDSLGenerator;
import de.itemis.jmhmathexample.interpreter.Calculator;
import de.itemis.jmhmathexample.mathDSL.Expression;
import de.itemis.jmhmathexample.mathDSL.Math;

public class MathDSLBenchmark extends AbstractDSLBenchmark {

	public static class ParserBenchmarkState extends AbstractBenchmarkState {

		private MathDSLGenerator generator = new MathDSLGenerator();

		public String inputString;

		@Setup
		public void setup() {
			inputString = generator.generate(size, GenerationStrategy.WITHOUT_DIV);
			disableValidators();
		}

		public Math parse(String input) {
			InputStream in = new ByteArrayInputStream(input.getBytes());
			try {
				resource.load(in, resourceSet.getLoadOptions());
			} catch (IOException e) {
				e.printStackTrace();
			}
			return (Math) resource.getContents().get(0);
		}
	}

	public static class InterpreterBenchmarkState extends ParserBenchmarkState {

		private Calculator calc = new Calculator();

		public Expression exp;

		@Setup
		public void setup() {
			super.setup();
			exp = parse(inputString).getExpression();
		}

		public BigDecimal interpret(Expression exp) {
			return calc.evaluate(exp);
		}

	}

	public static class ValidatorBenchmarkState extends ParserBenchmarkState {

		public Expression exp;

		@Setup
		public void setup() {
			super.setup();
			exp = parse(inputString).getExpression();
			enableValidators();
		}

		public List<Issue> validate() {
			return resourceValidator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl);
		}

	}

	@Benchmark
	public void benchmarkParse(ParserBenchmarkState s, Blackhole sink) {
		sink.consume(s.parse(s.inputString));
	}

	@Benchmark
	public void benchmarkInterpreter(InterpreterBenchmarkState s, Blackhole sink) {
		sink.consume(s.interpret(s.exp));
	}

	@Benchmark
	public void benchmarkValidator(ValidatorBenchmarkState s, Blackhole sink) {
		sink.consume(s.validate());
	}

}
