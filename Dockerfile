# Usage: docker build .
# Usage: docker run tpruvot/cpuminer-multi -a xevan --url=stratum+tcp://yiimp.ccminer.org:3739 --user=iGadPnKrdpW3pcdVC3aA77Ku4anrzJyaLG --pass=x

# FROM		ubuntu:14.04
# MAINTAINER	Tanguy Pruvot <tanguy.pruvot@gmail.com>
FROM  alpine:3.7

# update the package list from default OS repos
# RUN		apt-get update -qq

# RUN		apt-get install -qy automake autoconf pkg-config libcurl4-openssl-dev libssl-dev libjansson-dev libgmp-dev make g++ git

# install runtime dependancies
RUN   apk --update --no-cache add \
        libcurl \
        libgcc \
        libstdc++ \
        openssl

# install dependancies required only for build; then remove them from image
# pkgs updated in previous command, but --no-cache means db not preserved, so we need to update again!
RUN   apk --update --no-cache add --virtual \
        autoconf \
        automake \
        build-base \
        curl \
        curl-dev \
        git \
        openssl-dev 

# do git stuff
RUN		git clone https://github.com/tpruvot/cpuminer-multi -b linux /tmp/

# compile
RUN		cd cpuminer-multi && ./build.sh

# set the run environment
WORKDIR		/cpuminer-multi
ENTRYPOINT	["./cpuminer"]
