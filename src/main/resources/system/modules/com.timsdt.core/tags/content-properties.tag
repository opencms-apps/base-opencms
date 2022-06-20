<%@tag pageEncoding="UTF-8"
    display-name="content-properties"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Reads the properties for the current page." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%@ variable name-given="contentUri" declare="true"
    description="The URI of the resource currently rendered.
    This can be either the request context URI, or a detail content site path." %>

<%@ variable name-given="contentProperties" declare="true"
    description="The properties read directly from the URI resource." %>

<%@ variable name-given="contentPropertiesSearch" declare="true"
    description="The properties read from the URI resource with search." %>

<%@ variable name-given="contentPropertiesSearchDetail" declare="true"
    description="The properties read from the URI resource OR detail resource with search." %>

<%@ variable name-given="allowTemplateMods" declare="true"
    description="Controls if modifications of the template CSS and JS by including external files are allowed.
    This is controlled by the sitemap attribute 'template.allow.mods'." %>

<%@ variable name-given="allowTemplateIncludes" declare="true"
    description="Controls if custom includes files that are inserted veratim in the template head or foot are allowed.
    This is controlled by the combination of the sitemap attributes 'template.allow.includes' and 'template.allow.mods'." %>

<%@ variable name-given="templateVariant" declare="true"
    description="Template variant CSS selector to append to the generated HTML." %>

<%@ variable name-given="templateCustomer" declare="true"
    description="Template customer CSS selector to append to the generated HTML." %>

<%@ variable name-given="templateProject" declare="true"
    description="Template project CSS selector to append to the generated HTML." %>


<c:choose>
    <c:when test="${cms.detailRequest}">
        <c:set var="contentUri" value="${cms.detailContentSitePath}" />
    </c:when>
    <c:otherwise>
        <c:set var="contentUri" value="${cms.requestContext.uri}" />
    </c:otherwise>
</c:choose>

<c:set var="contentProperties"  value="${cms.vfs.readProperties[contentUri]}" />
<c:set var="contentPropertiesSearch" value="${cms.vfs.readPropertiesSearch[cms.requestContext.uri]}" />
<c:set var="contentPropertiesSearchDetail" value="${cms.vfs.readPropertiesSearch[contentUri]}" />

<c:set var="allowTemplateMods"      value="${cms.sitemapConfig.attribute['template.allow.mods'].toBoolean}" />
<c:set var="allowTemplateIncludes"  value="${allowTemplateMods and cms.sitemapConfig.attribute['template.allow.includes'].toBoolean}" />
<c:set var="templateVariant"        value="${cms.sitemapConfig.attribute['template.variant'].isSetNotNone ? ' v-'.concat(cms.sitemapConfig.attribute['template.variant'].toString) : null}" />
<c:set var="templateCustomer"       value="${cms.sitemapConfig.attribute['template.customer'].isSetNotNone ? ' c-'.concat(cms.sitemapConfig.attribute['template.customer'].toString) : null}" />
<c:set var="templateProject"        value="${cms.sitemapConfig.attribute['template.project'].isSetNotNone ? ' p-'.concat(cms.sitemapConfig.attribute['template.project'].toString) : null}" />


<jsp:doBody/>
