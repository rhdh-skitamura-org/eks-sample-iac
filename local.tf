locals {
  project    = "eks-sample"
  aws_region = "ap-northeast-1"

  base_tags = {
    terraform = "true"
    eks       = "eks-sample"
  }

  vpc = {
    name = "eks-sample-vpc"
    cidr = "10.0.0.0/16"

    public_subnets = [
      "10.0.0.0/20",
      "10.0.16.0/20",
      "10.0.32.0/20",
    ]

    private_subnets = [
      "10.0.128.0/20",
      "10.0.144.0/20",
      "10.0.160.0/20",
    ]

    tags = {
      Terraform = "true",
    }
  }

  eks = {
    cluster_name    = local.project
    cluster_version = "1.29"

    eks_managed_node_groups = {
      "eks-sample-nodegroup" = {
        min_size     = 3
        max_size     = 1
        desired_size = 3

        instance_types = [
          "m6i.xlarge"
        ]

        #capacity_type = "SPOT"
      }
    }
  }

  eks_access_entry = {
    principal_type = "user"
    principal_name = "eks-test-user"
  }
}
