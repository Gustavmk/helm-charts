helm upgrade -i filebeat filebeat/ 
helm upgrade -i logstash logstash/
helm upgrade -i elasticsearch elasticsearch/ 
helm upgrade -i kibana kibana/

# validate
# kubectl get pods --namespace=default -l app=filebeat-filebeat
# kubectl get pods --namespace=default -l app=logstash-logstash
# kubectl get pods --namespace=default -l app=elasticsearch-master
# kubectl get pods --namespace=default -l release=kibana 

#kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
#kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d

# Login Kibana
# user: elastic
# password=$(kubectl get secrets --namespace=default kibana-kibana-es-token -ojsonpath='{.data.token}' | base64 -d)