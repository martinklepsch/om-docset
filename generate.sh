#!/bin/bash

rm -rf _output/erlang.docset/Contents/Resources/docSet.dsidx
rm -rf _output/erlang.docset/Contents/Resources/Documents/*

mkdir -p _output/erlang.docset/Contents/Resources/Documents
tar zxf _input/doc.tar.gz -C _output/erlang.docset/Contents/Resources/Documents
cp -rf _input/Info.plist _output/erlang.docset/Contents/Info.plist
cp -rf _input/logo.png _output/erlang.docset/icon.png
cp -rf _input/otp_doc.css _output/erlang.docset/Contents/Resources/Documents/doc/otp_doc.css

cd _output/erlang.docset/Contents/Resources/Documents

#find doc -name \*\.html | xargs -n 1 ruby ../src/generate.rb | sqlite3 ../_output/erlang.docset/Contents/Resources/docSet.dsidx
#find lib -name \*\.html | xargs -n 1 ruby ../src/generate.rb | sqlite3 ../_output/erlang.docset/Contents/Resources/docSet.dsidx
find doc -name \*\.html | xargs -n 1 ruby ~/Codes/erlang.docset/src/generate.rb | sqlite3 ../docSet.dsidx
find lib -name \*\.html | xargs -n 1 ruby ~/Codes/erlang.docset/src/generate.rb | sqlite3 ../docSet.dsidx
find erts-5.9.1 -name \*\.html | xargs -n 1 ruby ~/Codes/erlang.docset/src/generate.rb | sqlite3 ../docSet.dsidx

cd -

cd _output

tar --exclude='*.pdf' --exclude='.DS_Store' -cvzf Erlang.tgz erlang.docset

cd -
