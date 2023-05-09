#!/bin/bash

export key=$(cat /etc/kubernetes/pki/etcd/server.ctr)
export cert=$(cat /etc/kubernetes/pki/etcd/server.key)
export ca=$(cat /etc/kubernetes/pki/etcd/ca.crt)

yq -i '.data.server.key =  strenv(key)' ./flannel-etcd-cert.yaml
yq -i '.data.server.crt =  strenv(cert)' ./flannel-etcd-cert.yaml
yq -i '.data.ca.crt =  strenv(ca)' ./flannel-etcd-cert.yaml
