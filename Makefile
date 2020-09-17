#!/usr/bin/make -f

export GO111MODULE = on

build: go.sum
ifeq ($(OS),Windows_NT)
	go build -mod=readonly -ldflags="-w -s" -o build/project.exe ./cmd/project
else
	go build -mod=readonly -ldflags="-w -s" -o build/project ./cmd/project
endif

build-linux: go.sum
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 $(MAKE) build

install: go.sum
	go install -mod=readonly ./cmd/project

go-mod-cache: go.sum
	@echo "--> Download go modules to local cache"
	@go mod download

go.sum: go.mod
	@echo "--> Ensure dependencies have not been modified"
	@go mod verify

clean:
	rm -rf build/
