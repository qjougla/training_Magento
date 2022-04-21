FROM node:latest@sha256:c07e26a290175b1971034db65ee88775739aad72e3bd125fa6bb005065af9d56

RUN npm install -g bower grunt-cli

RUN chmod 777 /var

COPY scripts/configure.sh /scripts/configure.sh

RUN chmod a+x /scripts/configure.sh
