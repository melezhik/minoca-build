
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin
verbose=$(config verbose)

thing=$(story_var thing)

thing_safe_name=$(story_var thing_safe_name)
export thing

echo -n build $thing ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/third-party/build/$thing || exit 1
#cp Makefile Makefile.new || exit 1
#perl -i -p -e 's/\$\(APPS\)/$ENV{thing}/g' Makefile.new || exit 1

if test "${verbose}" = "on"; then
  make -f Makefile || exit 1
else

  if make -f Makefile 1>$test_root_dir/$thing_safe_name-make.report.txt 2>&1; then
    echo ok
  else
    echo failed
    echo last 10 lines at report file: $test_root_dir/$thing_safe_name-make.report.txt
    ls -l $test_root_dir/$thing_safe_name-make.report.txt
    tail -n 10 $test_root_dir/$thing_safe_name-make.report.txt
    exit 1
  fi
  
fi


