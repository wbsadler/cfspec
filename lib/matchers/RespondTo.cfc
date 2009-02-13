<cfcomponent extends="cfspec.lib.Matcher" output="false">


  <cffunction name="setArguments">
    <cfset _matcherName = "RespondTo">
    <cfset requireArgs(arguments, 1)>

    <cfset _methodName = arguments[1]>
    <cfset verifyArg(isSimpleValue(_methodName), "methodName", "must be a simple value")>
  </cffunction>



  <cffunction name="isMatch">
    <cfargument name="target">

    <cfif not isObject(target)>
      <cfset _runner.fail("RespondTo expected an object, got #inspect(target)#")>
    </cfif>

    <cfreturn hasMethod(actual, _methodName)>
  </cffunction>



  <cffunction name="getFailureMessage">
    <cfreturn "expected to respond to #inspect(_methodName)#, but the method was not found">
  </cffunction>



  <cffunction name="getNegativeFailureMessage">
    <cfreturn "expected not to respond to #inspect(_methodName)#, but the method was found">
  </cffunction>



  <cffunction name="getDescription">
    <cfreturn "respond to #inspect(_methodName)#">
  </cffunction>



</cfcomponent>
