#!/bin/bash

cd "$(dirname "$0")"

pandoc --reference-doc="../pandoc-reference.docx" -o "AwesomeWiki User Guide.docx" index.md