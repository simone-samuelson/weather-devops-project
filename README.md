# Weather Dashboard - DevOps Project

A containerized weather dashboard application deployed on Azure using Infrastructure as Code.

## Technologies

- **Application**: Node.js + Express
- **API**: OpenWeather API
- **Containerization**: Docker
- **Cloud Platform**: Microsoft Azure
- **Infrastructure as Code**: Terraform
- **Version Control**: Git

## Architecture

- **Azure Resource Group**: Logical container for resources
- **Azure Container Registry**: Private Docker registry
- **Azure Container Instances**: Serverless container hosting
- **OpenWeather API**: Weather data source

## Local Development

### Prerequisites

- Docker Desktop
- Node.js 18+
- Azure CLI
- Terraform

### Run Locally
```bash
cd app
docker build -t weather-dashboard:local .
docker run -p 3000:3000 -e OPENWEATHER_API_KEY=your_key weather-dashboard:local
```

Access at http://localhost:3000

## Deployment

### Initialize Terraform
```bash
cd terraform
terraform init
```

### Deploy Infrastructure
```bash
terraform apply
```

### Build and Push Image
```bash
az acr login --name your_registry_name
docker build -t your_registry.azurecr.io/weather-dashboard:v1.0 .
docker push your_registry.azurecr.io/weather-dashboard:v1.0
```

## Environment Variables

- `OPENWEATHER_API_KEY`: API key from OpenWeather
- `PORT`: Application port (default: 3000)

## Cleanup

To destroy all Azure resources:
```bash
cd terraform
terraform destroy
```

## Author

Junior DevOps Engineer
