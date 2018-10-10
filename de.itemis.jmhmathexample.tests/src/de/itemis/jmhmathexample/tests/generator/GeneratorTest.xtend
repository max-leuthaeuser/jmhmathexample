package de.itemis.jmhmathexample.tests.generator

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Test
import org.eclipse.xtext.testing.XtextRunner
import org.junit.runner.RunWith
import de.itemis.jmhmathexample.generator.MathDSLGenerator

import static org.junit.Assert.*
import de.itemis.jmhmathexample.tests.MathDSLInjectorProvider
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import de.itemis.jmhmathexample.generator.GenerationStrategy

@RunWith(XtextRunner)
@InjectWith(MathDSLInjectorProvider)
class GeneratorTest {

	@Inject
	extension ParseHelper<de.itemis.jmhmathexample.mathDSL.Math> parseHelper

	@Inject
	extension ValidationTestHelper validationTestHelper

	@Inject
	MathDSLGenerator randomGenerator

	@Test
	def void testRandomGenerator() {
		val empty = randomGenerator.generate(0)
		assertTrue(empty.isEmpty)

		val oneNumberOnly = randomGenerator.generate(1)
		assertFalse(oneNumberOnly.isEmpty)
		oneNumberOnly.parse.assertNoErrors

		var larger = randomGenerator.generate(10)
		assertFalse(larger.isEmpty)
		larger.parse.assertNoErrors

		larger = randomGenerator.generate(100, GenerationStrategy.WITHOUT_DIV)
		assertFalse(larger.isEmpty)
		larger.parse.assertNoErrors

		larger = randomGenerator.generate(1000, GenerationStrategy.WITHOUT_DIV)
		assertFalse(larger.isEmpty)
		larger.parse.assertNoErrors

		larger = randomGenerator.generate(10000, GenerationStrategy.WITHOUT_DIV)
		assertFalse(larger.isEmpty)
		larger.parse.assertNoErrors
	}
}
