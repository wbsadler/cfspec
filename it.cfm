<cfsetting enableCfoutputOnly="true">

<cfif thisTag.executionMode eq "start">
  <cfset caller.$cfspec.stepCurrent()>
  
  <cfif caller.$cfspec.isTrial()>
    <cfset caller.$cfspec.makeTarget()>
    <cfexit method="exitTag">
  </cfif>
    
  <cfif not caller.$cfspec.isItRunnable()>
    <cfexit method="exitTag">
  </cfif>
  
  <cfset caller.$cfspec.setHint(attributes.should)>
<cfelse>
  <cfif not caller.$cfspec.hasExpectedException()>
    <cfset caller.$cfspec.throwOnDelayedMatcher()>
    <cfif caller.$cfspec.hadAnExpectation()>
      <cfset caller.$cfspec.appendOutput("<div class='it pass'>should #attributes.should#</div>")>
      <cfset caller.$cfspec.incrementPassCount()>
    <cfelse>
      <cfset caller.this.pend("There were no expectations.")>
    </cfif>
  </cfif>
</cfif>