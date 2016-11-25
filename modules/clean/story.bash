
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin

thing=$(story_var thing)
thing_safe_name=$(story_var thing_safe_name)
export thing

echo -n clean $thing ... ' '

#echo SRCROOT: $SRCROOT
#echo DEBUG  : $DEBUG
#echo ARCH   : $ARCH
#echo PATH   : $PATH


cd $SRCROOT/third-party || exit 1
cp Makefile Makefile.new || exit 1
perl -i -p -e 's/\$\(APPS\)/$ENV{thing}/g' Makefile.new || exit 1

if make -f Makefile.new clean 1>$test_root_dir/$thing_safe_name-make-clean.report.txt 2>&1; then
  echo ok
else
  echo failed
  echo last 10 lines at report file: $test_root_dir/$thing_safe_name-make-clean.report.txt
  ls -l $test_root_dir/$thing_safe_name-make-clean.report.txt
  tail -n 10 $test_root_dir/$thing_safe_make-clean.report.txt
  exit 1
fi

