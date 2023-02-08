ARG PYTHON_VER=3.11
FROM python:$PYTHON_VER-bullseye
LABEL maintainer="s.nikolaev@nklv.su"
RUN apt update && apt upgrade -y
RUN apt install -y mc vim htop tree sudo
RUN apt install -y virtualenv
RUN apt install -y openssh-server
RUN useradd -m -s /bin/bash --uid 1000 user
RUN usermod -a -G sudo user
RUN --mount=type=secret,id=SECRETS,required=true cat /run/secrets/SECRETS | chpasswd
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python
COPY ./setup_configuration.sh /setup_configuration.sh
RUN chmod +x /setup_configuration.sh && bash /setup_configuration.sh
USER user
WORKDIR /home/user
