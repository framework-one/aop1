AOP/1: Aspect Oriented Programming addition for the DI/1 (https://github.com/framework-one/di1) dependency injection framework.
You need DI/1 installed in order to use AOP/1. AOP/1 is part of the [FW/1 family of components](https://github.com/framework-one/fw1).
All development work occurs in that repo. This repo is provided purely as a convenience for users
who want just AOP/1 as a standalone component.

Usage
----
Using AOP/1 is easy if you already use DI/1. just replace the reference to "ioc" with "aop":

	bf = new aop("/services");

Now that you have your beanfactory defined, you have access to a new method, "intercept". This tells AOP/1 which bean's methods you are going to intercept using another bean:

	bf.intercept("ReverseService","Logger");

You can now carry on as usual and get the ReverseService and call methods on it: 

	result = rs.doReverse("This is being logged now!");
	dump(result);

The difference now is that the 'Logger' bean's methods will now be called, if it has the methods "before", "after", "around" and "onError". 

* The `before()`  method will be called before the call to `doReverse()`
* The `after()` method will be called after the `doReverse()` method has been called
* The `around()` method will be called instead of the `doReverse()` method -- it is up to you to implement some functionality here
* The `onError()` method will be called if the `doReverse()` method throws an exception 

If you want to only trigger an interceptor on certain methods you can add a parameter to the intercept method:

	bf.intercept("ReverseService","Logger", "doReverse,doOtherThing");

Check out the [AOP/1 documentation](http://framework-one.github.io/documentation/using-aop-one.html) for more details.
