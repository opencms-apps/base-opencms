<%@ tag pageEncoding="UTF-8"
    display-name="webform-vars"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Initializes a Webform." %>


<%@ attribute name="webform" type="java.lang.Object" required="true"
    description="The object to initialze the form with.
    This can be an XML content, a CmsResource, or a path to a XML configuration that contains a form configuration." %>

<%@ attribute name="bookingInfo" type="java.lang.Object" required="false"
    description="For booking forms, an object that points to the additional booking settings.
    This can be an XML content or a path to a XML configuration that contains booking information." %>

<%@ attribute name="dataPath" type="java.lang.String" required="false"
    description="The target path where the form data is written to.
    If not set, this is calculated from the provided form and booking contents." %>

<%@ attribute name="formId" type="java.lang.String" required="false"
    description="The optional ID for the form." %>

<%@ attribute name="title" type="java.lang.String" required="false"
    description="The title for the form.
    If not set, this is calculated from the provided form and booking contents." %>


<%@ variable name-given="form" declare="true"
    description="The initilized webform." %>

<%@ variable name-given="formTitle" declare="true"
    description="The title to use for the webform." %>

<%@ variable name-given="formXml" declare="true"
    description="The XML content access bean for the form." %>

<%@ variable name-given="formBookingXml" declare="true"
    description="The XML content access bean for content that contains extra booking information." %>

<%@ variable name-given="adminLink" declare="true"
    description="The page where subscriptions for the form should be managed.\
        Return value is the first present of the following:\
        detail-page of the content that uses the form, detail-page of the form, current page." %>

<%@ variable name-given="formBookingPossible" declare="true"
    description="Will be 'true' if booking with this webform is possible.
    In case of an incomplete email configuration, this will be false.
    This can occur in case the form is intended to be used for event bookings,
    but has been placed on a page directly, i.e. is not shown on the event detail page." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%-- ###### Initialize the webform ###### --%>
<c:choose>
    <c:when test="${webform['class'].simpleName eq 'CmsJspContentAccessBean'}">
        <c:set var="formXml" value="${webform}" />
    </c:when>
    <c:otherwise>
        <c:set var="formXml" value="${cms.vfs.readXml[webform]}" />
    </c:otherwise>
</c:choose>
<c:set var="formBean" value='${cms.getBean("alkacon.mercury.webform.CmsFormBean")}' />
<c:set var="form" value="${formBean.setForm(formXml.rawContent)}"/>

<%-- ###### Check if booking information has been provided ###### --%>
<c:choose>
    <c:when test="${bookingInfo['class'].simpleName eq 'CmsJspContentAccessBean'}">
        <c:set var="formBookingXml" value="${bookingInfo}" />
        <c:set var="booking" value="${bookingInfo.value['Booking']}" />
    </c:when>
    <c:when test="${not empty bookingInfo}">
        <c:set var="formBookingXml" value="${cms.vfs.readXml[bookingInfo]}" />
        <c:set var="booking" value="${formBookingXml.value['Booking']}" />
     </c:when>
</c:choose>

<%-- ###### Adjust form configuration with booking parameters (if required) ###### --%>
<c:if test="${not empty formBookingXml}">
    <c:if test="${empty title}">
        <c:set var="title" value="${formBookingXml.value.Title}" />
    </c:if>
    <c:if test="${empty dataPath}">
        <c:set var="dataPath" value="${fn:substringBefore(formBookingXml.file.rootPath, '.xml')}_data/" />
    </c:if>
    <c:if test="${booking.value.MailFrom.isSet}">
        ${form.adjustConfigValue("MailFrom", booking.value.MailFrom.toString)}
    </c:if>
    <c:if test="${booking.value.MailFromName.isSet}">
        ${form.adjustConfigValue("MailFromName", booking.value.MailFromName.toString)}
    </c:if>
    <c:if test="${booking.value.MailTo.isSet}">
        ${form.adjustConfigValue("MailTo", booking.value.MailTo.toString)}
    </c:if>
    <c:if test="${booking.value.MaxRegularDatasets.isSet}">
        ${form.adjustConfigValue("DBConfig/MaxRegularDatasets", booking.value.MaxRegularDatasets.toString)}
    </c:if>
    <c:if test="${booking.value.MaxWaitlistDatasets.isSet}">
        ${form.adjustConfigValue("DBConfig/MaxWaitlistDatasets", booking.value.MaxWaitlistDatasets.toString)}
    </c:if>
    <c:if test="${booking.value.NumOtherDatasets.isSet}">
        ${form.adjustConfigValue("DBConfig/NumOtherDatasets", booking.value.NumOtherDatasets.toString)}
    </c:if>
     <c:if test="${booking.value.KeepDays.isSet}">
        ${form.adjustConfigValue("DBConfig/KeepDays", booking.value.KeepDays.toString)}
    </c:if>
    <c:if test="${booking.value.Note.isSet}">
        ${form.adjustConfigValue("macro:event.note", booking.value.Note.toString)}
    </c:if>
    <c:if test="${formBookingXml.value.Type.isSet}">
        ${form.adjustConfigValue("macro:eventtype", formBookingXml.value.Type.toString)}
        ${form.adjustConfigValue("macro:event.type", formBookingXml.value.Type.toString)}
    </c:if>
    <c:if test="${formBookingXml.value.Dates.isSet}">
        <c:set var="dateSeries" value="${formBookingXml.value.Dates.toDateSeries}" />
        ${form.adjustConfigValue("macro:event.time", dateSeries.last.formatShort)}
        ${form.adjustConfigValue("EndTime", dateSeries.last.end.time)}
    </c:if>
</c:if>

<%-- ###### Set title, data path and ID (if required) ###### --%>
<c:if test="${not empty formId}">
    ${form.adjustConfigValue("formid", formId)}
</c:if>
<c:choose>
<c:when test="${not empty title}">
    <c:set var="formTitle" value="${title}" />
    ${form.adjustConfigValue("Title", formTitle)}
</c:when>
<c:otherwise>
    <c:set var="formTitle" value="${formXml.value.Title}" />
</c:otherwise>
</c:choose>
<c:if test="${not empty dataPath}">
    <c:set var="formDataPath" value="${dataPath}" />
    ${form.adjustConfigValue("DBConfig/ContentPath", formDataPath)}
</c:if>

<c:set var="formBookingPossible" value="${
    (booking.value.MailTo.isSet or formXml.value.MailTo.isSet) and
    (booking.value.MailFrom.isSet or formXml.value.MailFrom.isSet)
}" />

<%-- ###### Set adminLink that directs to the page where the form subscriptions are managed. ###### --%>
<c:set var="adminDetailPageContent" value="${not empty formBookingXml ? formBookingXml : formXml}" />
<c:set var="adeManager" value="<%=org.opencms.main.OpenCms.getADEManager() %>" />
<c:choose>
<c:when test="${empty adeManager.getDetailPageHandler().getDetailPage(cms.vfs.cmsObject, adminDetailPageContent.file.rootPath, cms.requestContext.uri, null)}">
    <c:set var="adminLink" value="${cms.requestContext.uri}" />
</c:when>
<c:otherwise>
    <c:set var="adminLink" value="${adminDetailPageContent.filename}" />
</c:otherwise>
</c:choose>
<c:set var="adminLink"><cms:link>${adminLink}</cms:link></c:set>

<%-- ###### Execute the JSP body where the initialized form is used ###### --%>
<jsp:doBody/>