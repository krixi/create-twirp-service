# create-twirp-service

This generates a golang microservice that implements a [Twirp](https://github.com/twitchtv/twirp) API. 


## Required tools

* Support for Protobuf. See the [twirp instructions](https://github.com/twitchtv/twirp#installation).
    * `go get github.com/twitchtv/twirp/protoc-gen-twirp`
    * `go get github.com/golang/protobuf/protoc-gen-go`
    * download a recent version of the [protoc](https://github.com/protocolbuffers/protobuf) compiler (v3+). 
* [goimports](golang.org/x/tools/cmd/goimports) 
    * `go get golang.org/x/tools/cmd/goimports`
* [Docker](https://docs.docker.com/) & [docker-compose](https://docs.docker.com/compose/) (optional)
* `make` (optional)
 
## Usage

```bash
$ ./create_service.sh github.com/krixi/my-service
```

