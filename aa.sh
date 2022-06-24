./gradlew clean
./gradlew Jar

echo "" > ~/servers/tomcat-9.0.62/webapps/ROOT/WEB-INF/logs/opencms.log
rm ~/servers/tomcat-9.0.62/webapps/ROOT/WEB-INF/lib/base-opencms-1.0.jar
cp build/libs/base-opencms-1.0.jar ~/servers/tomcat-9.0.62/webapps/ROOT/WEB-INF/lib/base-opencms-1.0.jar