<%@ page import="java.util.stream.Collectors" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tdt" tagdir="/WEB-INF/tags/tdt" %>
<%--@elvariable id="cms" type="org.opencms.jsp.util.CmsJspStandardContextBean"--%>

<cms:formatter var="content" val="value">
    <div class="content-area">
        <c:set var="req" value="${pageContext.request}" />
        <%
            String images = content.getValueList().get("Image").stream()
                    .map(item -> item.getToString())
                    .filter(img -> StringUtils.isNotBlank(img))
                    .map(img -> String.format("\"%s\"", img))
                    .collect(Collectors.joining(","));
            pageContext.setAttribute("images", images);
        %>
        <script type="application/ld+json">
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "brand": {
          "@type": "Brand",
          "name": "Trùm Da Thật"
        },
        "description": "${value.Title}",
        "name": "${value.Title}",
		"sku": "${value.SKU}",
        "image": [ ${images} ],
        "offers": {
          "@type": "Offer",
		  "url": "${curURL}",
          "price": "${value.Price}",
		  "priceValidUntil": "2022-12-30",
          "priceCurrency": "VND",
		  "itemCondition": "https://schema.org/UsedCondition",
          "availability": "https://schema.org/InStock"
        }
      }
    </script>
        <cms:include file="../elements/product/info.jsp" ></cms:include>
        <cms:include file="../elements/product/detail.jsp"></cms:include>
    </div>
</cms:formatter>