package com.timsdt.core.configurations;

import org.apache.commons.digester3.Digester;
import org.dom4j.Element;
import org.opencms.configuration.A_CmsXmlConfiguration;
import org.opencms.main.OpenCms;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

public class KafkaConfiguration extends A_CmsXmlConfiguration {
    private static final String configFileName = "opencms-kafka.xml";
    @Override
    protected void initMembers() {
        setXmlFileName(configFileName);
        String configPath = OpenCms.getSystemInfo().getConfigFolder() + this.configFileName ;
        File config = new File(configPath);
        if (config.exists()) {
            return;
        }
        InputStream stream = null;
        OutputStream resStreamOut = null;
        String jarFolder;
        try {
            stream = KafkaConfiguration.class.getResourceAsStream(configFileName);
            if (stream == null) {
                System.out.println("Cannot get resource \"" + configFileName + "\" from Jar file.");
                return;
            }

            int readBytes;
            byte[] buffer = new byte[4096];
            resStreamOut = new FileOutputStream(configPath);
            while ((readBytes = stream.read(buffer)) > 0) {
                resStreamOut.write(buffer, 0, readBytes);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void addXmlDigesterRules(Digester digester) {
        //do nothing
    }

    @Override
    public Element generateXml(Element parent) {
        return parent.addElement("kafka");
    }

    @Override
    public String getDtdSystemLocation() {
        return null;
    }

    @Override
    public String getDtdFilename() {
        return null;
    }
}
