<h1>AOP/1: Aspect Oriented Programming for the rest of us</h1>
<h2>Running Framework Tests:</h2>
<cfscript>
	
	bf = getBeanFactory()
	rb = bf.getBean("ReverseService");
	
	s1 = rb.doReverse("Hello!");

	Assert(getMetaData(rb).displayName, "ReverseService", "", "Return the ReverseService bean")

	Assert("!olleH", s1 , "", "Reverse Works");

	AssertHasMethod(bf, "intercept", "", "Does it have the intercept method");
	AssertHasMethod(bf, "hasInterceptors", "", "Does it have the hasInterceptors method" );

	//Since we need to add beans in an order... maybe we need the "putBean" 

	//Check if the ReverseService has interceptors (first off it's false as we haven't added any!)
	Assert(bf.hasInterceptors("ReverseService"), false, "", "Did we add any interceptors (no)");

	//Define the interceptor bean 
	bf.declareBean("BasicInterceptor","interceptors.BasicInterceptor");

	Assert(bf.containsBean("BasicInterceptor"), true, "", "Did we declare the interceptor");

	//Add the interception!
	bf.intercept("ReverseService", "BasicInterceptor");

	//Get the bean, it should now be a proxy
	proxy = bf.getBean("ReverseService");
	Assert(bf.hasInterceptors("ReverseService"), true, "", "Test that an interceptor has been added");

	//Check if the interceptor actually worked

	s2 = proxy.doReverse("Hello!");

	Assert(getMetaData(proxy).displayName, "beanProxy", "", "Return the proxy")

	Assert(s2, Reverse("beforeHello!"),"", "Before interceptor is triggered");
	Assert(s2, Reverse("beforeHello!") & "after","", "After interceptor is triggered");

</cfscript>

<style type="text/css">
	
.failed{
	color: red;
}
.passed{
	color: green;
}

</style>
<cfoutput>
<table>
	<thead>
		<th>Passed?</th>
		<th>Name</th>
		<th>Message</th>
		<th>Expected</th>
		<th>Actual</th>
	</thead>
	<tbody>
	<cfloop array="#request.unittests#" item="ut" index="t">

		<cfset class = ut.passed?"passed":"failed">
		<tr class="#class#">
			<td>#ut.passed#</td>
			<td>#ut.testname#</td>
			<td>#ut.message#
				<cfif Len(ut.detail)>
					<cfdump var="#ut.detail#" expand="false">
				</cfif>

			</td>
			<td>#ut.expected#</td>
			<td>#ut.actual#</td>
		</tr>
	</cfloop>
	</tbody>
</table>
</cfoutput>