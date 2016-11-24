
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin

thing=$(story_var thing)

echo -n clean $thing ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/third-party/build/$thing && \
if make clean 1>$test_root_dir/$thing-make-clean.report.txt 2>&1; then
  echo ok
else
  echo failed
  echo last 10 lines at report file: $test_root_dir/$thing-make-clean.report.txt
  tail -n 10 $test_root_dir/$thing-make-clean.report.txt
  exit 1
fi

