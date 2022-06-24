package com.timsdt.core.configurations.domain;

public abstract class Configuration {
    protected String bootstrapServer;
    protected String host;
    protected String port;
    protected String topics;

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
}
