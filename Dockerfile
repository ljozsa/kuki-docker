FROM ubuntu:16.04
MAINTAINER l.jozsa@gmail.com
ENV DEBIAN_FRONTEND=noninteractive
ENV UNAME pacat
ENV DISPLAY=:0

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y curl apt-utils iproute2 sudo pulseaudio-utils libcurl3 pulseaudio less mplayer iputils-ping
RUN echo -e 'default-server = unix:/tmp/pulseaudio.socket\n\
	\# Prevent a server running in the container\n\
	autospawn = no\n\
	daemon-binary = /bin/true\n\
	\# Prevent the use of shared memory\n\
	enable-shm = false' >> /etc/pulse/client.conf
RUN curl http://linux.kuki.cz/kuki.pgp | apt-key add -
RUN echo "deb http://linux.kuki.cz/ xenial kuki" > /etc/apt/sources.list.d/kuki.list
RUN apt-get update
RUN apt-get install -y kuki
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

COPY pulse-client.conf /etc/pulse/client.conf

USER $UNAME
ENV HOME /home/pacat

CMD ["pacat", "-vvvv", "/dev/urandom"]
CMD /usr/bin/kuki
