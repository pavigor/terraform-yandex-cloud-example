labels = {
  "project" = "stage"
  "env" = "lab"
}

resources = {
  cpu = 2
  disk = 10
  memory = 2
}

cidr_blocks = [ "10.2.0.0/24", "10.3.0.0/24", "10.4.0.0/24" ]

lb_listener_port = 80

nlb_healthcheck = {
    name = "test"
    port = 80
    path = "/"
}

vm_count = 3

vm_image_family = "lemp"

allocate_public_ip = true