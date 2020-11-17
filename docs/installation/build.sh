#!/bin/bash

cd "$(dirname "$0")"

pandoc --reference-doc="../pandoc-reference.docx" -o "AwesomeWiki Installation Guide.docx" index.md