FROM node:lts-alpine3.14

WORKDIR /home/node

#make sudoers and make node sudoers
RUN apk add sudo
ARG DOCKER_USER=www
ARG DOCKER_UID=1001

RUN adduser -D -u ${DOCKER_UID} -s /bin/sh -G wheel ${DOCKER_USER}
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo "node:node" | chpasswd \
  && addgroup node wheel \
  && echo "root:root" | chpasswd


RUN sudo apk upgrade && apk update
RUN sudo apk add autoconf
RUN sudo apk --no-cache add shadow \
    gcc \
    g++ \
    bash \
    musl-dev \
    autoconf \
    automake \
    make \
    libtool \
    nasm \
    tiff \
    jpeg \
    zlib \
    zlib-dev \
    file \
    pkgconf \
    less \
    vim \
    curl \
    git \
    tzdata

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime &&\
    apk del tzdata



##---------------##
##   USER Node   ##
##---------------##
USER node
WORKDIR /home/node

RUN touch /home/node/.profile && \
  echo -e $'\n\
if [ -n "$BASH_VERSION" ]; then\n\
# include .bashrc if it exists\n\
  if [ -f "$HOME/.bashrc" ]; then\n\
  . "$HOME/.bashrc"\n\
  fi\n\
fi\n\
  ' >> /home/node/.profile && \
    touch /home/node/.bashrc && \
echo -e $'\n\
PS1="\[\033[01;33m\]\u\[\033[00m\]@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\[\e[0m\]\$ "\n\
' >> /home/node/.bashrc



# in case of production env
# ENV NODE_ENV=development

WORKDIR /home/node


RUN yarn global add gatsby-cli vue-cli create-react-app firebase-tools

# in case of using npm
#RUN npm i --save-dev http-server \
#    && npm i -g gatsby-cli vue-cli create-react-app firebase-tools

ENV HOST=0.0.0.0
ENV NODE_ENV=development
ENV NODE_PATH=.

EXPOSE 80
EXPOSE 8000
EXPOSE 3000
USER root
RUN chown -R node:node /home/node
USER node