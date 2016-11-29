verbose=$(config verbose)

export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
tools_bin=$(config tools)

mkdir -p $test_root_dir/tools

if test -f $SRCROOT/$ARCH$DEBUG/tools/bin/perl; then

  echo "disabling" perl from $SRCROOT/$ARCH$DEBUG/tools/bin/ path:
  mv -v $SRCROOT/$ARCH$DEBUG/tools/bin/perl $SRCROOT/$ARCH$DEBUG/tools/bin/perl.off

fi

export PATH=$tools_bin:$SRCROOT/$ARCH$DEBUG/tools/bin:$PATH

if test "${verbose}" = "on"; then

  echo SRCROOT: $SRCROOT
  echo DEBUG  : $DEBUG
  echo ARCH   : $ARCH
  echo PATH   : $PATH

fi

