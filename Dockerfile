FROM wubster/ubuntu-cppcms-prebuild
RUN apt-get update 
#&& apt-get install -y git cmake libpcre3-dev zlib1g-dev libgcrypt11-dev libicu-dev python
WORKDIR /opt
RUN git clone https://github.com/artyom-beilis/cppcms.git cppcms
WORKDIR /opt/cppcms/build
RUN cmake ..
RUN make && make test
RUN make install
CMD ["/bin/bash"]
