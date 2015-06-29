FROM ubuntu:latest

RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update
RUN apt-get -y install oracle-java8-installer

RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list
RUN apt-get update
RUN apt-get -y install elasticsearch=1.4.4
COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN service elasticsearch restart

WORKDIR /root
RUN wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz
RUN tar xvf kibana-*.tar.gz

RUN mkdir -p /opt/kibana
RUN cp -R ~/kibana-4*/* /opt/kibana/
COPY kibana.yml /opt/kibana/config/kibana.yml
WORKDIR /etc/init.d
RUN wget https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4
RUN chmod +x /etc/init.d/kibana4
RUN update-rc.d kibana4 defaults 96 9
RUN service kibana4 start
