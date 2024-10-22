output "instance_id" {
  value = module.ec2_instance["instance1"].instance_id
}

output "jenkins_public_ip" {
  value = module.ec2_instance["instance1"].instance_public_ip
}

output "prom_public_ip" {
  value = module.ec2_instance["instance2"].instance_public_ip
}

output "sonar_public_ip" {
  value = module.ec2_instance["instance3"].instance_public_ip
}