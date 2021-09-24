#!/bin/bash
NEO_SDK=/neo-java-web-sdk
NEO=${NEO_SDK}/tools/neo.sh
TOMCAT_HOME=/tomcat
CATALINA=${TOMCAT_HOME}/bin/catalina.sh

init() {
	#${NEO} install-local -l ${TOMCAT_HOME}
	#${NEO} deploy-local -l ${TOMCAT_HOME} -s /tomcat/webapps
	${NEO} start-local -l ${TOMCAT_HOME}
}
startup() {
 	${TOMCAT_HOME}/bin/startup.sh
}
shutdown() {
 	${TOMCAT_HOME}/bin/shutdown.sh
}
run() {
 	${CATALINA} run
}
debug() {
 	${CATALINA} debug
}
start() {
 	${CATALINA} start
}
case $1 in
	init)
		init
		;;
	debug)
		debug
		;;
	start)
		start
		;;
	startup)
		startup
		;;
	shutdown)
		shutdown
		;;
esac
