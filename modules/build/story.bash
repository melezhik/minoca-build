
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin

thing=$(story_var thing)

echo -n build $thing ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/third-party/build/$thing && \
if make 1>$test_root_dir/$story_dir/make.report.txt 2>&1; then
  echo ok
else
  echo failed
  cat $test_root_dir/$story_dir/make.report.txt
  exit 1
fi

