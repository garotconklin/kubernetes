# taken from https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/
brew install xhyve
brew upgrade nodejs
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 &&   chmod +x minikube &&   sudo mv minikube /usr/local/bin/
brew install docker-machine-driver-xhyve
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
brew install kubectl
curl --proxy "" https://cloud.google.com/container-registry/
docker images
minikube start --vm-driver=xhyve
kubectl config use-context minikube
kubectl cluster-info
minikube dashboard
mkdir hellonode
cd hellonode/
vi server.js
node server.js
vi Dockerfile
eval $(minikube docker-env)
docker build -t hello-node:v1 .
docker images
kubectl run hello-node --image=hello-node:v1 --port=8080
kubectl get deployments
kubectl get pods
kubectl get events
kubectl config view
kubectl expose deployment hello-node --type=LoadBalancer
kubectl get services
minikube service hello-node
kubectl get pods
kubectl logs hello-node-658d8f6754-fkslv
# change the file and redeploy as v2
vi server.js 
docker build -t hello-node:v2 .
kubectl set image deployment/hello-node hello-node=hello-node:v2
minikube service hello-node
minikube addons list
minikube addons enable heapster
kubectl get po,svc -n kube-system
minikube addons open heapster
kubectl delete service hello-node; kubectl delete deployment hello-node
docker rmi hello-node:v1 hello-node:v2 -f
minikube stop
  557  eval $(minikube docker-env -u)
