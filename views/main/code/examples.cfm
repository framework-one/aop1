<cfscript>
	
	//Normal Setup
	bf = new aop("/services,/interceptors/example");
	bf.intercept("ReverseService","Logger");
	rs = bf.getBean("ReverseService");
	result = rs.doReverse("This is being logged now!");
	dump(result);
	
</cfscript>
