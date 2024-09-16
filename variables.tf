variable "cloudflare_zone_id" {
    type = string
    description = "The ID of the Cloudflare zone to create the spectrum application in"
}

variable "custom_domain" {
    type = string
    description = "The custom domain to use for the minecraft server"
}

variable "cloudflare_api_token" {
    type = string
    description = "The API token to use for the Cloudflare API"
}