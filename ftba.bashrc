# Just once: Make a local copy of the hands-on materials
[ -d $HOME/arm-sve-tools ] || cp -a /opt/arm/arm-sve-tools $HOME

# Add Fujitsu and Arm compilers to your environment
module use /opt/arm/modulefiles
module load A64FX/RHEL/8/FJSVstclanga/1.1.0 
module load Generic-SVE/RHEL/8/arm-linux-compiler-20.3/armpl/20.3.0 
