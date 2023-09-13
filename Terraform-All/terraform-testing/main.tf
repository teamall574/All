
module "vpc_name" {

    source = "./modules/aws_vpc"
    for_each = var.vpc_config
    vpc_cidr_block = "each.value.vpc_cidr_block"

    tags = ""

  
}

module "aws_subnet" {

    source = "./modules/aws_subnets"
    for_each =  "var.subnet_config"
    vpc_id = "module.vpc_modules[each.value.vpc_nmae].vpc_id"
    cidr_block = "each.value.cidr_block"
    availbility_zone = "each.value.availbility_zone"
    tags = ""
}

module "internetgw_module" {

    source = "./modules/aws_internet_gateway"
    for_each = "var.internet_gw_config"
    vpc_id = "module.vpc_modules[each.value.vpc_nmae].vpc_id"

    tags = "each.value.tags"

}

module "natgw_module" {

    source = "./modules/aws_nat-gw"
    for_each = "var.nat_gw_config"
    elasticIP_id = "module.elstic_ip_module[each.value.eip_name].elastic_ip_id"
    subnet_id =  module.aws_subnet[each.value.subnet_name]

    tags = "each.value.tags"
  
}

module "elstic_ip_module" {

    source = "./modules/aws_eip"

    for_each = var.elastic_ip_config
    
    tags = "each.value.tags"

}

module "route_table_module" {

    source = "./modules/aws_route_table"
    for_each = var.route_table_config
    vpc_id = "module.vpc_modules[each.value.vpc_nmae].vpc_id"
    gateway_id = ""

}

module "route_tabele_assocaiation" {

    source = "./modules/aws_rotetable_assocaition"
    subnet_id = ""
    route_table_id = ""
  
}