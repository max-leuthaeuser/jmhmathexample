package de.itemis.jmhmathexample.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Test
import org.eclipse.xtext.testing.XtextRunner
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(MathDSLInjectorProvider)
class ParserTest {
	@Inject
	extension ParseHelper<de.itemis.jmhmathexample.mathDSL.Math> parseHelper

	@Inject
	extension ValidationTestHelper validationTestHelper

	@Test
	def void parseMath() {
		'''
			1
		'''.parse.assertNoErrors

		'''
			1 + 2
		'''.parse.assertNoErrors

		'''
			1 * 2
		'''.parse.assertNoErrors

		'''
			2 / 1
		'''.parse.assertNoErrors

		'''
			(1 + 2) * 3
		'''.parse.assertNoErrors
	}

}
