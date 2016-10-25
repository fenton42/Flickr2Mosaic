FROM ruby:2.1-onbuild
MAINTAINER Tobias Overkamp <fenton42@tov.io>

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN apt-get update && apt-get install -y imagemagick
#RUN /bin/bash -l -c "rvm ree-1.8.7-2012.02@joker_on_rails_beta --create && gem install bundler --no-ri --no-rdoc"

CMD ["/bin/bash" , "-l" ]
