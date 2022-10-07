# KOPS AND TERRAFORM TO DEPLOY HIGHLY-AVAILABLE KUBERNETES SETUP ON AWS

## Prequisite
- Install [Kops](https://github.com/kubernetes/kops/blob/master/docs/install.md)
- Install [KubeCtl](https://kubernetes.io/docs/tasks/tools/#install-kubectl-binary-using-native-package-management)
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## TERRAFORM SETUP
- Clone Repository [Terraform Kops AWS](https://github.com/cyse7125-fall2022-group02/tf-aws-kops-k8s.git). Once clonned run following commands to deploy basic setup on AWS

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```


## KOPS ARGUMENTS :
```bash
Kubernetes Version : "1.22.15"
Master node size : "t2.medium"
Master node count : 3
Compute node size : "t2.small"
Compute node count : 3
DNS Zone : aws.yourdomainname.me
Master Availability Zones : "us-east-1a,us-east-1b,us-east-1c"
Node Availability Zones : "us-east-1a,us-east-1b,us-east-1c"
KOPS Cluster Name : <clustername>
KOPS STATE STORE : s3://yourbucketname
SSH Key : "~/.ssh/<yourkey.pub>"
``` 


## Create Cluster Command
``` bash
    kops create cluster \
    --zones=$Node_Zones \
    --name=${KOPS_CLUSTER_NAME} \
    --node-count=$Node_Count \
    --node-size=$Node_Size \
    --node-volume-size=$Node_Volume \
    --master-size=$Master_Instance_Type
    --master-count=$Master_Count \
    --master-volume-size=$Master_Volume_Size \
    --master-zones=$Master_Zones \
    --ssh-public-key=$Public_Key \
    --kubernetes-version=$Kubernetes_version \
    --authorization=alwaysAllow \
    --cloud=aws \
    --dns-zone=${KOPS_CLUSTER_NAME} \
    --associate-public-ip=false \
    --topology=private \
    --networking=calico \
    --image=ami-08c40ec9ead489470 \
    --bastion=true \
    --yes 
```


## Update Cluster Command
```bash
kops validate cluster --name <clustername> --state <bucketname> --yes
```

## Delete Cluster Command
```bash
kops delete cluster --name <clustername> --yes
```

## Setting Bastion from KOPS template
```bash
kops replace -f cluster.yaml --state ${KOPS_STATE_STORE} --name ${KOPS_CLUSTER_NAME} --force
```

## SSH To Bastion
```bash
ssh-add ~/.ssh/sshkey
```

```bash
ssh -A ubuntu@IP
```
