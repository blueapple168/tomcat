FROM tomcat:8.5-jdk8
MAINTAINER blueapple1120@qq.com
LABEL os="Debian10" \
      jdk="1.8.0_275" \
      tomcat="8.5.61"

ENV TZ="Asia/shanghai"

RUN  set -eux; \
  \
  ## Handle timezone
  rm -rf /etc/localtime ; \
  ln -sf /usr/share/zoneinfo/$TZ /etc/localtime; \
  echo $TZ > /etc/timezone; \
  \
  ## Install some necessary packages
   apt-get update; \
        apt-get install -y --no-install-recommends \
                net-tools \
                fontconfig \
                locales \
                vim ; \
        apt-get -t sid install libc6 \
                libc6-dev \
                libc6-dbg \

  > /dev/null; \
  rm -rf /var/lib/apt/lists/*; \
  \
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 ; \
    dpkg-reconfigure locales ; \
    mkdir /usr/local/tomcat/webapps/ROOT/

ENV LC_ALL zh_CN.UTF-8

# Add Chinese font 
COPY fonts/* /usr/share/fonts/truetype/
