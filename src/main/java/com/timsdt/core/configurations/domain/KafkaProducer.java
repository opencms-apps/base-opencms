package com.timsdt.core.configurations.domain;

import com.timsdt.core.configurations.domain.Configuration;

public class KafkaProducer extends Configuration {

    public KafkaProducer(String host, String port, String topics) {
        super(host, port, topics);
    }

    public Type getType() {
        return Type.PRODUCER;
    }
}
