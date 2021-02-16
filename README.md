# kubernetes-jenkins
Repository to deploy Jenkins to local Kubernetes cluster

## Installation
### 1. Configure Jenkins HELM repo
```
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
```

### 2. Verify Jenkins HELM repo
`helm search repo jenkins`

### 3. Create a Namespace for Jenkins
`kubectl create namespace jenkins`

### 4. Mount NFS volume
`mount.nfs 192.168.1.11:/volume2/NFS`

### 5. Create Persistent Volume
`kubectl apply -f jenkins-volume.yaml`
Since we are using 3-node k8s cluster, we need to use local storage class instead of hostPath.

### 6. Create service Account
`kubectl apply -f jenkins-sa.yaml`

### 7. Define installation configuration
Modify configuration by editing jenkins-values.yaml file or use the existing one. It is set to use metallb loadbalancer

### 8. Install Jenkins Chart
`helm install jenkins -n jenkins -f jenkins-values.yaml jenkinsci/jenkins`

## References
Official Chart repo: https://github.com/jenkinsci/helm-charts
Official Jenkins k8s install guide: https://www.jenkins.io/doc/book/installing/kubernetes/
