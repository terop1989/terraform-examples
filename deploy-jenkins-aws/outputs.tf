output "Jenkins-master_Instance_Public_IP" {
        value = aws_instance.jenkins-master.public_ip
}
