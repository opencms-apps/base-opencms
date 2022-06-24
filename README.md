## Opencms kafka configuration

### run `release.sh` to build and copy jar into you server.
* Configuration `opencms-kafka.xml` in config folder
* You can create file `opencms-kafka.xml` before start tomcat server
```xml
<?xml version="1.0"?>
<!DOCTYPE opencms [
        <!ELEMENT opencms    (kafka)>
        <!ELEMENT kafka      (producer?,consumer?)>
        <!ELEMENT producer EMPTY>
        <!ELEMENT consumer EMPTY>
        <!ATTLIST producer
                host CDATA #REQUIRED
                port CDATA #IMPLIED
                topics CDATA #IMPLIED>
        <!ATTLIST consumer
                host CDATA #REQUIRED
                port CDATA #IMPLIED
                topics CDATA #IMPLIED>
        ]>
<opencms>
    <kafka>
        <producer host="localhost" port="9200" topics="opencms-event" />
        <consumer host="localhost" port="9200" topics="" />
    </kafka>
</opencms>
```