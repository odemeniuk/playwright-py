FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install Python
RUN apt-get update && apt-get install -y python3.8 && apt-get install -y curl
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-distutils
RUN python3.8 get-pip.py
RUN python3.8 -m pip install -U setuptools
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

# 2. Install WebKit dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libwoff1 \
    libopus0 \
    libwebp6 \
    libwebpdemux2 \
    libenchant1c2a \
    libgudev-1.0-0 \
    libsecret-1-0 \
    libhyphen0 \
    libgdk-pixbuf2.0-0 \
    libegl1 \
    libnotify4 \
    libxslt1.1 \
    libevent-2.1-6 \
    libgles2 \
    libvpx5 \
    libxcomposite1 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libepoxy0 \
    libgtk-3-0 \
    libharfbuzz-icu0

# 3. Install Chromium dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libnss3 \
    libxss1 \
    libasound2 \
    fonts-noto-color-emoji \
    libxtst6

# 4. Install Firefox dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libdbus-glib-1-2 \
    libxt6


# 5. Install Project dependencies

# Install Allure.
# See https://github.com/allure-framework/allure-debian/issues/9
RUN apt-get update && apt-get install -y wget default-jdk && cd /opt && \
    (wget -c https://dl.bintray.com/qameta/generic/io/qameta/allure/allure/2.7.0/allure-2.7.0.tgz -O - | tar -xz && chmod +x allure-2.7.0/bin/allure)
ENV PATH="${PATH}:/opt/allure-2.7.0/bin"
RUN allure --version
#  Install Pipenv and playwright
ADD Pipfile /
RUN pip install --upgrade pip
RUN pip install pipenv
RUN pipenv install
RUN pipenv run python -m playwright install
WORKDIR /app