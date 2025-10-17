# storage.tf

# --- Public bucket for application assets ---
resource "aws_s3_bucket" "app_data" {
  bucket = "startup-app-data-12345"
}

resource "aws_s3_bucket_policy" "app_data_policy" {
  bucket = aws_s3_bucket.app_data.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.app_data.arn}/*"
      }
    ]
  })
}

# --- Internal bucket for development logs ---
resource "aws_s3_bucket" "dev_logs" {
  bucket = "startup-dev-logs-98765"
}

resource "aws_s3_object" "decoy_status_key" {
  bucket  = aws_s3_bucket.dev_logs.id
  key     = "status.txt"
  # This looks like some kind of encoded key...
  content = "FLAG{d3JvbmdfdHJhaWxfdGhlX3JlYWxfY2x1ZV9pc19pbl9hX3B1YmxpY19idWNrZXQ=}"
}

# --- REAL FLAG PART 2 CLUE ---
# This object is stored in the public bucket. Its content is the final breadcrumb.
resource "aws_s3_object" "final_flag_clue" {
  bucket  = aws_s3_bucket.app_data.id
  key     = "secrets/flag_part_2.txt" # This path matches the clue in compute.tf
  content = "The final key has been moved to a secure location for tracking." 
}









































See: https://github.com/your-username/your-repo/issues/1