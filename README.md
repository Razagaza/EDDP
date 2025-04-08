# Ephemeral data derived potential [EDDP](https://www.mtg.msm.cam.ac.uk/Codes/EDDP)
## Reference
- [Pickard, Ephemeral data derived potentials for random structure search, 2022](https://doi.org/10.1103/PhysRevB.106.014102)
- [Salzbrenner et al., Developments and further applications of ephemeral data derived potentials, 2023](https://doi.org/10.1063/5.0158710)
- [spawn-batch](https://github.com/SehunJoo/ddp-batch)

# 필요 소프트웨어 설치
## 파일 받은 후 설치 진행
### 파일은 $HOME 디렉토리에 다운
```bash
sh setup.sh
```

# ddp-batch 업데이트
## PBS 스케줄러에 호환 가능한 ddp-batch 업데이트 진행 중
### spawn-batch update command
```bash
cp ~/EDDP/spawn-batch ~/ddp-batch/bin/spawn-batch && chmod +x ~/ddp-batch/bin/spawn-batch
```

# spawn-batch PBS 버전
## 기존 spawn-batch와 다른 점
exec option (dafault=castep.mpi)을 추가하여 다른 소프트웨어 및 추가 커맨드 입력 가능
### Flat 노드 사용 방법
`mpirun -np NUM_CORES` 이후 `numactl -p 1` option을 적용하여 flat 모드 사용
- numactl 을 통해 1번 인덱스의 메모리 (MCDRAM 16GbB) 사용 가능
- -p 옵션은 1번 메모리를 우선 사용한다는 의미 (총 102 GB)
- -m 옵션은 1번 메모리만 사용한다는 의미 (총 16 GB)
- 예) `spawn-batch -despawn -exec "numactl -p 1 castep.mpi" -command airss.pl -mpinp 2 -steps 0 -seed <seed> -max 1000`

## 누리온 벤치마킹
2코어 사용 시 가장 적은 시간 소요

# airss.pl
```text
```

# forge
```text
Usage: forge [-ompnp] [-nn] [-tr] [-va] [-te] [-th] [-nc] [-n] [-b] [-eta] [-lmin] [-es] [-ne] [-np] [-fs]
              [-t] [-a] [-o] [-p] [-w] [-kT] [-l] [-s] [-q] [-pdf] [-numpot] [-h]
 -ompnp   : Number of omp threads (not mpi)
 -nn I    : Number of nodes in each layer
 -tr C    : File name for training data
 -va C    : File name for validation data
 -te C    : File name for testing data
 -th F    : Convergence threshold
 -nc I    : Chunk size
 -n I     : Number of steps
 -b I     : Batch size
 -eta F   : Learning rate
 -lmin F  : Minimum lambda
 -es      : Early stopping, number of steps
 -ne      : No early stopping
 -np      : No plotting
 -fs      : Use stop file
 -t       : Track the training
 -a       : Activation function
 -o       : Optimisation algorithm
 -p       : p value for IRLS
 -w       : Minimum weight for IRLS
 -kT      : Energy for Boltzmann weighting (eV)
 -l [C]   : Load data derived potential
 -s [C]   : Seedname
 -q       : Quiet - minimal output
 -pdf     : Output plots to pdf (requires grace)
 -numpot  : Number of potentials to generate
 -h       : Print this help message
```

# frank
```text
Usage: frank [-ompnp] [-c] [-r] [-nb] [-p] [-pmin] [-pmax] [-gp] [-lj] [-cl] [-m] [-h] < [.res]
 -ompnp : Number of OMP threads
 -c     : Composition space
 -r     : Maximum radius
 -nb    : Number of body terms
 -p     : Powers (number)
 -pmin  : Minimum power (0.1)
 -pmax  : Maximum power (10.0)
 -gp    : Delta power (0)
 -lj    : Lennard-Jones energy
 -cl    : Cluster
 -m     : Mean feature
 -h     : Print this help message
```
 
# flock
```text
Usage: flock [-ompnp] [-s] [-lambda] [-o] [-v] [-p] [-np] [-pdf] [-q] [-h]
 -ompnp    : Number of omp threads (not mpi)
 -s        : Seedname
 -lambda   : Regularisation parameter
 -o        : Optimisation scheme
 -v        : Optimise using validation dataset
 -p        : External pressure
 -np       : No plotting
 -pdf      : Output plots to pdf (requires grace)
 -q        : Quiet - minimal output
 -h        : Print this help message

 Note: a list of ddp files is read from STDIN
```
 
# repose
```text
Usage: repose [-ompnp] [-test] [-t] [-te] [-n] [-q] [-m] [-v] [-p] [-f] [-c] [-tol] [-r]
              [-a] [-g] [-rmin] [-devmax] [-devmin] [-h] <seedname>
 Example: `repose -t C` will track a relaxation of the structure contained in C.cell
   -ompnp : Number of threads
   -test  : Test derivatives
   -t     : Track relaxation
   -te    : Track every N steps
   -n     : No structural relaxation
   -q     : Minimal output
   -m     : Max relaxation steps
   -v     : Volume overide
   -p     : Pressure
   -f     : Fix unit cell
   -c     : Cluster
   -tol   : Convergence thresold
   -r     : Hard core radius
   -a     : Hard core strength
   -g     : Gamma cell damping
   -rmin  : Minimum tolerated contact
   -dmin  : Minimum tolerated deviation
   -dmax  : Maximum tolerated deviation
   -h     : Display this message
```
