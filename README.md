# terraform-aws-devops-infra
Production-ready infrastructure for scalable Kubernetes workloads, fully automated with CI/CD, TLS, and best-practice IAM roles.


# 🌐 Terraform AWS DevOps Infrastructure

This repository contains a fully modular, production-grade DevOps infrastructure built using **Terraform**, designed to deploy containerized applications on **Amazon EKS**, manage CI/CD workflows with **Jenkins**, enable secure AWS access via **IRSA**, and support blue/green deployments using **Ingress and Cert-Manager**.

>  Built and deployed by [Felix Moronge](https://www.felixmoronge.com) as part of a real-world DevOps portfolio project, this system reflects the architecture standards expected at mid-to-large tech companies. Does not include ALB as my portfolio site is a static Frontend site however.

---

## 📐 Architecture Overview

- **EKS Cluster** provisioned via Terraform with secure IAM roles
- **VPC, subnets, and security groups** created modularly
- **Elastic Container Registry (ECR)** for storing app images
- **Jenkins** deployed via Helm with full CI/CD pipeline
- **NGINX Ingress Controller** with TLS enabled via **Cert-Manager**
- **IRSA**-enabled Kubernetes pods for fine-grained AWS permissions
- **EBS CSI Driver** to support dynamic volume provisioning

---

## 🔧 Technologies Used

- **Terraform** (modularized for reusability)
- **Amazon Web Services** (EKS, ECR, IAM, VPC, ALB)
- **Helm 3**
- **Kubernetes** (K8s)
- **Jenkins**
- **Docker**
- **NGINX Ingress Controller**
- **cert-manager + Let's Encrypt**
- **IRSA (IAM Roles for Service Accounts)**

---

#  Repository Structure

```bash
terraform-aws-devops-infra/
├── modules/
│   ├── eks/                 # Cluster provisioning
│   ├── iam/                 # OIDC, IRSA, policies
│   ├── vpc/                 # Networking
│   ├── ecr/                 # Elastic Container Registry
│   ├── ingress/             # Helm install + SSL
│   ├── jenkins/             # Jenkins helm + ingress
│   ├── storage/             # EBS CSI driver and storage class
├── manifests/
│   ├── ingress.yaml
│   ├── jenkins-ingress.yaml
│   ├── letsencrypt-prod.yaml
│   ├── irsa-test.yaml
├── examples/
│   └── full-cluster/        # Opinionated full deployment
├── Jenkinsfile              # CI/CD automation
├── Dockerfile               # Jenkins agent or builder image
├── README.md


## 🔐 IAM & IRSA

This repository includes production-grade IAM and IRSA setup for secure, scoped pod access.

### Included Policies

- `ebs_csi_policy.json` – for volume provisioning/attachment  
- `ecr-inline-policy.json` – for Jenkins ECR access

### IRSA Service Account Examples

- `jenkins-irsa-sa`: Jenkins pipeline pod access to ECR  
- `ebs-csi-controller-sa`: CSI controller access to attach volumes

IRSA roles are configured in:

- `iam_oidc.tf`
- `iam_irsa.tf`

And mapped in Kubernetes using `serviceAccountName`.

## 🔄 CI/CD with Jenkins

Jenkins is deployed via Helm and configured for:

- 🛠️ Docker image builds
- 📦 Pushing to ECR
- 🚀 Deployments to EKS

CI/CD pipeline is defined in the `Jenkinsfile` and uses IRSA for secure image pushes.

## 🧩 Coming Soon

- Optional ALB Ingress integration
- Prometheus + Grafana monitoring modules
- ArgoCD GitOps support

## 🙌 Contributing

PRs and issues are welcome! If you find a bug or want to suggest improvements, feel free to open an issue or submit a pull request.

## 📄 License

MIT License. See `LICENSE` file for details.

## 👨‍💻 Author

**Felix Moronge**  
DevOps Engineer | Cloud Infrastructure | CI/CD | Kubernetes

- 🔗 [LinkedIn](https://www.linkedin.com/in/felixmoronge)  
- 🌐 [Portfolio](https://www.felixmoronge.com)
---
#  Step 1: Prerequisites & Local Setup

Before you begin, ensure the following tools are installed and properly configured on your local machine:

###  Required Tools ( Install in CLI )

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Helm 3](https://helm.sh/docs/intro/install/)
- [Docker](https://docs.docker.com/get-docker/) (for building container images)

### 📦 Optional (for CI/CD pipeline testing)

- [Jenkins](https://www.jenkins.io/doc/book/installing/) (if testing locally)
- [jq](https://stedolan.github.io/jq/) (for parsing CLI output)

### 🔐 AWS Access Configuration

Make sure your AWS CLI is configured with an IAM user or role that has administrative privileges:

```bash
aws configure

##  Step 2: Clone the Repository & Initialize Terraform

Start by cloning this repository and navigating to the full deployment example:

```bash
git clone https://github.com/yourusername/terraform-aws-devops-infra.git
cd terraform-aws-devops-infra/examples/full-cluster


# 🚀 Step 3: Apply the Terraform Configuration to Provision Infrastructure

Once you're initialized, apply the Terraform configuration to spin up your entire AWS infrastructure stack:

```bash
terraform apply

### 📦 Resources Created in Step 3

This step provisions:

- A complete **VPC** (with public/private subnets, route tables, and gateways)
- An **EKS Cluster** with managed node groups
- Required **IAM roles** and an **OIDC provider** for IRSA
- An **ECR Repository** for storing and retrieving container images
- Optional **S3 buckets** or **AWS Secrets Manager** entries (if extended)
- The groundwork for **Jenkins** and **Ingress** (installed via Helm in later steps)

## 🔗 Step 4: Configure `kubectl` and Verify EKS Cluster Access

Once your infrastructure is provisioned, you need to configure your local `kubectl` to access the newly created EKS cluster.

### 🧭 Update kubeconfig

Run the following command to merge your new EKS cluster context into your kubeconfig:

```bash
aws eks update-kubeconfig --region <your-region> --name <your-cluster-name>

###  Verify Access

Run the following command to confirm that your local machine can connect to the Kubernetes cluster:

```bash
kubectl get nodes

## 🧰 Step 5: Install Helm Charts for Jenkins, Ingress, and TLS

With your cluster live and reachable via `kubectl`, you're now ready to install key services into your EKS cluster using Helm.

This project includes modular Terraform code that provisions Helm releases for:

- **Jenkins** – for CI/CD pipelines
- **NGINX Ingress Controller** – to manage external traffic
- **cert-manager** – to issue TLS certificates via Let's Encrypt

### 🗂️ Apply the Helm-Based Modules

Make sure you're still inside the `examples/full-cluster` directory, then re-apply Terraform to install and configure the Helm charts:

```bash
terraform apply

  Terraform Will:

- Deploy Jenkins via Helm using stable values  
- Install NGINX Ingress Controller into the cluster  
- Deploy cert-manager to manage certificate issuance  
- Set up ClusterIssuer using the included `letsencrypt-prod.yaml`  
- Apply the Ingress resources in `manifests/` to expose Jenkins with TLS  

## 🔐 Step 6: Configure IRSA for Jenkins and EBS CSI

IAM Roles for Service Accounts (IRSA) allow your Kubernetes pods to securely interact with AWS services using scoped IAM permissions — without hardcoding credentials.

This project configures IRSA automatically through Terraform.

### 🔑 Roles Created

- `jenkins-irsa-sa`: Grants Jenkins pods permission to push Docker images to Amazon ECR
- `ebs-csi-controller-sa`: Grants the CSI driver permission to provision and attach EBS volumes

These service accounts are associated with IAM roles via the OIDC identity provider Terraform creates for your EKS cluster.

### 📁 Files Involved

- `modules/iam/iam_oidc.tf`: Creates the OIDC identity provider
- `modules/iam/iam_irsa.tf`: Creates IAM roles and attaches relevant policies
- `manifests/irsa-test.yaml`: Example manifest to test an IRSA-bound pod

### ✅ Verify IRSA Mapping

You can verify that your service accounts are correctly using the IAM roles by checking annotations:

```bash
kubectl get serviceaccount jenkins-irsa-sa -n default -o yaml

Look for an annotation like:
eks.amazonaws.com/role-arn: arn:aws:iam::<your-account-id>:role/jenkins-irsa-role

IRSA allows fine-grained, least-privilege access — and is required for secure CI/CD and EBS volume management on EKS.

## 📦 Step 7: Push a Docker Image to ECR from Jenkins

Now that Jenkins and IRSA are configured, you're ready to run a Jenkins pipeline that builds and pushes a Docker image to Amazon ECR.

This simulates real-world CI/CD automation and validates your IRSA + ECR access.

### 🛠️ Jenkinsfile

This repo includes a sample `Jenkinsfile` at the root, which automates:

- Docker image build using your app source (can be customized)
- Tagging the image with a unique ID
- Authenticating with ECR using IAM (via IRSA)
- Pushing the image to your provisioned ECR repo

### ✅ Pre-requisites

Ensure that:

- Jenkins is running and accessible via the Ingress route
- Your Jenkins agent is configured with Docker installed
- IRSA is properly attached to the Jenkins service account
- Your ECR repo name matches what's referenced in the `Jenkinsfile`

### 🧪 Trigger the Pipeline

To test the build and push flow:

1. Open your Jenkins UI (check the output of your ingress or go to `https://<your-domain>`).
2. Create a new Pipeline job and point it to this repository.
3. Save and run the job.

You should see logs confirming:

- Docker build success
- Authentication to ECR using IRSA
- Image successfully pushed to ECR

### 🔍 Verify Image in ECR

To confirm the image push worked:

```bash
aws ecr describe-images --repository-name <your-repo-name>

## This end-to-end pipeline proves that your CI/CD setup is secure, cloud-native, and production-grade.

## 🔒 Step 8: Expose Jenkins Securely with TLS

To ensure secure access to Jenkins over HTTPS, this project configures an NGINX Ingress route with a TLS certificate issued by Let's Encrypt using **cert-manager**.

### 📁 Apply the TLS Issuer & Ingress Resources

The required Kubernetes manifests are included in the `/manifests` directory. Apply them in this order:

```bash
kubectl apply -f ../../manifests/letsencrypt-prod.yaml
kubectl apply -f ../../manifests/jenkins-ingress.yaml

### 📄 What These Files Do

- `letsencrypt-prod.yaml`: Creates a **ClusterIssuer** using the Let's Encrypt production endpoint.
- `jenkins-ingress.yaml`: Defines an **Ingress** rule for Jenkins with:
  - TLS termination  
  - Hostname configuration (e.g. `jenkins.example.com`)  
  - Annotations for automatic TLS certificate provisioning  

---

### 🌐 DNS Configuration

Make sure you have a valid domain and point it to your EKS cluster’s LoadBalancer IP:

1. Get the external IP of your ingress controller:

   ```bash
   kubectl get svc -n ingress-nginx

###  Verify Secure Access

Once DNS propagates and the certificate is issued:

- Open your browser and visit:  
  `https://jenkins.yourdomain.com`
- You should see a valid HTTPS lock and the Jenkins login page

> 💡 TLS is critical for securing credentials, especially for web UIs like Jenkins. Let’s Encrypt + cert-manager automates this without manual intervention.

## 🚀 Step 9: Deploy Your Own Application via CI/CD

With your infrastructure live, Jenkins operational, and secure TLS in place, you're ready to deploy your own app using this pipeline.

This final step closes the loop: build → push → deploy → expose.

### 📁 Customize the Jenkins Pipeline

Edit the `Jenkinsfile` to reference your application's Dockerfile and Kubernetes deployment manifests.

Key areas to update:

- `docker build` context and tag logic
- ECR repository name
- `kubectl apply` paths (for your app's manifests)
- Namespace or Helm release if applicable

### 💡 Recommended File Structure

Place your app-specific files like this:

```plaintext
your-app/
├── Dockerfile
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml


Update your pipeline to apply:

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

### 🧪 Trigger the Deployment

- Commit and push your updated `Jenkinsfile`
- Trigger the Jenkins job
- Monitor build logs and ECR push success
- Confirm your app is running via:

  ```bash
  kubectl get pods
  kubectl get svc
> 💡 Congratulations — you’ve now deployed a containerized app using a production-grade DevOps stack on AWS.
