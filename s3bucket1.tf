

resource "aws_s3_bucket" "example1" {
  bucket = "www.mehtashreyaresume-website.com"
}
 

resource "aws_s3_object" "index1_file" {
  bucket = aws_s3_bucket.example1.id
  key    = "index.html"
  source = "C:/tf/s3-config/index.html"   # 🟡 Your local path
  etag   = filemd5("C:/tf/s3-config/index.html")
  content_type = "text/html"

}



resource "aws_s3_object" "css_file" {
  bucket = aws_s3_bucket.example1.id
  key    = "mystyle.css"
  source = "C:/tf/s3-config/mystyle.css"   # 🟡 Your local path
  etag   = filemd5("C:/tf/s3-config/mystyle.css")
  content_type = "text/css"

}
 