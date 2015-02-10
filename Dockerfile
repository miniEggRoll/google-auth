FROM google/debian:wheezy

RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates
RUN mkdir /nodejs && curl http://nodejs.org/dist/v0.12.0/node-v0.12.0-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

ENV PATH $PATH:/nodejs/bin

WORKDIR /app
ADD . /app
RUN npm install

CMD ["/nodejs/bin/npm", "start"]
