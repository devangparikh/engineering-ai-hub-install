# OpenShift Software Installer

A Python Jupyter notebook for installing software on OpenShift Container Platform (OCP) with support for both JSON configuration files and interactive user input.

## Features

- 🔐 Secure authentication with OpenShift clusters
- 📦 Automated namespace/project creation
- 🚀 Deployment creation with customizable resources
- 🌐 Service and route creation for external access
- 📊 Real-time deployment status monitoring
- 🔧 Support for environment variables and resource limits
- 📝 Two input modes: JSON file or interactive prompts

## Prerequisites

Before using this notebook, ensure you have:

1. **OpenShift CLI (`oc`)** installed on your system
   - Download from: https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/getting-started-cli.html
   
2. **Python 3.8+** with Jupyter Notebook support

3. **Valid OpenShift cluster credentials**
   - Cluster URL
   - Authentication token (can be obtained from OpenShift web console)

## Installation

1. Install required Python packages:
```bash
pip install jupyter kubernetes openshift pyyaml
```

2. Clone or download this repository

3. Start Jupyter Notebook:
```bash
jupyter notebook
```

4. Open `openshift_software_installer.ipynb`

## Usage

### Method 1: Using JSON Configuration File

1. Edit the `openshift_config.json` file with your configuration:

```json
{
  "cluster_url": "https://api.your-cluster.com:6443",
  "token": "sha256~your-token-here",
  "namespace": "my-project",
  "software_name": "my-app",
  "software_image": "nginx",
  "software_version": "latest",
  "replicas": 2,
  "port": 8080,
  "environment_vars": {
    "ENV": "production",
    "LOG_LEVEL": "info"
  },
  "resource_limits": {
    "cpu": "1000m",
    "memory": "1Gi"
  },
  "resource_requests": {
    "cpu": "500m",
    "memory": "512Mi"
  }
}
```

2. In the notebook, run the cells under **"Option A: Load Configuration from JSON File"**

3. Skip the cells under "Option B"

4. Continue with validation and installation cells

### Method 2: Interactive User Input

1. In the notebook, run the cells under **"Option B: Get Configuration from User Input"**

2. Answer the prompts for:
   - OpenShift cluster URL
   - Authentication token
   - Namespace/project name
   - Software name and image
   - Number of replicas
   - Container port
   - Environment variables (optional)

3. Skip the cells under "Option A"

4. Continue with validation and installation cells

## Configuration Parameters

| Parameter | Required | Description | Example |
|-----------|----------|-------------|---------|
| `cluster_url` | Yes | OpenShift cluster API URL | `https://api.cluster.com:6443` |
| `token` | Yes | OpenShift authentication token | `sha256~abc123...` |
| `namespace` | Yes | Project/namespace name | `my-project` |
| `software_name` | Yes | Application name | `my-app` |
| `software_image` | Yes | Container image | `nginx` or `registry.redhat.io/ubi8/ubi` |
| `software_version` | No | Image tag/version | `latest` (default) |
| `replicas` | No | Number of pod replicas | `1` (default) |
| `port` | No | Container port | `8080` (default) |
| `environment_vars` | No | Environment variables | `{"KEY": "value"}` |
| `resource_limits` | No | Resource limits | `{"cpu": "1000m", "memory": "1Gi"}` |
| `resource_requests` | No | Resource requests | `{"cpu": "500m", "memory": "512Mi"}` |

## What the Notebook Does

The installation process includes the following steps:

1. **Login**: Authenticates with the OpenShift cluster using the provided token
2. **Create/Switch Namespace**: Creates a new project or switches to an existing one
3. **Create Deployment**: Deploys the software with specified configuration
4. **Create Service**: Exposes the deployment internally within the cluster
5. **Create Route**: Creates an external route for accessing the application
6. **Status Check**: Verifies the deployment status and displays pod information

## Getting Your OpenShift Token

1. Log in to your OpenShift web console
2. Click on your username in the top-right corner
3. Select "Copy login command"
4. Click "Display Token"
5. Copy the token value (starts with `sha256~`)

## Example Use Cases

### Deploy NGINX Web Server
```json
{
  "software_name": "nginx-server",
  "software_image": "nginx",
  "software_version": "1.21",
  "port": 80
}
```

### Deploy Red Hat UBI Container
```json
{
  "software_name": "ubi-app",
  "software_image": "registry.access.redhat.com/ubi8/ubi",
  "software_version": "latest",
  "port": 8080
}
```

### Deploy Custom Application
```json
{
  "software_name": "my-custom-app",
  "software_image": "quay.io/myorg/myapp",
  "software_version": "v1.0.0",
  "replicas": 3,
  "port": 3000,
  "environment_vars": {
    "DATABASE_URL": "postgresql://...",
    "API_KEY": "secret-key"
  }
}
```

## Management Commands

After installation, you can use these commands in the notebook:

```python
# Scale deployment
!oc scale deployment/{config.software_name} --replicas=3

# View logs
!oc logs -l app={config.software_name} --tail=50

# Check pod status
!oc get pods -l app={config.software_name}

# Delete application
!oc delete all -l app={config.software_name}
```

## Troubleshooting

### "oc: command not found"
- Install the OpenShift CLI from the official documentation
- Ensure `oc` is in your system PATH

### "Login failed: Unauthorized"
- Verify your token is correct and not expired
- Check that the cluster URL is correct
- Ensure you have proper permissions on the cluster

### "Failed to create deployment"
- Check that the container image exists and is accessible
- Verify resource limits are within cluster quotas
- Ensure the namespace has sufficient permissions

### "Route creation failed"
- Verify that your cluster supports routes (OpenShift feature)
- Check if a route with the same name already exists

## Security Notes

- **Never commit your `openshift_config.json` with real credentials to version control**
- Add `openshift_config.json` to `.gitignore`
- Use environment variables or secure vaults for production deployments
- Rotate tokens regularly
- Use service accounts for automated deployments

## Additional Resources

- [OpenShift Documentation](https://docs.openshift.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [OpenShift CLI Reference](https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/developer-cli-commands.html)

## License

This project is provided as-is for educational and development purposes.