module "reezanvisramportfolio-server" {
  source = "../modules/reezanvisramportfolio/server"
}

module "reezanvisramportfolio-cloudstorage" {
  source = "../modules/reezanvisramportfolio/cloudstorage"
}

module "reezanvisramportfolio-client" {
  source = "../modules/reezanvisramportfolio/client"
}
