docker build -t xadragonxa/multi-client:latest -t xadragonxa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xadragonxa/multi-server:latest -t xadragonxa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xadragonxa/multi-worker:latest -t xadragonxa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push xadragonxa/multi-client:latest
docker push xadragonxa/multi-server:latest
docker push xadragonxa/multi-worker:latest
docker push xadragonxa/multi-client:$SHA
docker push xadragonxa/multi-server:$SHA
docker push xadragonxa/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xadragonxa/multi-server:$SHA
kubectl set image deployments/client-deployment client=xadragonxa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xadragonxa/multi-worker:$SHA