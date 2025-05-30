#/bin/bash

if [[ ! -f ~/gcc-13.1.0.tar.gz ]]; then
  echo "No gcc tar file"
  exit 0
fi
if [[ ! -f ~/eddp-v0.2.tgz ]]; then
  echo "No eddp tar file"
  exit 0
fi
if [[ ! -f ~/ddp-batch.tar ]]; then
  echo "No ddo-batch tar file"
  exit 0
fi

if [[ ! -f ~/CASTEP-25.11.tar.gz ]]; then
  echo "No CASTEP tar file"
  exit 0
fi

cd && wget https://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz
tar -xvf make-4.2.1.tar.gz && cd make-4.2.1/
./configure --prefix=$PWD
make && make install
echo 'export PATH=$HOME/make-4.2.1/bin:$PATH' >> ~/.bashrc
echo 'export CPATH=$HOME/make-4.2.1/include:$CPATH' >> ~/.bashrc
export PATH=$HOME/make-4.2.1/bin:$PATH
export CPATH=$HOME/make-4.2.1/include

cd && tar -xvzf gcc-13.1.0.tar.gz
echo 'export PATH=$HOME/gcc-13.1.0/bin:$PATH' >> ~/.bashrc
echo 'export CPATH=$HOME/gcc-13.1.0/include:$CPATH' >> ~/.bashrc
echo 'export LIBRARY_PATH=$HOME/gcc-13.1.0/lib:$HOME/gcc-13.1.0/lib64:$LIBRARY_PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$HOME/gcc-13.1.0/lib:$HOME/gcc-13.1.0/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
export PATH=$HOME/gcc-13.1.0/bin:$PATH
export CPATH=$HOME/gcc-13.1.0/include:$CPATH
export LIBRARY_PATH=$HOME/gcc-13.1.0/lib:$HOME/gcc-13.1.0/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/gcc-13.1.0/lib:$HOME/gcc-13.1.0/lib64

cd && git clone https://github.com/Reference-LAPACK/lapack.git && cd lapack/
mkdir build && cd build
module load cmake
cmake -DCMAKE_INSTALL_PREFIX=$HOME/lapack ..
cmake --build . -j --target install
echo 'export LD_LIBRARY_PATH=$HOME/lapack/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export LIBRARY_PATH=$HOME/lapack/lib64:$LIBRARY_PATH' >> ~/.bashrc
export LD_LIBRARY_PATH=$HOME/lapack/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$HOME/lapack/lib64:$LIBRARY_PATH

cd && wget https://ftp.gnu.org/gnu/parallel/parallel-20220222.tar.bz2
tar -xvf parallel-20220222.tar.bz2 && cd parallel-20220222/
./configure --prefix=$PWD
make && make install
echo 'export PATH=$HOME/parallel-20220222/bin:$PATH' >> ~/.bashrc
export PATH=$HOME/parallel-20220222/bin:$PATH

cd && tar -xvf eddp-v0.2.tgz && cd eddp
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
export EDDP_HOME=$HOME/eddp
export PATH=$EDDP_HOME/airss/bin:$EDDP_HOME/nn/bin:$EDDP_HOME/repose/bin:$EDDP_HOME/ddp/bin:$PATH

# ddp-batch.tar 파일 업로드하고 진행
cd && tar -xvf ddp-batch.tar
echo 'export PATH=$HOME/ddp-batch/bin:$PATH' >> ~/.bashrc
export PATH=$HOME/ddp-batch/bin:$PATH

# CASTEP-25.11.tar.gz 파일 업로드하고 진행
cd && tar -xvzf CASTEP-25.11.tar.gz
echo 'module load intel/19.0.5 impi/19.0.5' >> ~/.bashrc
echo 'export CASTEP=$HOME/CASTEP-25.11' >> ~/.bashrc
echo 'export PATH=$CASTEP/bin:$CASTEP/bin/linux_x86_64_ifort--serial:$CASTEP/obj/linux_x86_64_ifort--mpi:$PATH'  >> ~/.bashrc
module load intel/19.0.5 impi/19.0.5
export CASTEP=$HOME/CASTEP-25.11
export PATH=$CASTEP/bin:$CASTEP/bin/linux_x86_64_ifort--serial:$CASTEP/obj/linux_x86_64_ifort--mpi:$PATH
