
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin

echo -n build image ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/os/images && \
if make clean 1>$test_root_dir/image-make.report.txt 2>&1 \
  && make 1>>$test_root_dir/image-make.report.txt 2>&1; then
  echo ok
else
  echo failed
  echo last 10 lines at report file: $test_root_dir/image-make.report.txt
  tail -n 10 $test_root_dir/image-make.report.txt
  exit 1
fi

ls -l $SRCROOT/$ARCH$DEBUG/bin/*.img
