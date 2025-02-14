#!/bin/bash -ex

if test -z "$BTFS_TOP"; then
    echo "Variable BTFS_TOP is missing."
    exit 1
fi

cd $BTFS_TOP
WORKSPACE=$(pwd)

nuget restore tom-swifty.sln
cd "$WORKSPACE/plist-swifty"
msbuild
cd "$WORKSPACE/type-o-matic"
msbuild
cd "$WORKSPACE/swiftglue"
make generate-swift-bindings
make all -j8

cd "$WORKSPACE"
msbuild tom-swifty.sln
