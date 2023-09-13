
aws_access_key = ""
aws_secret_key = ""
aws_region = ""

vpc_config= {

    vpc01 = {
        vpc_cidr_block = "192.168.0.0/16"

        tags = {
            "Name" = "my_vpc"
        }
    }

}

subnet_config = {

    "public-us-east-1a" = {

        vpc_name = "vpc01"
        cidr_block = "192.168.1.0/24"
        availabilty_zone = "us-east-1a"
        tags = {

            "Name" = "public-us-east-1a"
        }
    }

    "public-us-east-1b" = {

        vpc_name = "vpc01"
        cidr_block = "192.168.10.0/24"
        availabilty_zone = "us-east-1a"
        tags = {

            "Name" = "public-us-east-1b"
        }
    }

    "private-us-east-1a" = {

        vpc_name = "vpc01"
        cidr_block = "192.168.20.0/24"
        availabilty_zone = "us-east-1a"
        tags = {

            "Name" = "private-us-east-1a"
        }
    }
    "private-us-east-1b" = {

        vpc_name = "vpc01"
        cidr_block = "192.168.30.0/24"
        availabilty_zone = "us-east-1b"
        tags = {

            "Name" = "private-us-east-1b"
        }
    }

}

internet_gw_config = {

    igw01 = {
        vpc_name = "vpc01"

        tags = {

            "Name" = "MY_IG"
        }
    
    }

}

elastic_ip_config = {
    eip01 = {
        tags = {
            "Name" = "my_eip1"
        }
    }
    eip02 = {
        tags = {
            "Name" = "my_eip2"
        }
    }
}

nat_gw_config = {
    natgw01 = {
        eip_name = "eip01"
        subnet_name = "public-us-east-1a"

        tags = {
            "Name" = "natgw01"
        }
    
    }
    natgw02 = {
        eip_name = "eip02"
        subnet_name = "public-us-east-1b"

        tags = {
            "Name" = "natgw02"
        }
    
    }

}

route_table_config = {

    rt01 = {
        private = 0
        vpc_name = "vpc01"
        gateway_name = "igw01"

        tags = {
            "Name" = "Public-subnet"
        }
    }
    rt02 = {
        private = 1
        vpc_name = "vpc01"
        gateway_name = "natgw01"

        tags = {
            "Name" = "private-subnet"
        }
    }
    rt03 = {
        private = 1
        vpc_name = "vpc01"
        gateway_name = "natgw02"

        tags = {
            "Name" = "private-subnet"
        }
    }

}

route_table_association_config = {

    rt01assoc = {
        subnet_name = "public-us-east-1a"
        route_table_name = "rto1"
    }
     rt02assoc = {
        subnet_name = "public-us-east-1a"
        route_table_name = "rto1"

    }
     rt03assoc = {
        subnet_name = "public-us-east-1a"
        route_table_name = "rto2"
    
    }
     rt04assoc = {
        subnet_name = "public-us-east-1a"
        route_table_name = "rt03"
        
    }


}







