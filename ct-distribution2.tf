
 /* 
 resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Access Identity for CloudFront to access S3"
}

resource "aws_s3_bucket_policy" "resume_policy" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontAccess"
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.example.arn}/*"
      }
    ]
  })
}
*/




resource "aws_cloudfront_distribution" "s3_distribution2" {
  enabled = true

  origin {
    domain_name = aws_s3_bucket.example.website_endpoint
    origin_id   = "mehtashreyaresume-website"

 custom_origin_config {
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "http-only"
    origin_ssl_protocols   = ["TLSv1.2"]
  }
  
  }


  aliases = ["mehtashreyaresume-website.com"]


  default_cache_behavior {
    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "mehtashreyaresume-website"

  

viewer_protocol_policy = "redirect-to-https"

  }


viewer_certificate {
  acm_certificate_arn      = "arn:aws:acm:us-east-1:368643221966:certificate/9b604cee-bd8f-4ebf-abe6-5c336c4523a7"
  ssl_support_method       = "sni-only"
  minimum_protocol_version = "TLSv1.2_2021"
}


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "My CloudFront Distribution1"
  }
}
