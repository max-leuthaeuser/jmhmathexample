package de.itemis.jmhmathexample.validation

import org.eclipse.xtext.validation.Check
import de.itemis.jmhmathexample.mathDSL.MathDSLPackage
import de.itemis.jmhmathexample.mathDSL.Div
import java.math.BigDecimal
import de.itemis.jmhmathexample.interpreter.Calculator

class MathDSLValidator extends AbstractMathDSLValidator {

	public static val DIV_BY_ZERO = 'Division by zero!'

	val calc = new Calculator()

	@Check
	def checkDivision(Div div) {
		val value = calc.evaluate(div.right)
		if (value.equals(BigDecimal.ZERO)) {
			error('Division by zero is not allowed!', MathDSLPackage.Literals.DIV__RIGHT, DIV_BY_ZERO)
		}
	}

}
