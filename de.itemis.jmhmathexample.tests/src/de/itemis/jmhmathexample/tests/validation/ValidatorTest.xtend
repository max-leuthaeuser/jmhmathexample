package de.itemis.jmhmathexample.tests.validation

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*
import de.itemis.jmhmathexample.tests.MathDSLInjectorProvider
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import de.itemis.jmhmathexample.mathDSL.MathDSLPackage
import de.itemis.jmhmathexample.validation.MathDSLValidator

@RunWith(XtextRunner)
@InjectWith(MathDSLInjectorProvider)
class ValidatorTest {

	@Inject
	ParseHelper<de.itemis.jmhmathexample.mathDSL.Math> parseHelper

	@Inject extension ValidationTestHelper

	@Test
	def void testValidate() {
		var result = parseHelper.parse('''
			2 / 0
		''')
		assertNotNull(result)
		result.assertError(MathDSLPackage.Literals.DIV, MathDSLValidator.DIV_BY_ZERO)

		result = parseHelper.parse('''
			2 / (1 * 0)
		''')
		assertNotNull(result)
		result.assertError(MathDSLPackage.Literals.DIV, MathDSLValidator.DIV_BY_ZERO)

		result = parseHelper.parse('''
			2 / 1
		''')
		assertNotNull(result)
		result.assertNoError(MathDSLValidator.DIV_BY_ZERO)
	}

}
