helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade --install nginx-ingress bitnami/nginx-ingress-controller -f nginx-ingress/values-aks.yaml -n nginx-ingress --create-namespace 