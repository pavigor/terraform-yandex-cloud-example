terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "PLACE_YANDEX_TOKEN"
  cloud_id  = "CLOUD_ID"
  folder_id = "FOLDER_ID"
}
provider "tls" {
  
}