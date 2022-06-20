<%@ page import="org.opencms.db.CmsDbContextFactory" %><%
    CmsDbContextFactory contextFactory = new CmsDbContextFactory();
    out.print(contextFactory.getDbContext().currentProject().getName());
%>