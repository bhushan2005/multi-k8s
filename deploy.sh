docker build -t bhushan2005/multi-client-k8s:latest -t bhushan2005/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t bhushan2005/multi-server-k8s-pgfix:latest -t bhushan2005/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t bhushan2005/multi-worker-k8s:latest -t bhushan2005/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push bhushan2005/multi-client-k8s:latest
docker push bhushan2005/multi-server-k8s-pgfix:latest
docker push bhushan2005/multi-worker-k8s:latest

docker push bhushan2005/multi-client-k8s:$SHA
docker push bhushan2005/multi-server-k8s-pgfix:$SHA
docker push bhushan2005/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bhushan2005/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=bhushan2005/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=bhushan2005/multi-worker-k8s:$SHA