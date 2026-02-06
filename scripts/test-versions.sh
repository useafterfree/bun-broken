#!/bin/bash

check_error_type () {
    if grep -q 'Parsing CSS source code failed' $1; then
        echo ":deep or other CSS error"
        return
    fi
    if grep -q 'NftJsonAsset' $1; then
        echo "NftJsonAsset"
        return
    fi

    echo "Unknown"

}

echo "Testing @scalar/api-reference-react versions..."
mkdir -p test-results
echo "| Version | Node Build | Bun Build | Timestamp |" > test-results/results.md
echo "|---------|------------|-----------|-----------|" >> test-results/results.md
for i in $(seq $1 $2); do
    version="0.8.$i";
    echo "";
    echo "=================================================";
    echo "Testing version $version";
    echo "=================================================";
    jq '.dependencies["@scalar/api-reference-react"] = "'$version'"' package.json > package.json.tmp && mv package.json.tmp package.json;
    set -o pipefail;
    

    if make node 2>&1 | tee test-results/$version-node.log; then
        node_status="✅ PASS";
        echo "✓ Node build PASSED";
    else
        node_status="❌ FAIL: $(check_error_type test-results/$version-node.log)";
        echo "✗ Node build FAILED";
    fi
    if make bun 2>&1 | tee test-results/$version-bun.log; then
        bun_status="✅ PASS";
        echo "✓ Bun build PASSED";
    else
        echo "✗ Bun build FAILED";
        bun_status="❌ FAIL: $(check_error_type test-results/$version-bun.log)";
    fi
    echo "| $version | $node_status | $bun_status | $(date +%Y-%m-%d\ %H:%M:%S) |" >> test-results/results.md;
done
echo ""
echo "================================================="; 
echo "Test Results Summary:"; 
echo "================================================="; 
cat test-results/results.md

