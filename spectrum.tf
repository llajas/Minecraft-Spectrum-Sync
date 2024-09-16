resource "cloudflare_spectrum_application" "minecraft_server" {
    origin_direct = ["tcp://${chomp(data.http.myip.response_body)}:25565"]
    protocol = "minecraft"
    zone_id = var.cloudflare_zone_id
    dns {
        type = "CNAME"
        name = "${var.custom_domain}"
    }
}