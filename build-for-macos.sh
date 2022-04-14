#!/bin/sh -ex

cargo build
cp ./target/debug/libicon.dylib ./godot/libicon.dylib
