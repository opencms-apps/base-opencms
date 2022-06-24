package com.timsdt.core.configurations.domain;

public class KafkaConsumer extends Configuration {
    public KafkaConsumer(String host, String port, String topics) {
        super(host, port, topics);
    }

    public Type getType() {
        return Type.CONSUMER;
    }
}
