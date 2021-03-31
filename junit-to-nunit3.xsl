<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt">
    <xsl:output method="xml" indent="yes" xalan:indent-amount="4" cdata-section-elements="message stack-trace"/>

    <xsl:template match="/">
        <test-run id="1" testcasecount="{count(//testcase)}" result="Passed" total="{count(//testcase)}" passed="{count(//testcase)} - count(//failure)}" failed="{count(//error) + count(//failure)}" inconclusive="0" skipped="{count(//skipped)}" asserts="0" start-time="2015-02-19 21:03:26Z" end-time="2015-02-19 21:03:48Z" duration="21.556964">
            <environment nunit-version="3.0.5509.17469" clr-version="4.0.30319.34014" os-version="Microsoft Windows NT 6.3.9600.0" platform="Win32NT" cwd="C:\Program Files (x86)\Jenkins\workspace\NUnit Testie Test" machine-name="PRDBUILD01" user="SYSTEM" user-domain="DATACENTER" culture="en-US" uiculture="en-US" />
            <culture-info current-culture="en-us" current-uiculture="en-us" />
            <xsl:apply-templates select="testcase"/>
            <xsl:apply-templates select="testsuite"/>

            <xsl:for-each select="testsuites">
                <xsl:apply-templates select="testcase"/>
                <xsl:apply-templates select="testsuite"/>
            </xsl:for-each>
        </test-results>
    </xsl:template>

    <xsl:template match="testcase">
        <xsl:variable name="asserts">
            <xsl:choose>
                <xsl:when test="@assertions != ''">
                    <xsl:value-of select="@assertions"></xsl:value-of>
                </xsl:when>
                <xsl:when test="count(skipped) > 0"></xsl:when>
                <xsl:when test="count(*) > 0">0</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="date">
           <xsl:value-of select="@date"></xsl:value-of>
       </xsl:variable> 
       <xsl:variable name="time">
            <xsl:choose>
                <xsl:when test="count(skipped) > 0"></xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@time"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="success">
            <xsl:choose>
                <xsl:when test="count(skipped) > 0"></xsl:when>
                <xsl:when test="count(failure) > 0">False</xsl:when>
                <xsl:otherwise>True</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="executed">
            <xsl:choose>
                <xsl:when test="count(skipped) > 0">False</xsl:when>
                <xsl:otherwise>True</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="result">
            <xsl:choose>
                <xsl:when test="count(skipped) > 0">Skipped</xsl:when>
                <xsl:when test="count(failure) > 0">Failure</xsl:when>
                <xsl:otherwise>Success</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <test-case id="1001" name="LandingPageVerificiation" fullname="Local_SmokeTestSuite.ServiceConsoleTest.LandingPageVerificiation" runstate="Runnable" result="Passed" duration="11.005068" asserts="1">
        <test-case id="1001" name="{@name}" fullname="{@name}" runstate="Runnable" result="{$result}" duration="11.005068" asserts="{$asserts}">
            <xsl:if test="@classname != ''">
                <categories>
                    <category name="{@classname}" />
                </categories>
            </xsl:if>

            <xsl:apply-templates select="error"/>
            <xsl:apply-templates select="failure"/>
            <xsl:apply-templates select="skipped"/>
        </test-case>
    </xsl:template>

    <xsl:template match="testsuite">
        <xsl:variable name="success">
            <xsl:choose>
                <xsl:when test="count(//testcase/failure) > 0">False</xsl:when>
                <xsl:otherwise>True</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="result">
            <xsl:choose>
                <xsl:when test="count(//testcase/failure) > 0">Failure</xsl:when>
                <xsl:otherwise>Success</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="asserts">
            <xsl:choose>
                <xsl:when test="@assertions != ''">
                    <xsl:value-of select="@assertions"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="count(//testcase) - count(//testcase/failure)"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <test-suite type="TestFixture" id="1" name="{@name}" fullname="{@file}" testcasecount="{$asserts}" result="{$result}" total="{$asserts}" failed="0" inconclusive="0" skipped="0" asserts="{$asserts}">
            <xsl:if test="@file != ''">
                <categories>
                    <category name="{@file}" />
                </categories>
            </xsl:if>
            <results>
                <xsl:apply-templates select="testcase"/>
                <xsl:apply-templates select="testsuite"/>
            </results>
        </test-suite>
    </xsl:template>

    <xsl:template match="error">
        <xsl:variable name="message">
            <xsl:choose>
                <xsl:when test="@message != ''">
                    <xsl:value-of select="@message"></xsl:value-of>
                </xsl:when>
                <xsl:when test="@type != ''">
                    <xsl:value-of select="@type"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>No message</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="stacktrace">
            <xsl:choose>
                <xsl:when test="text() != ''">
                    <xsl:value-of select="text()"></xsl:value-of>
                </xsl:when>
                <xsl:when test="@type != ''">
                    <xsl:value-of select="@type"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>No stack trace</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <failure>
            <message><xsl:value-of select="$message"></xsl:value-of></message>
            <stack-trace><xsl:value-of select="$stacktrace"></xsl:value-of></stack-trace>
        </failure>
    </xsl:template>

    <xsl:template match="failure">
        <xsl:variable name="message">
            <xsl:choose>
                <xsl:when test="@message != ''">
                    <xsl:value-of select="@message"></xsl:value-of>
                </xsl:when>
                <xsl:when test="@type != ''">
                    <xsl:value-of select="@type"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>No message</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="stacktrace">
            <xsl:choose>
                <xsl:when test="text() != ''">
                    <xsl:value-of select="text()"></xsl:value-of>
                </xsl:when>
                <xsl:when test="@type != ''">
                    <xsl:value-of select="@type"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>No stack trace</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <failure>
            <message><xsl:value-of select="$message"></xsl:value-of></message>
            <stack-trace><xsl:value-of select="$stacktrace"></xsl:value-of></stack-trace>
        </failure>
    </xsl:template>

    <xsl:template match="skipped">
        <reason>
            <message>Skipped</message>
        </reason>
    </xsl:template>
</xsl:stylesheet>
