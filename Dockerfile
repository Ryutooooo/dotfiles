FROM ubuntu:20.04

LABEL maintainer "ryutooooo <rf.ryutooooo.0907@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
    curl \
    git

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"  && \
    echo 'export PATH=${HOME}/.linuxbrew/bin:$PATH' >> .bash_profile

WORKDIR /workspace

CMD ["/bin/bash"]
