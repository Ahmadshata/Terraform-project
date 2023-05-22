module "vpc-sg" {
  source = "./vpc"
  vpc_cidr = "10.0.0.0/16"
  rules = {"from" = 0, "to" = 0, "protocol" = "-1", v4 = "0.0.0.0/0", v6 = "::/0"}
}

module "pub-sub" {
  source = "./public_subnet"
  subnet_cidr = ["10.0.0.0/24", "10.0.2.0/24"]
  vpc-id = module.vpc-sg.vpc-id
  sub_type = true
  az = ["us-east-1a", "us-east-1b"]
  sub_names = ["pub-sub-1a", "pub-sub-1b"]
  all_route =  "0.0.0.0/0"
  depends_on = [module.vpc-sg]
}

module "priv-sub" {
  source = "./private_subnet"
  subnet_cidr = ["10.0.1.0/24", "10.0.3.0/24"]
  vpc-id = module.vpc-sg.vpc-id
  az = ["us-east-1a", "us-east-1b"]
  sub_names = ["priv-sub-1a", "priv-sub-1b"]
  all_route =  "0.0.0.0/0"
  pub-sub-id = module.pub-sub.pub-sub-1a-id
  depends_on = [module.pub-sub]
}

module "ami" {
  source = "./ami"
  image = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

module "priv-ins" {
  source = "./priv_instance"
  image = module.ami.ami-id
  type = var.type
  sg = [module.vpc-sg.sg-id]
  sub-id = [module.priv-sub.priv-sub-1a-id, module.priv-sub.priv-sub-1b-id]
  ud-file = "${file("priv-userdata.sh")}"
}

module "private-lb" {
  source = "./loadbalancer"
  lb-name = "private-lb"
  lb_type = true
  sg = [module.vpc-sg.sg-id]
  subs = [module.priv-sub.priv-sub-1a-id, module.priv-sub.priv-sub-1b-id]
  tg-name = "private-tg"
  vpc-id = module.vpc-sg.vpc-id
  instance-id = [module.priv-ins.instance-1a-id, module.priv-ins.instance-1b-id]
  depends_on = [module.priv-ins]
}

module "pub-ins" {
  source = "./pub_instance"
  image = module.ami.ami-id
  type = var.type
  sg = [module.vpc-sg.sg-id]
  sub-id = [module.pub-sub.pub-sub-1a-id, module.pub-sub.pub-sub-1b-id]
  lb-dns = module.private-lb.lb-dns
  depends_on = [module.private-lb]
}

module "public-lb" {
  source = "./loadbalancer"
  lb-name = "public-lb"
  lb_type = false
  sg = [module.vpc-sg.sg-id]
  subs = [module.pub-sub.pub-sub-1a-id, module.pub-sub.pub-sub-1b-id]
  tg-name = "public-tg"
  vpc-id = module.vpc-sg.vpc-id
  instance-id = [module.pub-ins.instance-1a-id, module.pub-ins.instance-1b-id]
  depends_on = [module.pub-ins]
}


























