/*
TODO:
  Create variable with default values, update configuration statments to use them.
  var.role_arn should be optional.
*/


variable "region" {
  default     = "us-east-1"
  description = "region to copy ami from and save to"
  type        = string
}

variable "role_arn" {
  description = "role_arn to assume."
  type        = string
}



source "amazon-ebs" "ubuntu18-ami" {
  // Access Configuration = https://www.packer.io/docs/builders/amazon/ebs#access-configuration
  region                     = var.region
  skip_region_validation     = true
  skip_metadata_api_check    = true
  skip_credential_validation = true

  // Assume Role Configuration = https://www.packer.io/docs/builders/amazon/ebs#assume-role-configuration
  assume_role {
    role_arn = var.role_arn
  }

  // AMI Configuration - https://www.packer.io/docs/builders/amazon/ebs#ami-configuration
  ami_name         = "aws-ubuntu-1804"
  encrypt_boot     = true
  force_deregister = true

  // Run Configuration = https://www.packer.io/docs/builders/amazon/ebs#run-configuration
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  source_ami_filter {
    filters = {
      architecture                       = "x86_64"
      "block-device-mapping.volume-type" = "gp2"
      name                               = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
      root-device-type                   = "ebs"
      virtualization-type                = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  // Session Manager Connections - https://www.packer.io/docs/builders/amazon/ebs#session-manager-connections
  ssh_username = "ubuntu"
}



build {
  sources = ["source.amazon-ebs.ubuntu18-ami"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y --with-new-pkgs",
      "sudo sh -c 'echo \"deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main\" > /etc/apt/sources.list.d/pgdg.list'",
      "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -",
      "sudo add-apt-repository -y ppa:timescale/timescaledb-ppa",
      "sudo apt-get update",
      "sudo apt-get -y install postgresql-13",
      "sudo apt-get -y install timescaledb-2-postgresql-13",
      "sudo timescaledb-tune --quiet --yes",
      "sudo service postgresql restart"
    ]
  }
}