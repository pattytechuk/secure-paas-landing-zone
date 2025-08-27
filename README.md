# Secure PaaS Landing Zone

## ✅ Project Overview

This project provisions a secure PaaS landing zone in Azure using a hub-and-spoke network topology with private endpoints for App Service, SQL Database, and Key Vault. The deployment is automated with Bicep modules, PowerShell orchestration scripts, and a GitHub Actions CI/CD pipeline.

Some PowerShell scripting was used for initial setup (resource group creation, tests to confirm connectivity). The CI/CD workflow should validates, deploy, and test the infrastructure whenever code changes are pushed to the repo.

## ✅ Tech Stack
📐 Bicep (Infrastructure as Code)
💻 PowerShell (deployment & validation scripting)
☁️ Azure Networking (Hub-Spoke VNets, Private Endpoints, Bastion, Firewall)
🔁 GitHub Actions (CI/CD pipeline)

## ✅ Setup
Please check out the full project documentation under the folder documents/ for all steps taken, including all scripts, commands used.

Main commands used include:

Git commands:
`git clone https://github.com/pattytechuk/secure-paas-landing-zone.git`
`git checkout -b feature/initial-setup`
`git add .`
`git commit -m "Initial Bicep + PowerShell deployment"`
`git push origin feature/initial-setup`

PowerShell deployment commands: 
`Connect-AzAccount`
`New-AzResourceGroup -Name SecurePaaSLandingZone -Location "UKSouth"`
`pwsh ./scripts/deploy.ps1`

# Validation
pwsh ./scripts/validate.ps1

High-level overview of steps taken:
1. Created hub-and-spoke VNet architecture with separate reusable Bicep modules
2. Peered hub and spoke VNets (hub contains Bastion + Firewall, spokes contain App + Data services)
3. Deployed App Service (and created private endpoint in Spoke 1 to connect to it)
4. Deployed SQL Database and Key Vault (private endpoints in Spoke 2)
5. Configured private DNS zones for name resolution of private endpoints
6. Wrote PowerShell scripts to validate peering, private IP resolution, and service connectivity
7. Built GitHub Actions CI/CD pipeline to deploy infrastructure on push to main

## ✅ CI/CD Pipeline Overview

The GitHub Actions pipeline automates the full deployment and validation process:

- On push/PR to main → pipeline triggers
- Step 1: Authenticate to Azure using Service Principal stored in GitHub Secrets
- Step 2: Run Bicep deployment via PowerShell script (deploy.ps1)
- Step 3: Run validation checks (validate.ps1) to confirm:
- VNet peering is active
- App Service and SQL DB resolve via private endpoints
- Bastion provides secure connectivity to VMs if needed
- Step 4: Report results back into GitHub Actions logs

## ✅ Folder Structure
```
📁 secure-paas-landing-zone
│
├── 📁 bicep/ # Bicep modules for hub, spokes, endpoints, and services
├── 📁 scripts/ # PowerShell scripts for deployment & validation
├── 📁 .github/workflows/ # GitHub Actions pipeline (YAML)
├── 📁 documents/ # Detailed step-by-step documentation
├── 📁 images/ # Diagrams, screenshots, architecture exports
│
```

## ✅ Network Diagram / Screenshots

[insert here]
Above: Network diagram

<img src="https://github.com/user-attachments/assets/557d54bb-c895-4d60-b077-65b8f2061b1b" alt="screenshot1" width="343"/>

Above: Successful deployment of all resources, as reflected in Azure portal.

## ✅ Summary

This project demonstrates the following tech: IaC with Bicep, scripting with PowerShell, secure hub-and-spoke landing zone design, private networking using private endpoints, and CI/CD automation using GitHub Actions. Although landing zone accelerators are often used to simplify deployment processes, I wanted a hands on, ground level view while building an automated pipline that would deploy key parts of infra. 

This project's a simplification of what might be deployed in a production environment. The spokes are serverless-only, whereas real-life implementation would include application VM's (i.e. web servers, microservices, etc.), jumpboxes / management VMs, backup VMs, and other workloads.
