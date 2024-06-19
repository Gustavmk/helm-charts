helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update

helm upgrade --install  prometheus-operator prometheus-community/kube-prometheus-stack -f prometheus-operator/values-aks.yaml --namespace monitoring --create-namespace

# Check to see that all the Pods are running

kubectl get pods -n monitoring

# Check all resources relateded to prom operator

kubectl -n monitoring get all -l "release=prometheus-operator"

# Other Useful Prometheus Operator Resources to Peruse

kubectl get prometheus -n monitoring
kubectl get prometheusrules -n monitoring
kubectl get servicemonitor -n monitoring
kubectl get cm -n monitoring
kubectl get secrets -n monitoring
