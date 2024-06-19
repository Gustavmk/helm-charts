helm upgrade -i filebeat filebeat/ 
kubectl get pods --namespace=default -l app=filebeat-filebeat -w


helm upgrade -i logstash logstash/
kubectl get pods --namespace=default -l app=logstash-logstash -w

helm upgrade -i elasticsearch elasticsearch/ 
kubectl get pods --namespace=default -l app=elasticsearch-master -w
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
helm --namespace=default test elasticsearch

helm upgrade -i kibana kibana/
kubectl get pods --namespace=default -l release=kibana -w
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
kubectl get secrets --namespace=default kibana-kibana-es-token -ojsonpath='{.data.token}' | base64 -d

d4adSmQOMjLkkvrP
AAEAAWVsYXN0aWMva2liYW5hL2tpYmFuYS1raWJhbmE6ekRFVjV6aDdRYjZjSnpHNlFkV2VaZw

# validate
# get logs from filestash filebeat-filebeat-twp6m
# get logs to logstash