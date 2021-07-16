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

### 4. Create Persistent Volume
`kubectl apply -f jenkins-volume.yaml`

Since we are using 3-node k8s cluster, we need to use a NFS storage class instead of hostPath.

`jenkins-volume.yaml` is set to use NFS volume. The directory must exist with jenkins owner as user and group (1000:1000). I have had to add Full Control to jenkins user over the directory in Synology directory properties.

### 5. Create service Account
`kubectl apply -f jenkins-sa.yaml`

### 6. Define installation configuration
Modify configuration by editing values.yaml file or use the existing one. It has been set to use metallb loadbalancer

### 7. Install Jenkins Chart
`helm install jenkins -n jenkins -f values.yaml jenkinsci/jenkins`

## Next Steps
1. Jenkins Configuration as Code (JCasC) examples
2. Add relevant plugins

## References
Official Chart repo: https://github.com/jenkinsci/helm-charts

Official Jenkins k8s install guide: https://www.jenkins.io/doc/book/installing/kubernetes/
