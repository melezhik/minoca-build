
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

for p in $(ls -1 $SRCROOT/$ARCH$DEBUG/bin/packages); do
  echo  "copy $p ..." 
  bash opkg-extract-data $SRCROOT/$ARCH$DEBUG/bin/packages/$p $SRCROOT/$ARCH$DEBUG/bin/apps
done


