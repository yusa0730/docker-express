FROM node:18

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install
RUN apt-get update && apt-get install -y tar gzip
RUN mkdir -p /usr/local/bin/package
RUN curl -fLo /tmp/lambda-runtime.tgz https://github.com/aws/aws-lambda-nodejs-runtime-interface-client/releases/download/v3.0.0/aws-lambda-ric-3.0.0.tgz && \
    mkdir -p /usr/local/bin/package-tmp && \
    tar -xzf /tmp/lambda-runtime.tgz -C /usr/local/bin/package-tmp && \
    mv /usr/local/bin/package-tmp/package/* /usr/local/bin/package/ && \
    rmdir /usr/local/bin/package-tmp/package && \
    rm -r /usr/local/bin/package-tmp && \
    rm /tmp/lambda-runtime.tgz

RUN ls -la /usr/local/bin/

COPY . .

CMD [ "/usr/local/bin/package/bin/index.mjs", "app.handler"]
