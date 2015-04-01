<%@include file="/apps/edisonweb/components/shared/global.jsp"%>
<c:choose>
	<c:when test="${empty properties.header and empty properties.edisonInternationalText and empty properties.sceText and empty properties.searchButtonText}">
		<c:if test="${author }">
			Please author Job Search component.
		</c:if>
	</c:when>
	<c:otherwise>
		<h3>${properties.header}</h3>
	    <c:set var="bgimage" value="${edison:getImageSource(slingfn:getResourceRelative(resource,'bgimage'))}" />
	    <c:if test="${not empty bgimage}">
	    	<c:set var="bgstyle" value="background: #f2f2f2 url('${bgimage}') no-repeat top right;" />
	    </c:if>
	    <div class="job-form" style="${bgstyle}">      
	      <!-- (changes made EP/89/rekha) --> 
	      <!-- <form action="${edison:createValidLink(properties.searchButtonLink, '#')}" method="get" target="${properties.searchButtonLinkTarget}" onsubmit="return trackjobsearch(this)">  -->
	      <form action="${edison:createValidLink(properties.searchButtonLink, '#')}" method="get" target="${properties.searchButtonLinkTarget}"> <!--onsubmit="return trackjobsearch(this) (changes made EP/89/rekha)  -->            
	        <div class="select-filter">
	          <c:if test="${not empty properties.edisonInternationalText}"><button id="edison" value="edison">${properties.edisonInternationalText}</button></c:if>
	          <c:if test="${not empty properties.sceText}"><button id="sce" value="sce">${properties.sceText}</button></c:if>
	          <label class="screen" for="company">Company</label>
	          <select id="company" class="target radio" name="company">
	            <c:if test="${not empty properties.edisonInternationalText}"><option value="edison">${properties.edisonInternationalText}</option></c:if>
	            <c:if test="${not empty properties.sceText}"><option value="sce" selected="selected">${properties.sceText}</option></c:if>
	          </select>
	        </div>
	        <div class="search-info">
	        	<label class="screen" for="jobnumber">${properties.jobNoDefaultText}</label>
	          <input id="jobnumber" type="text" placeholder="${properties.jobNoDefaultText}" value="${properties.jobNoDefaultText}" name="jobNumberSearch"/>
	          <label class="screen" for="keyword">${properties.keywordDefaultText}</label>
	          <input id="keyword" type="text" placeholder="${properties.keywordDefaultText}" value="${properties.keywordDefaultText}" name="keyword" />
	          <label class="screen" for="jobfield">Job Field</label>
	          <select id="jobfield" class="target" name="jobfield">
	            <option selected="true" style="display:none; color:#76797d;" value="-1">${properties.jobFieldDefaultText}</option>	
							<c:set var="jobFieldOptionsResource" value="${slingfn:getResourceRelative(resource, 'jobFieldOptions')}"/>				
							<c:set var="jobFieldOptions" value="${slingfn:listChildren(jobFieldOptionsResource)}"/>				
							<c:forEach var="jobFieldOption" items="${slingfn:adaptResources(jobFieldOptions, 'org.apache.sling.api.resource.ValueMap')}">               
								<option value="${jobFieldOption.jobFieldValue}">${jobFieldOption.jobFieldDisplay}</option>
							</c:forEach>				   			
	          </select>
	          <label class="screen" for="location">Location</label>
	          <select id="location" class="target" name="location">
	            <option selected="true" style="display:none; color:#76797d;" value="-1">${properties.locationDefaultText}</option>	            
							<c:set var="locationOptionsResource" value="${slingfn:getResourceRelative(resource, 'locationOptions')}"/>				
							<c:set var="locationOptions" value="${slingfn:listChildren(locationOptionsResource)}"/>				
							<c:forEach var="locationOption" items="${slingfn:adaptResources(locationOptions, 'org.apache.sling.api.resource.ValueMap')}">               
								<option value="${locationOption.locationValue}">${locationOption.locationDisplay}</option>
							</c:forEach>				
	          </select>
	        </div>
	        <input type="submit" class="btn" value="${properties.searchButtonText}" />
	        <c:if test="${not empty properties.advSearchLinkHref }">
	        	<a id="advancedSearch" onclick="updateAdvancedLink();" class="advanced-search" href="${edison:createValidLink(properties.sceAdvSearchLinkHref,'')}" target="${properties.advSearchLinkTarget }"><i class="fa fa-chevron-circle-right"></i>${properties.advSearchLinkText }</a>
	        </c:if>
	      </form>
	      
	      <div class="explore-careers">
	        <p>${properties.rightColumnText1}<span> ${properties.rightColumnText2 }</span></p>
	        <ul class="tile-link">
				<c:set var="jobListResource" value="${slingfn:getResourceRelative(resource, 'jobList')}"/>				
				<c:set var="jobList" value="${slingfn:listChildren(jobListResource)}"/>
		
				<c:forEach var="importantJob" items="${slingfn:adaptResources(jobList, 'org.apache.sling.api.resource.ValueMap')}">
					<c:if test="${not empty importantJob.jobLink }">              
						<li><edison:a link="${importantJob.jobLink}" linkTarget="${importantJob.jobLinkTarget}"><i class="fa fa-chevron-circle-right"></i>${importantJob.jobLinkText}</edison:a></li>
					</c:if>
				</c:forEach>
	       </ul>
	      </div>      
	    </div>
	    <script type="text/javascript">
	    	$(document).ready(function(){
 		    	if($("#company").val() == "sce") {
		    		$("#sce").addClass("active");
		    		$("#edison").removeClass("active");
		    	} else {
		    		$("#sce").removeClass("active");
		    		$("#edison").addClass("active");
		    	}
	    	});
	    
		    $("#edison").click(function() {
		    	$("#company").val("edison");
		    });
		    
		    $("#sce").click(function() {
		    	$("#company").val("sce");
		    });
		    function updateAdvancedLink() {
		    	var urlparams = "?";
		    	var jobNumberSearch = $("#jobnumber").val(); 
		    	var keyword = $("#keyword").val(); 
		    	var jobfield = $("#jobfield").val();
		    	var location = $("#location").val();
		    	
		    	if(jobNumberSearch != "${properties.jobNoDefaultText}" && jobNumberSearch != ""){
		    		urlparams += "jobNumberSearch="+jobNumberSearch;
		    	}
		    	if(keyword != "${properties.keywordDefaultText}" && keyword != ""){
		    		urlparams += "&keyword=" + keyword;
		    	}
		    	if(jobfield != "-1" && jobfield != ""){
		    		urlparams += "&jobfield=" + jobfield;
		    	}
		    	if(location != "-1" && location != ""){
		    		urlparams += "&location=" + location;
		    	}
		    	
		    	if(urlparams == "?"){
		    		urlparams = "";
		    	}
		    	
 		    	if($("#company").val() == "sce") {
		    		$("#advancedSearch").attr("href", "${edison:createValidLink(properties.sceAdvSearchLinkHref, '#')}" + urlparams);
		    	} else {
		    		$("#advancedSearch").attr("href", "${edison:createValidLink(properties.advSearchLinkHref, '#')}" + urlparams);
		    	}
		    }
		  <%-- function trackjobsearch(form) {
		    	if(form.jobnumber.value == '${properties.jobNoDefaultText}') {
		    		form.jobnumber.value="";
		    	}
		    	if(form.keyword.value == '${properties.keywordDefaultText}') {
		    		form.keyword.value = "";
		    	}
		    	if(form.company.value == 'sce') {
		    		form.action = "${edison:createValidLink(properties.sceSearchButtonLink, '#')}";
		    	} else {
		    		form.action = "${edison:createValidLink(properties.searchButtonLink, '#')}";
		    	}
			    if (CQ_Analytics.Sitecatalyst) {
			        CQ_Analytics.record({
			            event: 'jobSearches',
			            values: {
			            	searchmode:'basic', 
			            	company:form.company.value, 
			            	jobnumber:form.jobnumber.value, 
			            	keyword:form.keyword.value, 
			            	jobfield:form.jobfield.value, 
			            	location:form.location.value
			            },
			            componentPath: '<%=resource.getResourceType()%>'
			        });
			    }
		    }(EP/89/rekha)--%>
		</script>
	</c:otherwise>
</c:choose>
