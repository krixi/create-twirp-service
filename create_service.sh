#!/bin/bash
# This script can be used to generate a new golang service in this monorepo.

#set -ex

if [ $# -lt 1 ]; then
    echo "ERROR: Please specify the service url, e.g. github.com/krixi/my-service"
    exit 2
fi

BASEDIR="$GOPATH/src/$1"
echo "Create service: $BASEDIR"

package_name=$(basename $1)
service_name=$package_name
service_path="$BASEDIR"
current_dir=$(pwd)

echo "package_name = ${package_name}"
echo "service_name = ${service_name}"
echo "service_path = ${service_path}"
echo "current_dir = ${current_dir}"

if [[ -e "$service_path" ]]; then
    echo "Directory already exists!"
    read -p "Overwrite? (y/n): " do_overwrite

    echo
    echo "your input: $do_overwrite"
    echo

    if [[ "$do_overwrite" != "y" ]]; then
        echo "Exiting without overwriting..."
        exit 2
    fi
    echo "Continuing with overwrite..."
fi

# Make the service
cmd_dir="$service_path/cmd/$package_name/"
internal_dir="$service_path/internal/$package_name/"
rpc_dir="$service_path/rpc/$package_name/"

mkdir -p $service_path
mkdir -p $cmd_dir
mkdir -p $internal_dir
mkdir -p $rpc_dir

# copy over the templates
sed -e "s|SVCPATH|$1|g" -e "s|PKGNAME|$package_name|g" -e "s|SVCNAME|$service_name|g" template/Makefile > $service_path/Makefile
sed -e "s|SVCPATH|$1|g" -e "s|PKGNAME|$package_name|g" -e "s|SVCNAME|$service_name|g" template/Dockerfile > $service_path/Dockerfile
sed -e "s|SVCPATH|$1|g" -e "s|PKGNAME|$package_name|g" -e "s|SVCNAME|$service_name|g" template/main.go.template > $cmd_dir/main.go
sed -e "s|SVCPATH|$1|g" -e "s|PKGNAME|$package_name|g" -e "s|SVCNAME|$service_name|g" template/server.go.template > $internal_dir/server.go
sed -e "s|SVCPATH|$1|g" -e "s|PKGNAME|$package_name|g" -e "s|SVCNAME|$service_name|g" template/config.go.template > $internal_dir/config.go
sed -e "s|SVCPATH|$1|g" -e "s|PKGNAME|$package_name|g" -e "s|SVCNAME|$service_name|g" template/template.proto > $rpc_dir/$package_name.proto

pushd $service_path

make gen || echo "Unable to generate twirp bindings! Please make sure you have all tools installed, then run 'make gen' in the new service directory."

go mod init

popd

echo "Done"
