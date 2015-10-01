# Create a website with Nginx
FROM ubuntu:14.04.2
MAINTAINER Firstname Lastname "myemail.com"
ENV REFRESHED_AT 2015-03-12
RUN apt-get -qq update
RUN apt-get -qq upgrade
RUN apt-get -qq -y install nginx
# Change Nginx configuration so that it will not run as a daemon
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD service nginx start
