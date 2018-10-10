/*
 * generated by Xtext 2.15.0
 */
package de.itemis.jmhmathexample.ide

import com.google.inject.Guice
import de.itemis.jmhmathexample.MathDSLRuntimeModule
import de.itemis.jmhmathexample.MathDSLStandaloneSetup
import org.eclipse.xtext.util.Modules2

/**
 * Initialization support for running Xtext languages as language servers.
 */
class MathDSLIdeSetup extends MathDSLStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new MathDSLRuntimeModule, new MathDSLIdeModule))
	}
	
}