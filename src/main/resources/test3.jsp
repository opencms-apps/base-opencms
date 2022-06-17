<%@ page import="java.lang.reflect.Method" %><%
    try {
        Class<?> aClass = ClassLoader.getSystemClassLoader().loadClass("com.timsdt.core.actions.TestAction");
        Object obj = aClass.getDeclaredConstructor().newInstance();
        Method[] methods = aClass.getDeclaredMethods();
        for (Method method: methods) {
            out.print(method.getName() + "<br/>");
            method.invoke(obj);
        }
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>