<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tdt" tagdir="/WEB-INF/tags/tdt" %>
<%--@elvariable id="cms" type="org.opencms.jsp.util.CmsJspStandardContextBean"--%>

<cms:formatter var="content" val="value" rdfa="rdfa">
    <div class="content-area">
        <cms:navigation var="nav" type="breadCrumb" startLevel="1" />
        <c:set var="curTitle" value="${value.Title.toString}" />
        <c:set var="finalTitle" value="" />
        <c:choose>
            <c:when test="${curTitle.startsWith('##')}">
                <c:set var="finalTitle">${param[curTitle.substring(2)]}</c:set>
            </c:when>
            <c:otherwise>
                <c:set var="finalTitle"><cms:info property="opencms.title" /></c:set>
            </c:otherwise>
        </c:choose>
        <c:set var="tmpTitle" value="${finalTitle}" />
        <c:if test="${finalTitle eq ''}">
            <c:set var="finalTitle"><cms:info property="opencms.title" /></c:set>
        </c:if>

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

        <section class="page-section breadcrumbs">
            <div class="container">
                <div class="page-header">
                    <h1 ${rdfa.Title}>
                        <c:if test="${curTitle.startsWith('##') and tmpTitle ne ''}">
                            Kết quả tìm kiếm cho
                        </c:if> ${finalTitle}
                    </h1>
                </div>
                <ul class="breadcrumb">
                    <li><a href="<cms:link>${cms.subSitePath}</cms:link>>">${value.HomeTitle}</a></li>
                    <c:forEach var="item" items="${nav.items}" varStatus="stas">
                        <c:set var="itemLink"><cms:link>${item.resourceName}</cms:link></c:set>
                        <c:set var="itemText">${item.navText}</c:set>
                        <li><a href="${itemLink}">${itemText}</a></li>
                    </c:forEach>
                    <li class="active">${finalTitle}</li>
                </ul>
            </div>
        </section>
    </div>
</cms:formatter>