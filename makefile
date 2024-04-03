# Variables
IMAGE_NAME := myapp
IMAGE_TAG := latest
APP_NAME := myapp
MINIKUBE_PROFILE := minikube-cluster

# Comandos
start_cluster:
	minikube start --profile=$(MINIKUBE_PROFILE) 

delete_cluster:
	minikube stop --profile=$(MINIKUBE_PROFILE)
	minikube delete --profile=$(MINIKUBE_PROFILE)

enable_ingress:
	minikube addons enable ingress --profile=$(MINIKUBE_PROFILE)

# Install ArgoCD
install_argocd:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/core-install.yaml

# Delete ArgoCD
delete_argocd:
	kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl delete namespace argocd
	@echo "Delete argocd namespace manually when objects are finalized"


build-image:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

load-image:
	minikube image load $(IMAGE_NAME):$(IMAGE_TAG) --profile=$(MINIKUBE_PROFILE)

deploy-app:
	kubectl apply -f deployment.yaml

expose-app:
	kubectl expose deployment $(APP_NAME) --type=NodePort --port=80

apply-ingress:
	kubectl apply -f ingress.yaml

# Tareas
start: start-cluster enable-ingress

deploy: build-image load-image deploy-app expose-app apply-ingress