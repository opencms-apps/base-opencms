<%@ page import="java.lang.reflect.Constructor" %>
<%@ page import="java.lang.reflect.Method" %>
<%
    try {
        Constructor<?> cs = ClassLoader.getSystemClassLoader().loadClass("com.timsdt.core.actions.TestAction").getConstructor();
        Object obj = cs.newInstance();
        Method method = cs.getDeclaringClass().getMethod("test");
        method.invoke(obj);
    } catch (Exception ex) {
        throw new RuntimeException(ex);
    }





%>