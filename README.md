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

## 📁 Repository Structure

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
