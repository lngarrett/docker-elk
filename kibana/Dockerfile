FROM nginx:1.9
ENV KIBANA_VERSION 3.1.2
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN curl -SL https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz | \
  tar xzC /usr/share/nginx/html --strip-components 1
WORKDIR /usr/share/nginx/html
ENV ELASTICSEARCH http://kibana.whisk.ee
EXPOSE 80
CMD sed -i -e "/^\s*elasticsearch:.*/ c elasticsearch: '$ELASTICSEARCH'," config.js && nginx -g 'daemon off;'
