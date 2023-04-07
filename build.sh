
GOOS=linux GOARCH=amd64 go build -o cni_plugin
 scp cni_plugin nuc-ubuntu22.sh.intel.com:~/bin
