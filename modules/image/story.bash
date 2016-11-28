
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin


#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH

cd $SRCROOT/third-party/build/opkg-utils || exit 1 
mkdir -p $SRCROOT/$ARCH$DEBUG/bin/apps
mkdir -p $SRCROOT/$ARCH$DEBUG/bin/packages

echo exporting packages to $SRCROOT/$ARCH$DEBUG/bin/apps ...

for p in $(ls -1 $SRCROOT/$ARCH$DEBUG/bin/packages); do
  echo  "copy $p ..." 
  bash opkg-extract-data $SRCROOT/$ARCH$DEBUG/bin/packages/$p $SRCROOT/$ARCH$DEBUG/bin/apps
done

echo -n make image ... ' '

cd $SRCROOT/os/images && \
if make clean 1>$test_root_dir/make-image.report.txt 2>&1 \
  && make 1>>$test_root_dir/make-image.report.txt 2>&1; then
  echo ok
else
  echo failed
  echo last 10 lines at report file: $test_root_dir/make-image.report.txt
  tail -n 10 $test_root_dir/make-image.report.txt
  exit 1
fi

ls -l $SRCROOT/$ARCH$DEBUG/bin/*.img