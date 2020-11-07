
[ -d $HOME/arm-sve-tools ] || cp -a ~ri-jlinford/arm-sve-tools $HOME

module purge
module load cpe-cray
module load cce-sve/10.0.1
module load craype/2.7.0
module load craype-arm-nsp1
module load craype-network-infiniband
module load cray-libsci/20.09.1.1

