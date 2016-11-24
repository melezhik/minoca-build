export SRCROOT=$(config srcroot)

cd $SRCROOT/third-party/build || exit 1

for p in $(ls -1); do
  echo "build-$p";
done

