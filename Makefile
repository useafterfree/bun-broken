bun:
	docker build -t bun-broken -f Dockerfile.bun  .
normal:
	docker build -t node-broken .

docker: normal bun

install:
	pnpm install
	bun install