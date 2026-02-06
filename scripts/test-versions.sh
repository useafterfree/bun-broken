#!/bin/bash

echo "Testing @scalar/api-reference-react versions..."
mkdir -p test-results
echo "| Version | Node Build | Bun Build | Timestamp |" > test-results/results.md
echo "|---------|------------|-----------|-----------|" >> test-results/results.md
for i in $(seq 49 50); do \
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
    node_status="❌ FAIL"; \
    bun_status="❌ FAIL"; \
    if $(MAKE) node 2>&1 | tee test-results/$$version-node.log; then \
        node_status="✅ PASS"; \
        echo "✓ Node build PASSED"; \
    else \
        echo "✗ Node build FAILED"; \
    fi; \
    if $(MAKE) bun 2>&1 | tee test-results/$$version-bun.log; then \
        bun_status="✅ PASS"; \
        echo "✓ Bun build PASSED"; \
    else \
        echo "✗ Bun build FAILED"; \
    fi; \
    echo "| $$version | $$node_status | $$bun_status | $$(date +%Y-%m-%d\ %H:%M:%S) |" >> test-results/results.md; \
done
echo ""
echo "================================================="; 
echo "Test Results Summary:"; 
echo "================================================="; 
cat test-results/results.md

