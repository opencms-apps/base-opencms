<%@ page import="java.io.File" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLClassLoader" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page import="java.lang.reflect.Constructor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.zip.ZipInputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.zip.ZipEntry" %>
<%@ page import="java.util.stream.Collectors" %><%
    String jarPath = "/home/sacle/projects/base-opencms/build/libs/base-opencms-1.0.jar";
    File file = new File(jarPath);
    URL url = file.toURI().toURL();

    List<String> classNames = new ArrayList<String>();
    ZipInputStream zip = new ZipInputStream(new FileInputStream(jarPath));
    for (ZipEntry entry = zip.getNextEntry(); entry != null; entry = zip.getNextEntry()) {
        if (!entry.isDirectory() && entry.getName().endsWith(".class")) {
            // This ZipEntry represents a class. Now, what class does it represent?
            String className = entry.getName().replace('/', '.'); // including ".class"
            classNames.add(className.substring(0, className.length() - ".class".length()));
        }
    }

    System.out.println(String.join("\n", classNames));

    URLClassLoader classLoader = (URLClassLoader)ClassLoader.getSystemClassLoader();
    Method method = null;
    try {
        method = URLClassLoader.class.getDeclaredMethod("addURL", URL.class);
        method.setAccessible(true);
        method.invoke(classLoader, url);
        out.print("LOAD OK");
    } catch (Exception e) {
        throw new RuntimeException(e);
    }

%>