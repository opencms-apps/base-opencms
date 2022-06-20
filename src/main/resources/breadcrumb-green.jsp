<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
    <div class="breadcrumb-area mb-50">
        <script type="application/ld+json">{
  "@context": "http://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "item": {
        "@id": "https://greenfarmcoop.vn/",
        "name": "HTX Nông Nghiệp Công Nghệ Cao - Khởi nguồn an toàn của mọi món ngon"
      }
    }

<c:set var="lastIndx" value="1" />
<c:forEach var="item" items="${nav.items}" varStatus="stas">
            <c:set var="itemLink">http://greenfarmcoop.vn<cms:link>${item.resourceName}</cms:link></c:set>
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
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="breadcrumb-container">
                        <ul>
                            <li><a href="${cms.subSitePath}"><i class="fa fa-home"></i> <span>${value.Home}</span></a></li>
                            <li class="active"><cms:info property="opencms.title" /></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</cms:formatter>