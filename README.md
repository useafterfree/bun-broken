Docker builds using api-reference-react will fail in docker.

App created with: `bun create next-app bun-broken`
Docker configs from Next.js https://github.com/vercel/next.js/tree/canary/examples/with-docker
Created a simple api-reference-react from: https://scalar.com/products/api-references/integrations/react

# Reproduce:
- `git clone https://github.com/useafterfree/bun-broken`
- `make install`
- `make normal`
- `make bun`


- this will fail with @scalar/api-reference-react @0.8.31:
```
0.742 https://nextjs.org/telemetry
0.747 ▲ Next.js 16.1.4 (Turbopack)
0.747 
0.763   Creating an optimized production build ...
8.173 
8.173 > Build error occurred
8.177 Error: Turbopack build failed with 4 errors:
8.177 ./node_modules/@scalar/oas-utils/dist/helpers/fetch-document.js:1:1
8.177 Module not found: Can't resolve '@scalar/helpers/url/redirect-to-proxy'
8.177 > 1 | import { redirectToProxy } from "@scalar/helpers/url/redirect-to-proxy";
8.177     | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
8.177   2 | import { formatJsonOrYamlString } from "./parse.js";
8.177   3 | const OLD_PROXY_URL = "https://api.scalar.com/request-proxy";
8.177   4 | const NEW_PROXY_URL = "https://proxy.scalar.com";
8.177 
```

- this will pass with @scalar/api-reference-react @0.8.30 :)




Suspected change:
https://github.com/scalar/scalar/pull/7850/changes#diff-d290037d845ab20c4eecb755b020dc41711c07175c526e6be1e57d965b68c338

Specifically:
https://github.com/scalar/scalar/pull/7850/changes#diff-d290037d845ab20c4eecb755b020dc41711c07175c526e6be1e57d965b68c338R1

It appears `@scalar/helpers/url/redirect-to-proxy` is not exported in `@scalar/helpers` properly, or in a way the bun or node understands.

