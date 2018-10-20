FROM ubuntu:latest

ENV USERNAME ""
ENV PASSWORD ""
ENV HOME "/home/user/"

RUN apt update && apt install -y build-essential python bash git wget curl software-properties-common libnss-wrapper gettext-base sudo unzip wget

RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs

RUN adduser --uid 1000 --gid 0 --home /home/user/ --shell /bin/bash --disabled-password user
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers
RUN chmod 0440 /etc/sudoers.d/user

RUN npm i npm@latest -g

# RUN cd /home
# RUN curl -o wetty.zip -L https://github.com/krishnasrinivas/wetty/archive/master.zip
# RUN unzip wetty
# RUN rm -f wetty.zip
# RUN mv wetty* wetty && cd wetty
# RUN npm install

# WORKDIR /home/wetty/bin


RUN mkdir -p /workspace
RUN chown user:root /workspace
RUN chmod -R g+rw /home/user

RUN npm install -g wetty --unsafe-perm=true --allow-root

COPY run.sh /tmp/
ADD passwd_template /tmp/
RUN chmod +x /tmp/run.sh

WORKDIR /workspace

EXPOSE 8080

USER 1000
CMD ["/tmp/run.sh"]
# CMD node index.js -p 8080
