Docker builds using api-reference-react will fail in docker.

App created with: `bun create next-app bun-broken`
Docker configs from Next.js https://github.com/vercel/next.js/tree/canary/examples/with-docker
Created a simple api-reference-react from: https://scalar.com/products/api-references/integrations/react

# Reproduce:
- `git clone https://github.com/useafterfree/bun-broken`
- `make install`
- `make normal` ## fails
- `make bun` ## fails


- this will fail with @scalar/api-reference-react ^0.8.48:
failure with `make normal`:
```
9.970   2 |
9.970 
9.970 'deep' is not recognized as a valid pseudo-class. Did you mean '::deep' (pseudo-element) or is this a typo?
9.970 
9.970 Import trace:
9.970   Client Component Browser:
9.970     ./node_modules/.pnpm/@scalar+agent-chat@0.5.2_tailwindcss@4.1.18_typescript@5.9.3/node_modules/@scalar/agent-chat/dist/style.css [Client Component Browser]
9.970     ./node_modules/.pnpm/@scalar+api-reference@1.44.11_tailwindcss@4.1.18_typescript@5.9.3/node_modules/@scalar/api-reference/dist/components/ApiReference.vue2.js [Client Component Browser]
9.970     ./node_modules/.pnpm/@scalar+api-reference@1.44.11_tailwindcss@4.1.18_typescript@5.9.3/node_modules/@scalar/api-reference/dist/components/ApiReference.vue.js [Client Component Browser]
9.970     ./node_modules/.pnpm/@scalar+api-reference@1.44.11_tailwindcss@4.1.18_typescript@5.9.3/node_modules/@scalar/api-reference/dist/standalone/lib/html-api.js [Client Component Browser]
9.970     ./node_modules/.pnpm/@scalar+api-reference-react@0.8.48_react@19.2.3_tailwindcss@4.1.18_typescript@5.9.3/node_modules/@scalar/api-reference-react/dist/ApiReferenceReact.js [Client Component Browser]
9.970     ./node_modules/.pnpm/@scalar+api-reference-react@0.8.48_react@19.2.3_tailwindcss@4.1.18_typescript@5.9.3/node_modules/@scalar/api-reference-react/dist/ApiReferenceReact.js [Server Component]
9.970     ./app/page.tsx [Server Component]
9.970 
9.970 
9.970     at ignore-listed frames
10.05  ELIFECYCLE  Command failed with exit code 1.
```


failure with `make bun`:
```
0.972   Creating an optimized production build ...
8.924 
8.924 > Build error occurred
9.094 Error: Turbopack build failed with 1 errors:
9.094 ./node_modules/@scalar/agent-chat/dist/style.css:1:105128
9.094 Parsing CSS source code failed
```
