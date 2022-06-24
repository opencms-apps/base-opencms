package com.timsdt.core.configurations.domain;

import org.apache.commons.lang3.StringUtils;

public abstract class Configuration {
    public String bootstrapServer;
    protected String host;
    protected String port;
    public String topics;

    public Thread m_thread;

    public enum Type {
        CONSUMER, PRODUCER
    }

    public Configuration() {}
    public Configuration(String host, String port, String topics) {
        this.host = host;
        this.port = port;
        this.topics = topics;
        this.bootstrapServer = String.format("%s:%s", host, port);
    }

    public abstract Type getType();
    public boolean invalid() {
        return StringUtils.isAnyBlank(host, port, topics);
    }
}
