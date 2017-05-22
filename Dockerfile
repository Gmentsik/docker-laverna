FROM phusion/baseimage:latest
MAINTAINER github.com/gmentsik

RUN apt-get update && apt-get install -y \
    git \
    php5-fpm \
    supervisor \
    nginx

ADD laverna.nginx.conf /etc/nginx/sites-available/laverna
RUN ln -s /etc/nginx/sites-available/laverna /etc/nginx/sites-enabled/laverna
RUN rm /etc/nginx/sites-enabled/default

RUN mkdir /var/www
RUN git clone -b gh-pages https://github.com/Laverna/static-laverna /var/www

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
