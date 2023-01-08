resource "yandex_lb_target_group" "lb_tg" {

  name = "${local.prefix}lb-tg"
  region_id = "ru-central1"

  labels = var.labels
  dynamic "target" {
    for_each = yandex_compute_instance.this
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb" {

  name = "${local.prefix}lb"
  labels = var.labels

  listener {
    name = "${local.prefix}listener"
    port = var.lb_listener_port
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.lb_tg.id}"
    
    healthcheck {
      name = var.nlb_healthcheck.name
      http_options {
        port = var.nlb_healthcheck.port
        path = var.nlb_healthcheck.path
      }  
    }
  }
}