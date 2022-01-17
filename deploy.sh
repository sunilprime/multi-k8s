docker build -t nishanprime/multi-client:latest -t nishanprime/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nishanprime/multi-server:latest -t nishanprime/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nishanprime/multi-worker:latest -t nishanprime/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nishanprime/multi-client:latest
docker push nishanprime/multi-client:$SHA
docker push nishanprime/multi-server:latest
docker push nishanprime/multi-server:$SHA
docker push nishanprime/multi-worker:latest
docker push nishanprime/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nishanprime/multi-server:$SHA
kubectl set image deployments/client-deployment client=nishanprime/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nishanprime/multi-worker:$SHA
