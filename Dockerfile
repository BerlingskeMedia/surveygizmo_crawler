FROM ubuntu:14.04

MAINTAINER Daniel Kokott <xpiku@berlingskemedia.dk>

# Installing wget - needed to download node.js
RUN apt-get update
RUN apt-get install -y wget

ENV NODE_VERSION v6.9.1

# Downloading and installing Node.
RUN wget -O - https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz \
    | tar xzf - --strip-components=1 --exclude="README.md" --exclude="LICENSE" \
    --exclude="ChangeLog" -C "/usr/local"

# Set the working directory.
WORKDIR /surveygizmo_crawler

# Copying the code into image. Be aware no config files are including.
COPY ./lib /surveygizmo_crawler/lib
COPY ./node_modules /surveygizmo_crawler/node_modules
COPY ./worker /surveygizmo_crawler/worker

# When starting a container with our image, this command will be run.
CMD ["node", "worker/index.js"]
