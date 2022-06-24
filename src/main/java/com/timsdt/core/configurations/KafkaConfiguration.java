package com.timsdt.core.configurations;

import org.apache.commons.digester3.Digester;
import org.dom4j.Element;
import org.opencms.configuration.A_CmsXmlConfiguration;

public class KafkaConfiguration extends A_CmsXmlConfiguration {

    public KafkaConfiguration() {
        System.out.println("Init me");
    }

    @Override
    protected void initMembers() {

    }

    @Override
    public void addXmlDigesterRules(Digester digester) {
        //
    }

    @Override
    protected void setXmlFileName(String fileName) {
        System.out.println(fileName);
    }

    @Override
    public String getXmlFileName() {
        return "opencms-kafka.xml";
    }

    @Override
    public Element generateXml(Element parent) {
        return parent.addElement("karaf");
    }

    @Override
    public String getDtdFilename() {
        return "opencms-kafka.dtd";
    }
}
