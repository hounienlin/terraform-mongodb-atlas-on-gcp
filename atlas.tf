
# Create a Project
resource "mongodbatlas_project" "atlas-project" {
  org_id = var.atlas_org_id
  name = var.atlas_project_name
}

# Create a Database Password
resource "random_password" "db-user-password" {
  length = 16
  special = true
  override_special = "_%@"
}

# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
  username = var.db_username
  password = random_password.db-user-password.result
  project_id = mongodbatlas_project.atlas-project.id
  auth_database_name = "admin"

  roles {
    role_name     = "read"
    database_name = "${var.atlas_project_name}-${var.environment}-db"
  }
}

# Get My IP Address and whitelist my current IP address

data "http" "myip" {
  url = "http://ident.me"
}

resource "mongodbatlas_project_ip_whitelist" "project-whitelist-myip" {
  project_id = mongodbatlas_project.atlas-project.id
  ip_address = chomp(data.http.myip.body)
  comment    = "my IP Address for access atlas"
}

# If you have other CIDR also accessing mongodb, you have to whitelist them

resource "mongodbatlas_project_ip_whitelist" "atlas-whitelist-cidr" {
  for_each = toset(var.whitelist_list_cidr)

  project_id = mongodbatlas_project.atlas-project.id
  cidr_block = each.key
}

# Create a MongoDB Atlas Cluster
resource "mongodbatlas_cluster" "atlas-cluster" {
  project_id = mongodbatlas_project.atlas-project.id
  name       = "${var.atlas_project_name}-${var.environment}-cluster"
  num_shards = 1
  
  replication_factor           = 3
  provider_backup_enabled      = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = var.db_version  
  
  provider_name               = "GCP"
  disk_size_gb                = 10
  provider_instance_size_name = var.cluster_instance_size_name
  provider_region_name        = var.atlas_region
}


