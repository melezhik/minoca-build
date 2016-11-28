export SRCROOT=$(config srcroot)
export ARCH=$(config arch)
export DEBUG=$(config debug)
PATH=$PATH:$SRCROOT/$ARCH$DEBUG/tools/bin

filter=$(config filter)


cd $SRCROOT/third-party/ || exit 1

if test -z $filter; then

  make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}'     

else

  make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' \
  | grep $filter 

fi
