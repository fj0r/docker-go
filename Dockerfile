FROM nnurphy/deb

ENV HOME=/root
ENV GOROOT=/opt/go GOPATH=${HOME}/go GO_VERSION=1.14.2
ENV PATH=${GOPATH}/bin:${GOROOT}/bin:$PATH
ENV GO111MODULE=auto
RUN set -ex \
  ; cd /opt \
  #; ssh up "cat ~/pub/Platform/go${GO_VERSION}.linux-amd64.tar.gz" \
  ; wget -q -O- https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
      | tar xzf - \
  ; go get -u -v \
      github.com/spf13/viper \
      github.com/sirupsen/logrus \
      github.com/kardianos/govendor \
      github.com/gin-gonic/gin \
      github.com/jinzhu/gorm \
      gonum.org/v1/gonum/mat \
      github.com/mdempsky/gocode \
      github.com/uudashr/gopkgs/cmd/gopkgs \
      github.com/ramya-rao-a/go-outline \
      github.com/acroca/go-symbols \
      golang.org/x/tools/cmd/guru \
      golang.org/x/tools/cmd/gorename \
      github.com/rogpeppe/godef \
      github.com/zmb3/gogetdoc \
      github.com/sqs/goreturns \
      golang.org/x/tools/cmd/goimports \
      golang.org/x/lint/golint \
      github.com/alecthomas/gometalinter \
      honnef.co/go/tools/... \
      github.com/golangci/golangci-lint/cmd/golangci-lint \
      github.com/mgechev/revive \
      github.com/derekparker/delve/cmd/dlv 2>&1 \
  ; go get -x -d github.com/stamblerre/gocode \
    ; go build -o gocode-gomod github.com/stamblerre/gocode \
    ; mv gocode-gomod $GOPATH/bin/ \
  ; rm -rf $(go env GOCACHE)/* \
  ; go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct