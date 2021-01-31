module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"
  # remote repo path"github.com/lincwest/terraform-orionx/tree/master/services//webserver-cluster?ref=v0.0.2"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-linc-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}