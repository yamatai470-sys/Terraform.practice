terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# LocalStack専用の接続設定
provider "aws" {
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  region                      = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
  }
}

# 練習用：ダミーのS3バケット
resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-local-test-bucket"
}
# 練習用：S3バケットの中に配置するファイル（オブジェクト）の定義
resource "aws_s3_object" "sample_file" {
  bucket       = aws_s3_bucket.test_bucket.id # 上で作成したバケットの名前を自動連動
  key          = "hello.txt"                  # S3上でのファイル名
  content      = "Terraformのローカル練習、大成功！" # ファイルの中身
  content_type = "text/plain"
}

