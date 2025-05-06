

resource "aws_s3_bucket" "example" {
  bucket = "mehtashreyaresume-website.com"
}
 
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id


redirect_all_requests_to {
       host_name = "www.mehtashreyaresume-website.com"
       protocol = "https"

}
}


resource "aws_s3_bucket" "example1" {
  bucket = "www.mehtashreyaresume-website.com"
}
 

resource "aws_s3_object" "index1_file" {
  bucket = aws_s3_bucket.example1.id
  key    = "index.html"
  source = "C:/tf/s3-config/frontend/index.html"   # 🟡 Your local path
  etag   = filemd5("C:/tf/s3-config/frontend/index.html")
  content_type = "text/html"

}



resource "aws_s3_object" "css_file" {
  bucket = aws_s3_bucket.example1.id
  key    = "mystyle.css"
  source = "C:/tf/s3-config/frontend/mystyle.css"   # 🟡 Your local path
  etag   = filemd5("C:/tf/s3-config/frontend/mystyle.css")
  content_type = "text/css"

}
 