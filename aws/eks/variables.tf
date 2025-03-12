variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "control_plane_subnet_ids" {
  type = list(string)
}

variable "cluster_name" {
  type    = string
  default = "temp"
}

variable "kubernets_version" {
  type    = string
}

variable "eks_managed_node_groups" {
  description = "Map of map of node groups to create. See `node_groups` module's documentation for more details"
  type        = any
  default     = {}
}

variable "access_entries" {
  description = "Map of access entries to add to the cluster"
  type        = any
  default     = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
