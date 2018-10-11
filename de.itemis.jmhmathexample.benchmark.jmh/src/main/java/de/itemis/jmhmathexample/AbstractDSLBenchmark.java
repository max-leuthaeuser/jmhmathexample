package de.itemis.jmhmathexample;

import java.util.HashMap;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EValidator;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.resource.XtextResourceSet;
import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.validation.ResourceValidatorImpl;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.Param;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.State;

import com.google.inject.Injector;

@BenchmarkMode(Mode.SingleShotTime)
abstract public class AbstractDSLBenchmark {

	@State(Scope.Benchmark)
	abstract public static class AbstractBenchmarkState {
		protected Injector injector = new MathDSLStandaloneSetup().createInjectorAndDoEMFRegistration();
		protected XtextResourceSet resourceSet = injector.getInstance(XtextResourceSet.class);
		protected IResourceValidator resourceValidator = injector.getInstance(ResourceValidatorImpl.class);
		protected Resource resource = resourceSet.createResource(URI.createURI("dummy:/example.math"));

		@Param({ "100", "1000", "10000" })
		public int size;

		private java.util.Map<EPackage, java.lang.Object> validators = new HashMap<>();

		public AbstractBenchmarkState() {
			if (null == injector)
				throw new RuntimeException("injector is null!");
			if (null == resource)
				throw new RuntimeException("resource is null!");
			if (null == resourceValidator)
				throw new RuntimeException("resourceValidator is null!");
			if (null == resourceSet)
				throw new RuntimeException("resourceSet is null!");
			resourceSet.addLoadOption(XtextResource.OPTION_RESOLVE_ALL, Boolean.TRUE);
		}

		public void disableValidators() {
			validators.putAll(EValidator.Registry.INSTANCE);
			EValidator.Registry.INSTANCE.clear();
		}

		public void enableValidators() {
			EValidator.Registry.INSTANCE.putAll(validators);
		}
	}

}
