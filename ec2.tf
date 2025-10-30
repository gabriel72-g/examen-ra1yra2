resource "aws_instance" "mi_instancia" {
  ami = "ami-057f203c37d64cd34"
  instance_type = "t4g.micro"
  key_name = "nueva_clave"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.mi_seguridad.id]
  associate_public_ip_address = true
  user_data = file("user-data.sh")
}