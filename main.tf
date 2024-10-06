resource "aws_key_pair" "developer" {
    key_name   = "terra-key"
    public_key = file("D:/TerraformProject/terra-key.pub")
}

resource "aws_default_vpc" "my_vpc" {
}

resource "aws_security_group" "example" {
    name   = "my-security"
    vpc_id = aws_default_vpc.my_vpc.id

    ingress = [
        {
            description      = "To allow incoming SSH traffic"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            from_port        = 22
            protocol         = "tcp"
            to_port          = 22
            security_groups  = []
            self             = false
        },
        {
            description      = "To allow incoming HTTP traffic"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            from_port        = 80
            protocol         = "tcp"
            to_port          = 80
            security_groups  = []
            self             = false
        },
        {
            description      = "To allow incoming HTTPS traffic"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            from_port        = 443
            protocol         = "tcp"
            to_port          = 443
            security_groups  = []
            self             = false
        },
        {
            description      = "To allow incoming traffic on port 8080"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            from_port        = 8080
            protocol         = "tcp"
            to_port          = 8080
            security_groups  = []
            self             = false
        }
    ]

    egress = [
        {
            description      = "To allow outgoing traffic"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            security_groups  = []
            self             = false
        }
    ]
}

resource "aws_instance" "my_instance" {
    ami               = "ami-0866a3c8686eaeeba"
    instance_type     = "t2.micro"
    key_name          = aws_key_pair.developer.key_name
    security_groups   = [aws_security_group.example.name]
    user_data = file("D:/TerraformProject/docker.sh")

    tags = {
        Name = "DevClient"
    }
}
