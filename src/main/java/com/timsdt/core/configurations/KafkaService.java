package com.timsdt.core.configurations;

import com.timsdt.core.configurations.domain.Configuration;
import com.timsdt.core.configurations.domain.KafkaConsumer;
import com.timsdt.core.configurations.domain.KafkaProducer;
import org.opencms.jlan.CmsJlanThreadManager;
import org.opencms.main.CmsEvent;
import org.opencms.main.I_CmsEventListener;
import org.opencms.main.OpenCms;

import java.io.File;

public class KafkaService {
    public KafkaConsumer consumer;
    public KafkaProducer producer;

    public synchronized void start() {
        startConfiguration(producer);
    }

    private void startConfiguration(Configuration configuration) {
        if (configuration == null || configuration.invalid()) {
            return;
        }
        if (configuration.m_thread != null) {
            return;
        }
        configuration.m_thread = new Thread() {
            @Override
            public void run() {
                System.out.printf("KafkaService :: startConfiguration kafka %s?topics=%s%n", configuration.bootstrapServer,
                        configuration.topics);
                if (Configuration.Type.PRODUCER.equals(configuration.getType())) {

                }
            }
        };
        configuration.m_thread.start();
    }

    public void setupProducer(String host, String port, String topics) {
        producer = new KafkaProducer(host, port, topics);
    }

    public void setupConsumer(String host, String port, String topics) {
        consumer = new KafkaConsumer(host, port, topics);
    }
}
