#!/usr/bin/env bash
set -o errexit

version=$(curl -sS https://update.tabnine.com/version)
case $(uname -s) in
    'Darwin')
        targets='x86_64-apple-darwin
            aarch64-apple-darwin'
        ;;
    'Linux')
        targets="$(uname -m)-unknown-linux-musl"
        ;;
esac

echo "$targets" | while read target
do
    cd $(dirname $0)
    path=$version/$target/TabNine
    if [ -f binaries/$path ]; then
        exit
    fi
    echo Downloading version $version $target
    curl https://update.tabnine.com/$path --create-dirs -o binaries/$path
    chmod +x binaries/$path
done
