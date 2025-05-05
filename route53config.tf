resource "aws_route53_record" "www" {
  zone_id = "Z09176943RMEZCHBFD7SC"
  name    = "www.mehtashreyaresume-website.com"
  type    = "A"

  alias {
    name                   = "djp6e02w8wfyj.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}



resource "aws_route53_record" "root" {
  zone_id = "Z09176943RMEZCHBFD7SC"
  name    = "mehtashreyaresume-website.com"
  type    = "A"

  alias {
    name                   = "d2ybabdkrkou0l.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}