# Databricks Networking Cookbook

A collection of Terraform modules and examples demonstrating common Databricks networking scenarios across AWS and Azure. This repository provides practical, ready-to-use infrastructure code for evaluating and implementing secure networking patterns with Databricks.

## 🎯 Purpose

This cookbook is designed for:
- **Proof of Concepts (POCs)** - Quickly spin up networking infrastructure to test scenarios
- **Learning & Evaluation** - Understand Databricks networking patterns through working examples
- **Architecture Reference** - Use as a foundation for production designs (not production-ready as-is)

> ⚠️ **Important**: These examples are for evaluation and learning purposes. Review security settings, sizing, and configurations before adapting for production use.

## 🏗️ Architecture Patterns

### Cross-Cloud Connectivity
- **AWS ↔ Azure Site-to-Site VPN** with BGP routing
- ...more to follow!

## 📁 Repository Structure

```
├── examples/           # Complete deployment scenarios
│   └── cross-cloud/    # AWS-Azure VPN with Databricks + RDS
├── modules/            # Reusable Terraform modules
│   ├── aws/            # AWS networking components
│   └── azure/          # Azure networking components
├── configs/            # YAML configuration files
└── docs/               # Architecture diagrams
```

## 🧩 Available Modules

### AWS Modules
- **VPC & Networking**: VPCs, subnets, route tables, internet/NAT gateways
- **VPN Components**: Virtual private gateways, customer gateways, VPN connections
- **Security**: Security groups, VPC endpoints
- **Connectivity**: EC2 Connect endpoints
- **Services**: RDS instances, S3 buckets

### Azure Modules
- **Virtual Networks**: VNets, subnets, route tables
- **VPN Components**: Virtual network gateways, local network gateways, connections
- **Security**: Network security groups (NSGs), private endpoints
- **DNS**: Private DNS zones
- **Services**: Databricks workspaces

## 🚀 Quick Start

### Prerequisites
- Terraform >= 1.0
- AWS CLI configured with appropriate permissions
- Azure CLI configured with appropriate permissions

### Deploy Cross-Cloud Example
```bash
cd examples/cross-cloud
terraform init
terraform plan
terraform apply
```

For detailed instructions, see example scenario READMEs, e.g., [cross-cloud README](examples/cross-cloud/README.md).

## 🔧 Key Features

- **YAML-driven configuration** for easy customization
- **Modular design** for reusable components  
- **Multi-cloud support** (AWS + Azure)
- **Production-like patterns** with proper security
- **BGP routing** for dynamic failover
- **Private connectivity** for secure data transfer

## 📋 Common Use Cases

- **Cross-cloud data federation** (Databricks ↔ external databases)
- **Hybrid connectivity** evaluation
- **VPN tunnel testing** and configuration
- **Network security** pattern validation
- **Private endpoint** connectivity testing
- **Multi-cloud** architecture prototyping

## 🔒 Security Considerations

- Review all security group/NSG rules before deployment
- Customize CIDR blocks to avoid conflicts
- Enable logging and monitoring in production
- Follow principle of least privilege for access
- Use private endpoints where available

## 💰 Cost Management

⚠️ **Cost Alert**: VPN gateways are the most expensive components

- Use `terraform destroy` when done with testing
- Consider smaller instance sizes for evaluation
- Monitor data transfer costs between clouds
- Review all billable resources before deployment

## 🤝 Contributing

1. Follow the established module structure
2. Include comprehensive variable definitions
3. Add outputs for key resource attributes
4. Update relevant configuration YAML files
5. Document new scenarios in example READMEs

---

**⚠️ Disclaimer**: 
- This repository creates billable cloud resources. Always review costs and clean up unused resources to avoid unexpected charges.
- This is not an official Databricks product. All opinions and recommendations expressed here are my own and do not represent Databricks Inc.
