export SRCROOT=$(config srcroot)
filter=$(config filter)

cd $SRCROOT/third-party/build || exit 1

if test -z $filter; then

  for p in $(ls -1); do
    echo "build-$p clean-$p";
  done
  
else

  for p in $(ls -1 | grep $filter); do
    echo "build-$p clean-$p";
  done

fi
