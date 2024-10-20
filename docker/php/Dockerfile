FROM ubuntu:24.04

SHELL ["/bin/bash", "-i", "-c"]

RUN apt-get -y update && \
    apt-get install -y \
    curl git imagemagick libmagickwand-dev

ARG SITE_EDITOR_GID=830
ARG DOCKER_USER_UID_GID=1100
ARG DOCKER_WEB_USER=101
ARG PHP_VERSION=8.3.10
ARG PROJECT_ROOT
ARG PUBLIC_ROOT

RUN groupadd -g ${SITE_EDITOR_GID} site_editor && \
	useradd -Um -u ${DOCKER_USER_UID_GID} -G site_editor docker_user && \
	useradd -MrU -u ${DOCKER_WEB_USER} -G site_editor -d /nonexistent -s /usr/sbin/nologin nginx

USER docker_user

RUN echo -e "\n\
umask 002\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

# установка php version manager и php последней версии
RUN curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer \
    | bash

# https://github.com/phpenv/phpenv/issues/66
RUN echo -e "\n\
export PHPENV_ROOT=\"/home/docker_user/.phpenv\"\n\
if [ -d \"\${PHPENV_ROOT}\" ]; then\n\
export PATH=\"\${PHPENV_ROOT}/bin:\${PATH}\"\n\
eval \"\$(phpenv init -)\"\n\
fi\n\
\n\
\n\
export PHP_BUILD_CONFIGURE_OPTS=\"--with-pdo-pgsql\"\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

USER root

RUN /home/docker_user/.phpenv/plugins/php-build/install-dependencies.sh && \
    apt-get install -y libpq-dev

USER docker_user

RUN PHP_BUILD_INSTALL_EXTENSION='imagick=@' phpenv install ${PHP_VERSION} && \
    phpenv global ${PHP_VERSION}

ENV PROJECT_ROOT ${PROJECT_ROOT}

WORKDIR ${PROJECT_ROOT}

COPY ${PHP_VERSION}* /home/docker_user/.phpenv/versions/${PHP_VERSION}/etc/