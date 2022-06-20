<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tdt" tagdir="/WEB-INF/tags/tdt" %>
<%--@elvariable id="cms" type="org.opencms.jsp.util.CmsJspStandardContextBean"--%>

<script type="application/ld+json">{
  "@context": "http://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "item": {
        "@id": "https://trumdathat.com/",
        "name": "Trùm da thật"
      }
    }

<c:set var="lastIndx" value="2" />
<c:forEach var="item" items="${nav.items}" varStatus="stas">
    <c:set var="itemLink">http://trumdathat.com<cms:link>${item.resourceName}</cms:link></c:set>
    <c:set var="itemText">${item.navText}</c:set>
    <c:set var="lastIndx" value="${stas.index+2}" />
    ,
    {
    "@type": "ListItem",
    "position": ${lastIndx},
    "item": {
    "@id": "${itemLink}",
    "name": "${itemText}"
    }
    }
</c:forEach>

	,
    {
      "@type": "ListItem",
      "position": ${lastIndx + 1},
      "item": {
        "@id": "${curURL}",
        "name": "${finalTitle}"
      }
    }

  ]
}</script>