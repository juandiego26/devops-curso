resource "digitalocean_loadbalancer" "curso-devops" {
  name   = "platzi-html-v2"
  region = "nyc3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 3000
    target_protocol = "http"
  }

  healthcheck {
    port     = 3000
    protocol = "http"
    path     = "/"
  }

  droplet_tag = "${digitalocean_tag.curso-devops.name}"
}

resource "digitalocean_tag" "curso-devops" {
  name = "platzi-html"
}

resource "digitalocean_droplet" "curso-devops" {
  count    = 2
  image    = "32629659"
  name     = "devops-curso-v2"
  region   = "nyc3"
  size     = "512mb"
  ssh_keys = [19191407]
  tags     = ["${digitalocean_tag.curso-devops.id}"]

  user_data = <<EOF
#cloud-config
coreos:
  units:
    - name: "platzi.service"
      command: "start"
      content: |
        [Unit]
        Description=Platzi Demo
        After=docker.service

        [Service]
        ExecStart=/usr/bin/docker run -d -p 3000:3000 devops-curso
EOF
}
