FROM ubuntu:jammy-20240627.1

# Install the Ubuntu packages
RUN apt-get update \
    && apt-get install vim -y \
    && apt-get install nmap -y