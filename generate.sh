#!/bin/bash

rm -rf _output/om.docset/Contents/Resources/docSet.dsidx
rm -rf _output/om.docset/Contents/Resources/Documents/*

mkdir -p _output/om.docset/Contents/Resources/Documents
cp -rf _input/Info.plist _output/om.docset/Contents/Info.plist
# cp -rf _input/logo.png _output/erlang.docset/icon.png
cp -rf _input/gollum.css _output/om.docset/Contents/Resources/Documents/gollum.css

ruby src/stripdown.rb _input/om-documentation.html
ruby src/generate.rb _output/om.docset/Contents/Resources/Documents/om-documentation.html | sqlite3 _output/om.docset/Contents/Resources/docSet.dsidx
