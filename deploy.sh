docker build -t pedroloch/multi-client:latest -t pedroloch/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pedroloch/multi-server:latest -t pedroloch/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pedroloch/multi-worker:latest -t pedroloch/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pedroloch/multi-client:latest
docker push pedroloch/multi-server:latest
docker push pedroloch/multi-worker:latest
docker push pedroloch/multi-client:$SHA
docker push pedroloch/multi-server:$SHA
docker push pedroloch/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pedroloch/multi-server:$SHA
kubectl set image deployments/client-deployment client=pedroloch/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pedroloch/multi-worker:$SHA
