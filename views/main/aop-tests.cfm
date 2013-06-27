<h1>AOP/1: Aspect Oriented Programming for the rest of us</h1>
<h2>Running Framework Tests:</h2>
<cfscript>
	


	//We will create new configs each time, so new instances of AOP
	request.callstack = [];
	bf = new aop('/services', {});
	rs = bf.getBean("ReverseService");
	
	
	
	//Basic Bean Tests
	result = rs.doReverse("Hello!");
	Assert("!olleH", result , "No Inteceptors Works");
	Assert(ArrayLen(request.callstack),1, "One method registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"doReverse", "Before Called in the stack");

	
	//BeforeAdvice Tests
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//add an Interceptor
	bf.intercept("ReverseService", "BeforeInterceptor");
	rs = bf.getBean("ReverseService");
	
	result = rs.doReverse("Hello!");
	Assert(result, Reverse("beforeHello!"), "Before Works");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"before,doReverse", "Before Called in the stack");

	
	//AfterAdvice Tests
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//add an Interceptor
	bf.intercept("ReverseService", "AfterInterceptor");
	rs = bf.getBean("ReverseService");
	result = rs.doReverse("Hello!");

	Assert(result, Reverse("Hello!") , "Reverse still Works");	
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"doReverse,after", "Before Called in the stack");





	//AroundAdvice Tests
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//add an Interceptor
	bf.intercept("ReverseService", "AroundInterceptor");
	rs = bf.getBean("ReverseService");
	result = rs.doReverse("Hello!");


	Assert(result, Reverse("Hello!") , "Called method through Around");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"around,doReverse", "Before Called in the stack");



	


	//Putting it all together What happens when you call all of them?
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//add an Interceptor
	
	bf.intercept("ReverseService", "BeforeInterceptor");
	bf.intercept("ReverseService", "AroundInterceptor");
	bf.intercept("ReverseService", "AfterInterceptor");

	rs = bf.getBean("ReverseService");
	result = rs.doReverse("Hello!");
	

	Assert(result, Reverse("Hello!") , "Called method through Around");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"around,doReverse", "Before Called in the stack");





	
	//Multiple Before Advisors
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//Need to create different Before interceptors

	bf.addBean("BeforeInterceptorA", new interceptors.aop.BeforeInterceptor("beforeA"));
	bf.addBean("BeforeInterceptorB", new interceptors.aop.BeforeInterceptor("beforeB"));
	bf.addBean("BeforeInterceptorC", new interceptors.aop.BeforeInterceptor("beforeC"));
	bf.intercept("ReverseService", "BeforeInterceptorA");
	bf.intercept("ReverseService", "BeforeInterceptorB");
	bf.intercept("ReverseService", "BeforeInterceptorC");
	
	rs = bf.getBean("ReverseService");
	result = rs.doReverse("Hello!");

	Assert(result, Reverse("beforebeforebeforeHello!"), "Before Works");
	Assert(ArrayLen(request.callstack),4, "All before methods got called");
	AssertEquals(ArrayToList(request.callstack),"beforeA,beforeB,beforeC,doReverse", "Before Methods got called in order");
	

	//Multiple After Advisors
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//Need to create different Before interceptors

	bf.addBean("AfterInterceptorA", new interceptors.aop.AfterInterceptor("afterA"));
	bf.addBean("AfterInterceptorB", new interceptors.aop.AfterInterceptor("afterB"));
	bf.addBean("AfterInterceptorC", new interceptors.aop.AfterInterceptor("afterC"));
	bf.intercept("ReverseService", "AfterInterceptorA");
	bf.intercept("ReverseService", "AfterInterceptorB");
	bf.intercept("ReverseService", "AfterInterceptorC");
	rs = bf.getBean("ReverseService");
	result = rs.doReverse("Hello!");

	Assert(result, Reverse("Hello!"), "After Works");
	Assert(ArrayLen(request.callstack),4, "All after methods got called");
	AssertEquals(ArrayToList(request.callstack),"doReverse,afterA,afterB,afterC", "After Methods got called in order");

	//Multiple Around Advisors
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//Need to create different Before interceptors

	bf.addBean("AroundInterceptorA", new interceptors.aop.AroundInterceptor("aroundA"));
	bf.addBean("AroundInterceptorB", new interceptors.aop.AroundInterceptor("aroundB"));
	bf.addBean("AroundInterceptorC", new interceptors.aop.AroundInterceptor("aroundC"));
	bf.intercept("ReverseService", "AroundInterceptorA");
	bf.intercept("ReverseService", "AroundInterceptorB");
	bf.intercept("ReverseService", "AroundInterceptorC");
	rs = bf.getBean("ReverseService");

	result = rs.doReverse("Hello!");

	Assert(result, Reverse("Hello!"), "Around Still Works");
	Assert(ArrayLen(request.callstack),4, "All after methods got called");
	AssertEquals(ArrayToList(request.callstack),"aroundA,aroundB,aroundC,doReverse", "After Methods got called in order");



	//Named Method Interceptions

	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//add an Interceptor
	bf.intercept("ReverseService", "BeforeInterceptor", "doReverse");

	rs = bf.getBean("ReverseService");

	Assert(rs.methodMatches("doForward", "doReverse"), false, "Method doForward doesn't match doReverse");
	Assert(rs.methodMatches("doForward", ""), true, "Method doForward does match ''");
	Assert(rs.methodMatches("doForward", "doReverse,"), false, "Method doForward doesnt match 'doReverse,'");
	Assert(rs.methodMatches("doForward", "doReverse,doForward"), true, "Method doForward does match doReverse,doForward");
	

	result = rs.doReverse("Hello!");
	

	Assert(result, Reverse("beforeHello!"), "Before Works");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"before,doReverse", "Before Called in the stack");

	request.callstack = []; //reset
	result2 = rs.doForward("Hello!");


	Assert(result2, "Hello!", "Before Works");
	Assert(ArrayLen(request.callstack),1, "One methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"doForward", "Before NOT Called in the stack");



	//Error TestAssertError
	request.callstack = []; //reset
	bf = new aop('/services,/interceptors', {});
	//add an Interceptor
	bf.intercept("ReverseService", "ErrorInterceptor", "throwError");

	rs = bf.getBean("ReverseService");
	rs.throwError();

	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"throwError,onError", "Before NOT Called in the stack");



	include "showtests.cfm";
	dump(request.callstack);

		
</cfscript>
<h2>Here's the code for the tests</h2>
<cf_show template="aop-tests.cfm">
	
