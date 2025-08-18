output "instance_id" {

    value = [ for instance in aws_instance.instance : instance.public_ip] 
  
}