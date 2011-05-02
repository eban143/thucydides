package net.thucydides.samples;

import net.thucydides.core.annotations.Steps;
import net.thucydides.core.pages.Pages;
import net.thucydides.junit.annotations.Concurrent;
import net.thucydides.junit.annotations.Managed;
import net.thucydides.junit.annotations.ManagedPages;
import net.thucydides.junit.runners.ThucydidesParameterizedRunner;
import net.thucydides.junit.runners.ThucydidesParameterizedRunner.TestData;
import org.apache.http.annotation.ThreadSafe;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;

import java.util.Arrays;
import java.util.Collection;

@RunWith(ThucydidesParameterizedRunner.class)
@Concurrent
public class SampleParallelDataDrivenScenario {

    @TestData
    public static Collection testData() {
            return Arrays.asList(new Object[][]{
                    {"a", 1},
                    {"b", 2},
                    {"c", 3}
            });
        }
    private String option1;
    private Integer option2;

    public SampleParallelDataDrivenScenario(String option1, Integer option2) {
        this.option1 = option1;
        this.option2 = option2;
    }

    @Managed
    public WebDriver webdriver;

    @ManagedPages(defaultUrl = "http://www.google.com")
    public Pages pages;

    @Steps
    public SampleScenarioSteps steps;
        
    @Test
    public void happy_day_scenario() {
        steps.stepWithParameters(option1,option2);
    }

}
