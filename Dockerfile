FROM ubuntu:latest

ENV USERNAME ""
ENV PASSWORD ""
ENV HOME "/home/user/"
ENV SSHHOST "localhost"
ENV SSHPORT "2222"
ENV SSHPASS "yhiblog"

RUN apt update && apt install -y build-essential python bash vim git net-tools curl software-properties-common libnss-wrapper gettext-base sudo unzip wget ssh

RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs

RUN adduser --uid 1000 --gid 0 --home /home/user/ --shell /bin/bash user
RUN echo "user:$SSHPASS" | chpasswd
RUN echo "user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/user
RUN echo "user ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN chmod 0440 /etc/sudoers.d/user

RUN npm i npm@latest -g

# RUN cd /home
# RUN curl -o wetty.zip -L https://github.com/krishnasrinivas/wetty/archive/master.zip
# RUN unzip wetty
# RUN rm -f wetty.zip
# RUN mv wetty* wetty && cd wetty
# RUN npm install

# WORKDIR /home/wetty/bin

RUN sed -i "s/#Port/Port/g" /etc/ssh/sshd_config
RUN sed -i "s/Port 22/Port $SSHPORT/g" /etc/ssh/sshd_config
RUN chmod -R 777 /etc/ssh
RUN chmod -R 777 /run
RUN ssh-keygen -A

RUN mkdir -p /workspace/config
RUN chmod -R 777 /workspace
RUN chmod -R 777 /home/user

RUN npm install -g wetty --unsafe-perm=true --allow-root

COPY run.sh /tmp/
ADD passwd_template /tmp/
RUN chmod +x /tmp/run.sh

WORKDIR /workspace

EXPOSE 8080

USER 1000
CMD ["/tmp/run.sh"]
# CMD node index.js -p 8080
