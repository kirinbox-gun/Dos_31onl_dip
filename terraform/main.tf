# создаю ресурс
resource "kubernetes_namespace_v1" "dipl_zone" {
 
  metadata {
    name = "dos31dip" #имя папки в кубцтл
    labels = {
      project = "diploma"
      env     = "dev"
    }
  }
}