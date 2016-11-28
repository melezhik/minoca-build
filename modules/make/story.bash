
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin
verbose=$(config verbose)

target=$(story_var target)

target_safe_name=$(story_var target_safe_name)
export target

echo -n build $thing ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/third-party || exit 1

if test "${verbose}" = "on"; then

  make || exit 1

else

  if make 1>$test_root_dir/make-$target_safe_name.report.txt 2>&1; then
    echo ok
  else
    echo failed
    echo last 10 lines at report file: $test_root_dir/make-$target_safe_name.report.txt
    ls -l $test_root_dir/make-$target_safe_name.report.txt
    tail -n 10 $test_root_dir/make-$target_safe_name.report.txt
    exit 1
  fi
  
fi


