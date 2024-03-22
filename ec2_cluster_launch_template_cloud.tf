resource "aws_key_pair" "crypto-tracker" {
  key_name   = "crypto-pem"
  public_key = "public-key"
}

resource "aws_launch_template" "lt_0b1edd8807f267576" {
  default_version = 2
  image_id      = "ami-02bc711cd973d418f"
  instance_type = "t2.micro"
  placement {
    availability_zone = "sa-east-1a"
  }
  key_name      = aws_key_pair.crypto-tracker.id
  name          = "ECSLaunchTemplate_B1J75jkZDgJn"
  network_interfaces {
    security_groups = [aws_security_group.cluster.id]
  }
}
