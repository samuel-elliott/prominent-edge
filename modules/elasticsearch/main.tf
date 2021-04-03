# This is required to be able to use the SSL certificate in the
# "sam_elliott_test" ES domain.
#resource "aws_iam_service_linked_role" "sam-elliott-test-linked-role" {
#  aws_service_name = "es.amazonaws.com"
#}




resource "aws_elasticsearch_domain" "sam_elliott_test" {
  domain_name           = "sam-elliott-test"
  elasticsearch_version = "7.9"

  cluster_config {
    # The smallest (cheapest) instance type that supports encryption at rest.
    instance_type = "t3.small.elasticsearch"
    # Keeping costs down, seeing as this is being tested on my personal AWS account.
    instance_count = 1 
  }

# Do not have time to implement this due to inability to implement simple IP-based access policy
# AND VPC endpoints. Code left behind for potential future revision instead of deleting.

#vpc_options {
#  subnet_ids = [
#    var.subnets[0]
#    ]
#}

ebs_options {
  ebs_enabled = true
# Default for a dev environment test.
  volume_size = 10
}

  domain_endpoint_options {
    enforce_https = false
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
# Commenting out to meet 24 hour deadline.
    # My own wildcard SSL cert for my personal domain, slopshack.com
#    custom_endpoint_certificate_arn = var.ssl_certificate
    # The FQDN of the ElasticSearch service to be created
#    custom_endpoint_enabled = true
#    custom_endpoint = "sam-elliott-test.slopshack.com"
  }

  encrypt_at_rest {
    enabled = true
    # Does one want AWS managed keys or customer provided? Left AWS managed for simplicity's sake.
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

# The following policy will allow PUT actions from my home IP address. Obviously not suitable for anything resembling Prod but I cannot
# justify spending an entire weekend on this.
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:es:us-east-1:461891946941:domain/sam-elliott-test/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": ["72.69.3.40/32"]}
      }
    }
  ]
}
POLICY

  tags = {
    Domain = "slopshack.com"
  }
#depends_on = [aws_iam_service_linked_role.sam-elliott-test-linked-role]

}
