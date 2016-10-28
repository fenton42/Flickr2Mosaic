FROM ubuntu
MAINTAINER Tobias Overkamp <fenton42@tov.io>

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN apt-get update && apt-get install -y imagemagick
RUN apt-get install -y ruby git

CMD ["/bin/bash" , "-l" ]
