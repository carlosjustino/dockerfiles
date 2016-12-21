#!/bin/bash

set -e
self_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source ${self_path}/common/scripts/base.sh

# Build image for given product and version
# $1 - product name
# $2 - product version
# $3 - product profiles
function build_image() {
  product_name=$1
  product_version=$2
  product_profiles=$3
  echoBold "Building ${product_name}-${product_version}, profiles: ${product_profiles}"
  pushd ${self_path}/${product_name}/
  ./build.sh -v ${product_version} -l ${product_profiles}
  popd
  echoSuccess "${image_tag} build completed!"
}

while getopts :n:v:l: FLAG; do
  case $FLAG in
    n)
      product_name=$OPTARG
      ;;
    v)
      product_version=$OPTARG
      ;;
    l)
      product_profiles=$OPTARG
      ;;
  esac
done

if [[ -z $product_name ]] || [[ -z $product_version ]] || [[ -z $product_profiles ]]; then
  echo "Building all images..."
  build_image wso2am 2.0.0 default
  # build_image wso2am 2.0.0 "default|api-key-manager|api-publisher|api-store|gateway-manager|gateway-worker"
  docker tag wso2am:2.0.0 eristoddle/wso2am:2.0.0
  docker push eristoddle/wso2am:2.0.0

  # build_image wso2as 5.3.0 "default|worker|manager"
  build_image wso2as 5.3.0 default
  docker tag wso2as:5.3.0 eristoddle/wso2as:5.3.0
  docker push eristoddle/wso2as:5.3.0

  # build_image wso2bps 3.5.1 "default|worker|manager"

  # build_image wso2cep 4.1.0 default

  # build_image wso2das 3.0.1 default

  # build_image wso2dss 3.5.1 "default|worker|manager"
  build_image wso2dss 3.5.1 default
  docker tag wso2dss:3.5.1 eristoddle/wso2dss:3.5.1
  docker push eristoddle/wso2dss:3.5.1

  # build_image wso2es 2.0.0 "default|store|publisher"

  # build_image wso2esb 5.0.0 "default|worker|manager"
  build_image wso2esb 5.0.0 default
  docker tag wso2esb:5.0.0 eristoddle/wso2esb:5.0.0
  docker push eristoddle/wso2esb:5.0.0

  build_image wso2greg 5.3.0 default
  docker tag wso2greg:5.3.0 eristoddle/wso2greg:5.3.0
  docker push eristoddle/wso2greg:5.3.0

  # build_image wso2greg-pubstore 5.3.0 default

  build_image wso2is 5.2.0 default
  docker tag wso2is:5.2.0 eristoddle/wso2is:5.2.0
  docker push eristoddle/wso2is:5.2.0

  # build_image wso2is-km 5.2.0 default

  # build_image wso2mb 3.1.0 default

else
  echoBold "Building ${product_name}:${product_version}, profiles: ${product_profiles}"
  pushd ${self_path}/${product_name}/
  ./build.sh "$@"
  popd
  echoSuccess "${image_tag} build completed!"
fi

echoBold "Done"
