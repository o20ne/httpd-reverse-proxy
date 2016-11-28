FROM centos:centos7

# Add EPEL Repository
RUN rpm -iUvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

# Update
RUN yum -y update

# Apache and required packages
RUN yum install -y httpd mod_ssl mod_proxy_html nano

# Clean
RUN yum clean -y all

COPY ./httpd-foreground /usr/local/bin/
RUN chmod 0755 /usr/local/bin/httpd-foreground
COPY ./httpd.conf /etc/httpd/conf/


COPY ./reverse-proxy.conf /etc/httpd/conf.d/reverse-proxy.conf
COPY ./certs /etc/httpd/certs
RUN rm /etc/httpd/conf.d/ssl.conf


EXPOSE 80 8000 8080 8443 8888


CMD ["httpd-foreground"]
