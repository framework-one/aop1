aop1
====

AOP/1: Aspect Oriented Programming addition for the di1 (https://github.com/framework-one/di1)  dependency injection  framework for Railo and ColdFusion

Checking out the code
=====================

Checking this code out is pretty easy, but it also contains a couple of submodules, so all you have to do is:

    git clone git@github.com:framework-one/aop1.git
    cd aop1
    git submodule init
    git submodule update

Using AOP/1
===========

Using AOP/1 is easy if you already use DI/1. just replace the reference to "ioc" with "aop":

	bf = new aop("/services");

Now that you have your beanfactory defined, you have access to a new method, "intercept". This tells AOP/1 which bean's methods you are going to intercept using another bean:

	bf.intercept("ReverseService","Logger");

You can now carry on as usual and get the ReverseService and call methods on it: 

	result = rs.doReverse("This is being logged now!");
	dump(result);

The difference now is that the 'Logger' bean's methods will now be called, if it has the methods "before", "after", "around" and "onError". 

The "before"  method will be called before the call to doReverse
The "after" method will be called after the doReverse method has been called
The "around" method will be called instead of the doReverse method. It is up to you to implement some functionaluty here (see the example AroundInterceptor https://github.com/framework-one/aop1/blob/0.1/interceptors/aop/AroundInterceptor.cfc)
The "onError" method will be called if the "doReverse" method has an error. 

If you want to only trigger an interceptor on certain methods you can add a parameter to the intercept method:

	bf.intercept("ReverseService","Logger", "doReverse,doOtherThing");


Check out the wiki for more complete documentation https://github.com/framework-one/aop1/wiki/
