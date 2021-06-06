FROM ubuntu:20.04
RUN apt-get update
RUN apt update
RUN apt install -y default-jdk
RUN java -version
RUN apt update
RUN apt install -y wget
RUN cd /tmp
RUN wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.46/bin/apache-tomcat-9.0.46.tar.gz
RUN mkdir /opt/tomcat
RUN tar -xf apache-tomcat-9.0.46.tar.gz
RUN mv apache-tomcat-9.0.46 /opt/tomcat/
RUN useradd -m -U -d /opt/tomcat -s /bin/false tomcat
RUN chown -R tomcat: /opt/tomcat
RUN ln -s /opt/tomcat/apache-tomcat-9.0.46 /opt/tomcat/latest
RUN sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
COPY ./tomcat.service /etc/systemd/system
RUN apt update
RUN apt install -y systemctl
RUN systemctl daemon-reload
RUN systemctl start tomcat
RUN apt update
RUN apt install -y ufw
RUN ufw allow 8080/tcp
COPY ./testWebApp.war /opt/tomcat/latest/webapps
Expose 8080 443