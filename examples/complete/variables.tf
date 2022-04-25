#--------------------------------------------------------------
# Provider
#--------------------------------------------------------------

variable "region" {
  type        = string
  default     = null
  description = "The AWS region resources should reside in."
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

variable "cidr_block" {
  type        = string
  default     = null
  description = "(Required) The CIDR block for the VPC."
}

variable "instance_tenancy" {
  type        = string
  default     = null
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
}

variable "enable_dns_support" {
  type        = bool
  default     = null
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = null
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
}

variable "enable_classiclink" {
  type        = bool
  default     = null
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false."
}

variable "enable_classiclink_dns_support" {
  type        = bool
  default     = null
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  default     = null
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
}

#--------------------------------------------------------------
# Default Network ACL
#--------------------------------------------------------------

variable "manage_default_network_acl" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable management of the default network acl"
}

variable "default_network_acl_ingress" {
  description = "List of maps of ingress rules to set on the Default Network ACL"
  type        = list(any)

  default = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
  ]
}

variable "default_network_acl_egress" {
  description = "List of maps of egress rules to set on the Default Network ACL"
  type        = list(any)

  default = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
  ]
}

#--------------------------------------------------------------
# Default Security Group
#--------------------------------------------------------------

variable "manage_default_security_group" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable management of the default security group"
}

variable "default_security_group_ingress" {
  type = list(any)
  default = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      self      = true
    }
  ]
  description = "List of maps of ingress rules to set on the default security group"
}

variable "default_security_group_egress" {
  type = list(any)
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  description = "List of maps of egress rules to set on the default security group"
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------

variable "enable_internet_gateway" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable internet gateway creation"
}

#--------------------------------------------------------------
# Availability Zones
#--------------------------------------------------------------

variable "exclude_names" {
  type        = list(string)
  default     = null
  description = "(Optional) List of Availability Zone names to exclude."
}

variable "exclude_zone_ids" {
  type        = list(string)
  default     = null
  description = "(Optional) List of Availability Zone IDs to exclude."
}

variable "max_availability_zones" {
  type        = number
  default     = null
  description = "(Optional) Number of desired Availabilty Zones to use when creating network resources. Runs a zone state check before implmenting. Uses all available zones when set to null. Conflicts with 'availability_zones'"
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "(Optional) Specific Availabilty Zones to use when creating network resources. Does not run a zone state check before implmenting. Conflicts with 'max_availability_zones'"
}

#--------------------------------------------------------------
# Public Network
#--------------------------------------------------------------

variable "enable_public_network" {
  type        = bool
  default     = true
  description = "Enables public network resource creation"
}

#--------------------------------------------------------------
# Public Network ACL
#--------------------------------------------------------------

variable "public_ingress_acl_rules" {
  description = "Public subnets inbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "public_egress_acl_rules" {
  description = "Public subnets outbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

#--------------------------------------------------------------
# Private Network
#--------------------------------------------------------------

variable "enable_private_network" {
  type        = bool
  default     = true
  description = "Enables private network resource creation"
}

#--------------------------------------------------------------
# Private Network ACL
#--------------------------------------------------------------

variable "private_ingress_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "private_egress_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

#--------------------------------------------------------------
# Intra Network
#--------------------------------------------------------------

variable "enable_intra_network" {
  type        = bool
  default     = true
  description = "Enables intra network resource creation"
}

#--------------------------------------------------------------
# Intra Network ACL
#--------------------------------------------------------------

variable "intra_ingress_acl_rules" {
  description = "Intra subnets inbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "intra_egress_acl_rules" {
  description = "Intra subnets outbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}
