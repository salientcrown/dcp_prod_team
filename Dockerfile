
FROM amazonlinux:latest

RUN yum update -y && \
    yum install -y httpd && \
    yum search wget && \
    yum install wget -y && \
    yum install unzip -yum

RUN cd /var/www/html

RUN wget https://github.com/azeezsalu/techmax/archive/refs/heads/main.zip

RUN unzip main.zip

RUN cp -r techmax-main/* /var/www/html/

RUN rm -rf techmax-main main.zip

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]