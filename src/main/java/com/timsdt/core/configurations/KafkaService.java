package com.timsdt.core.configurations;

import com.timsdt.core.configurations.domain.KafkaConsumer;
import com.timsdt.core.configurations.domain.KafkaProducer;

public class KafkaService {
    public KafkaConsumer consumer;
    public KafkaProducer producer;

    public void setupProducer(String host, String port, String topics) {
        producer = new KafkaProducer(host, port, topics);
    }

    public void setupConsumer(String host, String port, String topics) {
        consumer = new KafkaConsumer(host, port, topics);
    }
}
