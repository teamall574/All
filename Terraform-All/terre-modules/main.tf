provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-east-1"
}

# create the Testing-environment
module "dev-Env" {
    source = "./modules/basic_infra"

    vpc_cidr = "192.1.0.0/16"
    public_subnet1_cidr = "192.1.1.0/24"
    public_subnet2_cidr = "192.1.2.0/24"
    public_subnet3_cidr = "192.1.3.0/24"
    vpc_name = "dev-aws-testing"
    IGW_name ="dev-aws-igw"
    public_subnet1_name = "dev_subnet1-testing"
    public_subnet2_name = "dev_subnet2-testing"
    public_subnet3_name = "dev_subnet3-testing"
    Main_Routing_Table = "dev_main_routing_table"
    key_name = "chefkeypair"
    environment = "dev"
}




# create the dev-environment
module "test-Env" {
    source = "./modules/basic_infra"
 
    vpc_cidr = "10.1.0.0/16"
    public_subnet1_cidr = "10.1.1.0/24"
    public_subnet2_cidr = "10.1.2.0/24"
    public_subnet3_cidr = "10.1.3.0/24"
    vpc_name = "test-aws-testing"
    IGW_name ="test-aws-igw"
    public_subnet1_name = "test_subnet1-testing"
    public_subnet2_name = "test_subnet2-testing"
    public_subnet3_name = "test_subnet3-testing"
    Main_Routing_Table = "test_main_routing_table"
    key_name = "chefkeypair"
    environment = "test"
   


}


# create the prod-environment
module "prod-Env" {
    source = "./modules/basic_infra"  #you can use github also by adding main.tf and variables.tf in github add url 
                                      #source = github/teamall574/module
    
    vpc_cidr = "172.19.0.0/16"
    public_subnet1_cidr = "172.19.1.0/24"
    public_subnet2_cidr = "172.19.2.0/24"
    public_subnet3_cidr = "172.19.3.0/24"
    vpc_name = "prod-aws-testing"
    IGW_name ="prod-aws-igw"
    public_subnet1_name = "prod_subnet1-testing"
    public_subnet2_name = "prod_subnet2-testing"
    public_subnet3_name = "prod_subnet3-testing"
    Main_Routing_Table = "prod_main_routing_table"
    key_name = "chefkeypair"
    environment = "prod"

}