package de.itemis.jmhmathexample.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import java.util.Random
import java.util.LinkedList

class MathDSLGenerator extends AbstractGenerator {

	static Random r = new Random()

	private def String addParanthesesRandomly(String around) {
		if (r.nextBoolean) {
			return "(" + around + ")"
		} else {
			return around
		}
	}

	private def String randomNumber() {
		return (r.nextInt(99) + 1).toString
	}

	def String generate(int size) {
		generate(size, GenerationStrategy.WITH_DIV)
	}

	def String generate(int size, GenerationStrategy strategy) {
		switch size {
			case 0:
				""
			case 1:
				randomNumber
			default: {
				val result = new LinkedList<String>()
				(2 .. size).forEach [ i |
					if (i % 2 == 0) {
						result.addLast(addParanthesesRandomly(randomNumber + strategy.randomOperator + randomNumber))
					} else {
						result.addFirst(addParanthesesRandomly(randomNumber + strategy.randomOperator + randomNumber))
					}
				]
				result.join(strategy.randomOperator)
			}
		}
	}

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		// intentionally left empty
	}
}
