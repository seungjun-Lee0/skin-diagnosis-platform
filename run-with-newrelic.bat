@echo off
echo Starting application with New Relic Java Agent...
set "MAVEN_OPTS=-javaagent:c:\Users\Admin\Projects\the3.0-dermatology-hospital-website\newrelic\newrelic.jar"
echo MAVEN_OPTS=%MAVEN_OPTS%
cd /d c:\Users\Admin\Projects\the3.0-dermatology-hospital-website
call mvn tomcat7:run
