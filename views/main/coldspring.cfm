<h1>Coldspring AOP behaviour tests</h1>
<cfxml variable="config">
	<beans>
        <bean id="ReverseService" class="services.Reverse" />
    </beans>
</cfxml>

<cfxml variable="config_before">
	<beans>

        <bean id="ReverseTarget" class="services.Reverse" />

        <bean id="BasicBeforeAdvice" class="interceptors.coldspring.BasicBeforeAdvice" />	

        <bean id="BasicAdvisor" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BasicBeforeAdvice" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>BasicAdvisor</value>
			    </list>
			</property>
		</bean>
	</beans>
</cfxml>


<cfxml variable="config_after">
	<beans>
		
        <bean id="ReverseTarget" class="services.Reverse" />

        <bean id="BasicAfterAdvice" class="interceptors.coldspring.BasicAfterAdvice" />	

        <bean id="BasicAdvisor" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BasicAfterAdvice" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>BasicAdvisor</value>
			    </list>
			</property>
		</bean>
	</beans>
</cfxml>


<cfxml variable="config_around">
	<beans>
		
        <bean id="ReverseTarget" class="services.Reverse" />
        <bean id="BasicAroundAdvice" class="interceptors.coldspring.BasicAroundAdvice" />	

        <bean id="BasicAdvisor" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BasicAroundAdvice" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>BasicAdvisor</value>
			    </list>
			</property>
		</bean>
	</beans>
</cfxml>


<cfxml variable="config_all">
	<beans>
		
        <bean id="ReverseTarget" class="services.Reverse" />
        <bean id="BasicBeforeAdvice" class="interceptors.coldspring.BasicBeforeAdvice" />	
        <bean id="BasicAroundAdvice" class="interceptors.coldspring.BasicAroundAdvice" />	
		<bean id="BasicAfterAdvice" class="interceptors.coldspring.BasicAfterAdvice" />	

        <bean id="BeforeAdvisor" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BasicBeforeAdvice" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>
        <bean id="AroundAdvisor" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BasicAroundAdvice" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>
		<bean id="AfterAdvisor" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BasicAfterAdvice" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>BeforeAdvisor</value>
			    	<value>AroundAdvisor</value>
			    	<value>AfterAdvisor</value>
			    </list>
			</property>
		</bean>
		
	</beans>
</cfxml>

<cfxml variable="config_before_multi">
	<beans>
		
        <bean id="ReverseTarget" class="services.Reverse" />

        <bean id="BeforeAdviceA" class="interceptors.coldspring.BeforeAdvice">
        	<constructor-arg name="name">
        		<value>beforeA</value>
        	</constructor-arg>
        </bean>
        <bean id="BeforeAdviceB" class="interceptors.coldspring.BeforeAdvice">
        	<constructor-arg name="name">
        		<value>beforeB</value>
        	</constructor-arg>
        </bean>

        <bean id="BeforeAdviceC" class="interceptors.coldspring.BeforeAdvice">
        	<constructor-arg name="name">
        		<value>beforeC</value>
        	</constructor-arg>
        </bean>
        
        <bean id="BeforeAdvisorA" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BeforeAdviceA" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<bean id="BeforeAdvisorB" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BeforeAdviceB" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<bean id="BeforeAdvisorC" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="BeforeAdviceC" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>
        
		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>BeforeAdvisorA</value>
			    	<value>BeforeAdvisorB</value>
			    	<value>BeforeAdvisorC</value>
			    </list>
			</property>
		</bean>
		
	</beans>
</cfxml>

<cfxml variable="config_after_multi">
	<beans>
		
        <bean id="ReverseTarget" class="services.Reverse" />

        <bean id="AfterAdviceA" class="interceptors.coldspring.AfterAdvice">
        	<constructor-arg name="name">
        		<value>afterA</value>
        	</constructor-arg>
        </bean>
        <bean id="AfterAdviceB" class="interceptors.coldspring.AfterAdvice">
        	<constructor-arg name="name">
        		<value>afterB</value>
        	</constructor-arg>
        </bean>

        <bean id="AfterAdviceC" class="interceptors.coldspring.AfterAdvice">
        	<constructor-arg name="name">
        		<value>afterC</value>
        	</constructor-arg>
        </bean>
        
        <bean id="AfterAdvisorA" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="AfterAdviceA" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<bean id="AfterAdvisorB" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="AfterAdviceB" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<bean id="AfterAdvisorC" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="AfterAdviceC" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>
        
		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>AfterAdvisorA</value>
			    	<value>AfterAdvisorB</value>
			    	<value>AfterAdvisorC</value>
			    </list>
			</property>
		</bean>
		
	</beans>
</cfxml>

<cfxml variable="config_around_multi">
	<beans>
		
        <bean id="ReverseTarget" class="services.Reverse" />

        <bean id="AroundAdviceA" class="interceptors.coldspring.AroundAdvice">
        	<constructor-arg name="name">
        		<value>aroundA</value>
        	</constructor-arg>
        </bean>
        <bean id="AroundAdviceB" class="interceptors.coldspring.AroundAdvice">
        	<constructor-arg name="name">
        		<value>aroundB</value>
        	</constructor-arg>
        </bean>

        <bean id="AroundAdviceC" class="interceptors.coldspring.AroundAdvice">
        	<constructor-arg name="name">
        		<value>aroundC</value>
        	</constructor-arg>
        </bean>
        
        <bean id="AroundAdvisorA" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="AroundAdviceA" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<bean id="AroundAdvisorB" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="AroundAdviceB" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>

		<bean id="AroundAdvisorC" class="coldspring.aop.support.NamedMethodPointcutAdvisor">
		    <property name="advice">
		    	<ref bean="AroundAdviceC" />
			</property>
			<property name="mappedNames">
		    	<value>*</value>
		    </property>
		</bean>
        
		<!--- now wrap our service --->
		<bean id="ReverseService" class="coldspring.aop.framework.ProxyFactoryBean">
			<property name="target">
			    <ref bean="ReverseTarget" />
			</property>
			<property name="interceptorNames">
				<list>
			    	<value>AroundAdvisorA</value>
			    	<value>AroundAdvisorB</value>
			    	<value>AroundAdvisorC</value>
			    </list>
			</property>
		</bean>
		
	</beans>
</cfxml>

<cfscript>
	
	function getRS(xmlConfig){
		//lets reset the callstack 
		request.callstack = [];
		bf = createObject("component", "coldspring.beans.DefaultXMLBeanFactory");
		bf.loadBeansFromXMLObj(xmlConfig);
	 return bf.getBean("ReverseService")
	}

	//Basic ColdSpring Tests
	result = getRS(config).doReverse("Hello!");
	Assert("!olleH", result , "No Inteceptors Works");
	Assert(ArrayLen(request.callstack),1, "One method registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"doReverse", "Before Called in the stack");

	//BeforeAdvice Tests
	s2 = getRS(config_before).doReverse("Hello!");
	Assert(s2, Reverse("beforeHello!"), "Before Works");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"before,doReverse", "Before Called in the stack");


	//AfterAdvice Tests
	s3 = getRS(config_after).doReverse("Hello!");
	Assert(s3, Reverse("Hello!") , "Reverse still Works");
	AssertTrue(StructKeyExists(request, "AfterReturningCalled"), "After got called still Works");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"doReverse,after", "Before Called in the stack");


	//AroundAdvice Tests
	s4 = getRS(config_around).doReverse("Hello!");
	Assert(s4, Reverse("Hello!") , "Called method through Around");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"around,doReverse", "Before Called in the stack");


	//Putting it all together What happens when you call all of them?
	s5 = getRS(config_around).doReverse("Hello!");
	Assert(s5, Reverse("Hello!") , "Called method through Around");
	Assert(ArrayLen(request.callstack),2, "Two methods registered in call stack");
	AssertEquals(ArrayToList(request.callstack),"around,doReverse", "Before Called in the stack");
	
	//Multiple Before Advisors
	s6 = getRS(config_before_multi).doReverse("Hello!");
	Assert(s6, Reverse("beforebeforebeforeHello!"), "Before Works");
	Assert(ArrayLen(request.callstack),4, "All before methods got called");
	AssertEquals(ArrayToList(request.callstack),"beforeA,beforeB,beforeC,doReverse", "Before Methods got called in order");
	


	//Multiple After Advisors
	result = getRS(config_after_multi).doReverse("Hello!");
	Assert(result, Reverse("Hello!"), "After Works");
	Assert(ArrayLen(request.callstack),4, "All after methods got called");
	AssertEquals(ArrayToList(request.callstack),"doReverse,afterA,afterB,afterC", "After Methods got called in order");


	//Multiple Around Advisors
	result = getRS(config_around_multi).doReverse("Hello!");
	Assert(result, Reverse("Hello!"), "Around Still Works");
	Assert(ArrayLen(request.callstack),4, "All after methods got called");
	AssertEquals(ArrayToList(request.callstack),"aroundA,aroundB,aroundC,doReverse", "After Methods got called in order");



	include "showtests.cfm";
	dump(request.callstack);
	



</cfscript>