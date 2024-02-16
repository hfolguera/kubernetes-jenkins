# kubernetes-jenkins
Repository to deploy Jenkins to local Kubernetes cluster

## Installation
### 1. Configure Jenkins HELM repo
```
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
```

### 2. Verify Jenkins HELM repo
```
helm search repo jenkins
```

### 3. Create a Namespace for Jenkins
```
kubectl apply -f jenkins-namespace.yaml
```

### 4. Create service Account
```
kubectl apply -f jenkins-sa.yaml
```

### 5. Create the Persistent Volume Claim
```
kubectl apply -f jenkins-volume.yaml
```

### 6. Create the Deployment
```
kubectl apply -f jenkins-deployment.yaml
```

### 7. Create the Service
```
kubectl apply -f jenkins-service.yaml
```

### 8. Obtain the initial password
```
kubectl exec -it jenkins-559d8cd85c-cfcgk cat /var/jenkins_home/secrets/initialAdminPassword -n jenkins
```

## Post Installation Steps
### Install plugins
Select the following plugins to install:
- Folders
- Configuration as Code
- Github
- Ansible
- Ansible Tower
- Kubernetes
- Docker
- Oracle Cloud Infrastructure DevOps
- Oracle Cloud Infrastructure Compute
- Ansicolor
- Terraform
- Thinbackup

### Configure Kubernetes cloud
Create a Kubernetes cloud to deploy build agents

## Next Steps
1. Jenkins Configuration as Code (JCasC)

## References
Official Chart repo: https://github.com/jenkinsci/helm-charts

Official Jenkins k8s install guide: https://www.jenkins.io/doc/book/installing/kubernetes/
