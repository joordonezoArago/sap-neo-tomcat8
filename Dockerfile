#FROM store/saplabs/hanaexpress:2.00.054.00.20210603.1 as hana

#RUN --ulimit nofile=1048576:1048576 \
	#--sysctl kernel.shmmax=1073741824 \
	#--sysctl net.ipv4.ip_local_port_range='40000 60999' \
	#--sysctl kernel.shmmni=524288 \
	#--sysctl kernel.shmall=8388608 \
	#--passwords-url file:///hana/mounts/pass.json \
	#--agree-to-sap-license

FROM debian:stable-20210902 as debian

RUN apt-get update && apt-get install -y \
	curl \
	unzip \
	nano \
	vim \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tomcat

RUN curl \
	--cookie "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
	https://tools.hana.ondemand.com/additional/sapjvm-8.1.078-linux-x64.zip \
	-o sapjvm_8.zip \
	&& \
	unzip sapjvm_8.zip \
	&& \
	rm sapjvm_8.zip

RUN curl \
	--cookie "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
	https://tools.hana.ondemand.com/sdk/neo-java-web-sdk-3.134.8.zip \
	-o neo-java-web-sdk.zip \
	&& \
	mkdir neo-java-web-sdk \
	&& \
	unzip neo-java-web-sdk.zip -d neo-java-web-sdk \
	&& \
	rm neo-java-web-sdk.zip


COPY src/scripts /scripts/
RUN chmod a+x /scripts/*

ENV JAVA_HOME=/sapjvm_8
ENV SAPJVM_HOME=/sapjvm_8
ENV JRE_HOME=/sapjvm_8
ENV UMASK=0000

RUN /neo-java-web-sdk/tools/neo.sh install-local -l /tomcat
#RUN /scripts/run.sh init
COPY example/cfg/conf /tomcat/conf/
COPY example/cfg/config_master /tomcat/config_master/

#EXPOSE 8080
#EXPOSE 8443
#EXPOSE 8009
#EXPOSE 8003

CMD ["/scripts/run.sh", "init"]


