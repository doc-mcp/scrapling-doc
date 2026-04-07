SCRAPLING_SRC := "3rdparty/Scrapling"
SCRAPLING_DOCS := SCRAPLING_SRC + "/docs"
DOCS_DIR := "docs"
API_REF_DIR := DOCS_DIR + "/api-reference"

# Build docs using existing local submodule (no remote fetch)
docs: copy-docs regen-api-reference

# Fetch latest submodule then rebuild docs (used by CI)
ci: update-submodule docs

# Initialize and update the Scrapling git submodule to latest remote commit
update-submodule:
    git submodule update --init --recursive

# Copy all docs from 3rdparty/Scrapling/docs/ into ./docs/
copy-docs:
    rsync -av --delete --exclude='.gitkeep' {{SCRAPLING_DOCS}}/ {{DOCS_DIR}}/

# Delete existing api-reference and regenerate it using pydoc-markdown
regen-api-reference: _remove-api-reference _gen-selector _gen-fetchers _gen-custom-types _gen-response _gen-proxy-rotation _gen-spiders _gen-mcp-server

_remove-api-reference:
    rm -rf {{API_REF_DIR}}
    mkdir -p {{API_REF_DIR}}

_gen-selector:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.parser \
        --no-render-toc \
        > {{API_REF_DIR}}/selector.md

_gen-fetchers:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.fetchers \
        --no-render-toc \
        > {{API_REF_DIR}}/fetchers.md

_gen-custom-types:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.core.custom_types \
        --no-render-toc \
        > {{API_REF_DIR}}/custom-types.md

_gen-response:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.engines.toolbelt.custom \
        --no-render-toc \
        > {{API_REF_DIR}}/response.md

_gen-proxy-rotation:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.engines.toolbelt.proxy_rotation \
        --no-render-toc \
        > {{API_REF_DIR}}/proxy-rotation.md

_gen-spiders:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.spiders \
        -m scrapling.spiders.result \
        -m scrapling.spiders.session \
        --no-render-toc \
        > {{API_REF_DIR}}/spiders.md

_gen-mcp-server:
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -m scrapling.core.ai \
        --no-render-toc \
        > {{API_REF_DIR}}/mcp-server.md
