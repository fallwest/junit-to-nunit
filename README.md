# junit-to-nunit

XSLT Template to transform JUnit XML reports to NUnit XML

## Transformation Example with Ant

You can use [Apache Ant](http://ant.apache.org/) (for example) to make the transform:

```xml
    <target name="transform" description="Run functional tests">
        <xslt in="${PATH_TO_THE_JUNIT_FILE}" out="${PATH_TO_THE_NUNIT_FILE}"  style="junit-to-nunit.xsl" />
    </target>
```