
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin

echo -n build os ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/os && \
if make 1>$cache_dir/make.report.txt 2>&1; then
  echo ok
else
  echo failed
  echo last 10 lines at report file: $cache_dir/make.report.txt
  tail -n 10 $cache_dir/make.report.txt
  exit 1
fi

