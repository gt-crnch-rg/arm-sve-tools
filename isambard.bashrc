
[ -d $HOME/arm-sve-tools ] || cp -a ~ri-jlinford/arm-sve-tools $HOME

module use /software/aarch64/tools/arm-compiler/20.3/modulefiles
module use /projects/bristol/modules-a64fx/modulefiles
module load Generic-SVE/RHEL/8/arm-linux-compiler-20.3/armpl/20.3.0

