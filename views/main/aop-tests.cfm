<h1>AOP/1: Aspect Oriented Programming for the rest of us</h1>
<h2>Running Framework Tests:</h2>
<cfscript>

	testSuite = createObject("component","mxunit.framework.TestSuite").TestSuite();
 	testSuite.addAll("unittests.BasicBeanTest");
 	testSuite.addAll("unittests.CombinedInterceptorsTest"); //Identical to above
 	results = testSuite.run();
</cfscript>
  
<cfoutput>#results.getResultsOutput("extjs")#</cfoutput>  
