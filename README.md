## make 설치

```bash
cd && wget https://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz
tar -xvf make-4.2.1.tar.gz && cd make-4.2.1/
./configure --prefix=$PWD
make && make install
echo 'module load intel/19.0.5 impi/19.0.5' >> ~/.bashrc
echo 'export PATH=$HOME/make-4.2.1/bin:$PATH' >> ~/.bashrc
echo 'export CPATH=$HOME/make-4.2.1/include:$CPATH' >> ~/.bashrc
source ~/.bashrc
```

## LAPACK 설치

```bash
cd && git clone https://github.com/Reference-LAPACK/lapack.git && cd lapack/
mkdir build && cd build
module load cmake
cmake -DCMAKE_INSTALL_PREFIX=$HOME/lapack ..
cmake --build . -j --target install
echo 'export LD_LIBRARY_PATH=$HOME/lapack/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export LIBRARY_PATH=$HOME/lapack/lib64:$LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

## GNU Parallel 설치

```bash
cd && wget https://ftp.gnu.org/gnu/parallel/parallel-20220222.tar.bz2
tar -xvf parallel-20220222.tar.bz2 && cd parallel-20220222/
./configure --prefix=$PWD
make && make install
echo 'export PATH=$HOME/parallel-20220222/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

## CASTEP 설치

```bash
# CASTEP-25.11.tar.gz 파일 업로드하고 진행
cd &&  tar -xvf CASTEP-25.11.tar.gz && cd CASTEP-25.11/
make COMMS_ARCH=mpi
make install
echo 'export CASTEP=$HOME/CASTEP-25.11' >> ~/.bashrc
echo 'export PATH=$CASTEP/bin:$CASTEP/bin/linux_x86_64_ifort--serial:$CASTEP/obj/linux_x86_64_ifort--mpi:$PATH'  >> ~/.bashrc
source ~/.bashrc
```

## GCC 설치 (매우 오래 걸림)

```bash
cd && wget https://ftp.gnu.org/gnu/gcc/gcc-13.1.0/gcc-13.1.0.tar.xz
tar -xvf gcc-13.1.0.tar.xz && cd gcc-13.1.0
./contrib/download_prerequisites
mkdir build && cd build
../configure --prefix=$PWD/../ --disable-multilib --enable-languages=c,c++,fortran
make -j16 && make install # 에러 나면 make clean && make && make install
echo 'export PATH=$HOME/gcc-13.1.0/bin:$PATH' >> ~/.bashrc
echo 'export CPATH=$HOME/gcc-13.1.0/include:$CPATH' >> ~/.bashrc
echo 'export LIBRARY_PATH=$HOME/gcc-13.1.0/lib:$HOME/gcc-13.1.0/lib64:$LIBRARY_PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$HOME/gcc-13.1.0/lib:$HOME/gcc-13.1.0/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

## EDDP 설치

```bash
# eddp-v0.2.tgz 파일 업로드하고 진행
tar -xvf eddp-v0.2.tgz && cd eddp
cd airss
make && make install
cd ../nn
make && make install
cd ../repose
make && make install
cd ../ddp
make && make install
echo 'export EDDP_HOME=$HOME/eddp' >> ~/.bashrc
echo 'export PATH=$EDDP_HOME/airss/bin:$EDDP_HOME/nn/bin:$EDDP_HOME/repose/bin:$EDDP_HOME/ddp/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

## ddp-batch 설치
```bash
# ddp-batch.tar 파일 업로드하고 진행
cd && tar -xvf ddp-batch.tar
echo 'export PATH=$HOME/ddp-batch/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

# 소프트웨어 설치 가이드 (User Local Installation)

모든 패키지는 `$HOME` 디렉토리에 설치되며, 환경 변수는 `.bashrc`에 추가합니다.

## 📌 환경 변수 설정 (`.bashrc`)

```bash
# 공통 PATH 설정
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# 라이브러리 경로
export LD_LIBRARY_PATH=$HOME/lib:$HOME/.local/lib:$LD_LIBRARY_PATH

# LAPACK
export LAPACK_DIR=$HOME/.local/lapack
export LD_LIBRARY_PATH=$LAPACK_DIR/lib:$LD_LIBRARY_PATH
export PATH=$LAPACK_DIR/bin:$PATH

# GCC
export PATH=$HOME/gcc-13.1.0/bin:$PATH
export LD_LIBRARY_PATH=$HOME/gcc-13.1.0/lib64:$LD_LIBRARY_PATH

# OpenMPI
export PATH=$HOME/openmpi-4.1.5/bin:$PATH
export LD_LIBRARY_PATH=$HOME/openmpi-4.1.5/lib:$LD_LIBRARY_PATH

# MAKE
export PATH=$HOME/make-4.2.1:$PATH

# Parallel
export PATH=$HOME/parallel-20220222:$PATH

# eddp & ddp-batch
export PATH=$HOME/eddp/bin:$HOME/ddp-batch/bin:$PATH
