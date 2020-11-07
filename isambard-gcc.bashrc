
[ -d $HOME/arm-sve-tools ] || cp -a ~ri-jlinford/arm-sve-tools $HOME

export ARM_LICENSE_DIR=/lustre/software/aarch64/tools/arm-compiler/licences

module purge
module use /lustre/software/aarch64/tools/arm-compiler/20.3/modulefiles
module use /lustre/projects/bristol/modules-a64fx/modulefiles
module load gcc/11-20201025

