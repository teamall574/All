resource "aws_key-pair" "anji-key" {
key_name = "anji-key"
public_key = tls_private-key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithum = "RSA"
rsa_bits = 4096
}
resource "local_file" "tf-key" {
content = tls_private_key.rsa.private_key_pem
filename = "tfkey"

}
