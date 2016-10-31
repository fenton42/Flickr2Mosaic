FROM ubuntu
MAINTAINER Tobias Overkamp <fenton42@tov.io>

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN apt-get update && apt-get install -y imagemagick
RUN apt-get install -y ruby git
WORKDIR /usr/local/src
RUN git clone https://github.com/fenton42/Flickr2Mosaic.git
WORKDIR /usr/local/src/Flickr2Mosaic
RUN gem install bundler && bundle install
RUN gem build flickr2mosaic.gemspec && gem install flickr2mosaic-0.1.3.gem

# CMD ["/bin/bash" , "-l" ]
