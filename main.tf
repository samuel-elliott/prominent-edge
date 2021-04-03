#module "dns" {
##  source = "./modules/dns"
#
#  aws_region = "us-east-1"
#  load_balancer_dns_name = module.network.load_balancer_dns_name
#  load_balancer_zone_id = module.network.load_balancer_zone_id
#}

module "elasticsearch" {
  az_count = 2
  aws_region = "us-east-1"
  aws_caller_identity = "461891946941"
  source = "./modules/elasticsearch"
  domain = "sam-elliott-test"
# Work to be completed at a later date for further security and network control.
#  subnets = module.network.subnets_private-id
#  ssl_certificate = module.ssl.ssl_cert_arn
#  vpc-id = module.network.vpc-id

}

#module "logs" {
#  source = "./modules/logs"
#
#  aws_region = "us-east-1"
#  environment_name = "Sam Elliott Elasticsearch Test"
#  environment = "Development"
#  
#  log_group = "/es/Sam_Elliott_Test"
#}

#module "network" {
#  source = "./modules/network"

#  ssl_certificate = module.ssl.ssl_cert_arn

#  aws_region = "us-east-1"
#  az_count = 2
#  environment_name = "Sam Elliott Elasticsearch Test"
#  environment = "Development"


#  health_check_path = "/"

#  app_port              = 443
#}

#module "ssl" {
#  source = "./modules/ssl"
#  aws_region = "us-east-1"
#  environment_name = "Sam Elliott Elasticsearch Test"
# environment = "Development"
#}
