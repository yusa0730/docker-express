FROM --platform=linux/amd64 public.ecr.aws/lambda/nodejs:18

COPY package.json yarn.lock ./

RUN yum -y update \
      && yum -y groupinstall "Development Tools" \
      && yum install -y nodejs gcc-c++ cairo-devel \
	                      libjpeg-turbo-devel pango-devel giflib-devel \
	                      zlib-devel librsvg2-devel

COPY . .

CMD [ "index.handler" ]
