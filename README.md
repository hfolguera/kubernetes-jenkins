# kubernetes-jenkins
Repository to deploy Jenkins to local Kubernetes cluster

## Installation

### Create a Namespace for Jenkins
```
kubectl apply -f jenkins-namespace.yaml
```

### Create service Account
```
kubectl apply -f jenkins-sa.yaml
```

### Create the Persistent Volume Claim
```
kubectl apply -f jenkins-volume.yaml
```

### Create the Deployment
```
kubectl apply -f jenkins-deployment.yaml
```

### Create the Service
```
kubectl apply -f jenkins-service.yaml
```

### 8. Obtain the initial password
```
kuectl get pods -n jenkins
kubectl exec -it jenkins-****** -n jenkins -- cat /var/jenkins_home/secrets/initialAdminPassword
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
- Prometheus
- CloudBees Disk Usage Simple
- OpenID Connect Authentication Plugin

## Next Steps
1. Auto-update plugins, is it possible?
1. Set Timezone

## Restore
To restore a previous backup...
1. Install the thinBackup plugin
2. Configure the plugin: XXXXX
3. Unzip the latest backup: `tar -xzvf <BACKUP FOLDER>/jenkins_backup_<DATE>.tar.gz`
4. Copy the latest backup to container: `kubectl cp <BACKUP FOLDER>/FULL_<DATE> <JENKINS_POD>:/var/jenkins_home/backups`
5. Restore the backup: XXX
6. Restart Jenkins

## References
Official Chart repo: https://github.com/jenkinsci/helm-charts

Official Jenkins k8s install guide: https://www.jenkins.io/doc/book/installing/kubernetes/
