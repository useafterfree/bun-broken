bun: install
	docker build -t bun-broken -f Dockerfile.bun  .

node: install
	docker build -t node-broken .

docker: install node bun

install:
	pnpm install
	bun install

test-versions:
	./scripts/test-versions.sh