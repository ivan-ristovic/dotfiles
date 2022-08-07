#!/bin/bash

function usage ()
{
    echo "usage $(basename $0) distro build|run [docker run/build opts ...]"
    exit 1
}

if [[ $# -ne 2 ]]; then
    usage
fi

distro=$2
if [[ ! -d $distro ]]; then
    echo "fatal: $distro directory is not present"
    exit 1
fi

cmd=$1
tag="dotfiles-$distro"
dotfiles_dir=$(realpath ../)
shift 2

set -e

cd $distro
case "$cmd" in
    build)
        priv_key=$(cat ~/.ssh/id_rsa)
        pub_key=$(cat ~/.ssh/id_rsa.pub)
        docker build -t $tag \
            --force-rm \
            --build-arg PRIVATE_KEY="$priv_key" \
            --build-arg PUBLIC_KEY="$pub_key" \
            .
    ;;
    run)
        docker run $@ -v $dotfiles_dir:/home/user/dotfiles -it --rm $tag
    ;;
    *)
        usage
    ;;
esac

