docker build -t ymykai/multi-client:latest -t ymykai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ymykai/multi-server:latest -t ymykai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ymykai/multi-worker:latast -t ymykai/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ymykai/multi-client:latest
docker push ymykai/multi-server:latest
docker push ymykai/multi-worker:latest

docker push ymykai/multi-client:$SHA
docker push ymykai/multi-server:$SHA
docker push ymykai/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ymykai/multi-server:$SHA
kubectl set image deployments/client-deployment client=ymykai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ymykai/multi-worker:$SHA