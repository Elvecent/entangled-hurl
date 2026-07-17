## Usage

Nix shell is available with `nix develop`.

Run `entangled tangle` to prepare tasks and tests.

Run again if you edit `.md` files, or start `entangled watch`.

Example output at `site/index.example.html`.

### Run generated tests

`entangled brei -B test`

### Render the doc

``` { .bash .task }
#| description: "render docs"
#| creates: "site/index.html"
#| requires: "#test"
#| collect: "render"
pandoc $(find . -name '*.md' | sort -r) \
    --standalone \
    --lua-filter=include-result.lua \
    --lua-filter=annotate-blocks.lua \
    --syntax-definition=hurl.xml \
    --metadata title="API doc" \
    -M maxwidth=40% \
    -V margin-top=0 \
    --toc \
    -o site/index.html
```

Can be invoked with `entangled brei render`.

`entangled brei -B render` to force render and test runs.
