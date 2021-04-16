provider "aws" {
  region  = var.region
}

resource "aws_ecr_repository" "devops-project-repo" {
  name                 = "devops-project"
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "devops-project-repo-policy" {
  repository = aws_ecr_repository.devops-project-repo.name
  policy     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the devops project repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "devops-role" {
  name = "devops-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  }
  EOF
}

resource "aws_codebuild_project" "devops" {
  name          = "devops-project"
  description   = "codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.devops-role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  } 
  source {
    type            = "GITHUB"
    location        = "https://github.com/o3cloudng/devops-project.git"
    git_clone_depth = 1
  }
}

