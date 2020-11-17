#!/bin/bash

# https://stackoverflow.com/a/3355423/
cd "$(dirname "$0")"

pandoc --reference-doc="../pandoc-reference.docx" -o "AwesomeWiki Developer Guide.docx" index.md