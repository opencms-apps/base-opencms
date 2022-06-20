<%@ tag pageEncoding="UTF-8"
    display-name="heading"
    body-content="tagdependent"
    trimDirectiveWhitespaces="true"
    description="Displays a HTML heading with a specified level." %>


<%@ attribute name="text" type="java.lang.Object" required="false"
    description="The heading text. HTML in this will be escaped.
    This can be either a String or a CmsJspContentAccessValueWrapper" %>

<%@ attribute name="level" type="java.lang.Integer" required="true"
    description="The HTML level of the heading, must be from 1 to 6 to generate h1 to h6.
    If the special value 7 is used, the text will be outputted as 'div' not as HTML heading.
    If no valid level is provided, for example 0, the headline will not be outputted at all." %>

<%@ attribute name="suffix" type="java.lang.String" required="false"
    description="Optional suffix for the heading. HTML in this will NOT be escaped." %>

<%@ attribute name="prefix" type="java.lang.String" required="false"
    description="Optional prefix for the heading. HTML in this will NOT be escaped." %>

<%@ attribute name="css" type="java.lang.String" required="false"
    description="Optional CSS classes to attach to the heading tag." %>

<%@ attribute name="tabindex" type="java.lang.Boolean" required="false"
    description="Force adding 'tabindex=0' attribute to the generated markup
    If not set, use default 'true' for h1, h2 and h3, 'false' for all other sizes.
    If 'false' is set explicitly, supress genertion of tabindex attribute even for h1, h2 and h3." %>

<%@ attribute name="attr" type="java.lang.String" required="false"
    description="Optional HTML attributes to attach to the heading tag." %>

<%@ attribute name="markupText" fragment="true" required="false"
    description="Markup shown for the text if the text is not provided.
    If both attributes 'markupText' and 'text' are provided, only the 'markupText' will be displayed." %>

<%@ attribute name="escapeXml" type="java.lang.Boolean" required="false"
    description="Controls if the heading text is XML escaped.
    Default is 'true' if not provided." %>

<%@ attribute name="ade" type="java.lang.Boolean" required="false"
    description="Enables advanced direct edit for the generated heading.
    Default is 'false' if not provided." %>

<%@ attribute name="addId" type="java.lang.Boolean" required="false"
    description="Adds an automatically generated ID attribute for the heading, for use in anchor links.
    The ID attribute will be generated from the provided text, which will be translated according to the configured file name translation rules.
    The result will also be all lower case.
    This requires that the 'text' attribute is provided, if only 'markupText' is provided no ID can be generated.
    Default is 'false' if not provided." %>

<%@ attribute name="test" type="java.lang.Boolean" required="false"
    description="The heading markup will only be generated if this evaluates to 'true'." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>


<c:if test="${(level > 0) and (level <= 7) and (empty test or test)}">

    <c:set var="escapeXml" value="${empty escapeXml ? true : escapeXml}" />
    <c:set var="addTabindex" value="${empty tabindex ? ((level > 0) and (level <=3)) : tabindex}" />

    <c:if test="${(not empty markupText) or (not empty text)}">
        <c:choose>
            <c:when test="${level == 7}">
                ${'<div'}
            </c:when>
            <c:otherwise>
                ${'<h'}${level}
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty css}">${' '}class="${css}"</c:if>
        <c:if test="${addId and not empty text}">${' id=\"'}<mercury:translate-name name="${text}" />${'\"'}</c:if>
        <c:if test="${addTabindex}">${' '}tabindex="0"</c:if>
        <c:if test="${not empty attr}">${' '}${attr}</c:if>
        <c:if test="${ade and cms:isWrapper(text) }">${' '}${text.rdfaAttr}</c:if>
        ${'>'}
            ${prefix}
            <c:choose>
                <c:when test="${not empty markupText}">
                    <jsp:invoke fragment="markupText" />
                </c:when>
                <c:when test="${not empty text}">
                    <mercury:out value="${text}" escapeXml="${escapeXml}" />
                </c:when>
            </c:choose>
            ${suffix}

        <c:choose>
            <c:when test="${level == 7}">
                ${'</div>'}
            </c:when>
            <c:otherwise>
                 ${'</h'}${level}${'>'}
            </c:otherwise>
        </c:choose>
        <mercury:nl />
    </c:if>

</c:if>