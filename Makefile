APP=$(basename $())
REGISTRY=S-W-G
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./

lint:
	golint

test: 
	go test -v

GET: 
	go get

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/S-W-G/kbot/cmd.appVersion=${VERSION}

image: 
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
