
GOOS=linux GOARCH=amd64 go build ../ -o ../bin/cni_plugin
scp ../bin/cni_plugin nuc-ubuntu22.sh.intel.com:~/bin
