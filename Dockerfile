FROM mono:3.12

MAINTAINER Sean McAdams <sean.j.mcadams@gmail.com>

#get build dependencies and download mono
RUN apt-get update -y \
    && apt-get install -y git autoconf libtool automake build-essential mono-devel gettext \
    && PATH=/usr/local/bin:$PATH \
    && git clone https://github.com/mono/mono.git

#Move to mono directory for build process
WORKDIR mono

RUN ./autogen.sh --prefix="/usr/local" \
    && make \
    && make install \
    && rm /mono -r

