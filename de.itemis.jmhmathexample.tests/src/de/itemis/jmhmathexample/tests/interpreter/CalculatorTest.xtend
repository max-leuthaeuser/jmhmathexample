package de.itemis.jmhmathexample.tests.interpreter

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*
import de.itemis.jmhmathexample.tests.MathDSLInjectorProvider
import de.itemis.jmhmathexample.interpreter.Calculator
import de.itemis.jmhmathexample.generator.MathDSLGenerator
import de.itemis.jmhmathexample.generator.GenerationStrategy

@RunWith(XtextRunner)
@InjectWith(MathDSLInjectorProvider)
class CalculatorTest {

	@Inject
	ParseHelper<de.itemis.jmhmathexample.mathDSL.Math> parseHelper

	@Inject
	MathDSLGenerator randomGenerator

	@Inject
	Calculator calculator

	@Test
	def void testSimple() throws Exception {
		check(7, "1 + 2 * 3")
		check(9, "(1 + 2) * 3")
		check(6, "1 + 2 + 3")
		check(0, "1 + 2 - 3")
		check(5, "1 * 2 + 3")
		check(-4, "1 - 2 - 3")
		check(1.5, "1 / 2 * 3")
	}

	@Test
	def void testLargeExpressions() throws Exception {
		val largeOne = randomGenerator.generate(10000, GenerationStrategy.WITHOUT_DIV)
		assertFalse(largeOne.isEmpty)
		val math = parseHelper.parse(largeOne)
		calculator.evaluate(math.expression)
	}

	def protected void check(double expected, String expression) throws Exception {
		val math = parseHelper.parse(expression)
		var result = calculator.evaluate(math.expression)
		assertEquals(expected, result.doubleValue, 0.0001)
	}

}
