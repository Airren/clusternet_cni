#!/usr/bin/env bash

# first of all, you should install multipass to create vm instances.
# intel_http_proxy='http://proxy-prc.intel.com:913'
# sudo snap set system proxy.https=$intel_http_proxy
# sudo snap set system proxy.http=$intel_http_proxy
# sudo snap install multipass

# if create vm encounter network error or create failed, please set proxy for
# multipassd though the method below.
#    sudo systemctl edit snap.multipass.multipassd.service
#  add proxy environment into the [Service] section.
#    [Service]
#    Environment="HTTP_PROXY=http://child-prc.intel.com:913"
#    Environment="HTTPS_PROXY=http://child-prc.intel.com:913"
#  after add the env variables, you should restart the multipassd service.
#    sudo systemctl daemon-reload
#    sudo systemctl restart snap.multipass.multipassd
#  check the env variable
#     sudo systemctl show --property Environment snap.multipass.multipassd
#  after restart, you need wait for about minute till multipassd started.

CORE='4'
MEMORY='8'
DISK='40'
OS_VERSION='jammy'
NAME_PREFIX=""
NAME_SUFFIX=""

# ------------------------------------------------------------------------------
# --------------------- Parse the Arguments ------------------------------------
# ------------------------------------------------------------------------------
while [[ $# -gt 0 ]]; do
  case $1 in
  -c | --core)
    CORE="$2"
    shift
    shift
    ;;
  -m | --memory)
    MEMORY="$2"
    shift
    shift
    ;;
  -d | --disk)
    DISK="$2"
    shift
    shift
    ;;
  -v | --os-version)
    OS_VERSION="$2"
    shift
    shift
    ;;
  -p | --prefix)
    NAME_PREFIX="$2"
    shift
    shift
    ;;
  -s | --suffix)
    NAME_SUFFIX="$2"
    shift
    shift
    ;;
  -h | --help)
    echo 'if you encounter any error, please read the corresponding comment in the scripts'
    echo
    echo '    arguments:
      -c | --core         set the cpu core num for VM, integer, default 4
      -m | --memory       set vm memory xx GB, -m 2 | --memory 2 -> 2GB, default 8GB
      -d | --disk         set vm disk   xx GB, -d 20 | --disk 20 -> 2GB, default 40GB
      -v | --os-version   set vm os type and version,default jammy
      -p | --prefix       set vm name prefix
      -s | --suffix       set vm name suffix
      -h | --help         help
      '

    exit 0
    ;;
  -* | --*)
    echo "unknown options $1"
    exit 1
    shift
    shift
    ;;
  esac
done


VM_NAME=$NAME_PREFIX+"node"+$NAME_SUFFIX

if multipass ls | grep --quiet "${VM_NAME}"; then
  echo "the VM ${VM_NAME} exists. please double check with multipass ls."
  exit 1
fi

echo "0 create a vm:  ${VM_NAME}"
multipass launch -c "${CORE}" -m "${MEMORY}G" -d "${DISK}G" -n "${VM_NAME}" \
  --cloud-init "$(pwd)/cloud-init.yaml" --timeout 1200 "${OS_VERSION}"
