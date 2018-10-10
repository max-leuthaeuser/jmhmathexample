## Benchmark your Xtext DSL with JMH

How to run the JMH benchmark with Maven:

1.) Make sure a recent _Java_ (>1.8), _ant_, and _Maven_ is installed.

2.) Build the standalone Jar for ```de.itemis.jmhmathexample``` with running _ant_ there (see ```export.xml```).

3.) Build local Maven repo and deploy the Jar generated in step 2 into it: ```mvn deploy:deploy-file -Dfile=./bin/MathDSL.jar -DgroupId=de.itemis -DartifactId=de.itemis.jmhmathexample -Dversion=1.0 -Dpackaging=jar -Durl=file:./maven-repository/ -DrepositoryId=maven-repository -DupdateReleaseInfo=true```.

4.) Build the JMH augmented standalone Jar for ```de.itemis.jmhmathexample.benchmark.jmh```: ```mvn clean install```.

5.) Run the benchmark and generate the json result file: ```java -jar target/benchmarks.jar -rf json```.
