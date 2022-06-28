provider "yandex" {
  token     = "temp"
  cloud_id  = "b1gs7tftaga7jvk11mr2"
  folder_id = "b1gerr5bqboo5cv6dtr2"
  zone      = "ru-central1-a"
  service_account_key_file = "key.json"
  }


resource "yandex_kms_symmetric_key" "key-a" {
  name              = "backet"
  description       = "backet test"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 год
}

resource "yandex_storage_bucket" "test" {
  bucket = "andrey0622"
  access_key = "backet"
  secret_key = "temp"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

