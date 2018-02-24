# check for go workspace and create if it not exists
if [ ! -d "$GOPATH" ]; then
  mkdir -p $GOPATH $GOPATH/src $GOPATH/pkg $GOPATH/bin
fi