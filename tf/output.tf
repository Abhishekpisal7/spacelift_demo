output "aws_instances" {

    value = [ for instance in aws_instance.instance : instance.public_ip] 
  
}