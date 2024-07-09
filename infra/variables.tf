variable "subscription_id" {
    description = "Azure subscription"
    type = string
    default = "20c17ce1-c880-4374-ab18-0c3a72158cf7"
}

variable "location" {
    description = "Primary datacenter"
    type = string
    default = "Canada Central"
}

variable "env" {
    description = "Working environment"
    type = string
    default = "dev"
}

variable "project" {
    description = "shorthand project codename"
    type = string
    default = "dvp"
}