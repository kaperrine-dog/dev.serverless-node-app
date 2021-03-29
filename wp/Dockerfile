FROM wordpress:5.6.1-php7.4-apache

WORKDIR /var/www/html
COPY ./wp-setup.sh /var/www/html/wp-setup.sh


RUN apt-get update
RUN apt-get -y install wget unzip sudo less vim ibus-mozc iputils-ping

RUN echo export LANG=ja_JP.UTF-8 >> ~/.profile


#webadmin作成
ARG UID=900
ARG GID=900
ARG GROUPS=900
ARG USERNAME=webadmin
#要変更
ARG PASSWD=webadmin 


# echo "username:password" | chpasswd
# root password is "root"

RUN echo "root:root" | chpasswd && \
    adduser -u ${UID} -g ${GID} -G ${GROUPS} -p ${PASSWD} --disabled-password --gecos "" "${USERNAME}" && \
    echo "${USERNAME}:${USERNAME}" | chpasswd && \
    echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

#wp-cliインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp \
     && wp --info

ENV WPINSTALLDIR=/var/www/html


RUN wp core download \
    --locale=ja --version=5.6.1 --path=${WPINSTALLDIR} --allow-root
