FROM alpine:latest

RUN apk update && apk add nodejs npm make gcc python

RUN npm i npm@latest -g

# RUN cd /home
# RUN curl -o wetty.zip -L https://github.com/krishnasrinivas/wetty/archive/master.zip
# RUN unzip wetty
# RUN rm -f wetty.zip
# RUN mv wetty* wetty && cd wetty
# RUN npm install

# WORKDIR /home/wetty/bin

# https://github.com/nodejs/node-gyp/issues/1236#issuecomment-327668264
RUN npm install -g wetty --unsafe

EXPOSE 8080

CMD wetty -p 8080
# CMD node index.js -p 8080
