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

# Commands
## airss.pl
```text
Usage: airss.pl [-pressure] [-prand] [-pmin] [-devmin] [-devmax] [-build] [-pp0] [-gosh] [-pp3] [-repose]
                 [-ramble] [-gulp] [-lammps] [-gap] [-psi4] [-vasp] [-qe] [-python] [-castep] [-exec] [-launch]
                 [-cluster] [-slab] [-dos] [-workdir] [-max] [-num] [-amp] [-camp] [-mode] [-minmode] [-sim]
                 [-symm] [-nosymm] [-mpinp] [-steps] [-best] [-track] [-keep] [-pack] [-harvest] [-seed]
 -pressure f  Pressure (0.0)
 -prand       Randomise pressures (false)
 -pmin        Minimum pressure for randomisation (0.0)
 -devmin      Minimum deviation for repose (0.0)
 -devmax      Maximum deviation for repose (10000.0)
 -build       Build structures only (false)
 -pp0         Use pair potentials rather than Castep (0D) (false)
 -gosh        Use pair potentials rather than Castep (0D) (false)
 -pp3         Use pair potentials rather than Castep (3D) (false)
 -repose      Use data derived potentials to relax structure (false)
 -rample      Use data derived potentials to run dynamics (false)
 -gulp        Use gulp rather than Castep (false)
 -lammps      Use LAMMPS rather than Castep (false)
 -gap         Use GAP through QUIP/QUIPPY/ASE (false)
 -ps4         Use psi4 (false)
 -vasp        Use VASP (false)
 -qe          Use Quantum Espresso (false)
 -python      Use relax.py script (false)
 -castep      Use CASTEP in addition to alternative (false)
 -exec        Use this executable
 -launch      Use this parallel launcher
 -cluster     Use cluster settings for symmetry finder (false)
 -slab        Use slab settings (false)
 -dos         Calculate DOS at Ef (false)
 -workdir  s  Work directory ('.')
 -max      n  Maximum number of structures (1000000)
 -num      n  Number of trials (0)
 -amp      f  Amplitude of ion move (-1.5)
 -camp     f  Amplitude of cell move (0.0)
 -mode        Choose moves based on low lying vibrational modes (false)
 -minmode  n  Lowest mode (4)
 -sim      f  Threshold for structure similarity (0.0)
 -symm     f  Symmetrise on-the-fly (0.0)
 -nosymm   f  No symmetry (0)
 -mpinp    n  Number of cores per mpi Castep (1)
 -steps    n  Max number of geometry optimisation steps (400)
 -nbest    n  Best of n kept (1)
 -best        Only keep the best structures for each composition (false)
 -track       Keep the track of good structures during relax and shake (false)
 -keep        Keep intermediate files (false)
 -pack        Concatenate the res files (false)
 -harvest     Collect intermediate structures as res files (false)
 -seed     s  Seedname ('NONE')
```

## ca
```text
ca [-R(recursive)] [command line arguments for cryan]
```

## cryan
```text
Usage: cryan [OPTIONS]
The structures are read from STDIN, for example:
     cat *.res | cryan -s
     gunzip -c lots.res.gz | cryan -f H2O
     find . -name "*.res" | xargs cat | cryan -m
cryan options (note - the order matters):

 -r,  --rank                          Rank all structures, of any composition
 -nr, --not_relative                  Absolute enthalpy for ranking
 -s,  --summary                       Summary, most stable from each composition
 -e,  --enthalpy <length_scale>       Plot enthalpy vs. pressure, interpolate with <length_scale>
 -f,  --formula <formula>             Select structures of a given composition
 -fu, --formula_unt <nfu>             Select structures of a given number of formula units
 -fc, --formula_convert <formula>     Attempt to convert structures to this composition
 -fr, --formula_reference <formula>   Structure name for enthalpy reference
 -sn, --speciesnumber [num            Number of species, e.g 2 for binary
 -t,  --top [num]                     Output top few results (default 10)
 -u,  --unite <thresh>                Unite similar structures
 -dr, --distance <rmax>               Distance threshold for structure comparison (default 20)
 -de, --delta_e <energy>              Ignore structures above energy (per atom)
 -sd, --struc_dos <smear>             Plot a structural density of states, smeared
 -p,  --pressure <pressure>           Additional pressure (default 0 GPa)
 -m,  --maxwell                       Extract the stable compositions
 -ph, --pressure_hull                 Extract the stable structures with pressure
 -<n>                                 Component <n> for Maxwell construction
 -el, --elementlist                   Comma separated list of elements
 -xg, --xmgrace                       Plot output with xmgrace
 -xgf, --xg-fileout <format>          Save output plot in one of the formats: png, jpeg, svg, eps, ps, pdf
 -c,  --compare <thresh > <structure> Compare structure to all others
 -v,  --vector                        Output a descriptor vector
      --delete                        Delete unwanted structures
 -g,  --geometry [thresh]             Calculate the atomic geometry for the structures (default 0.1)
 -n,  --num_units                     Only report structures with n separate units (default -1)
 -d,  --dimensionality                Only report structures with dimensionality of d (default -1.0)
 -cl, --cluster                       No periodic boundary conditions
 -bl, --bondlength                    Maximum bond length (default 0.0, negative for modularity)
 -bs, --bondscale                     Bond length scaling (default 1.0, negative for modularity)
 -dm, --deltamodularity               Modularity bias parameter
 -wt, --weight                        Weight the adjacancy matrix toward short contacts
 -ns, --notsymm                       Do not calculate point group of clusters
 -sc, --struct_comm <thresh>          Determine the community structure
 -cm, --community                     Output the community structure
 -am, --adjacancymatrix               Output the adjacancy matrix
 -x,  --xyz                           Output clusters in XYZ format
 -o,  --off                           Output polyhedra in OFF format
 -al, --alpha                         Construct alpha shapes
 -l,  --long                          Long names for structures
 -h,  --help, -?                      Print usage information and exit
```

## crud.pl
```text
Usage: crud.pl [-launch] [-exec] [-mpinp xx] [-repose] [-ramble] [-keep] [-nostop] [-cycle]
 -exec           Use this executable
 -launch         Use this parallel launcher
 -mpinp          Number of cores per mpi Castep (0)
 -repose         Use repose (0)
 -ramble         Use ramble (0)
 -keep           Keep all output files (0)
 -nostop         Keep the script running (0)
 -cycle          Retry failed runs (0)
```

## forge
```text
Usage: forge [-ompnp] [-nn] [-tr] [-va] [-te] [-th] [-nc] [-n] [-b] [-eta] [-lmin] [-es] [-ne] [-np]
              [-fs] [-t] [-a] [-o] [-p] [-w] [-kT] [-l] [-s] [-q] [-pdf] [-numpot] [-h]
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

## frank
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
 
## flock
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
 
## repose
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
