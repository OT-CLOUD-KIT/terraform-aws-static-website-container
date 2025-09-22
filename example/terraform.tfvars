bucket_name             = "static-site-bucket"
aliases                 = []
force_destroy           = true
ssl_certificate_arn     = ""
allowed_ips             = []
web_acl_id              = ""
refer_secret            = "custom-user-agent"
cloudfront_price_class  = "PriceClass_100"
index_document          = "index.html"
error_document          = "error.html"
error_response_code     = "404"
spa_error_response_code = "200"



env = "dev"
owner = "opstree"
app = "otcloud-kit"