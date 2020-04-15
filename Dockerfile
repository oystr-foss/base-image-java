FROM phusion/baseimage:latest

# Install Java and other packages
# https://www.reddit.com/r/Ubuntu/comments/beqbs2/webupd8_oracle_java_jdk_8_installer_ppa/
RUN apt-get update
RUN apt-get install -y wget python tree jed curl unzip tzdata java-common

RUN wget https://d3pxv6yz143wms.cloudfront.net/8.212.04.1/java-1.8.0-amazon-corretto-jdk_8.212.04-1_amd64.deb
RUN dpkg --install java-1.8.0-amazon-corretto-jdk_8.212.04-1_amd64.deb
RUN update-alternatives --config java
RUN update-alternatives --config javac

RUN apt-get clean
RUN rm -rf /tmp/* /var/tmp/* /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define TZ
RUN ln -fs /usr/share/zoneinfo/America/Toronto /etc/localtime && printf 'America\nSao_Paulo\n' | dpkg-reconfigure tzdata

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
