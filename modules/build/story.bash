
export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)


thing=$(story_var thing)

echo build $thing ...

echo SRCROOT: $SRCROOT
echo DEBUG  : $DEBUG
echo ARCH   : $ARCH

