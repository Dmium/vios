# escape=`

FROM ubuntu

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get upgrade
RUN apt-get -y install build-essential curl bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo libisl-dev
RUN apt-get -y install grub-common

RUN mkdir $HOME/src
RUN curl ftp://ftp.gnu.org/gnu/binutils/binutils-2.43.1.tar.gz -o $HOME/src/binutils-2.43.1.tar.gz
RUN curl ftp://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.gz -o $HOME/src/gcc-14.2.0.tar.gz

RUN tar -xf $HOME/src/binutils-2.43.1.tar.gz -C $HOME/src/.
RUN tar -xf $HOME/src/gcc-14.2.0.tar.gz -C $HOME/src/.  
RUN ls $HOME/src/
#Preparation
ENV PREFIX=/home/ubuntu/opt/cross
ENV TARGET=i686-elf
ENV PATH=$PREFIX/bin:$PATH

#Binutils
RUN cd $HOME/src && `
mkdir build-binutils && `
cd build-binutils && `
../binutils-2.43.1/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
RUN cd $HOME/src/build-binutils && `
make
RUN cd $HOME/src/build-binutils && `
make install

#GCC
RUN cd $HOME/src && ` 
mkdir build-gcc

RUN cd $HOME/src/build-gcc && `
../gcc-14.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c --without-headers --disable-hosted-libstdcxx && `
# --without-isl
make all-gcc && `
make all-target-libgcc && `
make install-gcc && `
make install-target-libgcc

RUN echo Removing source files... && `
rm -rf /root/src
RUN apt-get -y install grub-pc-bin
RUN apt-get -y install nasm xorriso 
WORKDIR /src
CMD ["make", "all"]
