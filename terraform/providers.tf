# Блок terraform, настройка
terraform {
   required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0" #чтоб каждый раз не ниже.. совместимость
    }
  }
}

# Блок подключения
provider "kubernetes" {
  config_path = "../.kube/config" #откуда конф брать
}