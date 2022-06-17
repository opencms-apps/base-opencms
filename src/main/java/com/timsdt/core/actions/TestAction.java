package com.timsdt.core.actions;

import java.util.ArrayList;
import java.util.List;

public class TestAction extends ATest implements ITest {

    public TestAction() {
        System.out.println("Default contructor");
    }

    public TestAction(String xx) {
        System.out.println("Second contructor");
    }
    public void test() {
        System.out.println("\n\n\n");
        System.out.println("OKAY :: test");
        System.out.println("\n\n\n");
    }

    @Override
    public void test3() {
        System.out.println("\n\n\n");
        System.out.println("OKAY :: test3");
        System.out.println("\n\n\n");
    }


    public static void main(String[] args) {
        List<Runnable> threads = new ArrayList<>();
        threads.add(new Runnable() {
            @Override
            public void run() {
                try {
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.out.println("ABC ");
            }
        });
    }
}
