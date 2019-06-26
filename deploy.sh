docker build -t sssuthe/complex-client:latest -t sssuthe/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t sssuthe/complex-server:latest -t sssuthe/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t sssuthe/complex-worker:latest -t sssuthe/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sssuthe/complex-client:latest
docker push sssuthe/complex-server:latest
docker push sssuthe/complex-worker:latest

docker push sssuthe/complex-client:$SHA
docker push sssuthe/complex-server:$SHA
docker push sssuthe/complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=sssuthe/complex-client:$SHA
kubectl set image deployments/server-deployment server=sssuthe/complex-server:$SHA
kubectl set image deployments/worker-deployment worker=sssuthe/complex-worker:$SHA