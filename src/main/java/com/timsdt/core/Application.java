package com.timsdt.core;

import org.opencms.configuration.CmsConfigurationManager;
import org.opencms.main.OpenCms;
import org.opencms.main.OpenCmsCore;
import org.xml.sax.SAXException;

import java.io.IOException;

public class Application {

    public static void main(String[] args) throws IOException, SAXException {
        CmsConfigurationManager configs = new CmsConfigurationManager(OpenCms.getSystemInfo().getConfigFolder());
    }
}
