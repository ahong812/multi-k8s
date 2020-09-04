docker build -t ahong812/multi-client:latest -t ahong812/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahong812/multi-server:latest -t ahong812/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahong812/multi-worker:latest -t ahong812/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahong812/multi-client:latest
docker push ahong812/multi-server:latest
docker push ahong812/multi-worker:latest

docker push ahong812/multi-client:$SHA
docker push ahong812/multi-server:$SHA
docker push ahong812/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahong812/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahong812/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahong812/multi-worker:$SHA
