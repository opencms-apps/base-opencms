<%@ tag pageEncoding="UTF-8"
    display-name="data-external-cookies"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Generates cookie data for external elements." %>


<%@ attribute name="message" type="java.lang.String" required="false"
    description="Element depended messsage for the generated cookie alert box." %>

<%@ attribute name="heading" type="java.lang.String" required="false"
    description="Heading for the generated cookie alert box
    Will be read from the global configuration if not provided." %>

<%@ attribute name="footer" type="java.lang.String" required="false"
    description="Footer for the generated cookie alert box
    Will be read from the global configuration if not provided." %>

<%@ attribute name="modal" type="java.lang.Boolean" required="false"
    description="Controls if the data attibute is generated for a modal dialog." %>

<%@ attribute name="test" type="java.lang.Boolean" required="false"
    description="Can be used to defer the decision to actually create the cookie data to the calling element.
    If not set or 'true', the cookie data from this tag is generated and returned.
    Otherwise everything is ignored and an empty string ' ' is returned from this tag. " %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>


<c:choose>
    <c:when test="${empty test or test}">
        <cms:jsonobject var="cookieData">
            <c:if test="${not empty heading}">
                <cms:jsonvalue key="heading" value="${heading}" />
            </c:if>
            <c:if test="${not empty message}">
                <cms:jsonvalue key="message" value="${message}" />
            </c:if>
            <c:if test="${not empty footer}">
                <cms:jsonvalue key="footer" value="${footer}" />
            </c:if>
        </cms:jsonobject>
        <%----%>${' '}${modal ? 'data-modal-external-cookies' : 'data-external-cookies'}='${cookieData.compact}'${' '}<%----%>
    </c:when>
    <c:otherwise>
        <%----%>${' '}<%----%>
    </c:otherwise>
</c:choose>