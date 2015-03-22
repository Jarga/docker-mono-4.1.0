FROM ubuntu:14.04

MAINTAINER Sean McAdams <sean.j.mcadams@gmail.com>

#based on dockerfile by Mark Rendal <mark@markrendle.net>

#get build dependencies and download mono
RUN apt-get update -y \
    && apt-get install -y git autoconf libtool automake build-essential mono-devel gettext \
    && PATH=/usr/local/bin:$PATH \
    && git clone https://github.com/mono/mono.git

#Need previous build of mono to build next version of mono
RUN apt-get update -y \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/3.12.0 main" > /etc/apt/sources.list.d/mono-xamarin.list \  
    && apt-get update -y \
    && && apt-get install -y mono-devel ca-certificates-mono fsharp mono-vbnc nuget \
    && rm -rf /var/lib/apt/lists/*

#Move to mono directory for build process
WORKDIR mono

RUN ./autogen.sh --prefix="/usr/local" 
RUN make
RUN make install

RUN mozroots --machine --import --sync --quiet  
