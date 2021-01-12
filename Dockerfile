FROM ubuntu AS builder

RUN apt update \
	&& DEBIAN_FRONTEND=noninteractive apt install -y git build-essential gcc libusb-1.0-0-dev libglib2.0-dev libboost-all-dev autoconf libtool

RUN git clone https://github.com/dashesy/cc-tool.git

RUN cd /cc-tool \
	&& ./bootstrap \
	&& ./configure \
	&& make

FROM ubuntu

WORKDIR /workspace

ENTRYPOINT ["/bin/cc-tool"]

CMD ["--help"]

# we wouldn't need this if we used the builder image directly, but maybe this is better than shipping
# the build toolchain.. we could also just install libboost-all-dev but that seems to install compilers etc.
COPY --from=builder [ \
	"/usr/lib/x86_64-linux-gnu/libboost_regex.so.*", \
	"/usr/lib/x86_64-linux-gnu/libboost_filesystem.so.*", \
	"/usr/lib/x86_64-linux-gnu/libboost_program_options.so.*", \
	"/usr/lib/x86_64-linux-gnu/libicui18n.so.*", \
	"/usr/lib/x86_64-linux-gnu/libicuuc.so.*", \
	"/usr/lib/x86_64-linux-gnu/libicudata.so.*", \
	"/usr/lib/x86_64-linux-gnu/libusb-1.0.so.*", \
	"/usr/lib/x86_64-linux-gnu/"]

COPY --from=builder /cc-tool/cc-tool /bin/cc-tool
