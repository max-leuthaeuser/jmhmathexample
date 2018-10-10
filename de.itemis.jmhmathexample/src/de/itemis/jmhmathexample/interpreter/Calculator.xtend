package de.itemis.jmhmathexample.interpreter

import java.math.BigDecimal
import java.math.RoundingMode
import de.itemis.jmhmathexample.mathDSL.Expression
import de.itemis.jmhmathexample.mathDSL.NumberLiteral
import de.itemis.jmhmathexample.mathDSL.Minus
import de.itemis.jmhmathexample.mathDSL.Div
import de.itemis.jmhmathexample.mathDSL.Plus
import de.itemis.jmhmathexample.mathDSL.Multi
import java.util.Stack

class Calculator {

	private def Expression left(Expression expr) {
		switch expr {
			NumberLiteral: null
			Plus: expr.left
			Minus: expr.left
			Multi: expr.left
			Div: expr.left
		}
	}

	private def Expression right(Expression expr) {
		switch expr {
			NumberLiteral: null
			Plus: expr.right
			Minus: expr.right
			Multi: expr.right
			Div: expr.right
		}
	}

	private def Boolean isLeaf(Expression expr) {
		expr.left === null && expr.right === null
	}

	private def Stack<Expression> postorder(Expression obj) {
		var head = obj
		if (head === null) {
			return new Stack<Expression>()
		}
		val stack = new Stack<Expression>()
		val result = new Stack<Expression>()
		stack.push(head)
		while (!stack.isEmpty()) {
			var next = stack.peek()
			val finishedSubtrees = (next.right == head || next.left == head)
			if (finishedSubtrees || next.isLeaf) {
				stack.pop()
				result.push(next)
				head = next
			} else {
				if (next.right !== null) {
					stack.push(next.right)
				}
				if (next.left !== null) {
					stack.push(next.left)
				}
			}
		}
		return result
	}

	def BigDecimal evaluate(Expression obj) {
		val result = new Stack<BigDecimal>()
		postorder(obj).forEach [ curr |
			switch curr {
				NumberLiteral:
					result.push(curr.value)
				Plus:
					result.push(result.pop() + result.pop())
				Multi:
					result.push(result.pop() * result.pop())
				Minus: {
					val op1 = result.pop()
					val op2 = result.pop()
					result.push(op2 - op1)
				}
				Div: {
					val op1 = result.pop()
					val op2 = result.pop()
					result.push(op2.divide(op1, 20, RoundingMode.HALF_UP))
				}
			}
		]
		return result.peek()
	}

}
