helm upgrade -i filebeat filebeat/ 
kubectl get pods --namespace=default -l app=filebeat-filebeat -w


helm upgrade -i logstash logstash/
kubectl get pods --namespace=default -l app=logstash-logstash -w

helm upgrade -i elasticsearch elasticsearch/ 
kubectl get pods --namespace=default -l app=elasticsearch-master -w
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
helm --namespace=default test elasticsearch