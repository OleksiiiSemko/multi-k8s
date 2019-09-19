docker build -t romb1k/multi-client:latest -t romb1k/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t romb1k/multi-server:latest -t romb1k/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t romb1k/multi-worker:latest -t romb1k/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push romb1k/multi-client:latest
docker push romb1k/multi-server:latest
docker push romb1k/multi-worker:latest

docker push romb1k/multi-client:$SHA
docker push romb1k/multi-server:$SHA
docker push romb1k/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=romb1k/multi-client:$SHA
kubectl set image deployments/server-deployment server=romb1k/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=romb1k/multi-worker:$SHA