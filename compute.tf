# compute.tf

# This defines the main web server for the application.
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Standard Amazon Linux 2 AMI
  instance_type = "t2.micro"

  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  # The final key is stored in the public bucket at the path /secrets/flag_part_2.txt.
  # Also check the dev-logs bucket for status keys.
  
  user_data = <<-EOF
              #!/bin/bash
              # A temporary key for initial node registration. It seems encrypted...
              export SETUP_KEY="ISCP{nyzbfg_gur_erny_frperg_vf_sbe_gur_qngnonfr}"
              
              # Set the database password for the application
              export DB_PASSWORD="ISCP_PART_1{th1s_is_a_h4rdc0ded_s3cr3t}"
              
              echo "DB_PASSWORD=${DB_PASSWORD}" > /etc/app_config
              EOF
}