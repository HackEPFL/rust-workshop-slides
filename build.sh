#!/bin/bash

echo -n "Building slides..."
rustdoc slides.md -o . --html-in-header=inc/header.inc.html --markdown-no-toc
echo " Done."
