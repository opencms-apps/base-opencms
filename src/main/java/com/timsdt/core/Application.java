package com.timsdt.core;

import org.opencms.db.CmsSecurityManager;
import org.opencms.file.CmsObject;
import org.opencms.json.JSONException;
import org.opencms.jsp.search.config.CmsSearchConfiguration;
import org.opencms.jsp.search.config.I_CmsSearchConfiguration;
import org.opencms.jsp.search.config.parser.CmsJSONSearchConfigurationParser;
import org.opencms.jsp.search.config.parser.CmsSimpleSearchConfigurationParser;
import org.opencms.jsp.search.config.parser.I_CmsSearchConfigurationParser;
import org.opencms.jsp.search.controller.CmsSearchController;
import org.opencms.jsp.search.controller.I_CmsSearchController;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.main.OpenCmsCore;
import org.opencms.search.CmsSearch;
import org.opencms.ui.apps.lists.CmsListManager;

public class Application {
    public void test() throws JSONException {
        CmsSearch cmsSearch = new CmsSearch();
        CmsObject cmso = null;
        try {
            cmso = OpenCms.initCmsObject("Guest");
            cmso.loginUser("Admin", "46546564564234356756435243");
        } catch (CmsException e) {}
        CmsListManager.ListConfigurationBean listConfigurationBean = new CmsListManager.ListConfigurationBean();
        I_CmsSearchConfigurationParser parser = new CmsJSONSearchConfigurationParser("{}");
        I_CmsSearchConfiguration searchConfiguration = new CmsSearchConfiguration(parser, cmso);
        CmsSearchController searchController = new CmsSearchController(searchConfiguration);
    }

    public static void main(String[] args) throws JSONException {
        new Application().test();
    }
}
