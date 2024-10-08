#!/bin/bash

function install_fn() {
  helm --kube-context ${kubecontext} upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  -n ingress-nginx --create-namespace
}

function uninstall_fn() {
  helm --kube-context ${kubecontext} uninstall ingress-nginx -n ingress-nginx
}

source <(curl https://raw.githubusercontent.com/mintlime-in/kube-infra/main/installer.sh 2>/dev/null) $@

# An example Ingress that makes use of the controller:
#   apiVersion: networking.k8s.io/v1
#   kind: Ingress
#   metadata:
#     name: example
#     namespace: foo
#   spec:
#     ingressClassName: nginx
#     rules:
#       - host: www.example.com
#         http:
#           paths:
#             - pathType: Prefix
#               backend:
#                 service:
#                   name: exampleService
#                   port:
#                     number: 80
#               path: /
#     # This section is only required if TLS is to be enabled for the Ingress
#     tls:
#       - hosts:
#         - www.example.com
#         secretName: example-tls

# If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:

#   apiVersion: v1
#   kind: Secret
#   metadata:
#     name: example-tls
#     namespace: foo
#   data:
#     tls.crt: <base64 encoded cert>
#     tls.key: <base64 encoded key>
#   type: kubernetes.io/tls