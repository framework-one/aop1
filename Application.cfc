// caution: requires FW/1 2.0 Alpha 5 or later!!
component extends="fw1.org.corfield.framework" {

	this.mappings[ '/goldfish/trumpets' ] = expandPath( '/extrabeans' );
	function setupApplication() {
		var bf = new aop( '/services',{}, "di1");
		setBeanFactory( bf );
		
	}


	function setupRequest(){
		setupApplication();
	}


	function AssertHasMethod(object, method, message="", testname=""){
		Assert(StructKeyExists(object, method), true, "Method #method# doesn't exist in object #getMetaData(object).fullname#", testname);
	}

	function Assert(expected, actual, message="", testname=""){
		param name="request.unittests" default="#[]#";


		var utest = {expected:expected,actual:actual, passed:true, message="", testname=testname};

		if(expected NEQ actual){
			utest.passed = false;
			utest.message = Len(message) ? message : "Expected #expected# but got #actual#";
		}

		ArrayAppend(request.unittests, utest);
	}
}