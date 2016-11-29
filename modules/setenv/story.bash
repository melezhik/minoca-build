verbose=$(config verbose)

export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
tools_bin=$(config tools)

mkdir -p $test_root_dir/tools

test -f $SRCROOT/$ARCH$DEBUG/tools/bin/perl && mv $SRCROOT/$ARCH$DEBUG/tools/bin/perl $SRCROOT/$ARCH$DEBUG/tools/bin/perl.off

for b in $(ls -1 $tools_bin|grep -v perl); do
  ln -s -f $tools_bin/$b $test_root_dir/tools/$b
done


export PATH=$test_root_dir/tools/:$SRCROOT/$ARCH$DEBUG/tools/bin:$PATH

if test "${verbose}" = "on"; then

  echo SRCROOT: $SRCROOT
  echo DEBUG  : $DEBUG
  echo ARCH   : $ARCH
  echo PATH   : $PATH

fi

