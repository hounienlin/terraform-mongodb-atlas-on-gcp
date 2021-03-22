# Atlas Organization ID 
variable "atlas_org_id" {
  type        = string
  description = "Atlas organization id"
}

# Atlas Project name
variable "atlas_project_name" {
  type        = string
  description = "Atlas project name"
}

# Atlas Project environment
variable "environment" {
  type        = string
  description = "The environment to be built"
}

# Cluster instance size name 
variable "cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
  default     = "M10"
}

# Atlas region
variable "atlas_region" {
  type        = string
  description = "GCP region where resources will be created"
  default     = "ASIA_EAST_1"
}

# MongoDB Atlas DB version
variable "db_version" {
  type        = string
  description = "mongodb database version. 4.4"
  default     = "4.4"
}

# MongoDB Atlas DB username
variable "db_username" {
  type        = string
  description = "mongodb database username"
  default     = "demo-read"
}

# CIDR whitelist
variable "whitelist_list_cidr" {
  type        = list(string)
  description = "CIDR to whitelist access to the project"
}
