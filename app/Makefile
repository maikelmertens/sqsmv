# command to build and run on the local OS.
GO_BUILD = go build

APP = sqsmv
TMP_BUILD = tmp/$(APP)
BIN_BUILD = bin/$(APP)
DIST_DIR = dist

TAG ?= `git describe --tags | sed -e 's/^v//'`

.PHONY: dist

all: clean tools lint goimports vet dist

deps:
	go get -t ./...

prepare:
	mkdir -p build dist bin

tools:
	go get golang.org/x/tools/cmd/goimports
	go get golang.org/x/lint/golint
	go get github.com/aws/aws-sdk-go

lint: golint vet goimports vet

vet:
	go vet

golint:
	ret=0 && test -z "$$(golint . | tee /dev/stderr)" || ret=1 ; exit $$ret

goimports:
	ret=0 && test -z "$$(goimports -l . | tee /dev/stderr)" || ret=1 ; exit $$ret

compile: clean prepare tools lint goimports vet

build: compile build-linux build-darwin build-windows

dist: compile dist-linux dist-darwin dist-windows

build-linux: compile
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GO_BUILD) -a -tags netgo -ldflags '-w' -o $(BIN_BUILD)-linux

dist-linux: build-linux
	tar -C bin -zcvf $(DIST_DIR)/$(APP)-$(TAG)-linux.tgz $(APP)

build-darwin: compile
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(GO_BUILD) -a -tags netgo -ldflags '-w' -o $(BIN_BUILD)-darwin

dist-darwin: build-darwin
	tar -C tmp -zcvf $(DIST_DIR)/$(APP)-$(TAG)-darwin.tgz $(APP)

build-windows: compile
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GO_BUILD) -a -tags netgo -ldflags '-w' -o $(BIN_BUILD)-windows

dist-windows: build-windows
	tar -C tmp -zcvf $(DIST_DIR)/$(APP)-$(TAG)-windows.tgz $(APP)

clean:
	rm -rf build dist bin
