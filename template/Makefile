
test:
	@echo "testing PKGPATH"
	go test -race -coverprofile=coverage.out ./...


run:
	docker-compose up --build

fmt:
	goimports -w ./cmd
	goimports -w ./internal

dep-init:
	dep init

dep-ensure:
	rm -rf vendor/
	dep ensure

# Auto-generate code
gen: rpc/PKGNAME/PKGNAME.proto
	protoc --proto_path=. --twirp_out=. --go_out=. $<

