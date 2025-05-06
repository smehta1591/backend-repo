

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
  source = "${path.module}/index.html"   # 🟡 Your local path
  content_type = "text/html"

}



resource "aws_s3_object" "css_file" {
  bucket = aws_s3_bucket.example1.id
  key    = "mystyle.css"
  source = "${path.module}/mystyle.css"   # 🟡 Your local path
  content_type = "text/css"

}
 