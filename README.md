# 필요 소프트웨어 설치
## 파일 받은 후 설치 진행
### 파일은 $HOME 디렉토리에 다운
```bash
sh setup.sh
```

# ddp-batch 업데이트
## PBS 스케줄러에 호환 가능한 ddp-batch 업데이트 진행 중
### spawn-batch maintanenece
```bash
cp ~/EDDP/spawn-batch ~/ddp-batch/spawn-batch && chmod +x ~/ddp-batch/spawn-batch
```

# spawn-batch PBS 버전
## 기존 spawn-batch와 다른 점
exec option (dafualt=castep.mpi)을 추가하여 다른 소프트웨어 및 추가 커맨드 입력 가능
### Flat 노드 사용 방법
`mpirun -np NUM_CORES` 이후 `numactl -p 1` option을 적용하여 flat 모드 사용
- numactl 을 통해 1번 인덱스의 메모리 (MCDRAM 16GbB) 사용 가능
- -p 옵션은 1번 메모리를 우선 사용한다는 의미 (총 102 GB)
- -m 옵션은 1번 메모리만 사용한다는 의미 (총 16 GB)
- 예) `spawn-batch -despawn -exec "numactl -p 1 castep.mpi" -command airss.pl -mpinp 2 -steps 0 -seed <seed> -max 1000`

# 누리온 벤치마킹
## 2코어 사용 시 가장 빠른 시간 소요


# NURION training test
forge -ompnp 4 -nn 1 -n 100 -es 10 -s adenosine_fe #killed memory 부족
forge -ompnp 4 -nn 3 -n 50 -es 10 -s adenosine_fe1 &
forge -ompnp 4 -nn 5 -n 50 -es 10 -s adenosine_fe2 & #killed memory 부족
