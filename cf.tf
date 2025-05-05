
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Access Identity for CloudFront to access S3"
}

resource "aws_s3_bucket_policy" "resume_policy" {
  bucket = aws_s3_bucket.example1.id

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
        Resource = "${aws_s3_bucket.example1.arn}/*"
      }
    ]
  })
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true

  origin {
    domain_name = "${aws_s3_bucket.example1.bucket_regional_domain_name}"
    origin_id   = "www.mehtashreyaresume-website"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_root_object = "index.html"
  aliases = ["www.mehtashreyaresume-website.com"]


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "www.mehtashreyaresume-website"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }


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
    Name = "My CloudFront Distribution"
  }
}
