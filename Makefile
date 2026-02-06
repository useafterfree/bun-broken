clean:
	@if docker image inspect bun-broken >/dev/null 2>&1; then \
		docker rmi -f bun-broken; \
	fi
	@if docker image inspect node-broken >/dev/null 2>&1; then \
		docker rmi -f node-broken; \
	fi

bun: clean install
	docker build -t bun-broken -f Dockerfile.bun  .

node: clean install
	docker build -t node-broken .

docker: install node bun

install:
	pnpm install
	bun install

test-versions:
	./scripts/test-versions.sh 37 51