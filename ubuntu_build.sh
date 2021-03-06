#!/bin/bash

sudo apt-get -y install libz-dev libboost-dev automake libtool cmake pkgconf

wget https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz
tar xf protobuf-2.6.1.tar.gz
( cd protobuf-2.6.1 && ./configure --disable-shared --with-pic && make -j4 && sudo make install && sudo ldconfig )

git clone https://github.com/google/snappy
(cd snappy && sh ./autogen.sh && ./configure --disable-shared --with-pic && make -j4 && sudo make install )

git clone https://github.com/BaiduPS/sofa-pbrpc
( cd sofa-pbrpc && make -j4 && make install )

wget http://www.us.apache.org/dist/zookeeper/stable/zookeeper-3.4.6.tar.gz
tar zxvf zookeeper-3.4.6.tar.gz
( cd zookeeper-3.4.6/src/c && ./configure --disable-shared --with-pic && make -j4 && sudo make install )

wget https://github.com/gflags/gflags/archive/v2.1.2.tar.gz
tar xf v2.1.2.tar.gz
( cd gflags-2.1.2 && cmake -DGFLAGS_NAMESPACE=google -DCMAKE_CXX_FLAGS=-fPIC && make -j4 && sudo make install )

git clone https://github.com/google/glog
(cd glog && git checkout v0.3.3 && ./configure --disable-shared --with-pic && make -j4 && sudo make install )

wget http://download.savannah.gnu.org/releases/libunwind/libunwind-0.99-beta.tar.gz
tar zxvf libunwind-0.99-beta.tar.gz
(cd libunwind-0.99-beta && ./configure CFLAGS=-U_FORTIFY_SOURCE --disable-shared --with-pic && make -j4 && sudo make install )

git clone --depth=1 https://github.com/00k/gperftools
mv gperftools/gperftools-2.2.1.tar.gz .
tar zxvf gperftools-2.2.1.tar.gz
( cd gperftools-2.2.1 && ./configure --disable-shared --with-pic && make -j4 && sudo make install )

git clone --depth=1 https://github.com/xupeilin/gtest_archive
mv gtest_archive/gtest-1.7.0.zip .
unzip gtest-1.7.0.zip
(cd gtest-1.7.0 && ./configure --disable-shared --with-pic && make && cp -a lib/.libs/* /usr/lib && cp -a include/gtest /usr/include

git clone https://github.com/fxsjy/ins
(cd ins && PBRPC_PATH=../sofa-pbrpc/output/ make sdk )

sed -i 's/^SOFA_PBRPC_PREFIX=.*/SOFA_PBRPC_PREFIX=.\/sofa-pbrpc\/output/' depends.mk
sed -i 's/^PROTOBUF_PREFIX=.*/PROTOBUF_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^SNAPPY_PREFIX=.*/SNAPPY_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^ZOOKEEPER_PREFIX=.*/ZOOKEEPER_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^GFLAGS_PREFIX=.*/GFLAGS_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^GLOG_PREFIX=.*/GLOG_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^GTEST_PREFIX=.*/GTEST_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^GPERFTOOLS_PREFIX=.*/GPERFTOOLS_PREFIX=\/usr\/local/' depends.mk
sed -i 's/^BOOST_INCDIR=.*/BOOST_INCDIR=\/usr\/local\/include/' depends.mk
sed -i 's/^INS_PREFIX=.*/INS_PREFIX=.\/ins\/output/' depends.mk

make -j4
