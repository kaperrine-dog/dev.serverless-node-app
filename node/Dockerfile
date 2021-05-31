FROM node:lts-alpine3.12

WORKDIR /home/node/app

#make sudoers and make node sudoers
RUN apk add sudo
ARG DOCKER_USER=www
ARG DOCKER_UID=1001

RUN adduser -D -u ${DOCKER_UID} -s /bin/sh -G wheel ${DOCKER_USER}
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo "node:node" | chpasswd \
    && addgroup node wheel \
    && echo "root:root" | chpasswd


#RUN addgroup -S node \
#  && adduser -S node -G node \
#  && echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
#  && echo 'node:node' | chpasswd
#USER node

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

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    apk del tzdata

#RUN passwd node:node && passwd root:root

#make sudoers
#RUN apk --no-cache add sudo
#RUN adduser -D -u 1001 -s /bin/sh -G wheel alpine-sudoer
#RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# create a user
#ARG DOCKER_UID=1000
#ARG DOCKER_USER=node
#ARG DOCKER_PASSWORD=node
#RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
#  && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd

# change user
#USER ${DOCKER_USER}



# in case of production env
# ENV NODE_ENV=development
ENV NODE_ENV=development

WORKDIR /home/node/app

COPY ./app/gatsby/package.json .

#COPY . ./

WORKDIR /home/node/app/gatsby


RUN yarn global add gatsby-cli

#RUN npm install --save-dev http-server \
#    && npm install -g gatsby-cli


EXPOSE 80
EXPOSE 8000
EXPOSE 3000
EXPOSE 9000
EXPOSE 5000