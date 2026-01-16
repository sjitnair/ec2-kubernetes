output "ec2_ssh_command" {
  value = "ssh -i ~/.ssh/${var.ec2_key_name}.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"
}

output "Jenkins_application_link" {
  value = "http://${aws_instance.tf_ec2_instance.public_ip}:8080"
}
