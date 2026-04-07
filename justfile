SCRAPLING_SRC := "3rdparty/Scrapling"
SCRAPLING_DOCS := SCRAPLING_SRC + "/docs"
DOCS_DIR := "docs"
API_REF_DIR := DOCS_DIR + "/api-reference"

# Build docs using existing local submodule (no remote fetch)
docs: copy-docs regen-api-reference

# Fetch latest submodule then rebuild docs (used by CI)
ci: docs

# Initialize and update the Scrapling git submodule to latest remote commit
update-submodule:
    git submodule update --init --remote --recursive

# Copy all docs from 3rdparty/Scrapling/docs/ into ./docs/
copy-docs: update-submodule
    rsync -av --delete --exclude='.gitkeep' {{SCRAPLING_DOCS}}/ {{DOCS_DIR}}/
    rm {{DOCS_DIR}}/README_*.md
    cp {{SCRAPLING_SRC}}/README.md {{DOCS_DIR}}/README.md

# Delete existing api-reference and regenerate it using pydoc-markdown
regen-api-reference: update-submodule
    rm -rf {{API_REF_DIR}}
    mkdir -p {{API_REF_DIR}}
    uvx pydoc-markdown \
        -I {{SCRAPLING_SRC}} \
        -p scrapling \
        --no-render-toc \
        > {{API_REF_DIR}}/index.md
