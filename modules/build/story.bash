
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


cd $SRCROOT/third-party/build/$thing || exit 1

if make 1>$test_root_dir/$thing-make.report.txt 2>&1; then
  echo ok
else
  echo failed
  echo last 10 lines at report file: $test_root_dir/$thing-make.report.txt
  ls -l $test_root_dir/$thing-make.report.txt
  tail -n 10 $test_root_dir/$thing-make.report.txt
  exit 1
fi

