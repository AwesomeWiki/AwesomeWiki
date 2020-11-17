#!/bin/bash

cd "$(dirname "$0")"

pandoc --from=markdown-markdown_in_html_blocks -o index.html index.md
pandoc --reference-doc="../pandoc-reference.docx" -o "AwesomeWiki User Guide.docx" index.html
rm index.html