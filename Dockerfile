FROM alpine:latest

RUN apk update && apk add nodejs npm 

RUN npm i npm@latest -g

RUN apk add python
# RUN cd /home
# RUN curl -o wetty.zip -L https://github.com/krishnasrinivas/wetty/archive/master.zip
# RUN unzip wetty
# RUN rm -f wetty.zip
# RUN mv wetty* wetty && cd wetty
# RUN npm install

# WORKDIR /home/wetty/bin
RUN apk add make gcc
# https://github.com/nodejs/node-gyp/issues/1236#issuecomment-327668264
RUN npm install -g wetty --unsafe

EXPOSE 8080

CMD wetty -p 8080
# CMD node index.js -p 8080
