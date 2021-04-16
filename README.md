# DEVOPS PROJECT
**Sample devops project**

- #### [App](https://github.com/o3cloudng/devops-project/app)
    The main app files for the react-image-compressor, Dockerfile and docker-compose for containerization are also included serving with nginx
- #### [Deployment](https://github.com/o3cloudng/devops-project/infra-deploy/deploy)
    The deployment.yaml file to deploy built image from app into a kubernetes cluster (deployment & service)
- #### [Terraform](https://github.com/o3cloudng/devops-project/infra-deploy/terraform)
    Provisioning of Elastic Container Registry using terraform
    Provision AWS codebuild to run buildspec.yml for to containerize app from source github and push container to ECR


