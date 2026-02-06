bun: install
	docker build -t bun-broken -f Dockerfile.bun  .

normal: install
	docker build -t node-broken .

docker: install normal bun

install:
	pnpm install
	bun install

test-versions:
	@echo "Testing @scalar/api-reference-react versions..."
	@mkdir -p test-results
	@echo "Version,Status,Timestamp" > test-results/results.csv
	@for i in $$(seq 30 48); do \
		version="0.8.$$i"; \
		echo ""; \
		echo "================================================="; \
		echo "Testing version $$version"; \
		echo "================================================="; \
		echo "Cleaning up before test..."; \
		rm -rf node_modules .next bun.lockb pnpm-lock.yaml || true; \
		docker rmi -f bun-broken node-broken 2>/dev/null || true; \
		docker builder prune -af 2>/dev/null || true; \
		jq '.dependencies["@scalar/api-reference-react"] = "'$$version'"' package.json > package.json.tmp && mv package.json.tmp package.json; \
		set -o pipefail; \
		if $(MAKE) docker 2>&1 | tee test-results/$$version.log; then \
			echo "$$version,PASS,$$(date +%Y-%m-%d\ %H:%M:%S)" >> test-results/results.csv; \
			echo "✓ Version $$version PASSED"; \
		else \
			echo "$$version,FAIL,$$(date +%Y-%m-%d\ %H:%M:%S)" >> test-results/results.csv; \
			echo "✗ Version $$version FAILED"; \
		fi; \
	done
	@echo ""
	@echo "================================================="; 
	@echo "Test Results Summary:"; 
	@echo "================================================="; 
	@cat test-results/results.csv

