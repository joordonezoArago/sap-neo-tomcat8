#!/bin/bash
NEO_SDK=/neo-java-web-sdk
NEO=${NEO_SDK}/tools/neo.sh
TOMCAT_HOME=/tomcat

init() {
	${NEO} install-local -l ${TOMCAT_HOME}
}

run() {
	${NEO} deploy-local -l ${TOMCAT_HOME} -s /tomcat/webapps
	${NEO} start-local -l ${TOMCAT_HOME}
}


case $1 in
	run)
		run
		;;
	init)
		init
		;;
esac
