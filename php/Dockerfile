FROM wordpress:5.6.1-php7.4-apache

WORKDIR /var/www/html
COPY ./wp-setup.sh /var/www/html/
COPY ./config/php.ini /usr/local/etc/php/conf.d/

RUN apt-get update
RUN apt-get -y install wget unzip sudo less vim ibus-mozc iputils-ping

#日本語化
RUN apt-get install -y locales
RUN echo "ja_JP UTF-8" > /etc/locale.gen
RUN locale-gen
RUN echo export LANG=ja_JP.UTF-8 >> ~/.profile

#wp-cliインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp \
     && wp --info

ENV WPINSTALLDIR=/var/www/html


#RUN wp core download \
#    --locale=ja --version=5.6.1 --path=${WPINSTALLDIR} --allow-root

ARG THEMENAME=${HOST}
COPY ./wp-setup.sh ${WPINSTALLDIR}/
RUN /var/www/html/wp-setup.sh