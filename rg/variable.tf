variable "rg-map" {
    description = "Map of resource groups with their properties"
    type        = map(object({
        name     = string
        location = string
        tags     = optional(map(string))
    }))
}