FROM wordpress:5.7.2-php7.4-apache

#SHELL to /bin/bash
#SHELL ["/bin/bash", "-c"]

WORKDIR /var/www/html
COPY ./wp-setup.sh /var/www/html/
COPY ./config/php.ini /usr/local/etc/php/conf.d/

#諸々インストール
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get -y install --no-install-recommends wget unzip sudo less vim ibus-mozc \
    iputils-ping git locales \
    curl git mercurial make binutils bison gcc build-essential golang-go \
    apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*


#日本語化
RUN echo "ja_JP UTF-8" > /etc/locale.gen
RUN locale-gen
RUN echo export LANG=ja_JP.UTF-8 >> ~/.profile

#webadmin作成
ARG UID=1000
ARG GID=1000
ARG GROUP=webadmin
ARG USERNAME=webadmin
#要変更
ARG PASSWD=webadmin


# echo "username:password" | chpasswd
# root password is "root"

RUN echo "root:root" | chpasswd && \
    groupadd --gid ${GID} ${GROUP} && \
    groupadd --gid ${GID} wheel -o && \
    adduser --uid ${UID} --ingroup wheel \
    --disabled-password --gecos "" "${USERNAME}" && \
    usermod -G wheel,${GROUP} ${USERNAME} && \
    echo "${USERNAME}:${USERNAME}" | chpasswd && \
    echo "%wheel    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/wheel && \
    echo "%${GROUP}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${GROUP} && \
    chmod 0440 /etc/sudoers.d/


#wp-cliインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp \
     && wp --info

ENV WPINSTALLDIR=/var/www/html

# nvm install
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# nvm .profile install node --lts
RUN echo -e 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.bashrc
RUN echo -e '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc
RUN . $HOME/.bashrc
RUN nvm install --lts

# Node.js 14.x install
#RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
#RUN sudo apt-get install -y nodejs

#RUN wp core download \
#    --locale=ja --version=5.6.1 --path=${WPINSTALLDIR} --allow-root


#golang
#gvm
RUN sudo bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) 
RUN . $HOME/.gvm/scripts/gvm
#go package manager
RUN gvm install go1.16.5 && gvm use go1.16.5 &&\
    go get -u github.com/justjanne/powerline-go

#Debian系では$削除
RUN echo -e '\n\
GOPATH=$HOME/go\n\
function _update_ps1() {\n\
    PS1="$($GOPATH/bin/powerline-go -error 0)"\n\
}\n\
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then\n\
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"\n\
fi\n\
' >> $HOME/.bashrc


ARG THEMENAME=${HOST}
COPY ./wp-setup.sh ${WPINSTALLDIR}/
COPY ./docker-entrypoint.sh ${WPINSTALLDIR}/
#RUN /var/www/html/wp-setup.sh

