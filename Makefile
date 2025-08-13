default: build

build:
	cd testdata && make
	cd go && make

clean:
	cd testdata && make clean
	cd go && make clean

docker: build
	docker buildx build ./docker --load --tag=cucumber/json-formatter:latest --build-context binaries=./go/dist

.PHONY: default build clean docker
